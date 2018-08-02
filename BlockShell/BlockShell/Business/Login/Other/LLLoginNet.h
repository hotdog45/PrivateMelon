//
//  LLLoginNet.h
//  BlockShell
//
//  Created by 李顺风 on 2018/4/5.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import <Foundation/Foundation.h>


//发送验证码
static NSString *const LLUsersSendverifycode = @"usermanager/user/sendverifycode";
//登录
static NSString *const LLUsermanagerUsersLogin = @"usermanager/user/login";
//授权绑定手机号
static NSString *const LLUserAuthbindphone = @"usermanager/user/authbindphone";
//授权登录
static NSString *const LLUsermanagerUserAuthlogin = @"usermanager/user/authlogin";
//查询用户信息
static NSString *const LLUsermanagerUserQueryuser = @"usermanager/user/queryuser";
//退出登录
static NSString *const LLUsermanagerUsersLogout = @"usermanager/user/logout";
//更新用户资料
static NSString *const LLUsermanagerUsersUpdateuserinfo = @"usermanager/user/updateuserinfo";

@interface LLLoginNet : NSObject

/** 单例 */
+ (instancetype)sharedInstance;



//验证码
- (void)postUsersSmiWithParameters:(NSDictionary *) param
                          Complete:(void (^)(void))completeBlock
                            failed:(void (^)(NSString *error))failedBlock;

//登录
- (void)postUsermanagerUsersLoginWithParameters:(NSDictionary *) param
                          Complete:(void (^)(void))completeBlock
                            failed:(void (^)(NSString *error))failedBlock;
//授权绑定手机号
- (void)postUserAuthbindphoneWithParameters:(NSDictionary *) param
                          Complete:(void (^)(void))completeBlock
                            failed:(void (^)(NSString *error))failedBlock;
//授权登录
- (void)postUsermanagerUserAuthloginWithParameters:(NSDictionary *) param
                          Complete:(void (^)(void))completeBlock
                            failed:(void (^)(NSString *error))failedBlock;
//查询用户信息
- (void)postUsermanagerUserQueryuserWithParameters:(NSDictionary *) param
                                          Complete:(void (^)(LLUserModel *model))completeBlock
                            failed:(void (^)(NSString *error))failedBlock;
//退出登录
- (void)postUsermanagerUsersLogoutComplete:(void (^)(void))completeBlock
                            failed:(void (^)(NSString *error))failedBlock;
//更新用户资料
- (void)postUsermanagerUsersUpdateuserinfoSmiWithParameters:(NSDictionary *) param
                          Complete:(void (^)(void))completeBlock
                            failed:(void (^)(NSString *error))failedBlock;



@end
