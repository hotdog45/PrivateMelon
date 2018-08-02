//
//  NSDictionary+BBDicCategory.h
//  beibei
//
//  Created by LSY on 2017/4/7.
//  Copyright © 2017年 iSailor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BBDicCategory)

//删除所有的空键值
-(NSDictionary *)deleteAllNullValue;

//JSONString 转字典
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

//字典数据预警
- (NSString *)jsonString: (NSString *)key;
- (NSDictionary *)jsonDict: (NSString *)key;
- (NSArray *)jsonArray: (NSString *)key;
- (NSArray *)jsonStringArray: (NSString *)key;
- (BOOL)jsonBool: (NSString *)key;
- (NSInteger)jsonInteger: (NSString *)key;
- (long long)jsonLongLong: (NSString *)key;
- (unsigned long long)jsonUnsignedLongLong:(NSString *)key;

- (double)jsonDouble: (NSString *)key;


@end
