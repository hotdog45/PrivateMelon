//
//  BSVoucherTwoCell.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/22.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSVoucherTwoCell.h"
#import "BSVoucherCollectionCell.h"



@implementation BSVoucherTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureCollectionView];
    
    
    
}

- (void)configureCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置缩进量
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 15;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(11, 15, 12, 15);
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-60)/3, (SCREEN_WIDTH-60)/3 + 20);
    
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    // 注册collectionCell
    [self.collectionView registerNib:[UINib nibWithNibName:@"BSVoucherCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BSVoucherCollectionCell"];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  self.dataArray.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BSVoucherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BSVoucherCollectionCell" forIndexPath:indexPath];
//    cell.type = indexPath.row % 2;
    cell.type1.hidden = NO;
    cell.type2.hidden = YES;
    cell.type3.hidden = YES;
    BSQueryvirtualitemModel *model = self.dataArray[indexPath.row];
    
    cell.amountLab.text = model.priceYuan.stringValue;
    cell.price.text = model.discountPrice.stringValue;
    cell.forceLab.text = model.bksPrice.stringValue;
    return cell;
}

// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectionViewSelectItem" object:self userInfo:@{@"index":@(indexPath.row)}];
}

@end
