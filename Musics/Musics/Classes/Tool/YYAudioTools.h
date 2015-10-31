//
//  YYAudioTools.h
//  Musics
//
//  Created by 杨振 on 15/10/31.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface YYAudioTools : NSObject

/**
 *  播放音乐
 */
+ (AVAudioPlayer *)playMusicWithName:(NSString *)musicName;

/**
 *  暂停音乐
 */
+ (void)pauseMusicWithName:(NSString *)musicName;

/**
 *  停止音乐
 */
+ (void)stopMusicWithName:(NSString *)musicName;

/**
 *  播放音效
 */
+ (void)playSoundWithName:(NSString *)soundName;

/**
 *  销毁音效
 */
+ (void)disposeSoundWihtName:(NSString *)soundName;

@end
