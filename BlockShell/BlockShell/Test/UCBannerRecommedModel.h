//
//  UCBannerRecommedModel.h
//  UCity
//
//  Created by 李顺风 on 2017/9/4.
//
//

#import <Foundation/Foundation.h>

@protocol LLSchoolModel <NSObject>
@end
@interface LLSchoolModel : BSBaseJSONModel
@property(nonatomic) NSNumber  * id;
@property(nonatomic) NSNumber  * isHot;
@property(nonatomic) NSNumber  * isActive;
@property(nonatomic) NSString  * uniName;
@property(nonatomic) NSString  * cityName;
@property(nonatomic) NSString  * createTime;

@property(nonatomic) NSNumber  * uniId;
@property(nonatomic) NSNumber  * stuCount;


@property(nonatomic) NSString  * uniClass;
@property(nonatomic) NSString  * uniYear;
@property(nonatomic) NSString  * uniDepartment;
@property(nonatomic) NSString  * uniMajor;

@end
@interface LLSchoolListModel : BSBaseJSONModel
@property(nonatomic) NSArray <LLSchoolModel,Optional>* data;
@property(nonatomic) NSNumber  * page;
@property(nonatomic) NSNumber  * perPage;
@property(nonatomic) NSNumber  * total;
@property(nonatomic) NSNumber  * totalPage;
@end

@interface LLUniYearListModel : BSBaseJSONModel
@property(nonatomic) NSArray <LLSchoolModel,Optional>* data;
@end

///////
@protocol UCUCityItemsModel <NSObject>
@end

@interface UCUCityItemsModel : BSBaseJSONModel


@property(nonatomic) NSNumber   *isSelected;

@property(nonatomic) NSNumber  * id;
@property(nonatomic) NSNumber  * isActive;
@property(nonatomic) NSNumber  * isBan;
@property(nonatomic) NSNumber  * isBannaer;
@property(nonatomic) NSNumber  * isCollect;
@property(nonatomic) NSNumber  * isEnroll;
@property(nonatomic) NSNumber  * isFollow;
@property(nonatomic) NSNumber  * isLike;
@property(nonatomic) NSNumber  * isLost;
@property(nonatomic) NSNumber  * isReport;
@property(nonatomic) NSNumber  * isSell;
@property(nonatomic) NSNumber  * itemHighPrice;
@property(nonatomic) NSNumber  * itemLowPrice;
@property(nonatomic) NSString  * banedReason;
@property(nonatomic) NSString  * cityCode;

@property(nonatomic) NSString  * cityName;
@property(nonatomic) NSString  * contact;
@property(nonatomic) NSString  * contactPerson;
@property(nonatomic) NSString  * createTime;
@property(nonatomic) NSString  * endTime;
@property(nonatomic) NSString  * groupId;
@property(nonatomic) NSString  * nickName;
@property(nonatomic) NSString  * provinceCode;
@property(nonatomic) NSString  * provinceName;
@property(nonatomic) NSString  * pubAddr;
@property(nonatomic) NSString  * pubDescription;
@property(nonatomic) NSString  * pubExtend;
@property(nonatomic) NSNumber  * pubItemType;
@property(nonatomic) NSString  * pubShortCover;
@property(nonatomic) NSString  * pubShortDesc;
@property(nonatomic) NSString  * pubTitle;


@property(nonatomic) NSNumber  * pubType;
@property(nonatomic) NSNumber  * pubTypeId;
@property(nonatomic) NSString  * recallReason;
@property(nonatomic) NSString  * rollImgs;
@property(nonatomic) NSString  * startTime;
@property(nonatomic) NSString  * studyHost;
@property(nonatomic) NSNumber  * uid;
@property(nonatomic) NSString  * uniArea;
@property(nonatomic) NSNumber  * uniId;
@property(nonatomic) NSString  * uniName;
@property(nonatomic) NSString  * uniSpell;
@property(nonatomic) NSNumber  * unreadNotice;
@property(nonatomic) NSString  * userAvatar;
@property(nonatomic) NSString  * remarkNickName;
@property(nonatomic) NSNumber  * userDelete;
@property(nonatomic) NSString  * author;


@property(nonatomic) NSString  * zoneCode;
@property(nonatomic) NSString  * zoneName;
@property(nonatomic) NSNumber  * rcGroupId;

@property(nonatomic) NSNumber  * userRole;
@property(nonatomic) NSString  * rcGroupName;
@property(nonatomic) NSString  * rcGroupLogo;
@property(nonatomic) NSString  * likeCount;

@end

@interface UCUCityBaseListMdoel : BSBaseJSONModel

@property(nonatomic) NSArray <UCUCityItemsModel,Optional>* data;
@property(nonatomic) NSNumber  * page;
@property(nonatomic) NSNumber  * perPage;
@property(nonatomic) NSNumber  * total;
@property(nonatomic) NSNumber  * totalPage;

@end
