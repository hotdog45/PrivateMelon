//
//  LLMainTabBarController.m
//  PrivateMelon
//
//  Created by 李顺风 on 2018/3/26.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLMainTabBarController.h"
#import "BaseNavigationController.h"

#import "LLMomentsVC.h"
#import "LLDiscoverVC.h"
#import "LLMessageVC.h"
#import "LLMineVC.h"

#import "UCCustomTabBar.h"


@interface LLMainTabBarController ()<UCCustomTabBarDelegate,UITabBarControllerDelegate>

@end

@implementation LLMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor whiteColor];
    self.delegate = self;
    self.tabBar.translucent = NO;
    
    [self initControllers];
}

- (void)initControllers
{
    
    LLMomentsVC *vc1 = [[LLMomentsVC alloc] init];
    [self addChildViewController:vc1 image:@"home_normal" selectedImage:@"home_highlight" title:@"好友圈"];
    
    LLDiscoverVC *vc2 = [[LLDiscoverVC alloc] init];
    [self addChildViewController:vc2 image:@"mycity_normal" selectedImage:@"mycity_highlight" title:@"发现"];
    
    LLMessageVC *vc3 = [[LLMessageVC alloc] init];
    [self addChildViewController:vc3 image:@"message_normal" selectedImage:@"message_highlight" title:@"消息"];
    
    //我
    LLMineVC *profile = [[LLMineVC alloc]init];
    [self addChildViewController:profile image:@"account_normal" selectedImage:@"account_highlight" title:@"自己"];
    
    UCCustomTabBar *tabBar = [[UCCustomTabBar alloc]init];
    tabBar.customTabBarDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}
#pragma mark -- Initial Methods
/**
 *  添加子控制器
 *
 *  @param childViewController 子控制器
 *  @param image               tabBarItem正常状态图片
 *  @param selectedImage       tabBarItem选中状态图片
 *  @param title               标题
 */
- (void)addChildViewController:(UIViewController *)childViewController image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    
    //标题
    childViewController.title = title;
    //tabBarItem图片
    childViewController.tabBarItem.image = [UIImage imageNamed:image];
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem字体的设置
    NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
    normalText[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
    [childViewController.tabBarItem setTitleTextAttributes:normalText forState:UIControlStateNormal];
    
    //选中状态
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] = LRRGBColor(253, 150, 30);
    [childViewController.tabBarItem setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    BaseNavigationController *navgationVC = [[BaseNavigationController alloc] initWithRootViewController:childViewController];
    [self addChildViewController:navgationVC];
}




#pragma mark -- UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
   
    return true;
}





#pragma mark - Target Methods
#pragma mark - UCCustomTabBarDelegate

- (void)addBtnDidClick:(UCCustomTabBar *)tabBar
{
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
