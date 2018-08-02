//
//  BSBaseCell.m
//  BlockShell
//
//  Created by 李顺风 on 2018/7/6.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSBaseCell.h"

@implementation BSBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
