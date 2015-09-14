//
//  TimerShim.h
//  ColorBar
//
//  Created by Grayson Hansard on 9/13/15.
//  Copyright © 2015 From Concentrate Software. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TimerShimBlock)(NSTimer *);

@interface TimerShim : NSObject
@property (nonatomic, copy) TimerShimBlock block;
- (void)fire:(NSTimer *)timer;
@end
