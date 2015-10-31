//
//  YYMusicTools.h
//  Musics
//
//  Created by 杨振 on 15/10/31.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YYMusic;

@interface YYMusicTools : NSObject

/// 获取所有音乐的数组
+ (NSArray *)musics;

/// 获取当前正在播放的音乐
+ (YYMusic *)playingMusic;

/// 设置正在播放的音乐
+ (void)setPlayingMusic:(YYMusic *)playingMusic;

/// 下一首
+ (YYMusic *)nextMusic;

/// 上一首
+ (YYMusic *)previousMusic;

@end
