//
//  LLChannelsModel.h
//  BlockShell
//
//  Created by 李顺风 on 2018/4/9.
//  Copyright © 2018年 李顺风. All rights reserved.
//




//"name": "旅行",
//"displayName": "旅行",
//"id": 0
@protocol LLChannelsModel <NSObject>
@end
@interface LLChannelsModel : BSBaseJSONModel
@property(nonatomic) NSString  * name;
@property(nonatomic) NSString  * displayName;
@property(nonatomic) NSNumber  * id;
@property(nonatomic) BOOL  isSetting;


@end

@interface LLChannelsArrModel : BSBaseJSONModel
@property(nonatomic) NSArray <LLChannelsModel,Optional>  * list;
@end


