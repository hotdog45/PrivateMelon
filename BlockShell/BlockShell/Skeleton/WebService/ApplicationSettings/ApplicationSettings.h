

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HXSEnvironmentType) {
    HXSEnvironmentProduct = 0,
    HXSEnvironmentStage,                    // Stage测试
    HXSEnvironmentQA,                       // 测试环境

    HXSServiceURLCounts
};
typedef enum
{
    //普通
    HostTypeEntity = 0,
    //虚拟
    HostTypeVirtual = 1,
    //支付
    HostTypePay = 2,
    
    
    HostTypeOther = 999,
    
}HostTypeEnum;

//==============================================================
@class HXSFinanceOperationManager;

@interface ApplicationSettings : NSObject

+ (ApplicationSettings *)instance;
+ (void)clearInstance;

// service base surl
- (NSString *)currentServiceURL:(HostTypeEnum)type;

- (HXSEnvironmentType)currentEnvironmentType;

- (void)setCurrentEnvironmentType:(HXSEnvironmentType)type;

- (NSString *)serviceURLForEnvironmentType:(HXSEnvironmentType)type;

- (NSString *)titleForServiceType:(HXSEnvironmentType)type;

/** H5网页的路径, 分享url */
- (NSString *)h5url;

/** 域名 */
- (NSArray *)hosts;

@end
