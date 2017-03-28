//
//  ScorollADView.h
//  ScrollingAdvertising
//
//  Created by zhangwei on 17/3/27.
//  Copyright © 2017年 jyall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScorollADView : UIView
//设置是否横向滚动
- (id)initWithFrame:(CGRect)frame iScrollDirectionVertical:(BOOL)iScrollDirectionVertical;


//横向滚动文案
@property (nonatomic , copy) NSString * titleStr;

//竖向滚动文案
@property (nonatomic , copy) NSArray * titles;


@end
