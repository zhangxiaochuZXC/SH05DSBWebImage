//
//  NSString+path.m
//  12-列表异步加载网络图片
//
//  Created by teacher on 17/4/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

+ (NSString *)appendCachePath:(NSString *)icon {

    // cache文件路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 获取文件名字 : lastPathComponent自动根据`/`截取URL中文件的名字
    // app.icon ==> http://p18.qhimg.com/dr/48_48_/t0184f949337481f071.png
    NSString *name = [icon lastPathComponent];
    // 全路径 = cache文件路径 + 文件名字 (类似于收货地址)
    NSString *filePath = [cachePath stringByAppendingPathComponent:name];
//    NSLog(@"filePath = %@",filePath);
    
    return filePath;

}

// 哪个字符串对象调用这个分类方法,self就是那个字符串对象
- (NSString *)appendCachePath {
    // cache文件路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 获取文件名字 : lastPathComponent自动根据`/`截取URL中文件的名字
    // app.icon ==> http://p18.qhimg.com/dr/48_48_/t0184f949337481f071.png
    NSString *name = [self lastPathComponent];
    // 全路径 = cache文件路径 + 文件名字 (类似于收货地址)
    NSString *filePath = [cachePath stringByAppendingPathComponent:name];
//    NSLog(@"filePath = %@",filePath);
    
    return filePath;
}

@end
