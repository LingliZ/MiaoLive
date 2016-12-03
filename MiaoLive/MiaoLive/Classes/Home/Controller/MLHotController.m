//
//  MLHotController.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/2.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLHotController.h"
#import "MLRefreshGitHeader.h"
#import "MLAdModel.h"
#import "MLLiveModel.h"
#import "MLHotCell.h"
#import "MLLiveRoomController.h"
@interface MLHotController ()
/** 当前页 */
@property(nonatomic, assign) NSUInteger currentPage;
/** 直播 */
@property(nonatomic, strong) NSMutableArray *lives;
/** 广告 */
@property(nonatomic, strong) NSArray *topADS;

@end

@implementation MLHotController
- (NSMutableArray *)lives
{
    if (!_lives) {
        _lives = [NSMutableArray array];
    }
    return _lives;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)setupSubViews{
    self.currentPage = 1;
    self.tableView.mj_header = [MLRefreshGitHeader headerWithRefreshingBlock:^{
        self.lives = [NSMutableArray array];
        self.currentPage = 1;
        // 获取顶部的广告
        [self getTopAD];
        [self getHotLiveList];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self getHotLiveList];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 423;
}

- (void)getTopAD
{
    [MLHttpTool getWithURL:@"http://live.9158.com/Living/GetAD" params:nil success:^(NSDictionary * responseObject) {
            NSArray *result = responseObject[@"data"];
            if ([self isNotEmpty:result]) {
                self.topADS = [MLAdModel mj_objectArrayWithKeyValuesArray:result];
                [self.tableView reloadData];
            }else{
//                [self showHint:@"网络异常"];
            }
    } failure:^(NSError *error) {
//        [self showHint:@"网络异常"];
    }];
    
}

- (void)getHotLiveList
{
    
    [MLHttpTool getWithURL:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld", self.currentPage] params:nil success:^(NSDictionary * responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSArray *result = [MLLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if ([self isNotEmpty:result]) {
            [self.lives addObjectsFromArray:result];
            [self.tableView reloadData];
        }else{
//            [self showHint:@"暂时没有更多最新数据"];
            // 恢复当前页
            self.currentPage--;
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.currentPage--;
//        [self showHint:@"网络异常"];
    }];
    
}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lives.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLHotCell *cell = [MLHotCell hotCellWithTableview:tableView];
    cell.liveM = self.lives[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLLiveRoomController *liveVc = [[MLLiveRoomController alloc] init];
    liveVc.lives = self.lives;
    liveVc.currentIndex = indexPath.row;
    [self presentViewController:liveVc animated:YES completion:nil];
}

@end
