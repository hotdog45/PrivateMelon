//
//  BSPaymentSuccessVC.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/25.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSPaymentSuccessVC.h"

@interface BSPaymentSuccessVC ()

@end

@implementation BSPaymentSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Payment Success";
    _viewOrderBtn.layer.borderWidth = 1;
    _viewOrderBtn.layer.borderColor = [LRRGBHex(0x979797) CGColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithImage:[UIImage imageNamed:@"mine_icon_talk"]
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(rightBarClick)];

}

- (void)rightBarClick
{
    
    
}


@end
