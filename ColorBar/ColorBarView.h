//
//  ColorBarView.h
//  ColorBar
//
//  Created by Grayson Hansard on 9/13/15.
//  Copyright © 2015 From Concentrate Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

IB_DESIGNABLE
@interface ColorBarView : NSView

@property (nonatomic) NSData *seed;
@property (nonatomic) IBInspectable NSColor *color;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSString *ibseed;
#endif

@end
