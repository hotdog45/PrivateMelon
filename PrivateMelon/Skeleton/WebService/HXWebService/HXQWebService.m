

#import "HXQWebService.h"

#import "HXWebService.h"

// Pod Module
#import "HXAppConfig.h"
#import "HXAppDeviceHelper.h"
#import "ApplicationSettings.h"


// sync response
#define SYNC_RESPONSE_MSG               @"msg"
#define SYNC_RESPONSE_STATUS            @"status"
#define SYNC_RESPONSE_DATA              @"data"
#define DIC_HAS_NUMBER(dic, key)  ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSNumber class]])
#if     DEBUG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#       define breakpoint(e)  assert(e)//在调试模式下，如果程序进入不期望进入的分支，assert出来,如果在非调试模式下忽略
#else
#       define DLog(...)
#       define breakpoint(e)
#endif

@implementation HXQWebService

#pragma mark - Initial Methods

+ (HXWebService *)webService
{
    static HXWebService *webService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        NSString *userAgent = [NSString stringWithFormat:@"%@/%@; iOS %@; %.0fX%.0f/%0.1f", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleNameKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] systemVersion], SCREEN_WIDTH*[[UIScreen mainScreen] scale],SCREEN_HEIGHT*[[UIScreen mainScreen] scale], [[UIScreen mainScreen] scale]];
        NSString *userAgent = @"";
        if (userAgent) {
            if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
                NSMutableString *mutableUserAgent = [userAgent mutableCopy];
                if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                    userAgent = mutableUserAgent;
                }
            }
        }
        
        UIWebView *tempWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSString *originalUserAgent = [tempWebView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        NSString *userAgentStr = [NSString stringWithFormat:@"%@\\%@; %@; %@", originalUserAgent, [HXAppDeviceHelper modelString], userAgent,[NSString stringWithFormat:@"IsJailbroken/%d",[HXAppDeviceHelper isJailbroken]]];
        NSString *deviceIDStr = [HXAppDeviceHelper uniqueDeviceIdentifier];
        
        webService = [[HXWebService alloc] createWebServiceWithUserAgent:userAgentStr
                                                                deviceID:deviceIDStr];
    });
    
    return webService;
}


#pragma mark - Core

+ (void)handleSuccess:(BOOL)isPost
                 path:(NSString*)path
           parameters:(NSDictionary*)parameters
            operation:(NSURLSessionDataTask *)op
                 json:(id)json
              success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
              failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure
{
//    DLog(@"%@ handleSuccess", path);
    
    [HXQWebService onResponseData:json
                              success:success
                              failure:failure];
    
}

+ (void)handleFailure:(BOOL)isPost
                 path:(NSString*)path
           parameters:(NSDictionary*)parameters
            operation:(NSURLSessionDataTask *)op
                error:(NSError*)error
              success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
              failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure
{
    if([error.domain isEqualToString:@"NSURLErrorDomain"]
       && error.code == kNetworkingCancelError)
    {//增加上传取消操作后的error code 判断
        failure(kNetworkingCancelError, @"网络请求取消", nil);
        return;
    }
    failure(kNetWorkError, @"网络错误", nil);
}

+ (void)handleFailureWithTask:(NSURLSessionDataTask *)task
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
    //通讯协议状态码
    NSInteger statusCode = response.statusCode;
    //服务器返回的业务逻辑报文信息
    switch (statusCode) {
        case 403:
//            [UCLoginManager logoutJPush];
//            [UCLoginManager logout];
//            [[NSNotificationCenter defaultCenter] postNotificationName:UCUserLoginOutNotification object:nil];
            //                [UCLoginManager enterLoginView];
            break;

        default:
            break;
    }
}


#pragma mark - Public Methods

#pragma mark - POST

+ (NSURLSessionDataTask *)postRequest:(NSString*)path
                           parameters:(id)parameters
                             progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                              success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
                              failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure

{
//    DLog(@"Request Start %@", [NSDate date]);
//    DLog(@"Request %@", path);
//    DLog(@"Params %@", parameters);
    
    HXWebServiceModel *model = [HXQWebService createWebServiceModelWithPath:path];
    parameters = [HXQWebService signDictionary:parameters];
    
    NSURLSessionDataTask *task = [[HXQWebService webService]
                                  postWithWebServiceModel:model
                                  parameters:parameters
                                  progress:uploadProgress
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      [HXQWebService handleSuccess:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                  json:responseObject
                                                               success:success
                                                               failure:failure];
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      [HXQWebService handleFailureWithTask:task];

//                                      DLog(@"Request End Faile %@", [NSDate date]);
                                      [HXQWebService handleFailure:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure];
                                  }];
    
    
    return task;
}


#pragma mark - GET

+ (NSURLSessionDataTask *)getRequest:(NSString*)path
                          parameters:(NSDictionary*)parameters
                            progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                             success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
                             failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure
{
//    DLog(@"Request Start %@", [NSDate date]);
//    DLog(@"Request %@", path);
//    DLog(@"Params %@", parameters);
    
    HXWebServiceModel *model = [HXQWebService createWebServiceModelWithPath:path];
    
    parameters = [HXQWebService signDictionary:parameters];
    
    NSURLSessionDataTask *task = [[HXQWebService webService]
                                  getWithWebServiceModel:model
                                  parameters:parameters
                                  progress:downloadProgress
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      [HXQWebService handleSuccess:NO
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                  json:responseObject
                                                               success:success
                                                               failure:failure];
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                                      DLog(@"Request End Faile %@", [NSDate date]);
                                      [HXQWebService handleFailureWithTask:task];

                                      [HXQWebService handleFailure:NO
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure];
                                  }];
//    DLog(@"\n\n absoluteUrl = %@", task.currentRequest.URL.absoluteURL)

    return task;
}


#pragma mark - UPLOAD

+ (NSURLSessionDataTask *)uploadRequest:(NSString*)path
                             parameters:(NSDictionary*)parameters
                          formDataArray:(NSArray *)formDataArray
                               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                success:(void (^)(ErrorCode status, NSString *msg, NSDictionary *data))success
                                failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary *data))failure
{
//    DLog(@"Request Start %@", [NSDate date]);
//    DLog(@"Request %@", path);
//    DLog(@"Params %@", parameters);
    
    HXWebServiceModel *model = [HXQWebService createWebServiceModelWithPath:path];
    
    parameters = nil; // Don't send paramenter, If send parameters, the server returns error
    
    NSURLSessionDataTask *task = [[HXQWebService webService]
                                  uploadWithWebServiceModel:model
                                  parameters:parameters
                                  formDataArray:formDataArray
                                  progress:uploadProgress
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
//                                      DLog(@"Request End Success %@", [NSDate date]);
                                      
                                      [HXQWebService handleSuccess:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                  json:responseObject
                                                               success:success
                                                               failure:failure];
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                                      DLog(@"Request End Faile %@", [NSDate date]);
                                      [HXQWebService handleFailureWithTask:task];

                                      [HXQWebService handleFailure:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure];
                                  }];
    
    
    
    
    return task;
}



#pragma mark - PUT

+ (NSURLSessionDataTask *)putRequest:(NSString*)path
                          parameters:(NSDictionary*)parameters
                             success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
                             failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure
{
    DLog(@"Request Start %@", [NSDate date]);
    DLog(@"Request %@", path);
    DLog(@"Params %@", parameters);
    
    HXWebServiceModel *model = [HXQWebService createWebServiceModelWithPath:path];
    
    parameters = [HXQWebService signDictionary:parameters];
    
    NSURLSessionDataTask *task = [[HXQWebService webService]
                                  putWithWebServiceModel:model
                                  parameters:parameters
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      [HXQWebService handleSuccess:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                  json:responseObject
                                                               success:success
                                                               failure:failure];
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      DLog(@"Request End Faile %@", [NSDate date]);
                                      [HXQWebService handleFailureWithTask:task];

                                      [HXQWebService handleFailure:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure];
                                  }];
    
    
    return task;
}


#pragma mark - DELETE

+ (NSURLSessionDataTask *)deleteRequest:(NSString*)path
                             parameters:(NSDictionary*)parameters
                                success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
                                failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure
{
    DLog(@"Request Start %@", [NSDate date]);
    DLog(@"Request %@", path);
    DLog(@"Params %@", parameters);
    
    HXWebServiceModel *model = [HXQWebService createWebServiceModelWithPath:path];
    
    parameters = [HXQWebService signDictionary:parameters];
    
    NSURLSessionDataTask *task = [[HXQWebService webService]
                                  deleteWithWebServiceModel:model
                                  parameters:parameters
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      [HXQWebService handleSuccess:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                  json:responseObject
                                                               success:success
                                                               failure:failure];
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      DLog(@"Request End Faile %@", [NSDate date]);
                                      [HXQWebService handleFailureWithTask:task];

                                      [HXQWebService handleFailure:YES
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure];
                                  }];
    
    return task;
}


#pragma mark - Private Methods

+ (NSDictionary *)signDictionary:(NSDictionary *)dic
{
    if ((nil == dic)
        || [dic isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dicReal = [NSMutableDictionary dictionaryWithDictionary:dic];
        if (dicReal == nil) {
            dicReal = [NSMutableDictionary dictionary];
        }

        return dicReal;
    } else {
        return [NSDictionary dictionary];
    }
}


+ (void)onResponseData:(id)responseObject
               success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
               failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure
{
    id json = responseObject;
    
    if(json && [json isKindOfClass:[NSDictionary class]]) {
        if(DIC_HAS_NUMBER(json, SYNC_RESPONSE_STATUS)) {
            id message = [json objectForKey:SYNC_RESPONSE_MSG];
            NSString * msg = [message isKindOfClass:[NSString class]] ? message : @"";
            int status = [[json objectForKey:SYNC_RESPONSE_STATUS] intValue];
            NSDictionary * data = [json objectForKey:SYNC_RESPONSE_DATA];
            if(!data) {
                data = [NSDictionary dictionary];
            } else if ([data isKindOfClass:[NSArray class]]) {
                NSArray *array = (NSArray *)data;
                data = @{
                         KEY_LIST:array,
                         };
            } else if ([data isKindOfClass:[NSString class]]) {
                NSString *value = (NSString *)data;
                data = @{
                         KEY_VALUE:value,
                         };
            } else if ([data isKindOfClass:[NSNumber class]]) {
                NSNumber *value = (NSNumber *)data;
                data = @{
                         KEY_VALUE:value,
                         };
            }
            
            if (kNoError == status) {
                success(kNoError, msg, data);
            } else if (status == kNOMoreData) {
                failure(status, msg, data);
            } else if(status == kInvalidTokenError) {
//                BEGIN_MAIN_THREAD
//                [UCLoginManager logout];
//                [[NSNotificationCenter defaultCenter] postNotificationName:UCUserLoginOutNotification object:nil];
//                END_MAIN_THREAD

                failure(status, msg, data);
            } else if (kVerificationCodeError != status) {
                failure(status, msg, data);
            } else if(msg != nil) {
                failure(status, msg, data);
            } else {
                failure(kUnknownError, @"未知错误-1000", data);
            }
        }else {
            failure(kUnknownError, @"未知错误-1001", nil);
        }
    } else {
        success(kNoError, nil, [[NSDictionary alloc] init]);
    }
}

+ (NSString *)webServiceCurrentDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *now = [[NSDate alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [dateFormatter stringFromDate:now];
}

+ (HXWebServiceModel *)createWebServiceModelWithPath:(NSString *)pathStr
{
    // base url
    NSString *baseURLStr = [[ApplicationSettings instance] currentServiceURL];
    
    // ip address
    NSString *ipAddressStr = nil;
    
    // web service model
    HXWebServiceModel *model = [[HXWebServiceModel alloc] init];
    model.baseURLStr = baseURLStr;
    model.ipAddressStr = ipAddressStr;
    model.pathStr = pathStr;
    
    return model;
}


@end
