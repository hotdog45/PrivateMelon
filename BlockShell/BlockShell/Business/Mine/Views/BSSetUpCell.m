//
//  BSSetUpCell.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/28.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSSetUpCell.h"

@implementation BSSetUpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = LRRGBHex(0xF7F8FB);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
