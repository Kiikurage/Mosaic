//
//  MOAppDelegate.m
//  Mosaic
//
//  Created by KikuraYuichirou on 2014/09/05.
//  Copyright (c) 2014年 KikuraYuichiro. All rights reserved.
//

#import "MOAppDelegate.h"



@interface MOAppDelegate ()

@property (weak) IBOutlet NSMenu *menu;
@property (weak) IBOutlet NSWindow *window;

@end



@implementation MOAppDelegate

NSStatusItem *item;



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self setupStatusItem];
	[self checkAuthorized];
	
	NSArray *windows = [MOWindow windows];
	for (MOWindow *window in windows) {
		NSSize size = {500, 500};
		NSPoint origin = {0, 0};
		[window setSize:size];
		[window setOrigin:origin];
	}
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (void)setupStatusItem {
	item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	item.highlightMode = true;
	item.image = [NSImage imageNamed:@"StatusBarIconTemplate"];
	item.menu = self.menu;
}

- (void)checkAuthorized {
	BOOL isAuthorized = (AXIsProcessTrusted() == 1);

	if (isAuthorized) return;
	
	NSAlert *alert = [[NSAlert alloc] init];
	alert.messageText = @"Authorization Required";
	[alert addButtonWithTitle:@"Recheck"];
	[alert addButtonWithTitle:@"Open System Preferences"];
	[alert addButtonWithTitle:@"Quit" ];
	alert.informativeText = @"Mosaic needs to be authorized to use an Accessibility Service in order to be able to move and resize application windows.";
		
	while (!isAuthorized) {
		NSModalResponse selection = [alert runModal];
		switch (selection){
				
				//Recheck
			case 1000:
				isAuthorized = (AXIsProcessTrusted() == 1);
				break;
				
				//Open System Preferences
			case 1001:
				// this should hopefully add it to the list so user can only click on the checkbox
				AXIsProcessTrustedWithOptions(nil);
				break;
				
				//Quit
				case 1002:
				[NSApp terminate:self];
				break;
				
			default:
				break;
		}
	}
}



#pragma mark - screen

- (NSArray *) screens {
	return [NSScreen screens];
}

- (NSScreen *) primaryScreen {
	return [self screens][0];
}

- (NSRect) getScreenRect {
	return [self primaryScreen].frame;
}



#pragma mark - window

- (IBAction) test: (id)sender {
	if (self.window.visible) {
		[self.window orderOut:self];
	} else {
		[self.window setFrame:[self primaryScreen].frame display:TRUE];
		[self.window setMovable:FALSE];
		[self.window makeKeyAndOrderFront:NSApp];
	}
}

@end
