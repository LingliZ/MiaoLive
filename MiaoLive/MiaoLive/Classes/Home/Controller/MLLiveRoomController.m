//
//  MLLiveRoomController.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLLiveRoomController.h"
#import "MLRefreshGitHeader.h"
#import "MLLivePlayerCell.h"
#import "MLLiveRoomLayout.h"
#import "MLLiveModel.h"
@interface MLLiveRoomController ()
@end

@implementation MLLiveRoomController

static NSString * const reuseIdentifier = @"MLLivePlayerCell";


- (instancetype)init{
    return [super initWithCollectionViewLayout:[[MLLiveRoomLayout alloc] init]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollcetionView];
    
    [self setupRefresh];
}

- (void)setupCollcetionView{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[MLLivePlayerCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)setupRefresh{
    __weak typeof(self) weakself = self;
    MLRefreshGitHeader *header= [MLRefreshGitHeader headerWithRefreshingBlock:^{
         //获取最合适的index
//        MLLiveModel *live = [weakself.lives objectAtIndex:weakself.currentIndex];
        [weakself.collectionView.mj_header endRefreshing];
        //刷新currentIndex
        if (self.currentIndex == weakself.lives.count) {
            weakself.currentIndex = 0;
        }else{
            weakself.currentIndex++;
        }
        //刷新collectionView
        [weakself.collectionView reloadData];
    }];
    header.stateLabel.hidden = NO;
    [header setTitle:@"下啦获取新的主播" forState:MJRefreshStateIdle];
    [header setTitle:@"下啦获取新的主播" forState:MJRefreshStatePulling];
    [header setTitle:@"下啦获取新的主播" forState:MJRefreshStateRefreshing];
    self.collectionView.mj_header = header;
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLLivePlayerCell *cell = [MLLivePlayerCell livePlayerCellWithCollectionView:collectionView
                                                                      indexPath:indexPath];
    
    cell.liveM = self.lives[self.currentIndex];
    cell.currentVC = self;
    return cell;
}


@end
