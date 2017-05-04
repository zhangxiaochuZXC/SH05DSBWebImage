//
//  NSString+path.h
//  12-列表异步加载网络图片
//
//  Created by teacher on 17/4/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (path)

/// 类方法
+ (NSString *)appendCachePath:(NSString *)icon;

/// 对象方法
- (NSString *)appendCachePath;

@end
