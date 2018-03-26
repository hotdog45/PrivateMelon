

#import "ApplicationSettings.h"

#pragma mark - Service Url

NSString* const HXSServiceURLProduct      = @"http://xxxxxxxx.com/ucwapi";

NSString* const HXSServiceURLTest         = @"http://106.14.176.243:8080/ucwapi";

NSString* const HXSServiceURLStage        = @"http://106.14.176.243:8080/ucwapi";

NSString* const HXSServiceURLQA           = @"http://106.14.176.243:8080/ucwapi";

NSString* const HXSServiceURLQAMaster     = @"http://106.14.176.243:8080/ucwapi";


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

- (NSString*)currentServiceURL
{
    NSString *urlStr = [self serviceURLForEnvironmentType:[self currentEnvironmentType]];
    
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
    
    return (number == nil) ? HXSEnvironmentTemai : (HXSEnvironmentType)[number intValue];
#else
    return HXSEnvironmentProduct;
#endif
}

- (void)setCurrentEnvironmentType:(HXSEnvironmentType)type
{
    [[NSUserDefaults standardUserDefaults] setObject:@(type) forKey:kServiceURLType];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)serviceURLForEnvironmentType:(HXSEnvironmentType) type {
    switch(type) {
        case HXSEnvironmentProduct:    return HXSServiceURLProduct;
        case HXSEnvironmentTemai:      return HXSServiceURLTest;
        case HXSEnvironmentStage:      return HXSServiceURLStage;
        case HXSEnvironmentQA:         return HXSServiceURLQA;
        case HXSEnvironmentQAMaster:   return HXSServiceURLQAMaster;
        default:
            break;
    }
    return @"";
}

- (NSString *)titleForServiceType:(HXSEnvironmentType)type
{
    switch(type) {
        case HXSEnvironmentProduct:    return @"生产环境";
        case HXSEnvironmentTemai:      return @"开发环境";
        case HXSEnvironmentStage:      return @"预发布环境";
        case HXSEnvironmentQA:         return @"测试环境";
        case HXSEnvironmentQAMaster:   return @"测试Master环境";
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
        case HXSEnvironmentTemai:      return @"http://106.14.176.243:8080";
        case HXSEnvironmentStage:      return @"http://106.14.176.243:8080";
        case HXSEnvironmentQA:         return @"http://106.14.176.243:8080";
        case HXSEnvironmentQAMaster:   return @"http://106.14.176.243:8080";
        default:
            break;
    }
    return @"http://xxxxxxxx.com";
}

/** 域名 uchengwang*/
- (NSArray *)hosts
{
    NSURL *serviceURLProductUrl   = [NSURL URLWithString:HXSServiceURLProduct];
    NSURL *serviceURLTest         = [NSURL URLWithString:HXSServiceURLTest];
    NSURL *serviceURLStage        = [NSURL URLWithString:HXSServiceURLStage];
    NSURL *serviceURLQA           = [NSURL URLWithString:HXSServiceURLQA];
    
    
    return @[serviceURLProductUrl.host,
             serviceURLTest.host,
             serviceURLStage.host,
             serviceURLQA.host,
             ];
}



@end
