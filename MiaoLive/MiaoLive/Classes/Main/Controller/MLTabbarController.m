//
//  MLTabbarController.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/1.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLTabbarController.h"
#import "MLMineController.h"
#import "MLHomeController.h"
#import "MLLiveController.h"
#import "MLNavigationController.h"
@interface MLTabbarController ()

@end

@implementation MLTabbarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //设置基本的只控制器
    [self setupChildVC];
}
- (void)setupChildVC{
    [self.view setBackgroundColor:[UIColor greenColor]];
    //首页
    [self configWithChildVCClass:NSClassFromString(@"MLHomeController")
                       imageName:@"toolbar_home"
               selectedImageName:@"toolbar_home_sel"];
    //直播
    [self configWithChildVCClass:NSClassFromString(@"MLLiveController")
                       imageName:@"toolbar_live"
               selectedImageName:@"toolbar_live"];
    //个人
    [self configWithChildVCClass:NSClassFromString(@"MLMineController")
                       imageName:@"toolbar_me"
               selectedImageName:@"toolbar_me_sel"];
}

- (void)configWithChildVCClass:(Class )childVCClass
                    imageName:(NSString *)imageName
            selectedImageName:(NSString *)selectedImageName{
    UIViewController *childVC = [[childVCClass alloc] init];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    MLNavigationController *nav = [[MLNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

@end
