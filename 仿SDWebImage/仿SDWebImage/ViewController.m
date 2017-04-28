//
//  ViewController.m
//  仿SDWebImage
//
//  Created by teacher on 17/4/28.
//  Copyright © 2017年 teacher. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"

@interface ViewController ()

/// 全局并发队列
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 实例化队列
    self.queue = [NSOperationQueue new];
    
    // 图片地址
    NSString *urlStr = @"http://paper.taizhou.com.cn/tzwb/res/1/2/2015-01/20/12/res03_attpic_brief.jpg";

    DownloadOperation *op = [DownloadOperation downloadOperationWithUrlStr:urlStr finished:^(UIImage *image) {
        NSLog(@"%@ %@",image,[NSThread currentThread]);
    }];
    
    // 把自动的操作添加到队列
    [self.queue addOperation:op];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
