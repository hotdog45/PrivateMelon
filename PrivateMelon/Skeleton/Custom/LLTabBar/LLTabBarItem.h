

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LLTabBarItemType) {
	LLTabBarItemNormal = 0,
	LLTabBarItemRise,
};

extern NSString *const kLLTabBarItemAttributeTitle;// NSString
extern NSString *const kLLTabBarItemAttributeNormalImageName;// NSString
extern NSString *const kLLTabBarItemAttributeSelectedImageName;// NSString
extern NSString *const kLLTabBarItemAttributeType;// NSNumber, LLTabBarItemType

@interface LLTabBarItem : UIButton

@property (nonatomic, assign) LLTabBarItemType tabBarItemType;

@end
