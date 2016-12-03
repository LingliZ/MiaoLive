//
//  MLLivePlayerCell.h
//  MiaoLive
//
//  Created by 王鑫 on 16/12/3.
//  Copyright © 2016年 王鑫. All rights reserved.
// 直播的控制器

#import <UIKit/UIKit.h>
#import "MLLiveModel.h"
@interface MLLivePlayerCell : UICollectionViewCell
+ (id)livePlayerCellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath;
/** liveModel */
@property(nonatomic,strong)MLLiveModel *liveM;
/** 相关的liveModel*/
@property(nonatomic,strong)MLLiveModel *relationLiveM;

///当前的控制器
@property(nonatomic,weak)UIViewController *currentVC;

@end
