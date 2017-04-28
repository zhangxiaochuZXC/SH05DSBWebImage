//
//  APPModel.h
//  12-列表异步加载网络图片
//
//  Created by teacher on 17/4/27.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPModel : NSObject

/// app名字
@property (nonatomic, copy) NSString *name;
/// app下载量
@property (nonatomic, copy) NSString *download;
/// app图标
@property (nonatomic, copy) NSString *icon;

@end

/*
{
    "name" : "植物大战僵尸",
    "download" : "10311万",
    "icon" : "http:\/\/p16.qhimg.com\/dr\/48_48_\/t0125e8d438ae9d2fbb.png"
}
*/
