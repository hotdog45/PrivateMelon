//
//  BSVoucherCollectionCell.h
//  BlockShell
//
//  Created by 李顺风 on 2018/6/22.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSVoucherCollectionCell : UICollectionViewCell

@property (assign, nonatomic) int type;

@property (weak, nonatomic) IBOutlet UILabel *symbolLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *forceLab;
@property (weak, nonatomic) IBOutlet UIView *type1;



@property (weak, nonatomic) IBOutlet UIView *type2;

@property (weak, nonatomic) IBOutlet UILabel *amountLab2;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UILabel *forceLab2;


@property (weak, nonatomic) IBOutlet UILabel *moreLab;
@property (weak, nonatomic) IBOutlet UIView *type3;












@end
