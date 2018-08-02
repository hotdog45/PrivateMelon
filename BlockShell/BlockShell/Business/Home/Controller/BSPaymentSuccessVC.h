//
//  BSPaymentSuccessVC.h
//  BlockShell
//
//  Created by 李顺风 on 2018/6/25.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSBaseVC.h"

@interface BSPaymentSuccessVC : BSBaseVC

@property (weak, nonatomic) IBOutlet UIButton *forceBtn;
@property (weak, nonatomic) IBOutlet UIButton *viewOrderBtn;

@property (weak, nonatomic) IBOutlet UILabel *forceLab;

@property (weak, nonatomic) IBOutlet UILabel *successLab;

@property (weak, nonatomic) IBOutlet UILabel *descLab;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@end
