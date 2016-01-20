//
//  AppDelegate.h
//  AD_BL
//
//  Created by 3013 on 14-6-5.
//  Copyright (c) 2014年 com.aidian. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)?YES:NO

@class DDMenuController;
@class ViewController;
@class MeunViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DDMenuController *menuController;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) MeunViewController *leftMenu;

+ (NSInteger)OSVersion;

@end
