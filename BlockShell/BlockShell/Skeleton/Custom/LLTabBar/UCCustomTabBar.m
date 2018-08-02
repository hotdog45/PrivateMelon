//
//  UCCustomTabBar.m
//  UCity
//
//  Created by beibei on 2017/8/2.
//
//

#import "UCCustomTabBar.h"
#import "UIView+Extension.h"



@interface UCCustomTabBar ()

@property (strong, nonatomic) UIButton *addBtn;
@end

@implementation UCCustomTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //初始化中间加号按钮
        UIButton *addBtn = [[UIButton alloc]init];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"icon_home_pub"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"icon_home_pub"] forState:UIControlStateHighlighted];
//        [addBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
//        [addBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        addBtn.size = addBtn.currentBackgroundImage.size;
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.addBtn = addBtn;
        [self addSubview:addBtn];
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{    
    [super layoutSubviews];
    self.addBtn.y = -15 * Scale_X;
    self.addBtn.centerX= self.width * 0.5;
    //重新布局tabBar上的tabBarItem
    CGFloat tabBarItemWidth = self.width / 5;
    CGFloat tabBarItemIndex = 0;
    for (UIView *childItem in self.subviews) {
        if ([childItem isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            childItem.width = tabBarItemWidth;
            childItem.x = tabBarItemIndex*tabBarItemWidth;
            tabBarItemIndex ++;
            if (tabBarItemIndex == 2) {
                tabBarItemIndex = tabBarItemIndex + 1;
            }
        }
    }
}


/**
 *  中间按钮的点击方法
 */
- (void)addBtnClick{
    
    if ([self.customTabBarDelegate respondsToSelector:@selector(addBtnDidClick:)]) {
        [self.customTabBarDelegate addBtnDidClick:self];
    }
}



@end
