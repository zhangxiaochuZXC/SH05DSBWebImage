//
//  DownloadOperation.h
//  仿SDWebImage
//
//  Created by teacher on 17/4/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+path.h"

@interface DownloadOperation : NSOperation

/**
 创建操作对象同时传入图片地址和下载完成回调

 @param urlStr 图片地址
 @param finishedBlock 下载完成回调
 @return 操作对象
 */
+ (instancetype)downloadOperationWithUrlStr:(NSString *)urlStr finished:(void(^)(UIImage *image))finishedBlock;

@end
