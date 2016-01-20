//
//  AppDelegate.m
//  aa
//
//  Created by 群雄 on 13-11-28.
//  Copyright (c) 2013年 凯伦圣. All rights reserved.
//
#import "CommandMaster.h"
#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    
    [[CommandMaster sharedInstance] addButtons:@[
                                                 [CommandMaster createButtonWithImage:[UIImage imageNamed:@"mainView_person"] andTitle:@"会员俱乐部" ],
                                                 [CommandMaster createButtonWithImage:[UIImage imageNamed:@"mainview_cartip_1"] andTitle:nil ],
                                                 [CommandMaster createButtonWithImage:[UIImage imageNamed:@"mainView_normal_car_n"] andTitle:@"4S服务中心" ]
                                                 ] forGroup:@"TestGroup"];
    
    self.viewController=[[[ViewController alloc]init]autorelease];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    self.window.rootViewController = self.viewController;
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
