//
//  UCCustomTabBar.h
//  UCity
//
//  Created by beibei on 2017/8/2.
//
//

#import <UIKit/UIKit.h>


@class UCCustomTabBar;

@protocol UCCustomTabBarDelegate <UITabBarDelegate>

@optional
- (void)addBtnDidClick:(UCCustomTabBar *)tabBar;

@end

@interface UCCustomTabBar : UITabBar

@property (weak, nonatomic) id<UCCustomTabBarDelegate> customTabBarDelegate;
@property(nonatomic,assign)BOOL isCommunity;


@end
