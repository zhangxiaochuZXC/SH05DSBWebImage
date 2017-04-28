//
//  APPModel.m
//  12-列表异步加载网络图片
//
//  Created by teacher on 17/4/27.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "APPModel.h"

@implementation APPModel

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ %@",self.name,self.download,self.icon];
}

@end
