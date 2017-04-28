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

/// 用于接收外界传入的图片URL
@property (nonatomic, copy) NSString *urlStr;
/// 用于接收外界传入的代码块Block
@property (nonatomic, copy) void(^finishedBlock)(UIImage *image);

@end
