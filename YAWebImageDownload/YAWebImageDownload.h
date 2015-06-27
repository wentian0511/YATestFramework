//
//  YAWebImageDownload.h
//  YATestFramework
//
//  Created by MacDev1 on 15/6/16.
//  Copyright (c) 2015年 yanan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YAWebImageDownload;

/**
 *	@brief	接收到图片数据时回调
 *
 *	@param 	imageData 	图片的二进制数据
 *
 *	@param 	markPosition 	图片在视图中的标记位
 *
 *	@param 	sender 	本类的对象
 */
typedef void(^WebImageReceivedDataCallBack)(NSData *imageData, NSIndexPath *markPosition, YAWebImageDownload *sender);

/**
 *	@brief	图片下载完成回调
 *
 *	@param 	imageData 	图片的二进制数据
 *
 *	@param 	markPosition 	图片在视图中的标记位
 *
 *	@param 	sender 	本类的对象
 */
typedef void(^WebImageDownloadSuccessCallBack)(NSData *imageData, NSIndexPath *markPosition, YAWebImageDownload *sender);

/**
 *	@brief	图片下载失败回调
 *
 *	@param 	markPosition 	图片在视图中的标记位
 *
 *	@param 	sender 	本类的对象
 */
typedef void(^WebImageDownloadFailCallBack)(NSIndexPath *markPosition, YAWebImageDownload *sender);

@protocol YAWebImageDownloadDelegate <NSObject>

/*< 接收到图片数据时回调 */
- (void)callBackReceivedData:(NSData *)imageData
                markPosition:(NSIndexPath *)markPosition
                      sender:(YAWebImageDownload *)sender;

/*< 图片下载成功回调 */
- (void)callBackDownloadSuccess:(NSData *)imageData
                   markPosition:(NSIndexPath *)markPosition
                         sender:(YAWebImageDownload *)sender;

/*< 图片下载失败回调 */
- (void)callBackDownloadFail:(NSIndexPath *)markPosition
                      sender:(YAWebImageDownload *)sender;

@end

@interface YAWebImageDownload : NSObject

/**
 *	@brief	获取该类的下载对象，每次访问返回的都是不同的(新创建的)对象
 *
 *	@return	对象(非单例)
 */
+ (YAWebImageDownload *)grabWebImageDownload;

/** 方式1
 *	@brief	带有block回调的方法
 *
 *	@param 	imageUrl            图片的url
 *	@param 	imageStoragePath 	图片下载后存放路径
 *	@param 	markPosition        图片在视图中的标记位
 *	@param 	successCallBack 	下载成功后的回调block
 *	@param 	failCallBack        下载失败后的回调block
 *
 *	@return
 */
- (void)webImageDownload:(NSString *)imageUrl
        imageStoragePath:(NSString *)imageStoragePath
            markPosition:(NSIndexPath *)markPosition
     receiveDataCallBack:(WebImageReceivedDataCallBack)receiveDataCallBack
         successCallBack:(WebImageDownloadSuccessCallBack)successCallBack
            failCallBack:(WebImageDownloadFailCallBack)failCallBack;


/** 方式2
 *	@brief	带有代理回调的方法
 *
 *	@param 	imageUrl            图片的url
 *	@param 	imageStoragePath 	图片下载后存放路径
 *	@param 	markPosition        图片在视图中的标记位
 *	@param 	delegate            代理
 *
 *	@return
 */
- (void)webImageDownload:(NSString *)imageUrl
        imageStoragePath:(NSString *)imageStoragePath
            markPosition:(NSIndexPath *)markPosition
                delegate:(id<YAWebImageDownloadDelegate>)delegate;


/**
 *	@brief	取消所有图片下载；防止下载后，代理对象已经释放而导致回调的崩溃
 *
 *	@return
 */
+ (void)cancelAllWebImageDownload;

@end