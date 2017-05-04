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

@interface ViewController ()

/// 全局并发队列
@property (nonatomic, strong) NSOperationQueue *queue;
/// 模型数组
@property (nonatomic, strong) NSArray *appList;
/// 图片控件
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/// 操作缓存池
@property (nonatomic, strong) NSMutableDictionary *opCache;
/// 记录上次图片地址
@property (nonatomic, copy) NSString *lastUrlStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 实例化队列
    self.queue = [NSOperationQueue new];
    /// 实例化操作缓存池
    self.opCache = [[NSMutableDictionary alloc] init];
    
    // 获取用于测试的数据
    [self loadData];
}

// 说明 : 当获取到模型数组后再点击屏幕,测试DownloadOperation这个类是否可以正真的下载图片
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    // 获取随机数
    int random = arc4random_uniform((uint32_t)self.appList.count);
    
    // 获取随机模型和图片地址
    APPModel *app = self.appList[random];
    
    // 在建立下载操作前,判断本次传入的URL和上次的URL是否一样,如果不一样,就需要上次正在执行的下载操作
    if (![app.icon isEqualToString:self.lastUrlStr] && self.lastUrlStr != nil) {
        
        // 单例接管取消操作
        [[DownloadOperationManager sharedManager] cancelOperationWithLastUrlStr:self.lastUrlStr];
        
//        // 获取上次正在执行的操作
//        DownloadOperation *lastOP = [self.opCache objectForKey:self.lastUrlStr];
//        if (lastOP != nil) {
//            // 取消上次正在执行的操作 : 一旦调用的该方法,cancelled属性就是YES,表示该操作是个非正常操作
//            [lastOP cancel];
//            // 已经被取消的操作,需要从操作缓存池移除
//            [self.opCache removeObjectForKey:self.lastUrlStr];
//        }
    }
    
    // 记录图片地址
    self.lastUrlStr = app.icon;
    
    // 单例接管下载操作 : VC把图片地址和下载完成的回调传递到Manager
    [[DownloadOperationManager sharedManager] downloadWithUrlStr:app.icon finished:^(UIImage *image) {
        // 展示图片
        self.iconImageView.image = image;
    }];
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
