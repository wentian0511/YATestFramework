//
//  YAWebImageDownload.m
//  YATestFramework
//
//  Created by MacDev1 on 15/6/16.
//  Copyright (c) 2015年 yanan. All rights reserved.
//

#import "YAWebImageDownload.h"

#import "AppDelegate.h"
#pragma mark - 试图控制器(VC)

#pragma mark - 类别(category)

#pragma mark - 模型(model)

#pragma mark - 协议(protocol)

#pragma mark - 宏定义(#define)

#pragma mark - 静态变量
static NSString *CancelAllYAWebImageDownload = @"CancelAllYAWebImageDownload";

@interface YAWebImageDownload () {
    
    NSMutableData *storageImageData; /*< 存储下载到的image数据 */
    
}

@property (nonatomic) id<YAWebImageDownloadDelegate>delegate;

@property (retain, nonatomic) NSString *imageUrl; /*< 图片下载的url */

@property (retain, nonatomic) NSString *imageStoragePath; /*< 图片存储在本地的路径 */

@property (retain, nonatomic) NSIndexPath *markPosition; /*< 展示image的控件在视图中的标记 */

@property (copy, nonatomic) WebImageReceivedDataCallBack receivedDataCallBack; /*< 接收到图片数据时的回调block */

@property (copy, nonatomic) WebImageDownloadSuccessCallBack successCallBack; /*< 下载成功后的回调block */

@property (copy, nonatomic) WebImageDownloadFailCallBack failCallBack; /*< 下载失败时的回调block */

@end

@implementation YAWebImageDownload

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:CancelAllYAWebImageDownload
                                                  object:nil];
#if ! __has_feature(objc_arc)
    self.delegate = nil;
    [_imageUrl release];
    _imageUrl = nil;
    [_imageStoragePath release];
    _imageStoragePath = nil;
    [_markPosition release];
    _markPosition = nil;
    self.successCallBack = nil;
    self.failCallBack = nil;
    [storageImageData release];
    [super dealloc];
#else
    self.delegate = nil;
    self.imageUrl = nil;
    self.imageStoragePath = nil;
    self.markPosition = nil;
    self.successCallBack = nil;
    self.failCallBack = nil;
#endif
}

+ (YAWebImageDownload *)grabWebImageDownload {
    return [[self alloc]init];
}

- (void)webImageDownload:(NSString *)imageUrl
        imageStoragePath:(NSString *)imageStoragePath
            markPosition:(NSIndexPath *)markPosition
     receiveDataCallBack:(WebImageReceivedDataCallBack)receiveDataCallBack
         successCallBack:(WebImageDownloadSuccessCallBack)successCallBack
            failCallBack:(WebImageDownloadFailCallBack)failCallBack {
    self.delegate               = nil;
    self.imageUrl               = imageUrl;
    self.imageStoragePath       = imageStoragePath;
    self.markPosition           = markPosition;
    self.receivedDataCallBack   = receiveDataCallBack;
    self.successCallBack        = successCallBack;
    self.failCallBack           = failCallBack;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopAllWebImageDownload)
                                                 name:CancelAllYAWebImageDownload
                                               object:nil];
    [self sendDownloadRequest];
}

- (void)webImageDownload:(NSString *)imageUrl
        imageStoragePath:(NSString *)imageStoragePath
            markPosition:(NSIndexPath *)markPosition
                delegate:(id<YAWebImageDownloadDelegate>)delegate {
    self.delegate               = delegate;
    self.imageUrl               = imageUrl;
    self.imageStoragePath       = imageStoragePath;
    self.markPosition           = markPosition;
    self.receivedDataCallBack   = nil;
    self.successCallBack        = nil;
    self.failCallBack           = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopAllWebImageDownload)
                                                 name:CancelAllYAWebImageDownload
                                               object:nil];
    [self sendDownloadRequest];
}

#pragma mark - 发送下载请求
- (void)sendDownloadRequest {
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:_imageUrl]
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:30.0];
    [NSURLConnection connectionWithRequest:request
                                  delegate:self];
}

#pragma mark - 接收到响应头时调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; //< 菊花出现开始旋转
    storageImageData = [[NSMutableData alloc]init];
}

#pragma mark - 接收到响应体时调用
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [storageImageData appendData:data];
    if (_delegate && [_delegate respondsToSelector:@selector(callBackReceivedData:markPosition:sender:)]) {
        [_delegate callBackReceivedData:storageImageData
                           markPosition:_markPosition
                                 sender:self];
    } else {
        if (_receivedDataCallBack) {
            _receivedDataCallBack(storageImageData, _markPosition, self);
        }
    }
}

#pragma mark - 接收完成时调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; //< 菊花消失
    [storageImageData writeToFile:_imageStoragePath atomically:NO];
    if (_delegate && [_delegate respondsToSelector:@selector(callBackDownloadSuccess:markPosition:sender:)]) {
        [_delegate callBackDownloadSuccess:storageImageData
                              markPosition:_markPosition
                                    sender:self];
    } else {
        if (_successCallBack)
            _successCallBack(storageImageData, _markPosition, self);
    }
}

#pragma mark - 请求失败时调用
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; //< 菊花消失
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(callBackDownloadFail:sender:)]) {
            [_delegate callBackDownloadFail:_markPosition
                                     sender:self];
        } else {
            if (_failCallBack)
                _failCallBack(_markPosition, self);
        }
    }
}

#pragma mark - 取消所有正在下载图片的请求
+ (void)cancelAllWebImageDownload {
    [[NSNotificationCenter defaultCenter] postNotificationName:CancelAllYAWebImageDownload
                                                        object:nil];
}

#pragma mark - 停止网络请求
- (void)stopAllWebImageDownload {
    @synchronized(self) {
        self.delegate        = nil;
        self.successCallBack = nil;
        self.failCallBack    = nil;
    }
}

@end
