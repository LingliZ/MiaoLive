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
#import "MLLiveCellBottomBar.h"
#import "UIImage+ALinExtension.h"
#import "MLAnchorView.h"


static NSString * const reuseIdentifier = @"MLLivePlayerCell";


@interface MLLivePlayerCell (){
    //弹幕
    BarrageRenderer *_barrageRender;
    //时间
    NSTimer *_timer;
}
/** 直播的控制器*/
@property(nonatomic,strong)IJKFFMoviePlayerController *moviePlayer;
/**数组*/
@property(nonatomic,strong)NSArray *renderArr;
/** 是否开启弹幕*/
@property(nonatomic,strong)UISwitch *loggle;
///底部工具栏
@property(strong,nonatomic)MLLiveCellBottomBar *bottomBar;
///主播的view(cell左上角)
@property(strong,nonatomic)MLAnchorView *anchorView;
///等待时候显示的占位图片
@property(strong,nonatomic)UIImageView *placeHolderImage;
@end
@implementation MLLivePlayerCell
- (MLAnchorView *)anchorView{
    if (!_anchorView) {
        _anchorView = [MLAnchorView liveAnchorView];
        _anchorView.frame= CGRectMake(10, 24, MLScreenWidth - 2*20, 120);
    }
    return _anchorView;
}

- (UIImageView *)placeHolderImage{
    if (!_placeHolderImage) {
        _placeHolderImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_user_414x414"]];
        [self.currentVC showGifLoding:nil inView:self.placeHolderImage];
    }
    return _placeHolderImage;
}
- (MLLiveCellBottomBar *)bottomBar{
    if (!_bottomBar) {
        _bottomBar = [[MLLiveCellBottomBar alloc] init];
        _bottomBar.frame = CGRectMake(0, MLScreenHeight - 50, MLScreenWidth, 50);
    }
    return _bottomBar;
}
- (UISwitch *)loggle{
    if (!_loggle) {
        CGFloat sX = 50;
        CGFloat sY = MLScreenHeight *0.6;
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
    [self.contentView addSubview:self.anchorView];
    
   //2.当前观看人
    
   //3.底部操作栏目
    [self.contentView addSubview:self.bottomBar];
    __weak typeof(self)weakself = self;
    [self.bottomBar setClickToolBlock:^(MLLiveCellBottomBarType type) {
        switch (type) {
            case MLLiveCellBottomBarTypeGift:
                MLLog(@"gift");
                break;
            case MLLiveCellBottomBarTypePublicTalk:
                MLLog(@"MLLiveCellBottomBarTypePublicTalk");
                break;
            case MLLiveCellBottomBarTypePrivateTalk:
                MLLog(@"MLLiveCellBottomBarTypePrivateTalk");
                break;
            case MLLiveCellBottomBarTypeRank:
                MLLog(@"MLLiveCellBottomBarTypeRank");
                break;
            case MLLiveCellBottomBarTypeShare:
                MLLog(@"MLLiveCellBottomBarTypeShare");
                break;
            case MLLiveCellBottomBarTypeClose:
                [weakself.currentVC dismissViewControllerAnimated:YES completion:nil];
                [MLNoticeficationCenter removeObserver:weakself];
                [weakself.moviePlayer stop];
                weakself.moviePlayer = nil;
                break;
                
            default:
                break;
        }
    }];
   //4.相关人的直播圆形view视图
    
   //5.小星星气泡view
   
   //6.结束的时候样式view
   
   //7.loading的状态view
    
   //8.弹幕
    _barrageRender = [[BarrageRenderer alloc] init];
    _barrageRender.canvasMargin = UIEdgeInsetsMake(70, 10, 10, 10);
//    [self.contentView addSubview:_barrageRender.view];
    [_barrageRender start];
    [self createTimer];
    self.loggle.on = @(NO);
    
    //9.默认占位照片
    [self.contentView insertSubview:self.placeHolderImage atIndex:0];
    self.placeHolderImage.frame = MLScreenBounce;
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

///更新UI
- (void)setLiveM:(MLLiveModel *)liveM{
    _liveM = liveM;
    
    //9.当前的播放器
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    
    self.moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:liveM.flv withOptions:options];
    
    //设置茨村
    self.moviePlayer.view.frame = MLScreenBounce;
    //设置填充模式
    self.moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    //设置自动播放模式，一定要选择no，这样才能控制好直播
    self.moviePlayer.shouldAutoplay = NO;
    // 默认不显示s
    self.moviePlayer.shouldShowHudView = NO;
    [self.contentView insertSubview:self.moviePlayer.view atIndex:0];
    [self.moviePlayer prepareToPlay];
    
    
    // 设置监听
    [self initObserver];
    //赋值
    self.anchorView.live = liveM;
    //给默认图片
//    [self.placeHolderImage sd_setImageWithURL:[NSURL URLWithString:liveM.bigpic]
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:liveM.bigpic]
                                                          options:SDWebImageDownloaderUseNSURLCache
                                                         progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.currentVC showGifLoding:nil inView:self.placeHolderImage];
            self.placeHolderImage.image = [UIImage blurImage:image blur:0.8];
        });
    }];
}


- (void)initObserver{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFinish)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:self.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stateDidChange)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:self.moviePlayer];
}

- (void)didFinish{

}

- (void)stateDidChange{
    
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.placeHolderImage) {
                    [_placeHolderImage removeFromSuperview];
                    _placeHolderImage = nil;
                    [self.moviePlayer.view addSubview:_barrageRender.view];
                }
                [self.currentVC hideGufLoding];
            });
        }else{
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
            if (self.currentVC.gifView.isAnimating) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.currentVC hideGufLoding];
                });
            
            }
        }
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        [self.currentVC showGifLoding:nil inView:self.moviePlayer.view];
    }
}

@end
