//
//  MLAnchorView.h
//  MiaoLive
//
//  Created by 王鑫 on 16/12/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLLiveModel,MLUser;
@interface MLAnchorView : UIView
+ (instancetype)liveAnchorView;
/** 主播 */
@property(nonatomic, strong) MLUser *user;
/** 直播 */
@property(nonatomic, strong) MLLiveModel *live;
/** 点击开关  */
@property(nonatomic, copy)void (^clickDeviceShow)(bool selected);

@end
