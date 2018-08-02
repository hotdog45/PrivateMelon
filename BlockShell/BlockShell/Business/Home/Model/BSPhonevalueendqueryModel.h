//
//  BSPhonevalueendqueryModel.h
//  BlockShell
//
//  Created by 李顺风 on 2018/7/13.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSBaseJSONModel.h"
//充值话费结果查询（单条
@interface BSPhonevalueendqueryModel : BSBaseJSONModel
@property(nonatomic) NSString  * custom;
@property(nonatomic) NSString  * finishedTime;
@property(nonatomic) NSString  * status;
@property(nonatomic) NSString  * orderNumber;

@property(nonatomic) NSString  * result;
@property(nonatomic) NSString  * time;
@property(nonatomic) NSString  * msg;
@property(nonatomic) NSString  * stockprice;

@end
//{
//    "custom": "无",//备注
//    "finishedTime": "2018-07-09 15:56:30",
//    "status": "4",//充值成功
//    "orderNumber": "10000020180709100000000",
//    "msg":"查询成功",
//    "result":"t",
//    "time":"2018-07-09 15:56:29",
//    "stockprice":"10.000" //单价
//    }
