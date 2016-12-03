//
//  MLLiveCellBottomBar.h
//  MiaoLive
//
//  Created by 王鑫 on 16/12/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, MLLiveCellBottomBarType) {
    MLLiveCellBottomBarTypePublicTalk,
    MLLiveCellBottomBarTypePrivateTalk,
    MLLiveCellBottomBarTypeGift,
    MLLiveCellBottomBarTypeRank,
    MLLiveCellBottomBarTypeShare,
    MLLiveCellBottomBarTypeClose
};
@interface MLLiveCellBottomBar : UIView
/** 点击工具栏  */
@property(nonatomic, copy)void (^clickToolBlock)(MLLiveCellBottomBarType type);

@end
