//
//  MLLoginController.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/1.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLLoginController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface MLLoginController ()
/** 快速通道 */
@property (nonatomic, strong) UIButton *quickBtn;
/**创建播放器*/
@property(strong,nonatomic)  IJKFFMoviePlayerController *player;
@end

@implementation MLLoginController

- (IJKFFMoviePlayerController *)player{
    if (!_player) {
        //随机播放一个视频
        NSString *name = arc4random_uniform(10)%2?@"login_video":@"loginmovie";
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
        _player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:path withOptions:[IJKFFOptions optionsByDefault]];
        //填充fill
        [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
        //设置自动播放
        _player.shouldAutoplay = NO;
        //准备播放
        [_player prepareToPlay];
    }
    return _player;
}

- (UIButton *)quickBtn{
    if (!_quickBtn) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor yellowColor].CGColor;
        [btn setTitle:@"app快速登录通道" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor yellowColor]  forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loginSuccess) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _quickBtn = btn;
    }
    return _quickBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    //添加两个通知
    [self setupNotification];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player shutdown];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.player.view removeFromSuperview];
    self.player = nil;
}
- (void)setupNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFinish)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stateDidChange)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:nil];
}

- (void)setupSubViews{
    
    //设置frame
    [self.view addSubview:self.player.view];
    [self.player.view autoPinEdgesToSuperviewEdges];
    
    [self.view addSubview:self.quickBtn];
    [self.quickBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:80];
    [self.quickBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [self.quickBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [self.quickBtn autoSetDimension:ALDimensionHeight toSize:44];
}

- (void)stateDidChange
{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.player.isPlaying) {
            [self.player play];
        }
    }
}

- (void)didFinish
{
    // 播放完之后, 继续重播
    [self.player play];
}
#pragma mark - 内部登录方法
- (void)loginSuccess{
   //页面消失
    
}
@end
