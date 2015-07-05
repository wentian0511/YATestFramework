//
//  YAConfig.h
//  YATestFramework
//
//  Created by MacDev1 on 15/6/19.
//  Copyright (c) 2015年 yanan. All rights reserved.
//

#ifndef YATestFramework_YAConfig_h
#define YATestFramework_YAConfig_h


#endif

/* 获取设备的型号 */
#define YA_DEVICE_MODEL ([UIDevice currentDevice].model) // e.g. @"iPhone", @"iPod touch"

/* 获取该设备的名字 */
#define YA_DEVICE_NAME ([UIDevice currentDevice].name) // e.g. "My iPhone"

/* 获取系统的名称 */
#define YA_SYSTEM_NAEM ([UIDevice currentDevice].systemName) // e.g. @"iOS"

/* 获取系统的版本号 */
#define YA_SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

/* 判断版本号 */
#define YA_SYSTEM_VERSION_NotLessThan(__v) (YA_SYSTEM_VERSION >= __v) // 不小于
#define YA_SYSTEM_VERSION_NotMoreThan(__v) (YA_SYSTEM_VERSION <= __v) // 不大于
#define YA_SYSTEM_VERSION_LessThan(__v)    (YA_SYSTEM_VERSION < __v)  // 小于
#define YA_SYSTEM_VERSION_MoreThan(__v)    (YA_SYSTEM_VERSION > __v)  // 大于

/* 获取屏幕尺寸 */
#define YA_SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
#define YA_SCREEN_WIDTH  ([[UIScreen mainScreen]bounds].size.width)

/* release & autorelease */
#if __has_feature(objc_arc)
#define YA_release(obj)
#define YA_autorelease(obj)
#else
#define YA_release(obj)     [obj release]
#define YA_autorelease(obj) [obj autorelease]
#endif



