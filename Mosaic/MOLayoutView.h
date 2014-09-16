//
//  MOLayoutView.h
//  Mosaic
//
//  Created by KikuraYuichirou on 2014/09/05.
//  Copyright (c) 2014年 KikuraYuichiro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
IB_DESIGNABLE
@interface MOLayoutView: NSSplitView

@property (strong) IBInspectable NSColor *backgroundColor;
@property (strong) IBInspectable NSColor *borderColor;

@end
