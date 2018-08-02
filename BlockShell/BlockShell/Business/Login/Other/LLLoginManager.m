//
//  UCLoginManager.m
//  UCity
//
//
//

#import "LLLoginManager.h"
#import "BaseNavigationController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"


static NSString *const kUserLoginuserID = @"kUserLoginuserID";
static NSString *const kUserLoginToken = @"kUserLoginToken";


@interface LLLoginManager()
@property (strong, nonatomic) UIWindow *loginWindow;
@property (strong, nonatomic) UIWindow *originWindow;
@end
@implementation LLLoginManager
//创建单例
+ (instancetype)sharedManager {
    static LLLoginManager * sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        sharedManager.originWindow = [UIApplication sharedApplication].delegate.window;
    });
    return sharedManager;
}
//是否登录
+(BOOL)whetherLogin {
    LLUserModel *model = [LLLoginManager getUserModel];
    if (model.token != nil && model.token.length >4) {
        return YES;
    }
    return NO;
}
//清空用户信息
+(void)clearUserInfo {
    NSString *str = [[LLUserModel new] toJSONString];
    [LLLoginManager setAuthToken:@""];
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"kLLUserModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//进入登录页面
+(void)enterLoginVC{
    //退出登录
    [LLLoginManager logout];
    [[LLLoginManager sharedManager] showLoginVC];
}
//退出登录
+(void)logout{
    //清空用户信息
    [LLLoginManager clearUserInfo];
}


-(NSString *)getDeviceID{
    NSUUID * uuid = [[UIDevice currentDevice] identifierForVendor];
    NSString * uuidStr = [NSString stringWithFormat:@"%@",uuid];
    return uuidStr;
}
//显示登录控制器
- (void)showLoginVC{
    LoginViewController * loginVC = [LoginViewController new];
    WEAKSELF
    loginVC.loginCancelBlock = ^{
        [weakSelf showTabarWindow];
    };
    self.loginWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.loginWindow.rootViewController = loginVC;
    self.loginWindow.windowLevel = UIWindowLevelNormal;
    [self.loginWindow makeKeyAndVisible];
    
}
//显示主控制器
-(void)showTabarWindow{
    self.loginWindow.windowLevel = UIWindowLevelNormal;
    [self.originWindow makeKeyAndVisible];
    self.loginWindow = nil;
}


//取用户信息
+(LLUserModel *)getUserModel{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"kLLUserModel"];
    NSError *err;
    LLUserModel * model = [[LLUserModel alloc] initWithString:str error:&err];
    if (err) {
        return [LLUserModel new];
    }
    return model;
}
//存用户信息
+ (void)setUserModel:(LLUserModel *)userModel{
    if (userModel.token.length > 4) {
        [LLLoginManager setAuthToken:userModel.token];
    }
    if (userModel.userId.stringValue.length > 0) {
        [LLLoginManager setUserID:userModel.userId.stringValue];
    }
    NSString *str = [userModel toJSONString];
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"kLLUserModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  用户登录后授权令牌
 *
 *  @return token
 */
+ (NSString *)authToken {
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:kUserLoginToken];
    return str;
}

+ (void)setAuthToken:(NSString *)authToken {
    [[NSUserDefaults standardUserDefaults] setObject:authToken forKey:kUserLoginToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)userID{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:kUserLoginuserID];
    return str;
}

+ (void)setUserID:(NSString *)userID{
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kUserLoginuserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
