//
//  AppDelegate.h
//  YATestFramework
//
//  Created by MacDev1 on 15/6/16.
//  Copyright (c) 2015年 yanan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CTCallCenter *callCenter;


@end

