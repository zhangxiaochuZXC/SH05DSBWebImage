//
//  DownloadOperation.m
//  仿SDWebImage
//
//  Created by teacher on 17/4/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "DownloadOperation.h"

@implementation DownloadOperation

/// 重写操作的入口方法,可以在这个方法里面指定自定义的操作执行的代码;该方法默认就是在子线程执行的
- (void)main {
    NSLog(@"%s %@",__func__,[NSThread currentThread]);
}

@end
