//
//  NSString+handle.h
//  yuzhilai
//
//  Created by jiang on 2017/6/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (handle)

- (CGSize)stringSizeWithFont:(UIFont *)font;

- (NSString *)MD5String;

- (NSUInteger)getBytesLength;

- (NSString *)stringByDeletingPictureResolution;
//普通size
-(CGSize)getStrSize:(NSString*)str font:(UIFont*)font size:(CGSize)size;
//富文本size
-(CGSize)getStrsize:(NSString*)str font:(UIFont*)font lineSpace:(CGFloat)space firstLineSpace:(CGFloat)firstLineSpace size:(CGSize)size ;
+(NSString*)UUID;
//时间转换
+ (NSString *)theTime:(NSString *)issueTime;
- (BOOL)isMobileNumber;
- (NSString *)URLDecode;
- (NSString *)URLEncode;
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
@end
