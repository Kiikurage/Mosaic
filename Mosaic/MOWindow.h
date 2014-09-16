//
//  MOWindow.h
//  Mosaic
//
//  Created by KikuraYuichirou on 2014/09/05.
//  Copyright (c) 2014年 KikuraYuichiro. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MOWindow : NSObject

@property (readonly) pid_t ownerProcessID;



- (MOWindow *) initWithDictionary: (NSDictionary *)dict;
+ (NSArray *) windows;



#pragma mark - Get Attributes

- (AXUIElementRef) elementRef;



#pragma mark - Set Attributes

- (AXError) setSize:(NSSize)size;
- (AXError) setOrigin:(NSPoint)origin;

@end
