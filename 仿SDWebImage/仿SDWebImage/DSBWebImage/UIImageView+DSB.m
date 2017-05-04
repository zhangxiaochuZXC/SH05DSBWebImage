//
//  UIImageView+DSB.m
//  仿SDWebImage
//
//  Created by teacher on 17/5/4.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "UIImageView+DSB.h"
#import <objc/runtime.h>

@implementation UIImageView (DSB)

// 运行时的动态属性关联 : 实现分类属性存值

- (void)setLastUrlStr:(NSString *)lastUrlStr {
    
    /*
     1.要关联的对象 : self
     2.要关联的key 
     3.要关联的value (分类的属性)
     4.要关联的value的存储策略
     */
    objc_setAssociatedObject(self, "key", lastUrlStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastUrlStr {
    return objc_getAssociatedObject(self, "key");
}

- (void)DSB_setImageWithURLString:(NSString *)URLString {

    // 在建立下载操作前,判断本次传入的URL和上次的URL是否一样,如果不一样,就需要上次正在执行的下载操作
    if (![URLString isEqualToString:self.lastUrlStr] && self.lastUrlStr != nil) {
        // 单例接管取消操作
        [[DownloadOperationManager sharedManager] cancelOperationWithLastUrlStr:self.lastUrlStr];
    }
    
    // 记录图片地址
    self.lastUrlStr = URLString;
    
    // 单例接管下载操作 : VC把图片地址和下载完成的回调传递到Manager
    [[DownloadOperationManager sharedManager] downloadWithUrlStr:URLString finished:^(UIImage *image) {
        // 展示图片
        self.image = image;
    }];
}

@end
