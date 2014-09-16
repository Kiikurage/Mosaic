//
//  MOWindow.m
//  Mosaic
//
//  Created by KikuraYuichirou on 2014/09/05.
//  Copyright (c) 2014年 KikuraYuichiro. All rights reserved.
//

#import "MOWindow.h"



@interface MOWindow()

@property (readwrite) pid_t ownerProcessID;

@end



@implementation MOWindow

- (MOWindow *) initWithDictionary: (NSDictionary *)dict {
	
	self.ownerProcessID = [[dict objectForKey:@"kCGWindowOwnerPID"] intValue];
	
	return self;
}

+ (NSArray *) windows  {
	
	NSArray *windowInfos = (__bridge NSArray *) CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly + kCGWindowListExcludeDesktopElements, kCGNullWindowID);
	
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	for (NSDictionary *windowInfo in windowInfos) {
		if ([[windowInfo objectForKey:@"kCGWindowLayer"] intValue] != 0) {
			continue;
		}
		
		MOWindow *window = [[MOWindow alloc] initWithDictionary:windowInfo];
		[results addObject:window];
	}
	
	return results;
}



#pragma mark - Get Attributes

- (AXUIElementRef) elementRef {
	AXError err;
	CFTypeRef ptr;
	
	AXUIElementRef app = AXUIElementCreateApplication(self.ownerProcessID);
	
	err = AXUIElementCopyAttributeValue(app, kAXMainWindowAttribute, &ptr);
	if (err != kAXErrorSuccess) {
		return nil;
	}
	
	return (AXUIElementRef)ptr;
}



#pragma mark - Set Attributes

- (AXError) setSize:(NSSize)size {
	
	AXUIElementRef window = [self elementRef];
	
	if (!window) return kAXErrorFailure;
	
	CFTypeRef _size = (CFTypeRef)(AXValueCreate(kAXValueCGSizeType, (const void *)&size));
	return AXUIElementSetAttributeValue(window, kAXSizeAttribute, _size);
}

- (AXError) setOrigin:(NSPoint)origin {
	
	AXUIElementRef window = [self elementRef];
	
	if (!window) return kAXErrorFailure;
	
	CFTypeRef _origin = (CFTypeRef)(AXValueCreate(kAXValueCGPointType, (const void *)&origin));
	return AXUIElementSetAttributeValue(window, kAXPositionAttribute, _origin);
}

@end
