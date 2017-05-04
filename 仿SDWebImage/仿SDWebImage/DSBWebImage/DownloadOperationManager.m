//
//  DownloadOperationManager.m
//  仿SDWebImage
//
//  Created by teacher on 17/5/4.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "DownloadOperationManager.h"

@interface DownloadOperationManager ()

/// 全局队列
@property (nonatomic, strong) NSOperationQueue *queue;
/// 操作缓存池
@property (nonatomic, strong) NSMutableDictionary *opCache;

@end

@implementation DownloadOperationManager

+ (instancetype)sharedManager {
    
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    
    return instance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        // 实例化全局队列
        self.queue = [NSOperationQueue new];
        // 实例化操作缓存池
        self.opCache = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

/// 单例实现下载操作 : Manager把图片地址和自己定义的下载完成的回调传递给OP
- (void)downloadWithUrlStr:(NSString *)urlStr finished:(void (^)(UIImage *))finishedBlock {
    
    // 使用随机地址下载图片
    DownloadOperation *op = [DownloadOperation downloadOperationWithUrlStr:urlStr finished:^(UIImage *image) {
        // 调用VC传入的下载完成的回调 : Manager回调图片到VC
        if (finishedBlock != nil) {
            finishedBlock(image);
        }
        
        // 操作对应的图片下载结束后,也是需要移除
        [self.opCache removeObjectForKey:urlStr];
    }];
    
    // 把下载操作添加到操作缓存池
    [self.opCache setObject:op forKey:urlStr];
    
    // 把自定义的操作添加到队列
    [self.queue addOperation:op];
}

@end
