//
//  YALocationInfo.h
//  YATestFramework
//
//  Created by MacDev1 on 15/6/25.
//  Copyright (c) 2015年 yanan. All rights reserved.
//

/*
 * 需要导入 CoreLocation.framework
 */

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@class YALocationInfor;

typedef NS_ENUM(NSInteger, LocationResult) {
    FAIL    = 0,
    SUCCESS    ,
};

typedef void(^LocBlock)(YALocationInfor *locInforModel, LocationResult locRes, NSError *error);

@interface YALocationInfor : NSObject

/**
 *	@brief	YES 有定位的信息可以使用（可以自行决定是否再次调用 getUserCurrentLocationInfo 定位）；NO 还没有进行定位或者定位尚未成功过
 */
@property (assign, nonatomic, readonly) BOOL isHaveLocInfor;

/**
 *	@brief	用户当前的纬度
 */
@property (assign, nonatomic, readonly) CLLocationDegrees uLatitude;

/**
 *	@brief	用户当前的经度
 */
@property (assign, nonatomic, readonly) CLLocationDegrees uLongitude;

/**
 *	@brief	国家
 */
@property (strong, nonatomic, readonly) NSString *uCounty;

/**
 *	@brief	国家码
 */
@property (strong, nonatomic, readonly) NSString *uCountryCode;

/**
 *	@brief	省或直辖市
 */
@property (strong, nonatomic, readonly) NSString *uProvince;

/**
 *	@brief	城市
 */
@property (strong, nonatomic, readonly) NSString *uCity;

/**
 *	@brief	完整的详细信息
 */
@property (strong, nonatomic, readonly) NSString *uAddress;

/**
 *	@brief	街道
 */
@property (strong, nonatomic, readonly) NSString *uStreet;

/**
 *	@brief	区 e.g. 昌平区
 */
@property (strong, nonatomic, readonly) NSString *uSubLocality;

/**
 *	@brief	门牌号
 */
@property (strong, nonatomic, readonly) NSString *uSubThoroughfare;

/**
 *	@brief	路名
 */
@property (strong, nonatomic, readonly) NSString *uThoroughfare;

/**
 *	@brief	地址详情
 */
@property (strong, nonatomic, readonly) NSString *uDetailLocString;

/**
 *	@brief	单例
 *
 *	@return
 */
+ (YALocationInfor *)shareLocationInforModel;

/**
 *	@brief	定位（或重新定位）获取用户当前位置信息
 *
 *	@return
 */
- (void)getUserCurrentLocationInfo:(LocBlock)LocationBlock;


@end
