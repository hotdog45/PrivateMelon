//
//  BSLocationbyphoneModel.h
//  BlockShell
//
//  Created by 李顺风 on 2018/7/11.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSBaseJSONModel.h"

@interface BSLocationbyphoneModel : BSBaseJSONModel

@property(nonatomic) NSString  * city;
@property(nonatomic) NSString  * province;
@property(nonatomic) NSString  * phoneclass;
@property(nonatomic) NSString  * phonenumber;
@property(nonatomic) NSString  * result;
@property(nonatomic) NSString  * time;

@end
//{
//    "city": "杭州",
//    "province": "浙江",
//    "phoneclass": "移动",
//    "phonenumber": "17682458290",
//    "result": "t",
//    "time": "2017-08-15 14:02:42"
//    }
