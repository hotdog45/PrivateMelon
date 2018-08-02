//
//  LLHomePageCell.m
//  BlockShell
//
//  Created by 李顺风 on 2018/3/30.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLHomePageCell.h"

@implementation LLHomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = LRRandomColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
