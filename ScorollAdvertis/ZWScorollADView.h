//
//  ScorollADView.h
//  ScrollingAdvertising
//
//  Created by zhangwei on 17/3/27.
//  Copyright © 2017年 jyall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWScorollADView : UIView
//设置是否横向滚动 iScrollDirectionVertical = YES 的时候竖向滚动
- (id)initWithFrame:(CGRect)frame iScrollDirectionVertical:(BOOL)iScrollDirectionVertical;

@property (nonatomic,strong) UIImage *iconImage;
//横向滚动文案
@property (nonatomic , copy) NSString * titleStr;
//滚动时间
@property (nonatomic,assign) NSInteger timeInterval;
//竖向滚动文案
@property (nonatomic , copy) NSArray * titles;

@property (nonatomic,copy)   void(^clickWithBlock)(NSInteger rowIndex);


@end
