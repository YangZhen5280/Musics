//
//  YYLrcCell.h
//  Musics
//
//  Created by 杨振 on 15/10/31.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYLrcLine;
@interface YYLrcCell : UITableViewCell

@property (nonatomic, strong) YYLrcLine *lrcLine;

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;

@end
