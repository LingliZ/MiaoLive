//
//  MLNavigationController.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/1.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLNavigationController.h"

@interface MLNavigationController ()

@end

@implementation MLNavigationController

//设置背景
+ (void)initialize{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
}

//重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //重写返回按钮，防止手势问题出错，所以要去注意一下
        UIButton *backBtn = [[UIButton alloc] init];
        [backBtn setImage:[UIImage imageNamed:@"back_9x16"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [backBtn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        //如果自定义反悔按钮，收拾可能不好使，要去注意
        __weak typeof(viewController) weakSelf = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
    }
    [super pushViewController:viewController animated:animated];
}


//判断是pop还是dismiss
- (void)back{
    if ((self.presentedViewController || self.presentingViewController)&&self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self popViewControllerAnimated:YES];
    }
}

@end
