//
//  MOLayoutView.m
//  Mosaic
//
//  Created by KikuraYuichirou on 2014/09/05.
//  Copyright (c) 2014年 KikuraYuichiro. All rights reserved.
//

#import "MOLayoutView.h"

@implementation MOLayoutView

NSPoint p;



- (MOLayoutView *) init {
	self = [super init];
	return self;
}

- (void)mouseDown:(NSEvent *)theEvent {
	self.borderColor = [NSColor redColor];
	[self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent {
	[[self window] setAcceptsMouseMovedEvents:YES];
	[[self window] makeFirstResponder:self];
	self.borderColor = [NSColor greenColor];
	[self setNeedsDisplay:YES];
}

- (void)mouseMoved:(NSEvent *)theEvent {
	p = [theEvent locationInWindow];
	[self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect {
	//flip
	NSAffineTransform* xform1 = [NSAffineTransform transform];
	[xform1 scaleXBy:1.0 yBy:-1.0];
	
	NSAffineTransform* xform2 = [NSAffineTransform transform];
	[xform1 translateXBy:0.0 yBy:-rect.size.height];
	
	NSAffineTransform* xformTot = [NSAffineTransform transform];
	[xformTot appendTransform:xform1];
	[xformTot appendTransform:xform2];
	
	[xformTot concat];
	
	
	[self.backgroundColor set];
	[NSBezierPath fillRect: rect];
	
	[[NSColor redColor] set];
	[NSBezierPath strokeLineFromPoint:p toPoint:(NSPoint){0, 0}];
}

@end
