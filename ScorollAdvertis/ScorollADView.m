//
//  ScorollADView.m
//  ScrollingAdvertising
//
//  Created by zhangwei on 17/3/27.
//  Copyright © 2017年 jyall. All rights reserved.
//

#import "ScorollADView.h"

#import "CollectionViewCell.h"

static NSString * const JYindentify = @"CollectionViewIdentifier";//collection
//屏幕高度
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
//图片的宽度
#define kImage_Width 60

//屏幕宽度
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

@interface ScorollADView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong)  UICollectionViewFlowLayout *flowLayout;
@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , assign) BOOL iScrollDirectionVertical;
@property (nonatomic , assign) CGFloat titleStrWidth;
@end

@implementation ScorollADView


- (id)initWithFrame:(CGRect)frame iScrollDirectionVertical:(BOOL)iScrollDirectionVertical{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        _iScrollDirectionVertical = iScrollDirectionVertical;
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIImageView *imageIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tuanN"]];
    imageIcon.frame = CGRectMake(0, 0, kImage_Width, self.frame.size.height);
    imageIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageIcon];
    
    [self addTimer];
    
    
}

#pragma mark 添加定时器
-(void) addTimer{
    NSTimeInterval times = _iScrollDirectionVertical?3:0.02;
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
    
    if (_titleStrWidth < self.collectionView.frame.size.width)
    {
        [self.timer invalidate];
         self.timer = nil;
    }

    
    [self.collectionView reloadData];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_iScrollDirectionVertical) {
        return  CGSizeMake(kScreen_Width - kImage_Width, self.frame.size.height);
    }
    
    return CGSizeMake(_titleStrWidth,self.frame.size.height);
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self.collectionView reloadData];
    
}

- (void)nextpage{
    
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

}



- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = _iScrollDirectionVertical?UICollectionViewScrollDirectionVertical:UICollectionViewScrollDirectionHorizontal;
       
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing= 0;
        self.flowLayout = flowLayout;
        //这里强转为Int类型  防止取到的cell 个数正确
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kImage_Width, 0, kScreen_Width - kImage_Width, self.frame.size.height) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.scrollEnabled = NO;
        collectionView.pagingEnabled = _iScrollDirectionVertical;
        collectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:collectionView];
        self.collectionView=collectionView;
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:JYindentify];
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
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JYindentify forIndexPath:indexPath];
    if (_iScrollDirectionVertical) {
        cell.titleLable.text = self.titles[(indexPath.row % self.titles.count)];
    }else{
        cell.titleLable.text = self.titleStr;
    }
    return cell;
}




@end
