//
//  BSQueryvirtualitemModel.h
//  BlockShell
//
//  Created by 李顺风 on 2018/7/13.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSBaseJSONModel.h"

@interface BSQueryvirtualitemModel : BSBaseJSONModel
@property(nonatomic) NSString  * property;
@property(nonatomic) NSString  * title;
@property(nonatomic) NSString  * feature;
@property(nonatomic) NSString  * priceYuanString;
@property(nonatomic) NSString  * bksPriceYuanString;

@property(nonatomic) NSNumber  * traceId;
@property(nonatomic) NSNumber  * rpcId;
@property(nonatomic) NSNumber  * skuId;
@property(nonatomic) NSNumber  * pskuId;
@property(nonatomic) NSNumber  * sellerId;
@property(nonatomic) NSNumber  * itemId;
@property(nonatomic) NSNumber  * skuCode;
@property(nonatomic) NSNumber  * sku69code;
@property(nonatomic) NSNumber  * inventory;
@property(nonatomic) NSNumber  * price;

@property(nonatomic) NSNumber  * discountPrice;
@property(nonatomic) NSNumber  * bksPrice;
@property(nonatomic) NSNumber  * status;
@property(nonatomic) NSNumber  * gmtCreate;
@property(nonatomic) NSNumber  * gmtModified;
@property(nonatomic) NSNumber  * productId;
@property(nonatomic) NSNumber  * outerCode;
@property(nonatomic) NSNumber  * quantity;
@property(nonatomic) NSNumber  * priceYuan;

@property(nonatomic) NSArray  * propertyList;
@end
//"traceId": null,
//"rpcId": null,
//"skuId": 10091,
//"pskuId": 10007,
//"sellerId": 1,
//"itemId": 116,
//"skuCode": null,
//"sku69code": null,
//"property": "",
//"inventory": 0,
//"price": 3000,
//"discountPrice": 2980,
//"bksPrice": 2980,
//"status": 1,
//"gmtCreate": 1530845207000,
//"gmtModified": 1530845207000,
//"productId": null,
//"title": null,
//"feature": null,
//"outerCode": null,
//"quantity": 0,
//"propertyList": [],
//"priceYuan": 30,
//"discountPriceYuan": 29.8,
//"bksPriceYuan": 29.8,
//"priceYuanString": "30.00",
//"discountPriceYuanString": "30.00",
//"bksPriceYuanString": "30.00"
