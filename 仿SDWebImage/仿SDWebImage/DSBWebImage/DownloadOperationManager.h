//
//  DownloadOperationManager.h
//  仿SDWebImage
//
//  Created by teacher on 17/5/4.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DownloadOperation.h"

@interface DownloadOperationManager : NSObject

+ (instancetype)sharedManager;

/**
 单例下载图片主方法

 @param urlStr 图片地址
 @param finishedBlock 下载完成回调
 */
- (void)downloadWithUrlStr:(NSString *)urlStr finished:(void(^)(UIImage *image))finishedBlock;

/**
 取消操作的主方法

 @param lastUrlStr 上次下载的图片地址
 */
- (void)cancelOperationWithLastUrlStr:(NSString *)lastUrlStr;

@end
