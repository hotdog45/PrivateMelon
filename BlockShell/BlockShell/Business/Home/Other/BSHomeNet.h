//
//  BSHomeNet.h
//  BlockShell
//
//  Created by 李顺风 on 2018/7/11.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>


//号码归属地查询
static NSString *const HomeVirtualserviceLocationbyphone = @"virtualservice/virtualservice/locationbyphone";

//付款
static NSString *const HomeTradeOrderCreateImmediatelyOrder = @"trade/order/createImmediatelyOrder.json";
//查询虚拟销售商品(买家展示用)
static NSString *const HomeVirtualserviceQueryvirtualitem = @"virtualservice/virtualservice/queryvirtualitem";
//充值话费结果查询（单条）
static NSString *const HomeVirtualservicePhonevalueendquery = @"virtualservice/virtualservice/phonevalueendquery";
//话费充值
static NSString *const HomeVirtualservicePhonevaluepay = @"virtualservice/virtualservice/phonevaluepay";






@interface BSHomeNet : NSObject

/** 单例 */
+ (instancetype)sharedInstance;



//号码归属地查询
- (void)postVirtualserviceLocationbyphoneWithParameters:(NSDictionary *) param
                                               Complete:(void (^)(BSLocationbyphoneModel *model))completeBlock
                                                 failed:(void (^)(NSString *error))failedBlock;


//去支付
- (void)postTradeOrderCreateImmediatelyOrderWithParameters:(NSDictionary *) param
                                                  Complete:(void (^)(BSTradeOrderModel *model))completeBlock
                                                    failed:(void (^)(NSString *error))failedBlock;


//拉取虚拟商品列表
- (void)postVirtualserviceQueryvirtualitemWithParameters:(NSDictionary *) param
                                                Complete:(void (^)(NSArray *array))completeBlock
                                                  failed:(void (^)(NSString *error))failedBlock;

//充值话费结果查询（单条）
- (void)postVirtualservicePhonevalueendqueryWithParameters:(NSDictionary *) param
                                                  Complete:(void (^)(NSArray *array))completeBlock
                                                    failed:(void (^)(NSString *error))failedBlock;
//话费充值
- (void)postVirtualservicePhonevaluepayWithParameters:(NSDictionary *) param
                                             Complete:(void (^)(NSArray *array))completeBlock
                                               failed:(void (^)(NSString *error))failedBlock;














@end
