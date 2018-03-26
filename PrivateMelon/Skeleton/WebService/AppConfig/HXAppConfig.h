

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>


@interface HXAppConfig : NSObject

+ (HXAppConfig *)sharedInstance;

@property(nonatomic, strong) NSString              *appName;
@property(nonatomic, strong) NSString              *appVersion;
@property(nonatomic, strong) NSString              *appBuild;

@property(nonatomic, strong) NSOrderedSet          *historyVersions;

@end

