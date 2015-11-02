//
//  AppDelegate.m
//  Musics
//
//  Created by 杨振 on 15/10/30.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.拿到AVAudioSession
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 2.设置类型
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 3.激活
    [session setActive:YES error:nil];
    
    // Override point for customization after application launch.
    return YES;
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 开启后台任务
    [application beginBackgroundTaskWithExpirationHandler:nil];
}


@end
