//
//  YYAudioTools.m
//  Musics
//
//  Created by 杨振 on 15/10/31.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import "YYAudioTools.h"

@implementation YYAudioTools

static NSMutableDictionary *_soundIDs;
static NSMutableDictionary *_musics;

+ (void)initialize
{
    _soundIDs = [NSMutableDictionary dictionary];
    _musics = [NSMutableDictionary dictionary];
}
#pragma mark - 播放音乐
+ (AVAudioPlayer *)playMusicWithName:(NSString *)musicName {
    
    assert(musicName);
    
    AVAudioPlayer *player = _musics[musicName];
    
    if (player == nil) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:musicName withExtension:nil];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [player prepareToPlay];
        
        _musics[musicName] = player;
    }
    [player play];
  
    return player;
}

+ (void)pauseMusicWithName:(NSString *)musicName {
    assert(musicName);
    AVAudioPlayer *player = _musics[musicName];
    if (player) {
        [player pause];
    }
}

+ (void)stopMusicWithName:(NSString *)musicName {
    assert(musicName);
    AVAudioPlayer *player = _musics[musicName];
    if (player) {
        [player stop];
        player = nil;
        [_musics removeObjectForKey:musicName];
    }
}

#pragma mark - 播放音效
+ (void)playSoundWithName:(NSString *)soundName {
    SystemSoundID soundID = [_soundIDs[soundName] unsignedIntValue];
    
    if (soundID == 0) {
        NSURL *buyaoUrl = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(buyaoUrl), &soundID);
        _soundIDs[soundName] = @(soundID);
    }
    AudioServicesDisposeSystemSoundID(soundID);
}

+ (void)disposeSoundWihtName:(NSString *)soundName {
    SystemSoundID soundID = [_soundIDs[soundName] unsignedIntValue];
    if (soundID == 0) {
        AudioServicesDisposeSystemSoundID(soundID);
    }
}

@end
