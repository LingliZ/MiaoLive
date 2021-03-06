//
//  MLHomeController.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/1.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLHomeController.h"
#import "MLHotController.h"
#import "MLNewLivesController.h"
#import "MLFocusAnchorController.h"
#import "ALinSelectedView.h"
#import "MLWebViewController.h"
#import "ShowTimeViewController.h"

@interface MLHomeController ()<UIScrollViewDelegate>
/** 热门 */
@property(weak,nonatomic)  MLHotController *hot;
/** 直播 */
@property(weak,nonatomic)  MLNewLivesController *lastLive;
/** 我的关注主播 */
@property(weak,nonatomic)  MLFocusAnchorController *care;
/** scrollview */
@property(weak,nonatomic)  UIScrollView *scrollView;
/** 顶部选择视图 */
@property(nonatomic, assign) ALinSelectedView *selectedView;

@end

@implementation MLHomeController
- (void)loadView
{
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.contentSize = CGSizeMake(MLScreenWidth * 3, 0);
    view.backgroundColor = [UIColor whiteColor];
    // 去掉滚动条
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    // 设置分页
    view.pagingEnabled = YES;
    // 设置代理
    view.delegate = self;
    // 去掉弹簧效果
    view.bounces = NO;
    
    CGFloat height = MLScreenHeight - 49;
    
    // 添加子视图
    MLHotController *hot = [[MLHotController alloc] init];
    hot.view.frame = [UIScreen mainScreen].bounds;
    hot.view.height = height;
    [self addChildViewController:hot];
    [view addSubview:hot.view];
    self.hot = hot;
    
    
    MLNewLivesController *newLive = [[MLNewLivesController alloc] init];
    newLive.view.frame = [UIScreen mainScreen].bounds;
    newLive.view.x = MLScreenWidth;
    newLive.view.height = height;
    [self addChildViewController:newLive];
    [view addSubview:newLive.view];
    self.lastLive = newLive;
    
    MLFocusAnchorController *care = [[MLFocusAnchorController alloc] init];
    care.view.frame = [UIScreen mainScreen].bounds;
    care.view.x = MLScreenWidth * 2;
    care.view.height = height;
    [self addChildViewController:care];
    [view addSubview:care.view];
    self.care = care;
    
    self.view = view;
    self.scrollView = view;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    [self setup];
}

- (void)setup
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:self action:@selector(rankCrown)];
    [self setupTopMenu];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:addBtn];
    addBtn.frame = CGRectMake(100, 100, 60, 50);
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBtnClick{
    ShowTimeViewController *showTimeVc = [UIStoryboard storyboardWithName:NSStringFromClass([ShowTimeViewController class]) bundle:nil].instantiateInitialViewController;
    [self presentViewController:showTimeVc animated:YES completion:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_selectedView) {
        [self setupTopMenu];
    }
}

- (void)rankCrown
{
    MLWebViewController *web = [[MLWebViewController alloc] init];
    web.url = @"http://live.9158.com/Rank/WeekRank?Random=10";
    web.navigationItem.title = @"排行";
    [_selectedView removeFromSuperview];
    _selectedView = nil;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)setupTopMenu
{
    // 设置顶部选择视图
    ALinSelectedView *selectedView = [[ALinSelectedView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    selectedView.x = 45;
    selectedView.width = MLScreenWidth - 45 * 2;
    [selectedView setSelectedBlock:^(HomeType type) {
        [self.scrollView setContentOffset:CGPointMake(type * MLScreenWidth, 0) animated:YES];
    }];
    [self.navigationController.navigationBar addSubview:selectedView];
    _selectedView = selectedView;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / MLScreenWidth;
    CGFloat offsetX = scrollView.contentOffset.x / MLScreenWidth * (self.selectedView.width * 0.5 - kMLHomeControllerSelectViewHeight * 0.5 - 15);
    self.selectedView.underLine.x = 15 + offsetX;
    if (page == 1 ) {
        self.selectedView.underLine.x = offsetX + 10;
    }else if (page > 1){
        self.selectedView.underLine.x = offsetX + 5;
    }
    self.selectedView.selectedType = (int)(page + 0.5);
}
@end
