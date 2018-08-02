//
//  BSMineHeaderView.h
//  BlockShell
//
//  Created by 李顺风 on 2018/6/21.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSMineHeaderView : UIView



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconHeightc;





@property (weak, nonatomic) IBOutlet UIButton *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIButton *tag1;

@property (weak, nonatomic) IBOutlet UIButton *tag2;

@property (weak, nonatomic) IBOutlet UIButton *tag3;

@property (weak, nonatomic) IBOutlet UILabel *shellNum;

@property (weak, nonatomic) IBOutlet UILabel *shellLab;

@property (weak, nonatomic) IBOutlet UILabel *calculationNum;


@property (weak, nonatomic) IBOutlet UILabel *calculationLab;

@property (weak, nonatomic) IBOutlet UIButton *shellBtn;

@property (weak, nonatomic) IBOutlet UIButton *calculationBtn;




/**  View  */
+ (instancetype)mineHeaderView ;






@end
