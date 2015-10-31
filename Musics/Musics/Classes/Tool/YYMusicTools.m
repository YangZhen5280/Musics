//
//  YYMusicTools.m
//  Musics
//
//  Created by 杨振 on 15/10/31.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import "YYMusicTools.h"
#import "MJExtension.h"
#import "YYMusic.h"
@implementation YYMusicTools

static NSArray *_musics;
static YYMusic *_playingMusic;

+ (void)initialize {
    _musics = [YYMusic objectArrayWithFilename:@"Musics.plist"];
}

+ (NSArray *)musics {
    return _musics;
}

+ (YYMusic *)playingMusic {
    return _playingMusic;
}

+ (void)setPlayingMusic:(YYMusic *)playingMusic {
    assert(playingMusic);
    _playingMusic = playingMusic;
}

+ (YYMusic *)nextMusic {
    // 1.获取当前正在播放的音乐
    NSInteger currentMusicIndex = [_musics indexOfObject:_playingMusic];
    
    currentMusicIndex++;
    if (currentMusicIndex > _musics.count - 1) {
        currentMusicIndex = 0;
    }
    
    YYMusic *music = _musics[currentMusicIndex];
    _playingMusic = music;
    
    return music;
}

+ (YYMusic *)previousMusic {
    
    NSInteger currentMusicIndex = [_musics indexOfObject:_playingMusic];
    
    currentMusicIndex--;
    if (currentMusicIndex < 0) {
        currentMusicIndex = _musics.count - 1;
    }
    YYMusic *music = _musics[currentMusicIndex];
    _playingMusic = music;
    
    return music;
}

@end
