//
//  MLRefreshGitHeader.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLRefreshGitHeader.h"

@implementation MLRefreshGitHeader

- (instancetype)init{
    if (self = [super init]) {
        //设置照片
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
        NSArray *images = @[[UIImage imageNamed:@"reflesh1_60x55"], [UIImage imageNamed:@"reflesh2_60x55"], [UIImage imageNamed:@"reflesh3_60x55"]];
        [self setImages:images forState:MJRefreshStateRefreshing];
        [self setImages:images forState:MJRefreshStatePulling];
        [self setImages:images forState:MJRefreshStateIdle];
    }
    return self;
}

@end
