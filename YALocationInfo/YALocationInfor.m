//
//  YALocationInfo.m
//  YATestFramework
//
//  Created by MacDev1 on 15/6/25.
//  Copyright (c) 2015年 yanan. All rights reserved.
//

#import "YALocationInfor.h"

@interface YALocationInfor ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *mLocationManager;

@property (copy, nonatomic) LocBlock mLocationBlock;



@end

@implementation YALocationInfor

#pragma mark - 单例
static YALocationInfor *single = nil;
+ (YALocationInfor *)shareLocationInforModel {
    @synchronized(self) {
        if (!single) {
            single = [[YALocationInfor alloc]init];
            // 调用获取位置信息的方法
            [single getUserCurrentLocationInfo:NULL];
        }
        return single;
    }
}

#pragma mark - 开始获取用户当前的位置信息
- (void)getUserCurrentLocationInfo:(LocBlock)LocationBlock {
    _mLocationBlock = LocationBlock;
    if (!_mLocationManager) {
        _mLocationManager = [[CLLocationManager alloc]init];
        _mLocationManager.distanceFilter = kCLDistanceFilterNone; // meters
        _mLocationManager.delegate = self;
        _mLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        if (YA_IOS_VERSION_NotLessThan(8.0)) {
            
            /* 需要在info中新增两个key NSLocationAlwaysUsageDescription 和 NSLocationWhenInUseUsageDescription  */
            
            //使用期间
            [_mLocationManager requestWhenInUseAuthorization];
            //始终
            // [self.locationManage requestAlwaysAuthorization]
        }
    }
    if (_mLocationManager)
        [_mLocationManager startUpdatingLocation];
}

#pragma mark - 成功获取定位数据后
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    CLLocation *currentLocation = [locations lastObject];
    
    _uLatitude = currentLocation.coordinate.latitude;
    _uLongitude = currentLocation.coordinate.longitude;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *array, NSError *error) {
                       if (array.count > 0) {
                           CLPlacemark *placemark = [array objectAtIndex:0];
                           [self locSuccessSet:placemark];
                           if (_mLocationBlock)
                               _mLocationBlock(self, SUCCESS, error);
                       } else if (error == nil && [array count] == 0) {
                           if (_mLocationBlock)
                               _mLocationBlock(self, FAIL, error);
                       } else if (error != nil) {
                           if (_mLocationBlock)
                               _mLocationBlock(self, FAIL, error);
                       }
                   }];
}


#pragma mark - 定位失败时回调
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (_mLocationBlock) {
        _mLocationBlock(self, FAIL, error);
    }
    
}


#pragma mark - 处理定位成功后，反向地理编码得到的信息
- (void)locSuccessSet:(CLPlacemark *)placemark {
    _isHaveLocInfor = YES;
    
    //获取城市
    NSString *city = placemark.locality;
    if (!city) {
        // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
        city = placemark.administrativeArea;
    }
    _uCity = city;
    
    _uCounty          = [placemark.addressDictionary objectForKey:@"Country"];
    _uCountryCode     = [placemark.addressDictionary objectForKey:@"CountryCode"];
    _uProvince        = [placemark.addressDictionary objectForKey:@"State"];
    _uAddress         = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
    _uStreet          = [placemark.addressDictionary objectForKey:@"Street"];
    _uSubLocality     = [placemark.addressDictionary objectForKey:@"SubLocality"];
    _uSubThoroughfare = [placemark.addressDictionary objectForKey:@"SubThoroughfare"];
    _uThoroughfare    = [placemark.addressDictionary objectForKey:@"Thoroughfare"];
    
    _uDetailLocString = [[NSString alloc]initWithFormat:@"%@%@%@",_uProvince?_uProvince:@"",_uSubLocality?_uSubLocality:@"",_uStreet?_uStreet:@""];
//    FIXLog(@"\n\n\n\nplacemark.addressDictionary = %@\n\n\n\n",placemark.addressDictionary);
}

#pragma mark - iOS8 新增回调方法
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_mLocationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_mLocationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
    
}


@end
