//
//  ScorollADView.m
//  ScrollingAdvertising
//
//  Created by zhangwei on 17/3/27.
//  Copyright © 2017年 jyall. All rights reserved.
//

#import "ZWScorollADView.h"
#import "ZWCollectionViewCell.h"


static NSString * const JYindentify = @"CollectionViewIdentifier";//collection
//开始X
#define iconStartX 16
//图片的宽度 collection 到2边的宽度
#define kImage_Width (iconStartX + 12 * 2)


@interface ZWScorollADView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , assign) BOOL iScrollDirectionVertical;
@property (nonatomic , assign) CGFloat titleStrWidth;

@property (nonatomic,strong) UIImageView *imageIcon;
@end

@implementation ZWScorollADView


- (id)initWithFrame:(CGRect)frame iScrollDirectionVertical:(BOOL)iScrollDirectionVertical{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.timeInterval = 3;
        _iScrollDirectionVertical = iScrollDirectionVertical;

    }
    return self;
}


- (void)setIconImage:(UIImage *)iconImage{
   
    
    UIImageView *imageIcon = [[UIImageView alloc]initWithImage:iconImage];
    imageIcon.frame = CGRectMake(iconStartX, (self.frame.size.height - iconImage.size.height)/2, iconImage.size.width, iconImage.size.height);
    imageIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageIcon];
    
    UIImage *imageArrow = [UIImage imageNamed:@"home_information_pull"];
    
    UIImageView *imageViewArrow = [[UIImageView alloc]initWithImage:imageArrow];
    imageViewArrow.frame = CGRectMake(self.frame.size.width - iconStartX - imageArrow.size.width, (self.frame.size.height - imageArrow.size.height)/2, imageArrow.size.width, imageArrow.size.height);
    imageViewArrow.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageViewArrow];
    
   
    
 
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(kImage_Width, 0, self.frame.size.width - 2 * kImage_Width, self.frame.size.height);
}

#pragma mark 添加定时器
-(void)addTimer{
    NSTimeInterval times = _iScrollDirectionVertical ? self.timeInterval : 0.02;
     self.timer = [NSTimer scheduledTimerWithTimeInterval:times target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer  forMode:NSRunLoopCommonModes];

    
}
#pragma mark 删除定时器
-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleStrWidth = [titleStr boundingRectWithSize:CGSizeMake(10000, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14.]} context:nil].size.width+20;
    
     [self removeTimer];
    if (_titleStrWidth > self.collectionView.frame.size.width)
    {
       [self addTimer];
    }

    
    [self.collectionView reloadData];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_iScrollDirectionVertical) {
        return  CGSizeMake(self.frame.size.width - 2 * kImage_Width, self.frame.size.height);
    }
    
    return CGSizeMake(_titleStrWidth,self.frame.size.height);
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self removeTimer];
    if (titles.count > 1) {
        [self addTimer];
    }
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
    
}

- (void)nextpage{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI更新代码
        if (_iScrollDirectionVertical) {
            CGFloat currentOffsetY = self.collectionView.contentOffset.y;
            
            CGFloat offsetY = currentOffsetY + self.collectionView.frame.size.height;
            
            [self.collectionView setContentOffset:CGPointMake(0, offsetY) animated:YES];
            
        }else{
            
            CGFloat x= self.collectionView.contentOffset.x;
            if (x < self.collectionView.contentSize.width - self.collectionView.frame.size.width)
            {
                self.collectionView.contentOffset = CGPointMake(x+1, 0);
                
            }
            else
            {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
                self.collectionView.contentOffset = CGPointMake(0 , 0);
            }
            
            
        }
        
    });
  

}



- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = _iScrollDirectionVertical?UICollectionViewScrollDirectionVertical:UICollectionViewScrollDirectionHorizontal;
       
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing= 0;
        self.flowLayout = flowLayout;
        //这里强转为Int类型  防止取到的cell 个数正确
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.scrollEnabled = NO;
        collectionView.pagingEnabled = _iScrollDirectionVertical;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:collectionView];
        self.collectionView=collectionView;
        [self.collectionView registerClass:[ZWCollectionViewCell class] forCellWithReuseIdentifier:JYindentify];

    }
    return _collectionView;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_iScrollDirectionVertical) {
        return 10000 *self.titles.count;
    }
    return 5;
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JYindentify forIndexPath:indexPath];
    if (_iScrollDirectionVertical) {
        cell.titleLabel.text = self.titles[(indexPath.row % self.titles.count)];
    }else{
        cell.titleLabel.text = self.titleStr;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_iScrollDirectionVertical) {
        if (self.clickWithBlock) {
            self.clickWithBlock((indexPath.row % self.titles.count));
        }
    }
    
}




@end
