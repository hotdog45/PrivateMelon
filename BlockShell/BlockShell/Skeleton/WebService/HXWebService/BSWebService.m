

#import "BSWebService.h"

#import "HXWebService.h"

// Pod Module
#import "HXAppConfig.h"
#import "HXAppDeviceHelper.h"
#import "ApplicationSettings.h"


// sync response
#define SYNC_RESPONSE_MSG               @"errorMsg"
#define SYNC_RESPONSE_STATUS            @"resultCode"
#define SYNC_RESPONSE_DATA              @"module"
#define DIC_HAS_NUMBER(dic, key)  ([dic objectForKey:key] && [[dic objectForKey:key] isKindOfClass:[NSNumber class]])
#if     DEBUG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#       define breakpoint(e)  assert(e)//在调试模式下，如果程序进入不期望进入的分支，assert出来,如果在非调试模式下忽略
#else
#       define DLog(...)
#       define breakpoint(e)
#endif

@implementation BSWebService

#pragma mark - Initial Methods

+ (HXWebService *)webService
{
    static HXWebService *webService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *userAgent = [NSString stringWithFormat:@"%@/%@; iOS %@; %.0fX%.0f/%0.1f", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleNameKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] systemVersion], SCREEN_WIDTH*[[UIScreen mainScreen] scale],SCREENH_HEIGHT*[[UIScreen mainScreen] scale], [[UIScreen mainScreen] scale]];
//        NSString *userAgent = @"";
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
    DLog(@"%@ handleSuccess", path);
    
    [BSWebService onResponseData:json
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
//            [[NSNotificationCenter defaultCenter] postNotificationName:UCUserLoginOutNotification object:nil];
            [LLLoginManager enterLoginVC];
            break;

        default:
            break;
    }
}


#pragma mark - Public Methods

#pragma mark - POST

+ (NSURLSessionDataTask *)postRequest:(NSString*)path
                             hostType:(HostTypeEnum)hostType
                           parameters:(id)parameters
                             progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                              success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
                              failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure

{
    DLog(@"Request Start %@", [NSDate date]);
    DLog(@"Request %@", path);
    DLog(@"Params %@", parameters);
    
    
    
    HXWebServiceModel *model = [BSWebService createWebServiceModelWithPath:path hostType:hostType];
    parameters = [BSWebService signDictionary:parameters];
    parameters = [BSWebService parametersWithData:parameters];
    DLog(@"Params %@", parameters);
    
    NSURLSessionDataTask *task = [[BSWebService webService]
                                  postWithWebServiceModel:model
                                  parameters:parameters
                                  progress:uploadProgress
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      
                                      if (responseObject) {
                                          [BSWebService handleSuccess:YES
                                                                 path:path
                                                           parameters:parameters
                                                            operation:task
                                                                 json:responseObject
                                                              success:success
                                                              failure:failure];
                                      }else{
                                          [BSWebService handleFailureWithTask:task];
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      [BSWebService handleFailureWithTask:task];

//                                      DLog(@"Request End Faile %@", [NSDate date]);
                                      [BSWebService handleFailure:YES
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
                    hostType:(HostTypeEnum)hostType
                          parameters:(NSDictionary*)parameters
                            progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                             success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
                             failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure
{
    DLog(@"Request Start %@", [NSDate date]);
    DLog(@"Request %@", path);
    DLog(@"Params %@", parameters);
    
    HXWebServiceModel *model = [BSWebService createWebServiceModelWithPath:path hostType:hostType];
    
    parameters = [BSWebService signDictionary:parameters];
    parameters = [BSWebService parametersWithData:parameters];
    DLog(@"Params %@", parameters);
    
    NSURLSessionDataTask *task = [[BSWebService webService]
                                  getWithWebServiceModel:model
                                  parameters:parameters
                                  progress:downloadProgress
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      
                                      if (responseObject) {
                                          [BSWebService handleSuccess:YES
                                                                 path:path
                                                           parameters:parameters
                                                            operation:task
                                                                 json:responseObject
                                                              success:success
                                                              failure:failure];
                                      }else{
                                          [BSWebService handleFailureWithTask:task];
                                      }
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                                      DLog(@"Request End Faile %@", [NSDate date]);
                                      [BSWebService handleFailureWithTask:task];

                                      [BSWebService handleFailure:NO
                                                                  path:path
                                                            parameters:parameters
                                                             operation:task
                                                                 error:error
                                                               success:success
                                                               failure:failure];
                                  }];
    DLog(@"\n\n absoluteUrl = %@", task.currentRequest.URL.absoluteURL)

    return task;
}


#pragma mark - UPLOAD

+ (NSURLSessionDataTask *)uploadRequest:(NSString*)path
hostType:(HostTypeEnum)hostType
                             parameters:(NSDictionary*)parameters
                          formDataArray:(NSArray *)formDataArray
                               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                success:(void (^)(ErrorCode status, NSString *msg, NSDictionary *data))success
                                failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary *data))failure
{
    DLog(@"Request Start %@", [NSDate date]);
    DLog(@"Request %@", path);
    DLog(@"Params %@", parameters);
    
    HXWebServiceModel *model = [BSWebService createWebServiceModelWithPath:path hostType:hostType];
    
    parameters = nil; // Don't send paramenter, If send parameters, the server returns error
    
    NSURLSessionDataTask *task = [[BSWebService webService]
                                  uploadWithWebServiceModel:model
                                  parameters:parameters
                                  formDataArray:formDataArray
                                  progress:uploadProgress
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      DLog(@"Request End Success %@", [NSDate date]);
                                      
                                      if (responseObject) {
                                          [BSWebService handleSuccess:YES
                                                                 path:path
                                                           parameters:parameters
                                                            operation:task
                                                                 json:responseObject
                                                              success:success
                                                              failure:failure];
                                      }else{
                                          [BSWebService handleFailureWithTask:task];
                                      }
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                                      DLog(@"Request End Faile %@", [NSDate date]);
                                      [BSWebService handleFailureWithTask:task];

                                      [BSWebService handleFailure:YES
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
hostType:(HostTypeEnum)hostType
                          parameters:(NSDictionary*)parameters
                             success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
                             failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure
{
    DLog(@"Request Start %@", [NSDate date]);
    DLog(@"Request %@", path);
    DLog(@"Params %@", parameters);
    
    HXWebServiceModel *model = [BSWebService createWebServiceModelWithPath:path hostType:hostType];
    
    parameters = [BSWebService signDictionary:parameters];
    parameters = [BSWebService parametersWithData:parameters];
    DLog(@"Params %@", parameters);
    NSURLSessionDataTask *task = [[BSWebService webService]
                                  putWithWebServiceModel:model
                                  parameters:parameters
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      
                                      if (responseObject) {
                                          [BSWebService handleSuccess:YES
                                                                 path:path
                                                           parameters:parameters
                                                            operation:task
                                                                 json:responseObject
                                                              success:success
                                                              failure:failure];
                                      }else{
                                          [BSWebService handleFailureWithTask:task];
                                      }
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      DLog(@"Request End Faile %@", [NSDate date]);
                                      [BSWebService handleFailureWithTask:task];

                                      [BSWebService handleFailure:YES
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
hostType:(HostTypeEnum)hostType
                             parameters:(NSDictionary*)parameters
                                success:(void (^)(ErrorCode status, NSString * msg, NSDictionary * data))success
                                failure:(void (^)(ErrorCode status, NSString *msg, NSDictionary * data))failure
{
    DLog(@"Request Start %@", [NSDate date]);
    DLog(@"Request %@", path);
    DLog(@"Params %@", parameters);
    
    HXWebServiceModel *model = [BSWebService createWebServiceModelWithPath:path hostType:hostType];
    
    parameters = [BSWebService signDictionary:parameters];
    parameters = [BSWebService parametersWithData:parameters];
    DLog(@"Params %@", parameters);
    NSURLSessionDataTask *task = [[BSWebService webService]
                                  deleteWithWebServiceModel:model
                                  parameters:parameters
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      if (responseObject) {
                                          [BSWebService handleSuccess:YES
                                                                 path:path
                                                           parameters:parameters
                                                            operation:task
                                                                 json:responseObject
                                                              success:success
                                                              failure:failure];
                                      }else{
                                          [BSWebService handleFailureWithTask:task];
                                      }
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      DLog(@"Request End Faile %@", [NSDate date]);
                                      [BSWebService handleFailureWithTask:task];

                                      [BSWebService handleFailure:YES
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
            
            if (kNoError == status ) {
                success(kNoError, msg, data);
            } else if (status == kNotBindPhoneError) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotBindPhoneError" object:nil];
//                failure(status, msg, data);
//            } else if(status == kInvalidTokenError) {
//                BEGIN_MAIN_THREAD
////                [UCLoginManager logout];
////                [[NSNotificationCenter defaultCenter] postNotificationName:UCUserLoginOutNotification object:nil];
////                END_MAIN_THREAD
//
//                failure(status, msg, data);
            } else if (kError == status) {
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

+ (HXWebServiceModel *)createWebServiceModelWithPath:(NSString *)pathStr hostType:(HostTypeEnum)hostType
{
    // base url
    NSString *baseURLStr = [[ApplicationSettings instance] currentServiceURL:hostType];
    
    // ip address
    NSString *ipAddressStr = nil;
    
    // web service model
    HXWebServiceModel *model = [[HXWebServiceModel alloc] init];
    model.baseURLStr = baseURLStr;
    model.ipAddressStr = ipAddressStr;
    model.pathStr = pathStr;
    
    return model;
}
+(NSDictionary *)parametersWithData:(NSDictionary*)data{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    mutDic[@"v"] = @"1.0";
    mutDic[@"platform"] = @"IOS";
    if ([LLLoginManager authToken].length > 4) {
        mutDic[@"token"] = [LLLoginManager authToken];
    }else{
        mutDic[@"token"] = @"";
    }
    if ([LLLoginManager userID].length > 2) {
        mutDic[@"uid"] = @"776798523507174860";
    }
//    mutDic[@"timestamp"] = @([[NSDate date] timeIntervalSince1970]);
    mutDic[@"timestamp"] = @12312312312;
    mutDic[@"chanel"] = @"0"; //渠道，暂时传0
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if (!uuid ||uuid.length <4) {
       uuid =  [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    mutDic[@"deiceId"] = uuid;//设备id
    mutDic[@"longtitude"] = @"120";//经度
    mutDic[@"latitude"] = @"30";//维度
    
    
    [parameters addEntriesFromDictionary:mutDic];
    if (data.allValues.count > 0 ) {
        [mutDic addEntriesFromDictionary:data];
        parameters[@"data"] = data;
    }
    DLog(@"dic1111111%@",mutDic);
    NSArray* arr = [mutDic allKeys];
    DLog(@"arr222222222%@",arr);
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *columnListArray = [arr sortedArrayUsingDescriptors:descriptors];
    DLog(@"columnListArray5555555555555%@",columnListArray);
    NSString * sign;
    int i = 0;
    for (NSString * key in columnListArray) {
        i++;
        
        if ([mutDic[key] isKindOfClass:[NSDictionary class]]) {
            NSString *str = [BSWebService convertToJsonData:mutDic[key]];
            if (!sign) {
                
                sign=[NSString stringWithFormat:@"%@=%@&",key,str];
            } else if (i == columnListArray.count) {
                sign=[NSString stringWithFormat:@"%@%@=%@",sign,key,str];
            }else{
                sign=[NSString stringWithFormat:@"%@%@=%@&",sign,key,str];
            }
        } else {
            if (!sign) {
                sign=[NSString stringWithFormat:@"%@=%@&",key,mutDic[key]];
                
            } else if (i == columnListArray.count) {
                sign=[NSString stringWithFormat:@"%@%@=%@",sign,key,mutDic[key]];
            }else{
                sign=[NSString stringWithFormat:@"%@%@=%@&",sign,key,mutDic[key]];
            }
        }
       
    }
    sign=[NSString stringWithFormat:@"%@&key=%@",sign,LRKEY];
    
    DLog(@"sign------%@",sign);
    parameters[@"sign"] = [[sign MD5String] uppercaseString];
    DLog(@"sign为======%@",parameters[@"sign"]);
    DLog(@"parameters77777777777%@",parameters);
    return parameters;
}

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    NSString *str = [NSString stringWithFormat:@"%@",dict];
    //去掉字符串中的空格
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@";" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return str;
}


//+(NSString *)convertToJsonData:(NSDictionary *)dict
//
//{
//    
//    NSError *error;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
//    
//    NSString *jsonString;
//    
//    if (!jsonData) {
//        
//        NSLog(@"%@",error);
//        
//    }else{
//        
//        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//        
//    }
//    
//    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//    
//    NSRange range = {0,jsonString.length};
//    
//    //去掉字符串中的空格
//    
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    
//    NSRange range2 = {0,mutStr.length};
//    
//    //去掉字符串中的换行符
//    
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
//    
//    return mutStr;
//    
//}
@end
