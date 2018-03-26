//
//  LLTestNetWork.h
//  PrivateMelon
//
//  Created by 李顺风 on 2018/3/26.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCBannerRecommedModel.h"



@interface LLTestNetWork : NSObject
/** 单例 */
+ (instancetype)sharedInstance;




- (void)getUniDataWithParameters:(NSDictionary *) param
                        Complete:(void (^)(LLSchoolListModel *model))completeBlock
                          failed:(void (^)(NSString *error))failedBlock;

- (void)getLLUCWithParameters:(NSDictionary *) param
                     Complete:(void (^)(UCUCityBaseListMdoel *list))completeBlock
                       failed:(void (^)(NSString *error))failedBlock;
@end
