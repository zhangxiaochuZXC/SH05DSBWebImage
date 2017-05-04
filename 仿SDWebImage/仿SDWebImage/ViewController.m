//
//  ViewController.m
//  仿SDWebImage
//
//  Created by teacher on 17/4/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "APPModel.h"
#import "DownloadOperationManager.h"
#import "UIImageView+DSB.h"

@interface ViewController ()

/// 模型数组
@property (nonatomic, strong) NSArray *appList;
/// 图片控件
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取用于测试的数据
    [self loadData];
}

// 说明 : 当获取到模型数组后再点击屏幕,测试DownloadOperation这个类是否可以正真的下载图片
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    // 获取随机数
    int random = arc4random_uniform((uint32_t)self.appList.count);
    
    // 获取随机模型和图片地址
    APPModel *app = self.appList[random];
    
    // UIImageView分类接管图片下载和缓存...
    [self.iconImageView DSB_setImageWithURLString:app.icon];
}

/// 获取数据的主方法 : 用于测试的数据,需要提前获取到
- (void)loadData {
    
    NSString *urlStr = @"https://raw.githubusercontent.com/zhangxiaochuZXC/SHHM05/master/apps.json";
    
    // AFN默认在子线程发送网络请求,默认在主线程回调代码块
    [[AFHTTPSessionManager manager] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 把字典数组转模型数组
        self.appList =  [NSArray yy_modelArrayWithClass:[APPModel class] json:responseObject];
        NSLog(@"appList %@",self.appList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误信息 = %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
