//
//  MLShowTimeController.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/1.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLShowTimeController.h"
#import "LFLiveKit.h"
@interface MLShowTimeController ()<LFLiveSessionDelegate>
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) UIView *livingPreView;
//直播使用的lfLiveKit
@property(nonatomic,strong) LFLiveSession *session;
//直播的地址
@property(nonatomic,strong)NSString *tempUrl;
@end

@implementation MLShowTimeController
- (UIView *)livingPreView
{
    if (!_livingPreView) {
        UIView *livingPreView = [[UIView alloc] initWithFrame:self.view.bounds];
        livingPreView.backgroundColor = [UIColor clearColor];
        livingPreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:livingPreView atIndex:0];
        _livingPreView = livingPreView;
    }
    return _livingPreView;
}
- (LFLiveSession*)session{
    if(!_session){
        /***   默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏 ***/
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2] liveType:LFLiveRTMP];
        // 设置代理
        _session.delegate = self;
        _session.running = YES;
        _session.preView = self.livingPreView;
    }
    return _session;
}
- (IBAction)beatifuLoggle:(UISwitch *)sender {
    sender.on = !sender.on;
    self.session.beautyFace = sender.on;
}
- (IBAction)startPlayer:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
        streamInfo.url = @"rtmp://192.168.1.102:1935/rtmplive/room";
        self.tempUrl = streamInfo.url;
        [self.session startLive:streamInfo];
    }else{
        [self.session stopLive];
        self.statusLabel.text = [NSString stringWithFormat:@"状态: 直播被关闭\nRTMP: %@", self.tempUrl];
    }
}
- (IBAction)stopPlay:(id)sender {
    
    if (self.session.state == LFLivePending || self.session.state == LFLiveStart){
        [self.session stopLive];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    [self setupBasicUI];
}


- (void)setupBasicUI{
   //默认的开启后置摄像头
    self.session.captureDevicePosition = AVCaptureDevicePositionBack;
}

/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
    self.statusLabel.text = [NSString stringWithFormat:@"状态: %@\nRTMP: %@", tempStatus, self.tempUrl];
}
@end
