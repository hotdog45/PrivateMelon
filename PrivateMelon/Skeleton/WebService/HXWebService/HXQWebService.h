

#import <Foundation/Foundation.h>

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

typedef enum
{
    //未知错误
    kUnknownError = -1,
    
    
    //服务器返回的错误
    kNoError = 0,
    
    kNOMoreData = 1,
    
    kVerificationCodeError = 2,
    
    kDidNotLoginError = 3,

    kInvalidTokenError = 4,
    
    kNetWorkError = 200,

    kNetworkingCancelError = -999,

}ErrorCode;

@interface HXQWebService : NSObject

/** 返回数据如果为数组，会添加一个list组装成字典 */
+ (NSURLSessionDataTask *)postRequest:(NSString*)path
                           parameters:(id)parameters
                             progress:(void (^)(NSProgress *))uploadProgress
                              success:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))success
                              failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure;

/** 返回数据如果为数组，会添加一个list组装成字典 */
+ (NSURLSessionDataTask *)getRequest:(NSString*)path
                          parameters:(NSDictionary*)parameters
                            progress:(void (^)(NSProgress *))downloadProgress
                             success:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))success
                             failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure;

/** 返回数据如果为数组，会添加一个list组装成字典 */
+ (NSURLSessionDataTask *)uploadRequest:(NSString*)path
                             parameters:(NSDictionary*)parameters
                          formDataArray:(NSArray *)formDataArray
                               progress:(void (^)(NSProgress *))uploadProgress
                                success:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))success
                                failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure;

/** 返回数据如果为数组，会添加一个list组装成字典 */
+ (NSURLSessionDataTask *)putRequest:(NSString*)path
                          parameters:(NSDictionary*)parameters
                             success:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))success
                             failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure;

/** 返回数据如果为数组，会添加一个list组装成字典 */
+ (NSURLSessionDataTask *)deleteRequest:(NSString*)path
                             parameters:(NSDictionary*)parameters
                                success:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))success
                                failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure;

@end
