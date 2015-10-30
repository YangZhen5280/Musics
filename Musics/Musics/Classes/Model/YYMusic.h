//
//  YYMusic.h
//  Musics
//
//  Created by 杨振 on 15/10/30.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYMusic : NSObject
/*
 <key>name</key>
 <string>月半小夜曲</string>
 <key>filename</key>
 <string>1201111234.mp3</string>
 <key>lrcname</key>
 <string>月半小夜曲.lrc</string>
 <key>singer</key>
 <string>李克勤</string>
 <key>singerIcon</key>
 <string>lkq_icon.jpg</string>
 <key>icon</key>
 <string>lkq.jpg</string>
*/
/// 歌曲名字
@property (nonatomic, copy) NSString *name;
/// 歌曲对应的文件名
@property (nonatomic, copy) NSString *filename;
/// 歌词名称
@property (nonatomic, copy) NSString *lrcname;
/// 歌手
@property (nonatomic, copy) NSString *singer;
/// 歌手头像
@property (nonatomic, copy) NSString *singerIcon;
/// 歌手封面
@property (nonatomic, copy) NSString *icon;

@end
