//
//  BSVoucherOneCell.h
//  BlockShell
//
//  Created by 李顺风 on 2018/6/22.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSVoucherOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UIButton *phoneListBtn;

@property (weak, nonatomic) IBOutlet UILabel *phoneType;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHc;


@end
