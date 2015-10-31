//
//  ViewController.m
//  Musics
//
//  Created by 杨振 on 15/10/30.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "YYMusic.h"
#import "UIImage+Circle.h"
#import "YYPlayingViewController.h"
#import "YYMusicTools.h"

@interface ViewController ()
/// 保存所有音乐的数组
@property (nonatomic, strong) YYPlayingViewController *playerVc;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
}
- (YYPlayingViewController *)playerVc {
    if (_playerVc == nil) {
        _playerVc = [[YYPlayingViewController alloc] init];
    }
    return _playerVc;
}
#pragma mark - 数据源方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.让cell变成为不可选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YYMusic *music = [YYMusicTools musics][indexPath.row];
    
    [YYMusicTools setPlayingMusic:music];
    
    // 2.弹出控制器
    [self.playerVc show];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [YYMusicTools musics].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"musicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    YYMusic *music = [YYMusicTools musics][indexPath.row];
    
    cell.textLabel.text = music.name;
    cell.detailTextLabel.text = music.filename;
    cell.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:2.5 borderColor:[UIColor purpleColor]];
    
    return cell;
}

@end
