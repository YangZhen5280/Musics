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
#pragma mark - 对控制器的操作
- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
    
    self.view.frame = window.bounds;
    [window addSubview:self.view];

    self.view.y = self.view.height;
    [UIView animateWithDuration:1.0 animations:^{

        self.view.y = 0;
    } completion:^(BOOL finished) {
        window.userInteractionEnabled = YES;
    }];
}
- (IBAction)close {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:1.0 animations:^{

        self.view.y = self.view.height;
    } completion:^(BOOL finished) {
        
        window.userInteractionEnabled = YES;
    }];
}

@end
