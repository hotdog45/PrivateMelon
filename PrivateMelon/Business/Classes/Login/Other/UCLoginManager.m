//
//  UCLoginManager.m
//  UCity
//
//
//

#import "UCLoginManager.h"
#import "BaseNavigationController.h"
#import "AppDelegate.h"

@interface UCLoginManager()
@property (strong, nonatomic) UIWindow *loginWindow;
@property (strong, nonatomic) UIWindow *originWindow;
@end
@implementation UCLoginManager
//创建单例
+ (instancetype)sharedManager {
    static UCLoginManager * sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        sharedManager.originWindow = [UIApplication sharedApplication].delegate.window;
    });
    return sharedManager;
}
//是否登录
+(BOOL)whetherLogin {
    LLUserModel *model = [UCLoginManager getUserModel];
    if (model.token != nil && model.token.length >4) {
        return YES;
    }
    return NO;
}
//清空用户信息
+(void)clearUserInfo {
    NSString *str = [[LLUserModel new] toJSONString];
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"kLLUserModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//进入登录页面
+(void)enterLoginView{
    //退出登录
    [UCLoginManager logout];
    [[UCLoginManager sharedManager] showLoginViewController];
}
//退出登录
+(void)logout{
    //清空用户信息
    [UCLoginManager clearUserInfo];
}


-(NSString *)getDeviceID{
    NSUUID * uuid = [[UIDevice currentDevice] identifierForVendor];
    NSString * uuidStr = [NSString stringWithFormat:@"%@",uuid];
    return uuidStr;
}
//显示登录控制器
- (void)showLoginViewController{
//    UCLoginViewController * loginVC = [UCLoginViewController new];
//    WEAKSELF
//    loginVC.loginCancelBlock = ^{
//        STRONGSELFFor(weakSelf)
//        [strongSelf showTabarWindow];
//    };
//    BaseNavigationController * loginNavigationController = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
//    self.loginWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.loginWindow.rootViewController = loginNavigationController;
//    self.loginWindow.windowLevel = UIWindowLevelNormal;
//    [self.loginWindow makeKeyAndVisible];
    
}
//显示主控制器
-(void)showTabarWindow{
    self.loginWindow.windowLevel = UIWindowLevelNormal;
    [self.originWindow makeKeyAndVisible];
    self.loginWindow = nil;
    
}

//使用手机登录
-(void)usePhoneLogin:(NSString *)account
            password:(NSString *)password
             success:(UCLoginSuccessBlock)success
             failure:(UCLoginFailureBlock)failure{
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:account forKey:@"userName"];
//    [params setValue:[[UCToolHelper toolHelper] encryptMD5:password] forKey:@"userPwd"];
    [params setValue:@"iOS" forKey:@"optSystem"];
    [params setValue:[self getDeviceID] forKey:@"deviceID"];
    
    
}


//获取注册验证码
- (void)getRegisterValid:(NSDictionary *)params state:(void (^)(BOOL success,NSString * msg))stateBlock
{
    
}
//注册请求
-(void)userPhoneRegister:(NSString *)account
                password:(NSString *)password
                   valid:(NSString *)valid
                     sex:(NSString *)sexStr
                nickName:(NSString *)nickName
                 headImg:(NSString *)headImg
                 success:(UCLoginSuccessBlock)success
                 failure:(UCLoginFailureBlock)failure{
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:account forKey:@"userName"];
    [params setValue:account forKey:@"mobile"];
    [params setValue:valid forKey:@"validCode"];
    [params setValue:nickName forKey:@"nickName"];
    [params setValue:sexStr forKey:@"sex"];
    [params setValue:headImg forKey:@"userAvatar"];
//    [params setValue:[[UCToolHelper toolHelper] encryptMD5:password] forKey:@"userPwd"];
    [params setValue:@"iOS" forKey:@"optSystem"];
    [params setValue:[self getDeviceID] forKey:@"deviceID"];
   
    
}

- (void)userRegisterAfter :(LLUserModel *)model
{
    
}

//获取忘记密码验证码
- (void)getForgetValid:(NSDictionary *)params state:(void (^)(BOOL success,NSString * msg))stateBlock
{
   
}

//忘记密码请求
-(void)forgetPassword:(NSString *)account
             password:(NSString *)password
                valid:(NSString *)valid
              success:(UCLoginSuccessBlock)success
              failure:(UCLoginFailureBlock)failure{
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:account forKey:@"userName"];
    [params setValue:account forKey:@"mobile"];
    [params setValue:valid forKey:@"validCode"];
//    [params setValue:[[UCToolHelper toolHelper] encryptMD5:password] forKey:@"userPwd"];
    [params setValue:@"iOS" forKey:@"optSystem"];
    [params setValue:[self getDeviceID] forKey:@"deviceID"];

    
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
    LLUserModel *model = [UCLoginManager getUserModel];
    return model.token;
}
+ (void)setAuthToken:(NSString *)authToken {
    LLUserModel *model = [UCLoginManager getUserModel];
    model.token = authToken;
    [UCLoginManager setUserModel:model];
}





@end
