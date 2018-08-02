//
//  BSVoucherCollectionCell.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/22.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSVoucherCollectionCell.h"

@implementation BSVoucherCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];



    


}

-(void)setType:(int)type{
    if (_type == 1) {//话费
        _type3.hidden = true;
        _type2.hidden = true;
        _type1.hidden = false;
    } else if (_type == 2){//流量
        _type3.hidden = true;
        _type2.hidden = false;
        _type1.hidden = true;
    } else if (_type == 3){ //更多
        _type3.hidden = false;
        _type2.hidden = true;
        _type1.hidden = true;
    }
}

@end
