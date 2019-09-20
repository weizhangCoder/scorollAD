//
//  ViewController.m
//  scorollAD
//
//  Created by zhangwei on 17/3/28.
//  Copyright © 2017年 jyall. All rights reserved.
//

#import "ViewController.h"
#import "ZWScorollADView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //横向滚动
    ZWScorollADView *view_1 = [[ZWScorollADView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 30) iScrollDirectionVertical:NO];
    view_1.titleStr = @"将文件推送到GitHub的方式有多种，不在本篇讨论范围内。最简单的做法，使用GitHub客户端，将项目文件拖入，点击Publish即可。";
    [self.view addSubview:view_1];
    
    
    //横向滚动
    ZWScorollADView *view_2 = [[ZWScorollADView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 30) iScrollDirectionVertical:YES];
    view_2.titles = @[@"表示已经提交到CocoaPods，其他开发者可以直接使用",@"将文件推送到GitHub的方式有多种",@"可以使用pod search LibraryName来查询是否已提交到CocoaPods."];
    [self.view addSubview:view_2];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
