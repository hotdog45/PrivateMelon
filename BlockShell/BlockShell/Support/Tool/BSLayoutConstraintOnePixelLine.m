//
//  BSLayoutConstraintOnePixelLine.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/28.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSLayoutConstraintOnePixelLine.h"

@implementation BSLayoutConstraintOnePixelLine


- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.constant == 1) {
        self.constant = 1 / [UIScreen mainScreen].scale;
    }
}

@end
