//
//  ColorBarView.m
//  ColorBar
//
//  Created by Grayson Hansard on 9/13/15.
//  Copyright © 2015 From Concentrate Software. All rights reserved.
//

#import "ColorBarView.h"
#include <CommonCrypto/CommonDigest.h>

@interface ColorBarView ()
{
	NSData *_seed;
	NSColor *_color;
	
#if TARGET_INTERFACE_BUILDER
	NSString *_ibseed;
#endif
}
@end

@implementation ColorBarView

- (NSData *)seed
{
	return _seed;
}

- (void)setSeed:(NSData *)seed
{
	_seed = seed;
	
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
	[self willChangeValueForKey:@"color"];
	if (_seed == nil || NULL == CC_SHA1([_seed bytes], (CC_LONG)[_seed length], digest))
	{
		_color = nil;
	}
	else
	{
		CGFloat red = digest[0] / 255.0;
		CGFloat green = digest[1] / 255.0;
		CGFloat blue = digest[2] / 255.0;
		_color = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:1.0];
	}
	[self didChangeValueForKey:@"color"];
	[self setNeedsDisplay:YES];
}

- (NSColor *)color
{
	return _color;
}

- (void)setColor:(NSColor *)color
{
#if TARGET_INTERFACE_BUILDER
	self.ibseed = nil;
#endif
	self.seed = nil;
	_color = color;
	[self setNeedsDisplay:YES];
}

#if TARGET_INTERFACE_BUILDER
- (NSString *)ibseed
{
	return _ibseed;
}

- (void)setIbseed:(NSString *)seed
{
	_ibseed = [seed copy];
	self.seed = [_ibseed dataUsingEncoding:NSUTF8StringEncoding];
}
#endif

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	[self.color ?: [NSColor orangeColor] set];
	NSRectFill(dirtyRect);
}

@end
