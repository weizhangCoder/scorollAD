# scorollAD
一个简单的广告轮播

    //横向滚动
    ScorollADView *view_1 = [[ScorollADView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 30) iScrollDirectionVertical:NO];
    view_1.titleStr = @"将文件推送到GitHub的方式有多种，不在本篇讨论范围内。最简单的做法，使用GitHub客户端，将项目文件拖入，点击Publish即可。";
    [self.view addSubview:view_1];
    
    
    //横向滚动
    ScorollADView *view_2 = [[ScorollADView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 30) iScrollDirectionVertical:YES];
    view_2.titles = @[@"表示已经提交到CocoaPods，其他开发者可以直接使用",@"将文件推送到GitHub的方式有多种",@"可以使用pod search LibraryName来查询是否已提交到CocoaPods."];
    [self.view addSubview:view_2];





![image](https://github.com/weizhangCoder/scorollAD/blob/master/gif/scorollAD.gif)
