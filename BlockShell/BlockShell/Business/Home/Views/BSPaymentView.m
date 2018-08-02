//
//  BSPaymentView.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/25.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSPaymentView.h"

@implementation BSPaymentView

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.backgroundColor = LRRGBHex(0xF5F5F5);
    _lineHc.constant = OnePxLinne;
    _line2Hc.constant = OnePxLinne;
    
}


/**  View  */
+ (instancetype)paymentView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
