//
//  BSMineHeaderView.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/21.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSMineHeaderView.h"

@implementation BSMineHeaderView



- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = LRRGBHex(0xF5F5F5);
    
    
    LRViewBorderRadius(self.tag1, 2, OnePxLinne, LRRGBHex(0x333333))
    LRViewBorderRadius(self.tag2, 2, OnePxLinne, LRRGBHex(0x333333))
    LRViewBorderRadius(self.tag3, 2, OnePxLinne, LRRGBHex(0x333333))
    
}


/**  View  */
+ (instancetype)mineHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}












@end
