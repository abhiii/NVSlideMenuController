//
//  AppDelegate.m
//  BasicDemo
//
//  Created by Nicolas Verinaud on 31/12/12.
//  Copyright (c) 2012 Nicolas Verinaud. All rights reserved.
//

#import "AppDelegate.h"
#import "NVSlideMenuController.h"
#import "MenuViewController.h"
#import "DetailsViewController.h"
#import "ARCAvailability.h"

void uncaughtExceptionHandler(NSException*);

@implementation AppDelegate

#if !OBC_ARC_ENABLED
- (void)dealloc
{
	[_window release];
	
	[super dealloc];
}
#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

#if !OBC_ARC_ENABLED
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
#else
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
#endif
	
	MenuViewController *menuVC = [[MenuViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *menuNavigationController = [[UINavigationController alloc] initWithRootViewController:menuVC];
	
	DetailsViewController *detailsVC = [[DetailsViewController alloc] init];
	detailsVC.detailedObject = @"Welcome Slide Menu !";
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailsVC];
	
	NVSlideMenuController *slideMenuVC = [[NVSlideMenuController alloc] initWithMenuViewController:menuNavigationController andContentViewController:navController];
	
	self.window.rootViewController = slideMenuVC;
	
#if !OBC_ARC_ENABLED
	[menuVC release];
	[detailsVC release];
	[menuNavigationController release];
	[navController release];
	[slideMenuVC release];
#endif
	
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

void uncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
}
