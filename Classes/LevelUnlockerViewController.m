//
//  LevelUnlockerViewController.m
//  haxie
//
//  Created by Kaikz on 7/01/11.
//  Copyright Kaikz 2011. All rights reserved.
//

#import "LevelUnlockerViewController.h"
#import "UIDickBar.h"

@implementation LevelUnlockerViewController

-(void) viewDidLoad {
	UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
	self.view.backgroundColor = background;
	[background release];
	
	UIDickBar *dickBar = [[UIDickBar alloc] initWithDickTitle:@"#LevelUnlocker" dickBadge:@"Info" actionBlock:^{
		UIAlertView *info = [[UIAlertView alloc]
							 initWithTitle:@"haxie 1.4"
							 message:@"LevelUnlocker by Ramsey\nTwitter: @iamramsey\n\nKaikz 2011\nhttp://pwncraft.net"
							 delegate:self
							 cancelButtonTitle:@"Ok!"
							 otherButtonTitles:@"Script Info", nil];
		[info show];
		[info release];
	}];
	[dickBar showInView:self.view];
	[dickBar release];
}

- (void)alertView:(UIAlertView *)info clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1)
	{
		NSURL *url = [ [ NSURL alloc ] initWithString: @"http://hackulo.us/forums/index.php?/topic/103893-release-levelunlocker/" ];
		[[UIApplication sharedApplication] openURL:url];
	}
}

-(IBAction) run {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Remember to close all apps before running LevelUnlocker!" 
															 delegate:self 
													cancelButtonTitle:nil
											   destructiveButtonTitle:@"Cancel" 
													otherButtonTitles:@"Continue", nil];
	[actionSheet setActionSheetStyle:UIBarStyleBlackTranslucent];
	[actionSheet showInView:[[self tabBarController] tabBar]];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)sheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if([sheet buttonTitleAtIndex:buttonIndex] == @"Continue") {
		HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
		[self.view.window addSubview:HUD];
		HUD.delegate = self;
		HUD.labelText = @"Running...";
		[HUD showWhileExecuting:@selector(runScript) onTarget:self withObject:nil animated:YES];
	}
}

-(void) runScript {
	task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
	NSString *script;
	script = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/levelunlocker.sh"];
	NSArray *args = [NSArray arrayWithObjects:script, nil];
	[task setArguments: args];
	[task launch];
	[NSThread sleepForTimeInterval:10.0];
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Complete!";
	[NSThread sleepForTimeInterval:1.0];
}

- (void)hudWasHidden {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	[HUD2 removeFromSuperview];
	[HUD2 release];
}

-(IBAction) supported {
	HUD2 = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
	[self.view.window addSubview:HUD2];
	HUD2.delegate = self;
	HUD2.labelText = @"Running...";
	[HUD2 showWhileExecuting:@selector(runSupported) onTarget:self withObject:nil animated:YES];
}



- (void) runSupported {
	stask = [[NSTask alloc] init];
    [stask setLaunchPath:@"/bin/bash"];
	NSString *script;
	script = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/levelunlocker.sh"];
	NSArray *sargs = [NSArray arrayWithObjects:script, @"-s", nil];
	[stask setArguments: sargs];
	[stask launch];
	[NSThread sleepForTimeInterval:1.0];
	
	NSString *apps;
	apps = [NSString stringWithContentsOfFile:@"/var/mobile/supported_levelunlocker.txt" encoding:NSUTF8StringEncoding error:nil];
	NSFileManager *fm = [NSFileManager defaultManager];
	if ([fm fileExistsAtPath:apps]) {
		UIAlertView *supported = [[UIAlertView alloc] initWithTitle:@"Your Supported Apps" message:apps delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
		[supported show];
		[supported release];
	} else {
		UIAlertView *supported = [[UIAlertView alloc] initWithTitle:@"Your Supported Apps" message:@"Error generating list." delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
		[supported show];
		[supported release];
	}
}
	


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
