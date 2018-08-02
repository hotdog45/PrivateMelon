//
//  BSPhonevaluepayModel.h
//  BlockShell
//
//  Created by 李顺风 on 2018/7/13.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSBaseJSONModel.h"

@interface BSPhonevaluepayModel : BSBaseJSONModel
@property(nonatomic) NSString  * ordernumber;
@property(nonatomic) NSString  * custom;
@property(nonatomic) NSString  * result;
@property(nonatomic) NSString  * time;

@property(nonatomic) NSString  * errcode;
@property(nonatomic) NSString  * errmsg;

@end
//{
//    "ordernumber": "10000020170622104117768",
//    "custom": "备注",
//    "result": "t",
//    "time": "2018-07-11 13:51:30",
//    "errcode": null,
//    "errmsg": null
//    }
