//
//  YYPlayingViewController.m
//  Musics
//
//  Created by 杨振 on 15/10/30.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import "YYPlayingViewController.h"
#import "UIView+AdjustFrame.h"
@interface YYPlayingViewController ()

@end

@implementation YYPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)show {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.view.frame = window.bounds;
    [window addSubview:self.view];

    self.view.y = self.view.height;
    [UIView animateWithDuration:1.0 animations:^{
        self.view.y = 0;
    }];
}

@end
