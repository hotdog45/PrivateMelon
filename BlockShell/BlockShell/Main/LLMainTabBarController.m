//
//  LLMainTabBarController.m
//  BlockShell
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
    [self initControllers];
}

- (void)initControllers
{
    
    LLMomentsVC *vc1 = [[LLMomentsVC alloc] init];
    [self addChildViewController:vc1 image:@"Triangle" selectedImage:@"Triangle" title:@"首页"];
    
    LLDiscoverVC *vc2 = [[LLDiscoverVC alloc] init];
    [self addChildViewController:vc2 image:@"Shopping_icon" selectedImage:@"Shopping_icon" title:@"购物车"];
    
    LLMineVC *vc3 = [[LLMineVC alloc] init];
    [self addChildViewController:vc3 image:@"my_icon" selectedImage:@"my_icon" title:@"我的"];
    
    //我
    LLMessageVC *profile = [[LLMessageVC alloc]init];
    [self addChildViewController:profile image:@"Calculation" selectedImage:@"Calculation" title:@"矿池算力"];
    
//    UCCustomTabBar *tabBar = [[UCCustomTabBar alloc]init];
//    tabBar.customTabBarDelegate = self;
//    tabBar.translucent = NO;
//    [self setValue:tabBar forKeyPath:@"tabBar"];
    UITabBar *tabBar = [[UITabBar alloc]init];
//    tabBar.customTabBarDelegate = self;
    tabBar.translucent = NO;
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
    
    selectedText[NSForegroundColorAttributeName] = [UIColor blackColor];
//    [UIColor colorWithRed:0.416 green:0.859 blue:0.859 alpha:1.000];
    [childViewController.tabBarItem setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    BaseNavigationController *navgationVC = [[BaseNavigationController alloc] initWithRootViewController:childViewController];
//    navgationVC.navigationBar.translucent  = NO;
    [self addChildViewController:navgationVC];
}




#pragma mark -- UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
   
    return true;
}





#pragma mark - Target Methods
#pragma mark - UCCustomTabBarDelegate

//- (void)addBtnDidClick:(UCCustomTabBar *)tabBar
//{
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    UITabBarController *tabBarController = (UITabBarController *)appDelegate.window.rootViewController;
//    UIViewController *viewController = tabBarController.selectedViewController;
//
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                             delegate:self
//                                                    cancelButtonTitle:@"取消"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"发布分享", @"发布活动", @"发布交换", nil];
//    [actionSheet showInView:viewController.view];
//}
//
//
//
//#pragma mark - UIActionSheetDelegate
//
//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    NSLog(@"buttonIndex = %ld", buttonIndex);
//}
@end
