//
//  DownloadOperation.h
//  仿SDWebImage
//
//  Created by teacher on 17/4/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadOperation : NSOperation

+ (instancetype)downloadOperationWithUrlStr:(NSString *)urlStr finished:(void(^)(UIImage *image))finishedBlock;

@end
