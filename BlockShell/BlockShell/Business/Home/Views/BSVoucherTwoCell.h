//
//  BSVoucherTwoCell.h
//  BlockShell
//
//  Created by 李顺风 on 2018/6/22.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSVoucherTwoCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *symbolLab1;
@property (weak, nonatomic) IBOutlet UILabel *amountLab1;
@property (weak, nonatomic) IBOutlet UILabel *price1;
@property (weak, nonatomic) IBOutlet UILabel *forceLab1;
@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UILabel *symbolLab2;
@property (weak, nonatomic) IBOutlet UILabel *amountLab2;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UILabel *forceLab2;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UILabel *symbolLab3;
@property (weak, nonatomic) IBOutlet UILabel *amountLab3;
@property (weak, nonatomic) IBOutlet UILabel *price3;
@property (weak, nonatomic) IBOutlet UILabel *forceLab3;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UILabel *symbolLab4;
@property (weak, nonatomic) IBOutlet UILabel *amountLab4;
@property (weak, nonatomic) IBOutlet UILabel *price4;
@property (weak, nonatomic) IBOutlet UILabel *forceLab4;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UILabel *symbolLab5;
@property (weak, nonatomic) IBOutlet UILabel *amountLab5;
@property (weak, nonatomic) IBOutlet UILabel *price5;
@property (weak, nonatomic) IBOutlet UILabel *forceLab5;
@property (weak, nonatomic) IBOutlet UIButton *btn5;

@property (weak, nonatomic) IBOutlet UILabel *symbolLab6;
@property (weak, nonatomic) IBOutlet UILabel *amountLab6;
@property (weak, nonatomic) IBOutlet UILabel *price6;
@property (weak, nonatomic) IBOutlet UILabel *forceLab6;
@property (weak, nonatomic) IBOutlet UIButton *btn6;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/**  cell商品  */
@property (nonatomic, strong) NSMutableArray *dataArray;








@end
