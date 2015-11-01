//
//  YYLrcCell.m
//  Musics
//
//  Created by 杨振 on 15/10/31.
//  Copyright © 2015年 杨振. All rights reserved.
//

#import "YYLrcCell.h"
#import "YYLrcLine.h"

@implementation YYLrcCell

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView {

    static NSString *ID = @"LrcCell";
    YYLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YYLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewRowActionStyleNormal;
   
    return cell;
}

- (void)setLrcLine:(YYLrcLine *)lrcLine {
    _lrcLine = lrcLine;
    self.textLabel.text = lrcLine.text;
    
}


@end
