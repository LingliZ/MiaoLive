//
//  MLHomeController.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/1.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLHomeController.h"

@interface MLHomeController ()

@end

@implementation MLHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(100, 100, 100, 100);
    UIButton *addBtn = [[UIButton alloc] initWithFrame:frame];
    [self.view addSubview:addBtn];
    [addBtn setTitle:@"按钮" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)addBtnClick{
    UIViewController *co = [[UIViewController alloc] init];
    co.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:co animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}



@end
