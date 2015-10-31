//
//  YYLrcView.m
//  Musics
//
//  Created by 杨振 on 15/10/31.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import "YYLrcView.h"
#import "UIView+AdjustFrame.h"
#import "YYLrcCell.h"
#import "YYLrcLine.h"

@interface YYLrcView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *lrcLines;

@end

@implementation YYLrcView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupTableView];
}
- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.bounds;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self addSubview:tableView];
    self.tableView = tableView;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.height * 0.5, 0, self.tableView.height * 0.5, 0);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lrcLines.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YYLrcCell *cell = [YYLrcCell lrcCellWithTableView:tableView];
    
    cell.lrcLine = self.lrcLines[indexPath.row];

    return cell;
}
- (void)setLrcName:(NSString *)lrcName {
    
    _lrcName = lrcName;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lrcName ofType:nil];
    NSString *lrcString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", lrcString);
    
    // 3.解析歌词
    /*
     [ti:瓦解]
     [ar:南拳妈妈]
     [al:南拳妈妈的夏天]
     
     [00:00.01]瓦解
     [00:02.74]作词：弹头（宋健彰） 作曲：周杰伦
     [00:06.09]演唱：南拳妈妈
     [00:09.06]
     [00:15.46]说着笑着的午后
     [00:19.41]钟声一直在停留
     [00:23.25]风声静静躺着在诱惑
     [00:30.89]我一个人在角落
     [00:34.80]没有你陪伴的我
     [00:38.78]连寂寞都笑我太堕落
     */
    NSArray *lrcLineStrs = [lrcString componentsSeparatedByString:@"\n"];
    NSMutableArray *tempArrM = [NSMutableArray array];
    
    for (NSString *lrcLineStr in lrcLineStrs) {
        if ([lrcLineStr hasPrefix:@"[ti"] || [lrcLineStr hasPrefix:@"[ar"] || [lrcLineStr hasPrefix:@"[al"] || ![lrcLineStr hasPrefix:@"["]) {
            continue;
        }
        NSArray *lrcLineStrParts = [lrcLineStr componentsSeparatedByString:@"]"];
        YYLrcLine *lrcLine = [[YYLrcLine alloc] init];
        lrcLine.text = [lrcLineStrParts lastObject];
        lrcLine.time = [[lrcLineStrParts firstObject] substringFromIndex:1];
        
        [tempArrM addObject:lrcLine];
    }
    self.lrcLines = tempArrM;
    
    [self.tableView reloadData];
}









@end
