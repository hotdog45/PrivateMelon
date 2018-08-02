//
//  BSTradeOrderModel.h
//  BlockShell
//
//  Created by 李顺风 on 2018/7/13.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSBaseJSONModel.h"

@interface BSTradeOrderModel : BSBaseJSONModel

@property(nonatomic) NSNumber  * traceId;
@property(nonatomic) NSNumber  * rpcId;
@property(nonatomic) NSNumber  * orderId;
@property(nonatomic) NSNumber  * payway;
@property(nonatomic) id<Optional> payInfo;

@end


@interface BSTradeOrderwxModel : BSBaseJSONModel

@property(nonatomic) NSString  * prepayid;
@property(nonatomic) NSString  * noncestr;
@property(nonatomic) NSString  * sign;
@property(nonatomic) NSString  * partnerid;
@property(nonatomic) NSString  * appid;

@property(nonatomic) NSNumber  * timestamp;
@property(nonatomic) NSString  * pack;

@end

//"traceId": null,
//"rpcId": null,
//"orderId": 100000000110010000,
//"payInfo": {
//    "prepayid": "wx12151229907951c37ee698533907298479",
//    "noncestr": "EC9453B8329B2402",
//    "timestamp": 1531379549,
//    "sign": "4AD4A48427B148BB52C0D481AA80FCF8",
//    "appid": "wxdf3989b2edb80672",
//    "partnerid": "1385693802",
//    "pack": "Sign=WXPay"
//},
//"payway": 2
