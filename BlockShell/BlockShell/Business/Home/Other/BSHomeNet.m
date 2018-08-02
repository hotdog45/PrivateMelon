//
//  BSHomeNet.m
//  BlockShell
//
//  Created by 李顺风 on 2018/7/11.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSHomeNet.h"

@implementation BSHomeNet
/** 单例 */
+ (instancetype)sharedInstance
{
    static BSHomeNet *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == instance) {
            instance = [[BSHomeNet alloc] init];
        }
    });
    
    return instance;
}


//号码归属地查询
- (void)postVirtualserviceLocationbyphoneWithParameters:(NSDictionary *) param
                                               Complete:(void (^)(BSLocationbyphoneModel *model))completeBlock
                                                 failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:HomeVirtualserviceLocationbyphone
                     hostType:HostTypeVirtual
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              NSError *err;
                              BSLocationbyphoneModel *model = [[BSLocationbyphoneModel alloc]
                                                    initWithDictionary:data
                                                    error:&err];
                              if (!err) {
                                  if (completeBlock) completeBlock(model);
                              } else {
                                  if (failedBlock)
                                      failedBlock(NSLocalizedString(@"Parse Error", nil));
                              }
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}
//去支付
- (void)postTradeOrderCreateImmediatelyOrderWithParameters:(NSDictionary *) param
                                                  Complete:(void (^)(BSTradeOrderModel *model))completeBlock
                                                    failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:HomeTradeOrderCreateImmediatelyOrder
                     hostType:HostTypePay
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              NSError *err;
                              BSTradeOrderModel *model = [[BSTradeOrderModel alloc]
                                                               initWithDictionary:data
                                                               error:&err];
                              if (!err) {
                                  if (completeBlock) completeBlock(model);
                              } else {
                                  if (failedBlock)
                                      failedBlock(NSLocalizedString(@"Parse Error", nil));
                              }
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}

//拉取虚拟商品列表
- (void)postVirtualserviceQueryvirtualitemWithParameters:(NSDictionary *) param
                                                Complete:(void (^)(NSArray *array))completeBlock
                                                  failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:HomeVirtualserviceQueryvirtualitem
                     hostType:HostTypeVirtual
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              if (completeBlock) completeBlock([data objectForKey:KEY_LIST]);
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}


- (void)postVirtualservicePhonevalueendqueryWithParameters:(NSDictionary *) param
                                                  Complete:(void (^)(NSArray *array))completeBlock
                                                    failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:HomeVirtualservicePhonevalueendquery
                     hostType:HostTypeVirtual
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              if (completeBlock) completeBlock([data objectForKey:KEY_LIST]);
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}
//话费充值
- (void)postVirtualservicePhonevaluepayWithParameters:(NSDictionary *) param
                                             Complete:(void (^)(NSArray *array))completeBlock
                                               failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:HomeVirtualservicePhonevaluepay
                     hostType:HostTypeVirtual
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              if (completeBlock) completeBlock([data objectForKey:KEY_LIST]);
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}





@end
