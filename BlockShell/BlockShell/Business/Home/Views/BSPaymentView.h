//
//  BSPaymentView.h
//  BlockShell
//
//  Created by 李顺风 on 2018/6/25.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSPaymentView : UIView



+ (instancetype)paymentView;


@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UIButton *bgBtn;

@property (weak, nonatomic) IBOutlet UILabel *Lab1;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@property (weak, nonatomic) IBOutlet UILabel *amoutLab;

@property (weak, nonatomic) IBOutlet UILabel *forceLab;

@property (weak, nonatomic) IBOutlet UILabel *descLab;

@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;

@property (weak, nonatomic) IBOutlet UIButton *wxBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line2Hc;


@end
