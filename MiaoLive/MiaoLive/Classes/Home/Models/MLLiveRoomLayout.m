
//
//  MLLiveRoomLayout.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLLiveRoomLayout.h"

@implementation MLLiveRoomLayout
- (void)prepareLayout{
    [super prepareLayout];
    self.collectionView.scrollEnabled = YES;
    self.collectionView.pagingEnabled = YES;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = MLScreenBounce.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}
@end
