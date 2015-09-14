//
//  TimerShim.m
//  ColorBar
//
//  Created by Grayson Hansard on 9/13/15.
//  Copyright © 2015 From Concentrate Software. All rights reserved.
//

#import "TimerShim.h"

@implementation TimerShim

- (void)fire:(NSTimer *)timer
{
	if (!!self.block)
		self.block(timer);
}

@end
