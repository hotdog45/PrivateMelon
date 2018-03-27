//
//  LLUserModel.h
//  UCity
//
//  Created by 李顺风 on 2017/9/9.
//
//


@interface LLUserModel : HXBaseJSONModel

@property(nonatomic) NSNumber * id;
@property(nonatomic) NSNumber  * isAuth;

@property(nonatomic) NSNumber  * userRole;
@property(nonatomic) NSNumber  * sex;
@property(nonatomic) NSNumber  * createTime;
@property(nonatomic) NSNumber  * uniId;
@property(nonatomic) NSNumber  * uniDataId;

@property(nonatomic) NSString  * uniName;
@property(nonatomic) NSNumber  * isBan;
@property(nonatomic) NSNumber  * shareVisibility;
@property(nonatomic) NSNumber  * fansOnly;
@property(nonatomic) NSNumber  * followsOnly;
@property(nonatomic) NSNumber  * friendsOnly;
@property(nonatomic) NSNumber  * isFollow;
@property(nonatomic) NSNumber  * isFriend;
@property(nonatomic) NSNumber  * isLink;

@property(nonatomic) NSString  * userName;
@property(nonatomic) NSString  * userPwd;
@property(nonatomic) NSString  * nickName;
@property(nonatomic) NSString  * realName;
@property(nonatomic) NSString  * mobile;
@property(nonatomic) NSString  * userAvatar;
@property(nonatomic) NSString  * token;
@property(nonatomic) NSString  * userSign;



@end
