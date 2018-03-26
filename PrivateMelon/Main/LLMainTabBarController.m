//
//  LLMainTabBarController.m
//  PrivateMelon
//
//  Created by 李顺风 on 2018/3/26.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLMainTabBarController.h"
#import "LLTest1ViewController.h"
#import "LLTest2ViewController.h"
#import "LLTabBar.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"



@interface LLMainTabBarController ()<LLTabBarDelegate, UIActionSheetDelegate>

@end

@implementation LLMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControllers];
}


#pragma mark -- Initial Methods

- (void)initControllers
{
    BaseNavigationController *homeVC = [[BaseNavigationController alloc] initWithRootViewController:[LLTest1ViewController new]];
    BaseNavigationController *foundVC = [[BaseNavigationController alloc] initWithRootViewController:[LLTest2ViewController new]];
    BaseNavigationController *messageVC = [[BaseNavigationController alloc] initWithRootViewController:[LLTest1ViewController new]];
    BaseNavigationController *mineVC = [[BaseNavigationController alloc] initWithRootViewController:[LLTest2ViewController new]];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[homeVC, foundVC, messageVC, mineVC];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabBarController.tabBar.bounds];
    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"好友圈", kLLTabBarItemAttributeNormalImageName : @"home_normal", kLLTabBarItemAttributeSelectedImageName : @"home_highlight", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"发现", kLLTabBarItemAttributeNormalImageName : @"mycity_normal", kLLTabBarItemAttributeSelectedImageName : @"mycity_highlight", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"", kLLTabBarItemAttributeNormalImageName : @"post_normal", kLLTabBarItemAttributeSelectedImageName : @"post_normal", kLLTabBarItemAttributeType : @(LLTabBarItemRise)},
                                    @{kLLTabBarItemAttributeTitle : @"消息", kLLTabBarItemAttributeNormalImageName : @"message_normal", kLLTabBarItemAttributeSelectedImageName : @"message_highlight", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"自己", kLLTabBarItemAttributeNormalImageName : @"account_normal", kLLTabBarItemAttributeSelectedImageName : @"account_highlight", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
    
    tabBar.delegate = self;
    [tabBarController.tabBar addSubview:tabBar];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = tabBarController;
}


#pragma mark - LLTabBarDelegate

- (void)tabBarDidSelectedRiseButton {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabBarController = (UITabBarController *)appDelegate.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"发布分享", @"发布活动", @"发布交换", nil];
    [actionSheet showInView:viewController.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %ld", buttonIndex);
}
@end
