//
//  AppDelegate.h
//  ColorBar
//
//  Created by Grayson Hansard on 9/13/15.
//  Copyright © 2015 From Concentrate Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ColorBarView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, copy) NSString *stringValue;
@property (nonatomic, copy) NSString *colorHexString;
@property (nonatomic, strong) NSColor *colorHexStringTextColor;

- (IBAction)cycle:(id)sender;

@end

