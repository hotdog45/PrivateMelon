//
//  BSVoucherOneCell.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/22.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSVoucherOneCell.h"

@implementation BSVoucherOneCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _lineHc.constant = OnePxLinne;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
