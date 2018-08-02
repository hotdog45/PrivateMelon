//
//  BSAddressCell.h
//  BlockShell
//
//  Created by 李顺风 on 2018/7/2.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIButton *defaultAddressBtn;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;





@end
