//
//  BSVoucherFlowCell.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/22.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSVoucherFlowCell.h"
#import "BSVoucherCollectionCell.h"


@implementation BSVoucherFlowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self configureCollectionView];
}

- (void)configureCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置缩进量
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 15;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 20, 15);
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-60)/3, (SCREEN_WIDTH-60)/3 + 20);
    
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    // 注册collectionCell
    [self.collectionView registerNib:[UINib nibWithNibName:@"BSVoucherCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BSVoucherCollectionCell"];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BSVoucherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BSVoucherCollectionCell" forIndexPath:indexPath];
    //    cell.type = indexPath.row % 2;
    cell.type1.hidden = YES;
    cell.type2.hidden = NO;
    cell.type3.hidden = YES;
    BSQueryvirtualitemModel *model = self.dataArr[indexPath.row];
    
    cell.amountLab.text = model.priceYuan.stringValue;
    cell.price.text = model.discountPrice.stringValue;
    cell.forceLab.text = model.bksPrice.stringValue;
    
    
    return cell;
}


// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectionView2SelectItem" object:self userInfo:@{@"index":@(indexPath.row)}];
    
}
@end
