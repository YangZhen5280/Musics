//
//  YYPlayingViewController.m
//  Musics
//
//  Created by 杨振 on 15/10/30.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import "YYPlayingViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+AdjustFrame.h"
#import "YYMusic.h"
#import "YYMusicTools.h"
#import "YYAudioTools.h"

@interface YYPlayingViewController ()

@property (nonatomic, strong) YYMusic *playingMusic;
@property (nonatomic, strong) NSTimer *progressTimer;


@property (weak, nonatomic) IBOutlet UILabel *singerName;
@property (weak, nonatomic) IBOutlet UILabel *songeName;
@property (weak, nonatomic) IBOutlet UILabel *clickTime;
@property (weak, nonatomic) IBOutlet UILabel *soneTime;
@property (weak, nonatomic) IBOutlet UIImageView *singerIcon;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;


@end

@implementation YYPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
#pragma mark - 对控制器的操作

- (void)show {
    
    if (self.playingMusic && self.playingMusic != [YYMusicTools playingMusic]) {
        [self stopPlayingMusic];
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
    
    self.view.frame = window.bounds;
    [window addSubview:self.view];

    self.view.y = self.view.height;
    [UIView animateWithDuration:1.0 animations:^{

        self.view.y = 0;
    } completion:^(BOOL finished) {
        
        window.userInteractionEnabled = YES;
        
        [self startPlayingMusic];
    }];
}

// 退出播放器
- (IBAction)exit {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:1.0 animations:^{

        self.view.y = self.view.height;
    } completion:^(BOOL finished) {
        
        window.userInteractionEnabled = YES;
    }];
}
#pragma mark - 对音乐播放的控制

- (void)startPlayingMusic {
    
    YYMusic *playingMusic = [YYMusicTools playingMusic];
    if (playingMusic == self.playingMusic) {
        [self addProgressTimer];
        return;
    }
    // 设置正在播放的音乐 为当前播放音乐
    self.playingMusic = playingMusic;
    
    // 设置界面数据
    self.songeName.text = playingMusic.name;
    self.singerName.text = playingMusic.singer;
    self.singerIcon.image = [UIImage imageNamed:playingMusic.icon];
    
    AVAudioPlayer *player = [YYAudioTools playMusicWithName:playingMusic.filename];
    self.totalTimeLabel.text = [self stringWithTime:player.duration];
    
    [self addProgressTimer];
}
- (void)stopPlayingMusic {
    
    self.songeName.text = nil;
    self.singerName.text = nil;
    self.singerIcon.image = [UIImage imageNamed:@"play_cover_pic_bg"];
    self.totalTimeLabel.text = nil;
    
    [YYAudioTools stopMusicWithName:self.playingMusic.filename];
    
    [self removeProgressTimer];
}
#pragma mark - 对定时器的操作

- (void)addProgressTimer {
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}
- (void)removeProgressTimer {
    [self.progressTimer invalidate]; // invalidate 无效的作废的
    self.progressTimer = nil;
}

#pragma mark - 私有方法
- (NSString *)stringWithTime:(NSTimeInterval)time {
    NSInteger minute = time / 60;
    NSInteger second = (NSInteger)time % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld",minute, second];
}

- (void)updateInfo {
    NSLog(@"%s",__FUNCTION__);
}

// 显示歌词
- (IBAction)soneLrcs:(id)sender {
}
@end
