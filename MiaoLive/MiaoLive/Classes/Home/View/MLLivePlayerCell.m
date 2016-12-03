//
//  MLLivePlayerCell.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLLivePlayerCell.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "BarrageHeader.h"
#import "NSSafeObject.h"

static NSString * const reuseIdentifier = @"MLLivePlayerCell";


@interface MLLivePlayerCell (){
    //弹幕
    BarrageRenderer *_barrageRender;
    //时间
    NSTimer *_timer;
}
/** 直播的控制器*/
@property(nonatomic,strong)IJKFFMoviePlayerController *player;
/**数组*/
@property(nonatomic,strong)NSArray *renderArr;
/** 是否开启弹幕*/
@property(nonatomic,strong)UISwitch *loggle;
@end
@implementation MLLivePlayerCell
- (UISwitch *)loggle{
    if (!_loggle) {
        CGFloat sX = 50;
        CGFloat sY = 70+30;
        CGFloat sW = 100;
        CGFloat sH = 40;
        CGRect frame = CGRectMake(sX, sY, sW, sH);
        _loggle = [[UISwitch alloc] initWithFrame:frame];
        [_loggle addTarget:self action:@selector(loggleBarrage:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_loggle];
    }
    return _loggle;
}
- (NSArray *)renderArr{
    if (!_renderArr) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"danmu" ofType:@"plist"];
        _renderArr = [NSArray arrayWithContentsOfFile:path];
    }
    return _renderArr;
}

+ (id)livePlayerCellWithCollectionView:(UICollectionView *)collectionView
                             indexPath:(NSIndexPath *)indexPath{
    MLLivePlayerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                       forIndexPath:indexPath];
    if (!cell) {
        cell = [[MLLivePlayerCell alloc] init];
    }
    return cell;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //创建子控件
        [self createSubViews];
    }
    return self;
}


//[self.contentView addSubView:tempView] 这个方法，最好在懒架子中使用，这样有利于省内存
- (void)createSubViews{
   //1.当前主播简介
    
   //2.当前观看人
    
   //3.底部操作栏目
    
   //4.相关人的直播圆形view视图
    
   //5.小星星气泡view
   
   //6.结束的时候样式view

   //7.loading的状态view
    
   //8.弹幕
    _barrageRender = [[BarrageRenderer alloc] init];
    _barrageRender.canvasMargin = UIEdgeInsetsMake(70, 10, 10, 10);
    [self.contentView addSubview:_barrageRender.view];
    [_barrageRender start];
    [self createTimer];
    self.loggle.on = @(NO);
    
}

- (void)autoSendBarrage{
    //判断当前的弹幕熟练
    NSInteger barrageNum = [_barrageRender spritesNumberWithName:nil];
    if (barrageNum < 300) {
        //创建弹幕
        [_barrageRender receive:[self walkTextSpriteDescripterWithDirection:BarrageWalkDirectionR2L]];
    }
}

- (BarrageDescriptor *)walkTextSpriteDescripterWithDirection:(NSInteger)direction{
   //创建弹幕
    BarrageDescriptor * desc = [[BarrageDescriptor alloc]init];
    desc.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
    desc.params[@"text"] = self.renderArr[arc4random_uniform(140)%self.renderArr.count];
    desc.params[@"textColor"] = MLRandomColor;
    desc.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    desc.params[@"direction"] = @(direction);
    desc.params[@"clickAction"] = ^{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"弹幕被点击"
                                                          delegate:nil
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:nil];
        [alertView show];
    };
    return desc;
}

#pragma mark - 点击时间
- (void)loggleBarrage:(UISwitch *)loggle{
    if (loggle.on) {
        [self createTimer];
        [_barrageRender start];
    }else{
        [_barrageRender stop];
        _timer = nil;
    }
}

- (void)createTimer{
    
    NSSafeObject * safeObj = [[NSSafeObject alloc]initWithObject:self
                                                    withSelector:@selector(autoSendBarrage)];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:safeObj
                                            selector:@selector(excute)
                                            userInfo:nil
                                             repeats:YES];
    
}

@end
