

#import "HXAppConfig.h"


static NSString* const HISTORY_VERSIONS_KEY = @"A34C93A1-B6B6-4B3F-A59F-094075710C3B";


@implementation HXAppConfig


+(HXAppConfig*) sharedInstance
{
    static HXAppConfig* shared;
    static dispatch_once_t done;
    dispatch_once(&done, ^{
        shared = [[HXAppConfig alloc] init];
    });
    return shared;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.appName =  [[[NSBundle mainBundle] infoDictionary]
                         objectForKey:@"CFBundleDisplayName"];
        self.appVersion = [[[NSBundle mainBundle] infoDictionary]
                           objectForKey:@"CFBundleShortVersionString"];
        
        // Build & update version history
        NSArray* oldVersions = [[NSUserDefaults standardUserDefaults] arrayForKey:HISTORY_VERSIONS_KEY] ? : @[];
        NSMutableOrderedSet* versions = [[NSMutableOrderedSet alloc] initWithArray:oldVersions];
        [versions insertObject:self.appVersion atIndex:0];
        self.historyVersions = versions;
        [[NSUserDefaults standardUserDefaults] setObject:versions.array forKey:HISTORY_VERSIONS_KEY];
        
        self.appBuild = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    }
    
    return self;
}

@end
