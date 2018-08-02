

#import <Foundation/Foundation.h>
#import "ApplicationSettings.h"

// 当返回的是数组时，那么添加一个可key：list
#define KEY_LIST  @"list"
#define KEY_VALUE @"value"

// ASYNC
#define SYNC_DEVICE_ID                   @"device_id"
#define SYNC_USER_ID                     @"uid"
#define SYNC_USER_TOKEN                  @"token"
#define SYNC_SITE_ID                     @"site_id"
#define SYNC_DEVICE_TYPE                 @"device_type"
#define SYNC_DEVICE_TOEKN                @"device_token"
#define SYNC_SYSTEM_VERSION              @"system_version"
#define SYNC_APP_VERSION                 @"app_version"
#define SYNC_APP_NAME                    @"application_name"

//错误码    描述    备注
//0    操作成功
//1001    操作异常，调用第三方服务器失败
//1002    操作异常，数据库连接异常
//1003    操作异常，文件I/O错误
//1004    操作未授权
//1005    非法操作
//1006    参数错误    msg 中需指出具体是哪个字段
//2001    用户已注册    msg 中需指出用户名
//2002    用户不存在
//2003    用户邮箱已经注册
//2004    密码校验错误
//2006    手机验证码校验失败
//2011    选择频道数量过多
//2016    已经是好友
//2017    不是好友
//3001    已经有用户参与置换    删除置换时如果已经有用户参与则不允许删除
//3002    用户已经参与过置换
//4001    已经有用户参与活动
//4002    用户已经参与过活动，不能重复参加


typedef enum
{
    //未知错误
    kError = -1,
    
    
    //服务器返回的错误
    kNoError = 1,
    
//    kNOMoreData = 1,
    
    kNotBindPhoneError = -110,
    
    kVerificationCodeError = 2,
    
    kDidNotLoginError = 3,

    kInvalidTokenError = 4,
    
    kNetWorkError = 5,
    kUnknownError = 99,
    kNetworkingCancelError = -999,

}ErrorCode;

@interface BSWebService : NSObject

/** 返回数据如果为数组，会添加一个list组装成字典 */
+ (NSURLSessionDataTask *)postRequest:(NSString*)path
                           hostType:(HostTypeEnum)hostType
                           parameters:(id)parameters
                             progress:(void (^)(NSProgress *))uploadProgress
                              success:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))success
                              failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure;

/** 返回数据如果为数组，会添加一个list组装成字典 */
+ (NSURLSessionDataTask *)getRequest:(NSString*)path
                            hostType:(HostTypeEnum)hostType
                          parameters:(NSDictionary*)parameters
                            progress:(void (^)(NSProgress *))downloadProgress
                             success:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))success
                             failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure;

/** 返回数据如果为数组，会添加一个list组装成字典 */
+ (NSURLSessionDataTask *)uploadRequest:(NSString*)path
                               hostType:(HostTypeEnum)hostType
                             parameters:(NSDictionary*)parameters
                          formDataArray:(NSArray *)formDataArray
                               progress:(void (^)(NSProgress *))uploadProgress
                                success:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))success
                                failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure;

/** 返回数据如果为数组，会添加一个list组装成字典 */
+ (NSURLSessionDataTask *)putRequest:(NSString*)path
                            hostType:(HostTypeEnum)hostType
                          parameters:(NSDictionary*)parameters
                             success:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))success
                             failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure;

/** 返回数据如果为数组，会添加一个list组装成字典 */
+ (NSURLSessionDataTask *)deleteRequest:(NSString*)path
                               hostType:(HostTypeEnum)hostType
                             parameters:(NSDictionary*)parameters
                                success:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))success
                                failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure;

@end
