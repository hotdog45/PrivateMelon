

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HXSEnvironmentType) {
    HXSEnvironmentProduct = 0,
    HXSEnvironmentTemai,                    // 特卖环境, Dev环境
    HXSEnvironmentStage,                    // Stage测试
    HXSEnvironmentQA,                       // 测试环境
    HXSEnvironmentQAMaster,                 // 测试Master环境

    HXSServiceURLCounts
};

//==============================================================
@class HXSFinanceOperationManager;

@interface ApplicationSettings : NSObject

+ (ApplicationSettings *)instance;
+ (void)clearInstance;

// service base surl
- (NSString *)currentServiceURL;

- (HXSEnvironmentType)currentEnvironmentType;

- (void)setCurrentEnvironmentType:(HXSEnvironmentType)type;

- (NSString *)serviceURLForEnvironmentType:(HXSEnvironmentType)type;

- (NSString *)titleForServiceType:(HXSEnvironmentType)type;

/** H5网页的路径, 分享url */
- (NSString *)h5url;

/** 域名 */
- (NSArray *)hosts;

@end
