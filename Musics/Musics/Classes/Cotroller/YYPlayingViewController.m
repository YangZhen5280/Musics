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
#import "YYLrcView.h"

@interface YYPlayingViewController () <AVAudioPlayerDelegate>

@property (nonatomic, strong) YYMusic *playingMusic;
@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic, strong) CADisplayLink *lrcTimer;
@property (nonatomic, strong) AVAudioPlayer *player;

@property (weak, nonatomic) IBOutlet YYLrcView *LrcView;

@property (weak, nonatomic) IBOutlet UILabel *singerName;
@property (weak, nonatomic) IBOutlet UILabel *songeName;
@property (weak, nonatomic) IBOutlet UIImageView *singerIcon;

@property (weak, nonatomic) IBOutlet UILabel *clickTime;
@property (weak, nonatomic) IBOutlet UILabel *soneTime;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *sliderButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderLeftConstrant;
@property (weak, nonatomic) IBOutlet UILabel *showTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *playOrStopButton;
@property (weak, nonatomic) IBOutlet UIButton *showLrcButton;

@end

@implementation YYPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showTimeLabel.layer.cornerRadius = 5.0;
    self.showTimeLabel.layer.masksToBounds = YES;

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
        
        [self removeLrcTimer];
        [self removeProgressTimer];
    }];
}
#pragma mark - 对音乐播放的控制

- (void)startPlayingMusic {
    
    YYMusic *playingMusic = [YYMusicTools playingMusic];
    if (playingMusic == self.playingMusic) {
        [self addProgressTimer];
        [self addLrcTimer];
        return;
    }
    // 设置正在播放的音乐 为当前播放音乐
    self.playingMusic = playingMusic;
    
    // 设置界面数据
    self.songeName.text = playingMusic.name;
    self.singerName.text = playingMusic.singer;
    self.singerIcon.image = [UIImage imageNamed:playingMusic.icon];
    
    self.LrcView.lrcName = playingMusic.lrcname;
    
    self.player = [YYAudioTools playMusicWithName:playingMusic.filename];
    self.totalTimeLabel.text = [self stringWithTime:self.player.duration];
    
    self.player.delegate = self;
    
    [self addProgressTimer];
    [self addLrcTimer];
    [self updateInfo];
    
    self.playOrStopButton.selected = NO;
}
- (void)stopPlayingMusic {
    
    self.songeName.text = nil;
    self.singerName.text = nil;
    self.singerIcon.image = [UIImage imageNamed:@"play_cover_pic_bg"];
    self.totalTimeLabel.text = nil;
    
    [YYAudioTools stopMusicWithName:self.playingMusic.filename];
    
    [self removeProgressTimer];
    [self removeLrcTimer];
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

- (void)addLrcTimer {
    if (self.LrcView.hidden) {
        return;
    }
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcTimer)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [self updateLrcTimer];
}
- (void)removeLrcTimer {
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
}

#pragma mark - 更新进度条的内容

- (void)updateInfo {
    
    CGFloat progressRatio = self.player.currentTime / self.player.duration;
    self.sliderLeftConstrant.constant = progressRatio * (self.view.width - self.sliderButton.width);
    
    NSString *currentTimeStr = [self stringWithTime:self.player.currentTime];
    [self.sliderButton setTitle:currentTimeStr forState:UIControlStateNormal];
}
- (void)updateLrcTimer {
    self.LrcView.currentTime = self.player.currentTime;
}

- (IBAction)tapProgressBackground:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:sender.view];
    
    if (point.x <= self.sliderButton.width * 0.5) {
        self.sliderLeftConstrant.constant = 0;
    }
    else if (point.x >= self.view.width - self.sliderButton.width * 0.5) {
        self.sliderLeftConstrant.constant = self.view.width - self.sliderButton.width - 1;
    }
    else {
        self.sliderLeftConstrant.constant = point.x - self.sliderButton.width * 0.5;
    }
    
    CGFloat progressRatio = self.sliderLeftConstrant.constant / (self.view.width - self.sliderButton.width);
    CGFloat currentTime = progressRatio * self.player.duration;
    
    self.player.currentTime = currentTime;
    
    [self updateInfo];
}
- (IBAction)panSliderButton:(UIPanGestureRecognizer *)sender {
    
    CGPoint point = [sender translationInView:sender.view];
    [sender setTranslation:CGPointZero inView:sender.view];
    
    if (self.sliderLeftConstrant.constant + point.x <= 0) {
        self.sliderLeftConstrant.constant = 0;
    }
    else if (self.sliderLeftConstrant.constant >= self.view.width - self.sliderButton.width) {
        self.sliderLeftConstrant.constant = self.view.width - self.sliderButton.width - 1;
    }
    else {
        self.sliderLeftConstrant.constant += point.x;
    }
    
    CGFloat progressRatio = self.sliderLeftConstrant.constant / (self.view.width - self.sliderButton.width);
    CGFloat currentTime = progressRatio * self.player.duration;
    
    NSString *currentTimeStr = [self stringWithTime:currentTime];
    [self.sliderButton setTitle:currentTimeStr forState:UIControlStateNormal];
    self.showTimeLabel.text = currentTimeStr;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        [self removeProgressTimer];
        self.showTimeLabel.hidden = NO;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
       
        self.player.currentTime = currentTime;
        [self addProgressTimer];
        self.showTimeLabel.hidden = YES;
    }
}

#pragma mark - 音乐暂停、上一首、下一首
- (IBAction)playorStopButton {
    
    self.playOrStopButton.selected = !self.playOrStopButton.selected;
    
    if (self.player.playing) {
        [self.player pause];
        [self removeProgressTimer];
        [self removeLrcTimer];
    } else {
        [self.player play];
        [self addProgressTimer];
        [self addLrcTimer];
    }
}

- (IBAction)previousButtonClick {

    [self stopPlayingMusic];
    [YYMusicTools previousMusic];
    [self startPlayingMusic];
   
    if (!self.LrcView.hidden) {
        [self soneLrcs:nil];
    }
}

- (IBAction)nextButtonClick {

    [self stopPlayingMusic];
    [YYMusicTools previousMusic];
    [self startPlayingMusic];
    
    if (!self.LrcView.hidden) {
        [self soneLrcs:nil];
    }
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        [self nextButtonClick];
    }
}
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    [self playorStopButton];
}
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player {
    [self playorStopButton];
}


#pragma mark - 显示歌词
- (IBAction)soneLrcs:(UIButton *)sender {
    self.showLrcButton.selected = !self.showLrcButton.selected;
    self.LrcView.hidden = !self.LrcView.hidden;
    
    if (self.LrcView.hidden) {
        [self removeLrcTimer];
    } else {
        [self addLrcTimer];
    }
}

#pragma mark - 私有方法
- (NSString *)stringWithTime:(NSTimeInterval)time {
    NSInteger minute = time / 60;
    NSInteger second = (NSInteger)time % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld",minute, second];
}

@end
