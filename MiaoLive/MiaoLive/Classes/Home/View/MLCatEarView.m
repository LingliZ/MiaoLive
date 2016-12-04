//
//  MLCatEarView.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/4.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLCatEarView.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface MLCatEarView ()
@property(nonatomic,strong)IJKFFMoviePlayerController *moviePlayer;
@end
@implementation MLCatEarView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 100*0.5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setLiveM:(MLLiveModel *)liveM{
    _liveM = liveM;
    
    IJKFFOptions *option = [IJKFFOptions optionsByDefault];
    [option setPlayerOptionValue:@"1" forKey:@"an"];
    // 开启硬解码
    [option setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
    
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:liveM.flv withOptions:option];
    self.moviePlayer = moviePlayer;
    [self addSubview:self.moviePlayer.view];
    self.moviePlayer.view.frame = self.bounds;
    self.moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    self.moviePlayer.shouldAutoplay = YES;
    
    [self.moviePlayer prepareToPlay];
}

- (void)removeFromSuperview
{
    if (_moviePlayer) {
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
    }
    [super removeFromSuperview];
}

@end
