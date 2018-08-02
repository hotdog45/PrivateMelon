//
//  LLUserModel.h
//  UCity
//
//  Created by 李顺风
//
//


@interface LLUserModel : BSBaseJSONModel

@property(nonatomic) NSNumber * userId;
@property(nonatomic) NSString  * phone;

@property(nonatomic) NSString  * name;
@property(nonatomic) NSString  * loginPwd;
@property(nonatomic) NSString  * tradePwd;
@property(nonatomic) NSString  * headPic;
@property(nonatomic) NSString  * birthday;
@property(nonatomic) NSString  * mail;
@property(nonatomic) NSString  * area;
@property(nonatomic) NSString  * address;
@property(nonatomic) NSString  * activeCode;
@property(nonatomic) NSString  * inviteCode;
@property(nonatomic) NSString  * attribute;

@property(nonatomic) NSNumber  * status;
@property(nonatomic) NSNumber  * gmtCreate;
@property(nonatomic) NSNumber  * gmtModified;
@property(nonatomic) NSNumber  * sex;
@property(nonatomic) NSNumber  * origin;
@property(nonatomic) NSNumber  * userTag;
@property(nonatomic) NSString  * token;

@end
//"userId": null,
//"phone": 13588847230,
//"name": "135****7230",
//"loginPwd": null,
//"tradePwd": null,
//"status": 1,
//"gmtCreate": null,
//"gmtModified": null,
//"headPic": null,
//"birthday": null,
//"sex": null,
//"mail": null,
//"area": null,
//"address": null,
//"activeCode": "000000;1528879793865",
//"inviteCode": null,
//"origin": null,
//"userTag": null,
//"attribute": null
