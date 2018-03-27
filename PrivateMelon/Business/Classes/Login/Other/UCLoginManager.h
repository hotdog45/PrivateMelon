

#import <Foundation/Foundation.h>
@class LLUserModel;
typedef void(^UCLoginSuccessBlock)(LLUserModel *model,BOOL isSuccess);
typedef void(^UCLoginFailureBlock)(NSString *errorMessage);

@interface UCLoginManager : NSObject
//创建单例
+ (instancetype)sharedManager;
//退出登录
+(void)logout;
//是否登录
+(BOOL)whetherLogin;
//清空用户信息
+(void)clearUserInfo;
//进入登录页面
+(void)enterLoginView;

//使用手机登录
-(void)usePhoneLogin:(NSString *)account
            password:(NSString *)password
             success:(UCLoginSuccessBlock)success
             failure:(UCLoginFailureBlock)failure;
//获取注册验证码
-(void)getRegisterValid:(NSDictionary *)params state:(void (^)(BOOL success,NSString * msg))stateBlock;
//注册请求
-(void)userPhoneRegister:(NSString *)account
                password:(NSString *)password
                   valid:(NSString *)valid
                     sex:(NSString *)sexStr
                nickName:(NSString *)nickName
                 headImg:(NSString *)headImg
                 success:(UCLoginSuccessBlock)success
                 failure:(UCLoginFailureBlock)failure;
//获取忘记密码验证码
-(void)getForgetValid:(NSDictionary *)params state:(void (^)(BOOL success,NSString * msg))stateBlock;
//忘记密码请求
-(void)forgetPassword:(NSString *)account
             password:(NSString *)password
             valid:(NSString *)valid
              success:(UCLoginSuccessBlock)success
              failure:(UCLoginFailureBlock)failure;

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
@end
