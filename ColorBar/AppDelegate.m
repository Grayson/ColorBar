//
//  AppDelegate.m
//  ColorBar
//
//  Created by Grayson Hansard on 9/13/15.
//  Copyright © 2015 From Concentrate Software. All rights reserved.
//

#import "AppDelegate.h"
#import "TimerShim.h"

@interface AppDelegate ()
{
	NSString *_stringValue;
	NSTimer *_timer;
	TimerShim *_shim;
	BOOL _isTimerFiring;
}

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, weak) IBOutlet ColorBarView *colorBarView;
@property (nonatomic, weak) IBOutlet NSButton *cycleButton;
@end

static NSString * ExampleSeeds[] = {
	@"example",
	@"appleseed",
	@"From",
	@"Concentrate",
	@"Software",
	@"ColorBar",
	@"pneumonoultramicroscopicsilicovolcanoconiosis",
	@"aqua",
};

@implementation AppDelegate

- (NSString *)stringValue
{
	return _stringValue;
}

- (void)setStringValue:(NSString *)stringValue
{
	_stringValue = stringValue;
	self.colorBarView.seed = [_stringValue dataUsingEncoding:NSUTF8StringEncoding];

	NSColor *color = self.colorBarView.color;
	if (color == nil)
	{
		self.colorHexString = @"";
	}
	else
	{
		CGFloat red, green, blue;
		[color getRed:&red green:&green blue:&blue alpha:NULL];
		self.colorHexString = [NSString stringWithFormat:@"#%02x%02x%02x", (unsigned int)(red * 255), (unsigned int)(green * 255), (unsigned int)(blue * 255)];
		
		// Brightness calculations taken from <http://www.w3.org/TR/AERT#color-contrast>
		CGFloat brightness = ((red * 299.0) + (green * 587.0) + (blue * 114.0)) / 1000.0;
		self.colorHexStringTextColor = brightness > 0.5 ? [NSColor textColor] : [NSColor whiteColor];
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	__block int seedIndex = 0;
	self.stringValue = ExampleSeeds[seedIndex++];

	__weak AppDelegate *weakSelf = self;
	_shim = [TimerShim new];
	_shim.block = ^(NSTimer *_)
	{
		int nextIndex = seedIndex++ % (sizeof(ExampleSeeds) / sizeof(NSString *));
		weakSelf.stringValue = ExampleSeeds[nextIndex];
	};
}

- (IBAction)cycle:(id)sender
{
	if (_isTimerFiring)
	{
		[_timer invalidate];
		_timer = nil;
		self.cycleButton.title = NSLocalizedString(@"Cycle", @"Button title");
	}
	else
	{
		_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:_shim selector:@selector(fire:) userInfo:nil repeats:YES];
		self.cycleButton.title = NSLocalizedString(@"Stop", @"Button title");
	}
	_isTimerFiring = !_isTimerFiring;
}

@end
