//
//  AppDelegate.m
//  BlockShell
//
//  Created by 李顺风 on 2018/3/26.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "AppDelegate.h"
#import "LLMainTabBarController.h"
#import  <UserNotifications/UserNotifications.h>



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [LLMainTabBarController new];
    

    //推送
    if (IOS_VERSION_10_OR_LATER) {
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
            [center setDelegate:self];
            UNAuthorizationOptions type = UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert;
            [center requestAuthorizationWithOptions:type completionHandler:^(BOOL granted, NSError * _Nullable error) {
                
                if (granted) {
                    NSLog(@"注册成功");
                }else{
                    NSLog(@"注册失败");
                }
                
            }];
        } else {
            // Fallback on earlier versions
        }
        
        
    }else if (IOS_VERSION_8_OR_LATER){
        
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        
        UIUserNotificationTypeSound |
        
        UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        
        [application registerUserNotificationSettings:settings];
        
    }
//    else{//ios8一下
//
//        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
//
//        UIRemoteNotificationTypeSound |
//
//        UIRemoteNotificationTypeAlert;
//
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
//
//    }
//    [OpenShare connectWeixinWithAppId:@"wxd930ea5d5a258f4f"];
    [OpenShare connectAlipay];//支付宝参数都是服务器端生成的，这里不需要key.
//    [OpenShare connectWeixinWithAppId:@"wxd930ea5d5a258f4f" miniAppId:@"gh_d43f693ca31f"];
//    [OpenShare connectWeixinWithAppId:@"wxd930ea5d5a258f4f"]; //wxdf3989b2edb80672
    [OpenShare connectWeixinWithAppId:@"wxb0d970a554086272"]; //
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }
    return YES;
}


// 将得到的deviceToken传给SDK

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString *deviceTokenStr = [[[[deviceToken description]
                                  
                                  stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                 
                                 stringByReplacingOccurrencesOfString:@">" withString:@""]
                                
                                stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"deviceTokenStr:\n%@",deviceTokenStr);
    
}

// 注册deviceToken失败

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"error -- %@",error);
    
}

//在前台

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionBadge|
                          
                          UNNotificationPresentationOptionSound|
                          
                          UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    
    //处理推送过来的数据
    
//    [self handlePushMessage:response.notification.request.content.userInfo];
    
    completionHandler();
    
}

// iOS10以下的处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary * _Nonnull)userInfo fetchCompletionHandler:(void (^ _Nonnull)(UIBackgroundFetchResult))completionHandler{
    
    NSLog(@"didReceiveRemoteNotification:%@",userInfo);
    
    /*
     
     UIApplicationStateActive 应用程序处于前台
     
     UIApplicationStateBackground 应用程序在后台，用户从通知中心点击消息将程序从后台调至前台
     
     UIApplicationStateInactive 用用程序处于关闭状态(不在前台也不在后台)，用户通过点击通知中心的消息将客户端从关闭状态调至前台
     
     */
    
    //应用程序在前台给一个提示特别消息
    
    if (application.applicationState == UIApplicationStateActive) {
        
        //应用程序在前台
        
//        [self createAlertViewControllerWithPushDict:userInfo];
        
    }else{
        
        //其他两种情况，一种在后台程序没有被杀死，另一种是在程序已经杀死。用户点击推送的消息进入app的情况处理。
        
//        [self handlePushMessage:userInfo];
        
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
