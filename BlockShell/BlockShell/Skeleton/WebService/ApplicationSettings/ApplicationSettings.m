

#import "ApplicationSettings.h"

#pragma mark - Service Url
/////////////////////////---------------生产---------------------------------------
NSString* const HXSServiceURLProduct      = @"http://52.83.155.132:8042/";
NSString* const HXSServiceURLProductEntity      = @"http://52.83.155.132:8042/";
NSString* const HXSServiceURLProductVirtual      = @"http://52.83.155.132:8062/";
NSString* const HXSServiceURLProductPay      = @"http://52.83.155.132:8072/";


NSString* const HXSServiceURLProductOther      = @"http://52.83.155.132:8072/";


/////////////////////////---------------预发---------------------------------------
NSString* const HXSServiceURLStage        = @"http://52.83.155.132:8042/";
NSString* const HXSServiceURLStageEntity       = @"http://52.83.155.132:8042/";
NSString* const HXSServiceURLStageVirtual        = @"http://52.83.155.132:8062/";
NSString* const HXSServiceURLStagePay      = @"http://52.83.155.132:8072/";

NSString* const HXSServiceURLStageOther        = @"http://52.83.155.132:8042/";


/////////////////////////---------------测试---------------------------------------
NSString* const HXSServiceURLQA           = @"http://52.83.155.132:8042/";
NSString* const HXSServiceURLQAEntity          = @"http://52.83.155.132:8042/";
NSString* const HXSServiceURLQAVirtual          = @"http://52.83.155.132:8062/";
NSString* const HXSServiceURLQPay      = @"http://52.83.155.132:8072/";

NSString* const HXSServiceURLQAOther          = @"http://52.83.155.132:8042/";


////////////////////////////////////////////////////////////////////////////////////////
NSString* const kServiceURL                    = @"kServiceURL";
NSString* const kServiceURLType                = @"kServiceURLType";


static ApplicationSettings * instance;


@interface ApplicationSettings() {
    
}

@end

@implementation ApplicationSettings

+ (ApplicationSettings *)instance {
    @synchronized(self) {
        if (!instance) {
            instance = [[ApplicationSettings alloc] init];
            
            
            
            
            
            
        }
    }
    return instance;
}

+ (void)clearInstance {
    @synchronized(self) {
        if (instance) {
            instance = nil;
        }
    }
}

- (NSString*)currentServiceURL:(HostTypeEnum)type
{
    NSString *urlStr = [self serviceURLForEnvironmentType:[self currentEnvironmentType] hostType:type];
    
    return urlStr;
}

- (void)setCurrentServiceURL:(NSString*)urlString
{
    [[NSUserDefaults standardUserDefaults] setObject:urlString forKey:kServiceURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (HXSEnvironmentType)currentEnvironmentType
{
#if DEBUG
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey: kServiceURLType];
    
    return (HXSEnvironmentType)[number intValue];
#else
    return HXSEnvironmentProduct;
#endif
}
//设置环境
- (void)setCurrentEnvironmentType:(HXSEnvironmentType)type
{
    [[NSUserDefaults standardUserDefaults] setObject:@(type) forKey:kServiceURLType];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)serviceURLForEnvironmentType:(HXSEnvironmentType) type hostType:(HostTypeEnum)hostType{
    switch(type) {
        case HXSEnvironmentProduct:
        {
            switch (hostType) {
                case HostTypeEntity:
                    return HXSServiceURLProductEntity;
                    break;
                case HostTypeVirtual:
                    return HXSServiceURLProductVirtual;
                    break;
                case HostTypePay:
                    return HXSServiceURLProductPay;
                    break;
                case HostTypeOther:
                    return HXSServiceURLProductOther;
                    break;
                
                default:
                    return HXSServiceURLProduct;
                    break;
            }
        }
            
        case HXSEnvironmentStage:
        {
            switch (hostType) {
                case HostTypeEntity:
                    return HXSServiceURLStageEntity;
                    break;
                case HostTypeVirtual:
                    return HXSServiceURLStageVirtual;
                    break;
                case HostTypePay:
                    return HXSServiceURLStagePay;
                    break;
                case HostTypeOther:
                    return HXSServiceURLStageOther;
                    break;
                default:
                    return HXSServiceURLStage;
                    break;
            }
        }
            
        case HXSEnvironmentQA:
        {
            switch (hostType) {
                case HostTypeEntity:
                    return HXSServiceURLQAEntity;
                    break;
                case HostTypeVirtual:
                    return HXSServiceURLQAVirtual;
                    break;
                case HostTypePay:
                    return HXSServiceURLQPay;
                    break;
                case HostTypeOther:
                    return HXSServiceURLQAOther;
                    break;
                default:
                    return HXSServiceURLQA;
                    break;
            }
        }
            
        default:
            break;
    }
    return @"";
}

- (NSString *)titleForServiceType:(HXSEnvironmentType)type
{
    switch(type) {
        case HXSEnvironmentProduct:    return @"生产环境";
        case HXSEnvironmentStage:      return @"预发布环境";
        case HXSEnvironmentQA:         return @"测试环境";
        default:
            break;
    }
    return @"";
}

/** H5网页的路径 */
- (NSString *)h5url
{
    HXSEnvironmentType type = [self currentEnvironmentType];
    switch(type) {
        case HXSEnvironmentProduct:    return @"http://xxxxxxxx.com";
        case HXSEnvironmentStage:      return @"http://106.14.176.243:8080";
        case HXSEnvironmentQA:         return @"http://106.14.176.243:8080";
        default:
            break;
    }
    return @"http://xxxxxxxx.com";
}

/** 域名 uchengwang*/
- (NSArray *)hosts
{
    NSURL *serviceURLProductUrl   = [NSURL URLWithString:HXSServiceURLProduct];
    NSURL *serviceURLStage        = [NSURL URLWithString:HXSServiceURLStage];
    NSURL *serviceURLQA           = [NSURL URLWithString:HXSServiceURLQA];
    
    
    return @[serviceURLProductUrl.host,
             serviceURLStage.host,
             serviceURLQA.host,
             ];
}



@end
