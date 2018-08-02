//
//  BSTableViewCell.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/21.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSTableViewCell.h"

@implementation BSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = LRRGBHex(0xF5F5F5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
