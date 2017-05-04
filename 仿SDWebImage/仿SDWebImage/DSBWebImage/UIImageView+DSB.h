//
//  UIImageView+DSB.h
//  仿SDWebImage
//
//  Created by teacher on 17/5/4.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadOperationManager.h"

@interface UIImageView (DSB)

/*
 提问
 1.分类可以拓展方法吗?可以
 2.如果分类方法和系统方法一样,先调用谁的方法?分类的
 3.如果一个类定义多个分类,分类方法都是一样的,会调用哪个分类的哪个方法?最后一个编译的分类的分类方法
 4.分类可以拓展属性吗?可以的(但是属性无法存值,一般不建议拓展属性)
 5.分类可以拓展成员变量吗?不可以(通过运行时查看内部实现,发现分类的结构体没有成员变量链表)
 6.为什么分类的属性无法存值?因为属性的值都是存储在成员变量里面的,分类连成员变量都木有,就无法使用属性存值
 7.分类的属性有setter和getter方法吗?有,但是系统不会自动实现
 */

@property (nonatomic, copy) NSString *lastUrlStr;

/// 分类方法 : 实现下载,缓存...
- (void)DSB_setImageWithURLString:(NSString *)URLString;

@end
