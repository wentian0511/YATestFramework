//
//  YATools.m
//  YATestFramework
//
//  Created by MacDev1 on 15/6/23.
//  Copyright (c) 2015年 yanan. All rights reserved.
//

#import "YATools.h"

#define EarthRadius 6371004 // 地球半径

@implementation YATools

#pragma mark - 判断图片是什么格式
+ (CheckImageFormat)checkImageFormatFromData:(NSData *)imageData {
    if (imageData.length > 4) {
        const unsigned char * bytes = [imageData bytes];
        if (bytes[0] == 0xff &&
            bytes[1] == 0xd8 &&
            bytes[2] == 0xff) {
            return CheckImageFormat_JPEG;
        }
        if (bytes[0] == 0x89 &&
            bytes[1] == 0x50 &&
            bytes[2] == 0x4e &&
            bytes[3] == 0x47) {
            return CheckImageFormat_PNG;
        }
    }
    return CheckImageFormat_Unknown;
}

#pragma mark - 判断图片是什么格式
+ (CheckImageFormat)checkImageFormatFromPath:(NSString *)imagePath {
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    return [self checkImageFormatFromData:imageData];
}

#pragma mark - 创建文件夹
+ (BOOL)createFolder:(NSString *)folderPath {
    
    
    
    
    
    return TRUE;
}

#pragma mark - 计算地球上两点之间的距离
+ (double)calcCoorPointDist:(double)startCoorlat
                           :(double)startCoorlon
                           :(double)endCoorlat
                           :(double)endCoorlon {
    
    double dd = M_PI/180; // 弧度
    double x1 = startCoorlat*dd, x2 = endCoorlat*dd;
    double y1 = startCoorlon*dd, y2 = endCoorlon*dd;
    double R  = EarthRadius;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    
    // 返回  距离(单位:m)
    return   distance;
}

#pragma mark - 时间戳转时间
+ (NSString *)unixTimeTransforTimeF:(double)unixTime
                         timeFormat:(NSString *)timeFormat {
    // timeFormat -> @"yyyy-MM-dd HH:mm:ss"
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:timeFormat];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:unixTime];
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

+ (NSString *)unixTimeTransforTimeS:(NSString *)unixTime
                         timeFormat:(NSString *)timeFormat {
    // timeFormat -> @"yyyy-MM-dd HH:mm:ss"
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:timeFormat];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[unixTime floatValue]];
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
    
//    double unixTimeStamp = [unixTime doubleValue];
//    NSTimeInterval _interval=unixTimeStamp;
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
//    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
//    [_formatter setLocale:[NSLocale currentLocale]];
//    [_formatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
//    NSString *_date=[_formatter stringFromDate:date];
//    
//    return _date;
    
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"yyyyMMddHHmmss"];
//    NSDate *date = [formatter dateFromString:unixTime];
//    
//    return date;
}

#pragma mark - 判断设备是否越狱
+ (BOOL)isJailbroken {
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    return jailbroken;
}

@end
