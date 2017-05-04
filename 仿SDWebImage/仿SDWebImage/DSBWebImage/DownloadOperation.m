//
//  DownloadOperation.m
//  仿SDWebImage
//
//  Created by teacher on 17/4/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "DownloadOperation.h"

/*
 作用 : 下载图片
 1.需要外界传入图片地址URL
 2.需要外界传入下载完成的Block(回调)
 */

@interface DownloadOperation ()

/// 用于记录外界传入的图片URL
@property (nonatomic, copy) NSString *urlStr;
/// 用于记录外界传入的代码块Block
@property (nonatomic, copy) void(^finishedBlock)(UIImage *image);

@end

@implementation DownloadOperation

/// OP接收Manager传入的图片地址和Manager的下载完成的回调
+ (instancetype)downloadOperationWithUrlStr:(NSString *)urlStr finished:(void (^)(UIImage *))finishedBlock {
    
    DownloadOperation *op = [DownloadOperation new];
    
    // 保存外界传入的图片地址和下载完成的回调
    op.urlStr = urlStr;
    op.finishedBlock = finishedBlock;
    
    return op;
}

/// 重写操作的入口方法,可以在这个方法里面指定自定义的操作执行的代码;该方法默认就是在子线程执行的
- (void)main {
    NSLog(@"传入 %@",self.urlStr);
    
    // 模拟网络延迟 : 没有实际意义
    [NSThread sleepForTimeInterval:1.0];
    
    // 下载图片
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    // 需要在操作执行的过程中,判断该操作是否是被取消的 : 可以在多个位置写,但是一定要在耗时操作的后面有个判断;不要在回调后面写,已经晚了
    if (self.cancelled == YES) {
        NSLog(@"取消 %@",self.urlStr);
        return;
    }
    
    // 图片下载结束后回调Manager传入的finishedBlock,把图片传递到Manager
    if (self.finishedBlock != nil) {
        // 回到主线程回调代码块
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"完成 %@",self.urlStr);
            self.finishedBlock(image);
        }];
    }
}

/*
 请求代理方法 / Block回调 / 通知方法 执行的线程?
 答案 : 在哪个线程发送代理消息 / 回调Block / 发送通知 就在哪个线程执行
 */

@end
