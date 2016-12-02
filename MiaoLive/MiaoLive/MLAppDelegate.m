//
//  AppDelegate.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/1.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLAppDelegate.h"
#import "MLTabbarController.h"
#import "MLLoginController.h"
@interface MLAppDelegate ()

@end

@implementation MLAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
//    MLTabbarController *tabbarVC = [[MLTabbarController alloc] init];
    MLLoginController *loginVC = [[MLLoginController alloc] init];
    _window.rootViewController = loginVC;
    return YES;
}


@end
