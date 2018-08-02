//
//  BSTableViewCell.h
//  BlockShell
//
//  Created by 李顺风 on 2018/6/21.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *myOrderBtn;

@property (weak, nonatomic) IBOutlet UIButton *allOrderBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line1H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line2H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line3H;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellHeightc;

@property (weak, nonatomic) IBOutlet UILabel *paymentLab;

@property (weak, nonatomic) IBOutlet UILabel *deliverLab;

@property (weak, nonatomic) IBOutlet UILabel *collectedLab;

@property (weak, nonatomic) IBOutlet UILabel *evaluatesLab;

@property (weak, nonatomic) IBOutlet UILabel *afterSaleLab;

@property (weak, nonatomic) IBOutlet UILabel *shopSworkbenchLab;

@property (weak, nonatomic) IBOutlet UILabel *InvitingFriendsLab;

@property (weak, nonatomic) IBOutlet UILabel *JoinBlockSheelLab;

@property (weak, nonatomic) IBOutlet UILabel *CustomerServiceLab;

@property (weak, nonatomic) IBOutlet UILabel *SettingLab;




@property (weak, nonatomic) IBOutlet UIButton *paymentBtn;
@property (weak, nonatomic) IBOutlet UIButton *DeliverBtn;

@property (weak, nonatomic) IBOutlet UIButton *collectedBtn;

@property (weak, nonatomic) IBOutlet UIButton *evaluatesBtn;

@property (weak, nonatomic) IBOutlet UIButton *afterSaleBtn;

@property (weak, nonatomic) IBOutlet UIButton *shopWorkBenchBtn;

@property (weak, nonatomic) IBOutlet UIButton *invitingFriendsBtn;

@property (weak, nonatomic) IBOutlet UIButton *joinBlockShellBtn;

@property (weak, nonatomic) IBOutlet UIButton *customerServiceBtn;

@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
















@end
