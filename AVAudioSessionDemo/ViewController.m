//
//  ViewController.m
//  AVAudioSessionDemo
//
//  Created by shenzhenshihua on 2018/9/2.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property(nonatomic,strong)AVPlayer * palyer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPalyer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initPalyer {
    _palyer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:@"http://olxnvuztq.bkt.clouddn.com/sansheng.mp4"]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_palyer];
    playerLayer.frame = _backView.bounds;
    [_backView.layer insertSublayer:playerLayer atIndex:0];
    
    /* Category
     // 是否允许音频播放/录音    是否打断其他不支持混音APP      是否会被静音键或锁屏键静音
     
            仅支持播放                否                           是
     AVF_EXPORT NSString *const AVAudioSessionCategoryAmbient;
     
            仅支持播放                是                           是
     AVF_EXPORT NSString *const AVAudioSessionCategorySoloAmbient; 系统默认的属性

            仅支持播放          默认YES，可以重写为NO                 否
     AVF_EXPORT NSString *const AVAudioSessionCategoryPlayback;
     
            仅支持录制                是                        否（锁屏下仍可录制）
     AVF_EXPORT NSString *const AVAudioSessionCategoryRecord;
     
        支持播放 支持录制              是                           否
     AVF_EXPORT NSString *const AVAudioSessionCategoryPlayAndRecord;
     
        支持播放 支持录制              是                           否
     AVF_EXPORT NSString *const AVAudioSessionCategoryMultiRoute
     
        iOS10 之后禁用
        不支持播放 不支持录音          是                            否
     AVF_EXPORT NSString *const AVAudioSessionCategoryAudioProcessing NS_DEPRECATED_IOS(3_0, 10_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;
    */
    
    /*
        支持和其他APP音频 mix
    AVAudioSessionCategoryOptionMixWithOthers            = 0x1,
        系统智能调低其他APP音频音量
    AVAudioSessionCategoryOptionDuckOthers                = 0x2,
        支持蓝牙音频输入
    AVAudioSessionCategoryOptionAllowBluetooth    __TVOS_PROHIBITED __WATCHOS_PROHIBITED        = 0x4,
        设置默认输出音频到扬声器
    AVAudioSessionCategoryOptionDefaultToSpeaker __TVOS_PROHIBITED __WATCHOS_PROHIBITED        = 0x8,

    AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers NS_AVAILABLE_IOS(9_0) = 0x11,

    AVAudioSessionCategoryOptionAllowBluetoothA2DP API_AVAILABLE(ios(10.0), watchos(3.0), tvos(10.0)) = 0x20,
    AVAudioSessionCategoryOptionAllowAirPlay API_AVAILABLE(ios(10.
     */
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError * error = nil;
    
    [session setCategory:AVAudioSessionCategoryAmbient withOptions:AVAudioSessionCategoryOptionDuckOthers error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
}

- (IBAction)playAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [[AVAudioSession sharedInstance] setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
        [_palyer play];
    } else {
        [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
        [_palyer pause];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
