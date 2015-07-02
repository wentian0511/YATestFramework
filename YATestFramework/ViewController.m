//
//  ViewController.m
//  YATestFramework
//
//  Created by MacDev1 on 15/6/16.
//  Copyright (c) 2015年 yanan. All rights reserved.
//

#import "ViewController.h"

#import "YAConfig.h"

@interface ViewController ()<UIScrollViewDelegate> {
    
    UIScrollView *superScrollView;
    UIScrollView *subScrollView;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    superScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, YA_SCREEN_WIDTH, YA_SCREEN_HEIGHT)];
    superScrollView.delegate = self;
    superScrollView.contentSize = CGSizeMake(YA_SCREEN_WIDTH*3, YA_SCREEN_HEIGHT);
    superScrollView.pagingEnabled = YES;
    superScrollView.backgroundColor = [UIColor colorWithRed:0.5 green:0.7 blue:0.8 alpha:1.0];
    [self.view addSubview:superScrollView];
    
    subScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, YA_SCREEN_WIDTH, 400)];
    subScrollView.delegate = self;
    subScrollView.contentSize = CGSizeMake(YA_SCREEN_WIDTH*3, 400);
    subScrollView.pagingEnabled = YES;
    subScrollView.backgroundColor = [UIColor colorWithRed:0.8 green:0.7 blue:0.5 alpha:1.0];
    subScrollView.bounces = NO;
    [superScrollView addSubview:subScrollView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
