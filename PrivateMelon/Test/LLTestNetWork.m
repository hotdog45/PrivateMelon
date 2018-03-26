//
//  LLTestNetWork.m
//  PrivateMelon
//
//  Created by 李顺风 on 2018/3/26.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLTestNetWork.h"
#import "HXQWebService.h"
static NSString *const Uni_data = @"uni/data";
static NSString *const LLUC = @"uc";

#define NET_DESP (msg && msg.length > 0) ? msg : NSLocalizedString(@"Network Error", nil)
@implementation LLTestNetWork

/** 单例 */
+ (instancetype)sharedInstance
{
    static LLTestNetWork *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == instance) {
            instance = [[LLTestNetWork alloc] init];
        }
    });
    
    return instance;
}


// 测试 /uni/data  参数{page=1, perPage=20}
- (void)getUniDataWithParameters:(NSDictionary *) param
                        Complete:(void (^)(LLSchoolListModel *model))completeBlock
                          failed:(void (^)(NSString *error))failedBlock
{
    [HXQWebService getRequest:Uni_data
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              NSError *err;
                              LLSchoolListModel *list = [[LLSchoolListModel alloc]
                                                         initWithDictionary:data
                                                         error:&err];
                              if (!err) {
                                  if (completeBlock) completeBlock(list);
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

- (void)getLLUCWithParameters:(NSDictionary *) param
                     Complete:(void (^)(UCUCityBaseListMdoel *list))completeBlock
                       failed:(void (^)(NSString *error))failedBlock
{
    [HXQWebService getRequest:LLUC
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              NSError *err;
                              UCUCityBaseListMdoel *m = [[UCUCityBaseListMdoel alloc]
                                                         initWithDictionary:data
                                                         error:&err];
                              if (!err) {
                                  if (completeBlock) completeBlock(m);
                              } else {
                                  if (failedBlock)
                                      failedBlock(NSLocalizedString(@"json解析错误", nil));
                              }
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}
@end
