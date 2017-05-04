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
/// 图片缓存池
@property (nonatomic, strong) NSMutableDictionary *imageCache;

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
        /// 实例化图片缓存池
        self.imageCache = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

/// 单例实现下载操作 : Manager把图片地址和自己定义的下载完成的回调传递给OP
- (void)downloadWithUrlStr:(NSString *)urlStr finished:(void (^)(UIImage *))finishedBlock {
    
    // 判断是否有缓存
    if ([self checkCache:urlStr] == YES) {
        // 把图片从内存中取出来,直接回调VC
        if (finishedBlock != nil) {
            finishedBlock([self.imageCache objectForKey:urlStr]);
        }
        return;
    }
    
    // 在建立下载操作前判断,要下载的图片对应的下载操作是否存在,如果存在就不再建立对应的下载操作,避免重复建立下载操作
    if ([self.opCache objectForKey:urlStr] != nil) {
        return;
    }
    
    // 使用随机地址下载图片
    DownloadOperation *op = [DownloadOperation downloadOperationWithUrlStr:urlStr finished:^(UIImage *image) {
        // 调用VC传入的下载完成的回调 : Manager回调图片到VC
        if (finishedBlock != nil) {
            finishedBlock(image);
        }
        
        // 实现内存缓存
        if (image != nil) {
            [self.imageCache setObject:image forKey:urlStr];
        }
        
        // 操作对应的图片下载结束后,也是需要移除
        [self.opCache removeObjectForKey:urlStr];
    }];
    
    // 把下载操作添加到操作缓存池
    [self.opCache setObject:op forKey:urlStr];
    
    // 把自定义的操作添加到队列
    [self.queue addOperation:op];
}

/// 判断是否有缓存的主方法
- (BOOL)checkCache:(NSString *)urlStr {
    
    // 判断是否有内存缓存
    if ([self.imageCache objectForKey:urlStr]) {
        NSLog(@"从内存中加载...");
        return YES;
    }
    
    // 判断是否有沙盒缓存
    UIImage *cacheImg = [UIImage imageWithContentsOfFile:[urlStr appendCachePath]];
    if (cacheImg != nil) {
        NSLog(@"从沙盒中加载...");
        // 还需要再内存中再缓存一次
        [self.imageCache setObject:cacheImg forKey:urlStr];
        return YES;
    }
    
    return NO;
}

- (void)cancelOperationWithLastUrlStr:(NSString *)lastUrlStr {

    // 获取上次正在执行的操作
    DownloadOperation *lastOP = [self.opCache objectForKey:lastUrlStr];
    if (lastOP != nil) {
        // 取消上次正在执行的操作 : 一旦调用的该方法,cancelled属性就是YES,表示该操作是个非正常操作
        [lastOP cancel];
        // 已经被取消的操作,需要从操作缓存池移除
        [self.opCache removeObjectForKey:lastUrlStr];
    }
}

@end
