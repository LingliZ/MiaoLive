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
#import "Reachability.h"
@interface MLAppDelegate ()
{
    
    Reachability *_reacha;
    MLHttpToolNetworkStates _preStatus;
}
@end

@implementation MLAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
//    MLTabbarController *tabbarVC = [[MLTabbarController alloc] init];
    MLLoginController *loginVC = [[MLLoginController alloc] init];
    _window.rootViewController = loginVC;
    
    
    [self checkNetworkStates];
    return YES;
}
// 实时监控网络状态
- (void)checkNetworkStates
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange) name:kReachabilityChangedNotification object:nil];
    _reacha = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    [_reacha startNotifier];
}

- (void)networkChange
{
    NSString *tips;
    MLHttpToolNetworkStates currentStates = [MLHttpTool getNetworkStates];
    if (currentStates == _preStatus) {
        return;
    }
    _preStatus = currentStates;
    switch (currentStates) {
        case MLHttpToolNetworkStatesNone:
            tips = @"当前无网络, 请检查您的网络状态";
            break;
        case MLHttpToolNetworkStates2G:
            tips = @"切换到了2G网络";
            break;
        case MLHttpToolNetworkStates3G:
            tips = @"切换到了3G网络";
            break;
        case MLHttpToolNetworkStates4G:
            tips = @"切换到了4G网络";
            break;
        case MLHttpToolNetworkStatesWIFI:
            tips = @"wifi";
            break;
        default:
            break;
    }
    
    if (tips.length) {
        [[[UIAlertView alloc] initWithTitle:@"喵播" message:tips delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}


@end
