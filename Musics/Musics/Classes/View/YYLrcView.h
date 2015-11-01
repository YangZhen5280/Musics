//
//  YYLrcView.h
//  Musics
//
//  Created by 杨振 on 15/10/31.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import "DRNRealTimeBlurView.h"

@interface YYLrcView : DRNRealTimeBlurView

@property (nonatomic, strong) NSString *lrcName;
@property (nonatomic, assign) NSTimeInterval currentTime;

@end
