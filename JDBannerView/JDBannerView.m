//
//  JDBannerView.m
//  BannerViewDemo
//
//  Created by Ngmm_Jadon on 2017/5/20.
//  Copyright © 2017年 JADON. All rights reserved.
//

#import "JDBannerView.h"
#import "JDBannerImageView.h"

@interface JDBannerView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) JDBannerImageView *previousImage;// 已经展示过的照片
@property (strong, nonatomic) JDBannerImageView *currentImage;// 当前展示的照片
@property (strong, nonatomic) JDBannerImageView *nextImage; // 将要展示的照片
@property (nonatomic, assign) NSUInteger currentImageIndex;

@property (strong, nonatomic) NSTimer *changeImageTimer; // 定时器

@end

@implementation JDBannerView

- (instancetype)initWithImageArray:(NSArray <NSDictionary *>*)imageArray frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageArray = imageArray;
        [self setUpConfig];
    }
    return self;
}

- (void)setUpConfig {
    _needAutoScroll = YES;
    _duration = 2.0;
    _currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageIndicatorTintColor = [UIColor grayColor];
    _currentImageIndex = 0;
}

- (void)layoutSubviews {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self updateScrollImage];
    if (_needAutoScroll) {
        [self setupTimer];
    }
}

- (void)updateScrollImage {
    int previousIndex;
    int nextIndex;
    
    // 计算页数
    int page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    if (page == 0) {
        // 计算当前图片索引
        self.currentImageIndex = (self.currentImageIndex + self.imageArray.count - 1) % self.imageArray.count;
    } else if(page == 2) {
        // 计算当前图片索引
        self.currentImageIndex = (self.currentImageIndex + 1) % self.imageArray.count;
    }
    
    // 当前图片左右索引
    previousIndex = (int)(self.currentImageIndex + self.imageArray.count - 1) % self.imageArray.count;
    nextIndex = (int)(self.currentImageIndex + 1) % self.imageArray.count;
    
    // 更换UIImage
    self.previousImage.dataDic = self.imageArray[previousIndex];
    
    self.currentImage.dataDic = self.imageArray[self.currentImageIndex];
    __weak typeof(self) weakSelf = self;
    self.currentImage.linkAction = ^(NSString *link) {
        [weakSelf imageClickActionWtihLink:link];
    };
    
    self.nextImage.dataDic = self.imageArray[nextIndex];
    
    self.pageControl.currentPage = self.currentImageIndex;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
}

- (void)imageClickActionWtihLink:(NSString *)link {
    if ([self.delegate respondsToSelector:@selector(bannerView:didselectImageWithLink:)]) {
        [self.delegate bannerView:self didselectImageWithLink:link];
    }
}

- (void)setupTimer {
    self.changeImageTimer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(updateScrollViewContentOffset) userInfo:nil repeats:YES];
    
    // 避免tableview滚动时，定时器停止；
    [[NSRunLoop mainRunLoop] addTimer:self.changeImageTimer forMode:NSRunLoopCommonModes];
}

- (void)updateScrollViewContentOffset {
    CGPoint offset = self.scrollView.contentOffset;
    offset.x += self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - scrollView delagate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateScrollImage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateScrollImage];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_needAutoScroll) {
        [self.changeImageTimer invalidate];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_needAutoScroll) {
        [self setupTimer];
    }
}

#pragma mark - lazyLoad
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.delegate = self;
        
        for (NSInteger i = 0; i < 3; i++) {
            JDBannerImageView *imgV = [[JDBannerImageView alloc] initWithFrame:CGRectMake(i*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
            imgV.placeHolderImg = _placeholderImage;
            [_scrollView addSubview:imgV];
            switch (i) {
                case 0:
                    _previousImage = imgV;
                    break;
                case 1:
                    _currentImage = imgV;
                    break;
                case 2:
                    _nextImage = imgV;
                    break;
                default:
                    break;
            }
        }
        
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.center = CGPointMake(self.frame.size.width * 0.5, 0.92 * self.frame.size.height);
        _pageControl.numberOfPages = _imageArray.count;
        _pageControl.currentPage = _currentImageIndex;
        _pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
        _pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
    }
    return _pageControl;
}

@end
