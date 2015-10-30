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

@interface ViewController ()
/// 保存所有音乐的数组
@property (nonatomic, strong) NSArray *musics;
@property (nonatomic, strong) YYPlayingViewController *playerVc;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
}
#pragma mark - 懒加载数据
- (NSArray *)musics {
    if (_musics == nil) {
        self.musics = [YYMusic objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
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
    // 2.弹出控制器
    [self.playerVc show];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.musics.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"musicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    YYMusic *music = self.musics[indexPath.row];
    
    cell.textLabel.text = music.name;
    cell.detailTextLabel.text = music.filename;
    cell.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:2.5 borderColor:[UIColor purpleColor]];
    
    return cell;
}

@end
