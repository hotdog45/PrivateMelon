

#import <Foundation/Foundation.h>
@class LLUserModel;
typedef void(^UCLoginSuccessBlock)(LLUserModel *model,BOOL isSuccess);
typedef void(^UCLoginFailureBlock)(NSString *errorMessage);

@interface LLLoginManager : NSObject
//创建单例
+ (instancetype)sharedManager;
//退出登录
+(void)logout;
//是否登录
+(BOOL)whetherLogin;
//清空用户信息
+(void)clearUserInfo;
//进入登录页面
+(void)enterLoginVC;


#pragma mark 存用户信息

+(LLUserModel *)getUserModel;
+ (void)setUserModel:(LLUserModel *)userModel;
/**
 *  用户登录后授权令牌
 *
 *  @return token
 */
+ (NSString *)authToken;

+ (void)setAuthToken:(NSString *)authToken;

+ (NSString *)userID;

+ (void)setUserID:(NSString *)userID;



@end
