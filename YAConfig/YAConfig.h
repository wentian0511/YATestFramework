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


/*********** 获取系统的版本号 ***********/
#define YA_IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])


/*********** 判断版本号 ***********/

#define YA_IOS_VERSION_NotLessThan(__v) (YA_IOS_VERSION >= __v) // 不小于
#define YA_IOS_VERSION_NotMoreThan(__v) (YA_IOS_VERSION <= __v) // 不大于

#define YA_IOS_VERSION_LessThan(__v) (YA_IOS_VERSION < __v) // 小于
#define YA_IOS_VERSION_MoreThan(__v) (YA_IOS_VERSION > __v) // 大于

/*********** 获取屏幕尺寸 ***********/

#define YA_SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define YA_SCREEN_WIDTH  [[UIScreen mainScreen]bounds].size.width
