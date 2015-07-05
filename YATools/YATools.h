//
//  YATools.h
//  YATestFramework
//
//  Created by MacDev1 on 15/6/23.
//  Copyright (c) 2015年 yanan. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    CheckImageFormat_JPEG     = 0, /*< jpg */
    CheckImageFormat_PNG         , /*< png */
    CheckImageFormat_Unknown     , /*< unknown */
} CheckImageFormat;



@interface YATools : NSObject

/* UIImage */
/**
 *	@brief	判断图片是什么格式
 *
 *	@param 	imageData 	图片data
 *
 *	@return	图片类型
 */
+ (CheckImageFormat)checkImageFormatFromData:(NSData *)imageData;

/**
 *	@brief	判断图片是什么格式
 *
 *	@param 	imagePath 	图片存放的路径
 *
 *	@return	图片类型
 */
+ (CheckImageFormat)checkImageFormatFromPath:(NSString *)imagePath;


/* 文件操作 */

+ (BOOL)createFolder:(NSString *)folderPath;


/* 计算两坐标点之间的距离 */

/**
 *	@brief	计算两坐标点之间的距离
 *
 *	@param 	startCoorlat 	起点的lat
 *	@param 	startCoorlon 	起点的lon
 *	@param 	endCoorlat      终点的lat
 *	@param 	endCoorlon      终点的lon
 *
 *	@return	距离(单位:m)
 */
+ (double)calcCoorPointDist:(double)startCoorlat
                           :(double)startCoorlon
                           :(double)endCoorlat
                           :(double)endCoorlon;

/* 时间和时间戳之间相互转换 */

/**
 *	@brief	时间戳转时间
 *
 *	@param 	unixTime 	时间戳float
 *	@param 	timeFormat 	时间格式
 *
 *	@return	格式化后的时间字符串
 */
+ (NSString *)unixTimeTransforTimeF:(double)unixTime
                         timeFormat:(NSString *)timeFormat;

/**
 *	@brief	时间戳转时间
 *
 *	@param 	unixTime 	时间戳字符串
 *	@param 	timeFormat 	时间格式
 *
 *	@return	格式化后的时间字符串
 */
+ (NSString *)unixTimeTransforTimeS:(NSString *)unixTime
                         timeFormat:(NSString *)timeFormat;


/* 判断设备是否越狱 */
+ (BOOL)isJailbroken;


@end





