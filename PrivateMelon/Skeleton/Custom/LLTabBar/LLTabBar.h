

#import <UIKit/UIKit.h>
#import "LLTabBarItem.h"

@protocol LLTabBarDelegate <NSObject>

- (void)tabBarDidSelectedRiseButton;

@end

@interface LLTabBar : UIView

@property (nonatomic, copy) NSArray<NSDictionary *> *tabBarItemAttributes;
@property (nonatomic, strong) id <LLTabBarDelegate> delegate;

@end
