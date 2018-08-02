//
//  LLLoginNet.m
//  BlockShell
//
//  Created by 李顺风 on 2018/4/5.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLLoginNet.h"

@implementation LLLoginNet

/** 单例 */
+ (instancetype)sharedInstance
{
    static LLLoginNet *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == instance) {
            instance = [[LLLoginNet alloc] init];
        }
    });
    
    return instance;
}


// 测试 /uni/data  参数{page=1, perPage=20}

//发送验证码
- (void)postUsersSmiWithParameters:(NSDictionary *) param
                          Complete:(void (^)(void))completeBlock
                            failed:(void (^)(NSString *error))failedBlock
{
    [BSWebService postRequest:LLUsersSendverifycode
     hostType:HostTypeEntity
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              completeBlock();
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}









//登录
- (void)postUsermanagerUsersLoginWithParameters:(NSDictionary *) param
                                       Complete:(void (^)(void))completeBlock
                                         failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:LLUsermanagerUsersLogin
     hostType:HostTypeEntity
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              [LLLoginManager setAuthToken:data[KEY_VALUE]];
                              completeBlock();
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}
//授权绑定手机号
- (void)postUserAuthbindphoneWithParameters:(NSDictionary *) param
                                   Complete:(void (^)(void))completeBlock
                                     failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:LLUserAuthbindphone
     hostType:HostTypeEntity
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              completeBlock();
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}
//授权登录
- (void)postUsermanagerUserAuthloginWithParameters:(NSDictionary *) param
                                          Complete:(void (^)(void))completeBlock
                                            failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:LLUsermanagerUserAuthlogin
     hostType:HostTypeEntity
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              completeBlock();
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}
//查询用户信息
- (void)postUsermanagerUserQueryuserWithParameters:(NSDictionary *) param
                                          Complete:(void (^)(LLUserModel *model))completeBlock
                                               failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:LLUsermanagerUserQueryuser
     hostType:HostTypeEntity
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              
                              NSError *err;
                              LLUserModel *model = [[LLUserModel alloc]
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
//退出登录
- (void)postUsermanagerUsersLogoutComplete:(void (^)(void))completeBlock
                                          failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:LLUsermanagerUsersLogout
     hostType:HostTypeEntity
                   parameters:nil
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              completeBlock();
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}
//更新用户资料
- (void)postUsermanagerUsersUpdateuserinfoSmiWithParameters:(NSDictionary *) param
                                                   Complete:(void (^)(void))completeBlock
                                                     failed:(void (^)(NSString *error))failedBlock{
    [BSWebService postRequest:LLUsermanagerUsersUpdateuserinfo
     hostType:HostTypeEntity
                   parameters:param
                     progress:nil
                      success:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (status == kNoError) {
                              completeBlock();
                          } else {
                              if (failedBlock) failedBlock(NET_DESP);
                          }
                      } failure:^(ErrorCode status, NSString *msg, NSDictionary *data) {
                          if (failedBlock) failedBlock(NET_DESP);
                      }];
}




@end
