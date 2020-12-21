//
//  XCPageView.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/17.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "XCPageView.h"

static const int ImageViewCount = 3;

@interface XCPageView ()<UIScrollViewDelegate>


@property (nonatomic, strong)  UIScrollView *scrollView;

@property (nonatomic, strong)  UIPageControl *pageControl;

@property (assign, nonatomic) CGRect tempRect;

@end

@implementation XCPageView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        [self initView:frame];
        
        //添加点击监听
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
        [gesture addTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:gesture];
        
    }
    return self;
}


- (void)initView:(CGRect)frame{

    self.tempRect = frame;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.backgroundColor = UIColor.whiteColor;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = YES;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.pagingEnabled = YES;//设置分页属性
    if (@available(iOS 13.0, *)) {
        
    } else {
        // Fallback on earlier versions
       
    }
    [self addSubview:self.scrollView];
    
    [self addSubview:self.pageControl];
    
    self.pageControl.frame = CGRectMake(frame.size.width - 180, frame.size.height - 38, 160, 28);
    
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPage = 0;
    [self startTimer];

}

/**
 *  处理点击事件
 */
- (void)tap:(UITapGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(pageViewDidClick:atCurrentPage:)]) {
        [self.delegate pageViewDidClick:self atCurrentPage:self.pageControl.currentPage];
    };
}

- (void)setImagesName:(NSArray *)imagesName{
    _imagesName = imagesName;
        
    if (!imagesName.count) {
        return;
    } else if (imagesName.count == 1) {
        self.scrollView.scrollEnabled = NO;
        self.pageControl.numberOfPages = 1;
    }
    
    // 判断原来是不是有值，如果有值，就把scrollView里面的元素全部删除
    if (self.scrollView.subviews.count) {
        [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    for (int i = 0; i < ImageViewCount; i++) {
        
        NSInteger index = i;
        if (i == 0) {
            // 默认显示3个ImageView的中间那个，而最左边的则要加载数组中最后一个图片
            index = imagesName.count - 1;
        }
        if (index >= imagesName.count) {
            index = 0;
        }
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imagesName[index]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;//使图片充满整个UIImageView控件
        // 给tag加值，用于在后面取出判断pageControl的当前页
        imageView.tag = i;
        
        [self.scrollView addSubview:imageView];
        
    }
    
    self.pageControl.numberOfPages = imagesName.count;
    
}

- (void)setCurrentIndicatorColor:(UIColor *)currentIndicatorColor {
    self.pageControl.currentPageIndicatorTintColor = currentIndicatorColor;
}

- (void)setPageIndicatorColor:(UIColor *)pageIndicatorColor {
    self.pageControl.pageIndicatorTintColor = pageIndicatorColor;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(self.tempRect.size.width * ImageViewCount, 0);
    
    if (self.imagesName.count) {
        // 设置UIImageView的frame
        for (int i = 0; i < ImageViewCount; i++) {
            UIImageView *imageView = self.scrollView.subviews[i];
            CGFloat imageW = self.frame.size.width;
            imageView.frame = CGRectMake(i * imageW, 0, imageW, self.frame.size.height);
        }
        
        [self updateContent];
    }

}

- (void)setTimerInterval:(NSTimeInterval)timerInterval {
    _timerInterval = timerInterval;
    if (!self.imagesName.count) {
        return;
    }
    if (timerInterval < 0) {
        _timerInterval = 3.0;
    }
    if (_timerInterval) {
        [self startTimer];
    }
}

/**
 *  更新内容，滚动结束时会调用此方法
 *  滚动结束时会把三个UIImageView的图片全部换掉，显示Array中后面的三张图片。并且设置scrollView的contentOffSet。
 *  在设置contentOffSet之前，当前ScrollView其实显示的是后一个UIImageView，但设置了之后ScrollView会瞬间把中间的那个UIImageView切换到中间来。
 */
- (void)updateContent {
    for (int i = 0; i < ImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        } else if (index >= self.pageControl.numberOfPages) {
            index = 0;
        }
        imageView.image = [UIImage imageNamed:self.imagesName[index]];
        imageView.tag = index;
    }
    
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
}

#pragma - mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = 0;

    NSLog(@"--------- %f",scrollView.contentOffset.y);
    // 找出应该在中间的那个UIImageView是第几个，然后设置pageControl的当前页
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = ABS(self.scrollView.contentOffset.x - imageView.frame.origin.x);
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;

        }
    }

    self.pageControl.currentPage = page;
}

/**
 *  当手动翻页的时候，停止定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

/**
 *  当松开手指调用，开启定时器，继续自动滚动
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.timerInterval) {
        [self startTimer];
    }
}

/**
 *  当手指松开时，scrollView会滚到分割好的页上，有一个减速的过程，当减速结束时会调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateContent];
}

/**
 *  定时器自动滚动结束时会调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateContent];
}

#pragma - mark 定时器相关

/**
 *  开启定时器，实现自动翻页
 */
- (void)startTimer {
    NSTimeInterval timerInterval = self.timerInterval;
    if (!timerInterval) {
        timerInterval = 3.0;
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(next) userInfo:nil repeats:YES];
    // 把当前的Timer加入到主线程去
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stopTimer {
    [self.timer invalidate];
}

/**
 *  显示下一张图片，使用setContentOffset:animated:，在ScrollView结束动画时会调用scrollViewDidEndScrollingAnimation:
 */
- (void)next {
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:YES];
}



- (void)clickPageController:(UIPageControl *)pageController event:(UIEvent *)touchs{
    
    UITouch *touch = [[touchs allTouches] anyObject];
    CGPoint p = [touch locationInView:self.pageControl];
    CGFloat centerX = pageController.center.x;
    CGFloat left = centerX-15.0 * self.imagesName.count / 2;
    [self.pageControl setCurrentPage:(int) (p.x - left) / 15];
    [self.scrollView setContentOffset:CGPointMake(_pageControl.currentPage * MainScreen_Width, 0)];

    NSLog(@"%f",(p.x-left)/15);
}





//- (UIScrollView *)scrollView{
//    if (!_scrollView) {
//        _scrollView = [[UIScrollView alloc]init];
//        _scrollView.scrollEnabled = YES;
//        _scrollView.backgroundColor = UIColor.whiteColor;
//        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.showsHorizontalScrollIndicator = NO;
//    }
//    return _scrollView;
//}



- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
//        [_pageControl addTarget:self action:@selector(clickPageController:event:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
