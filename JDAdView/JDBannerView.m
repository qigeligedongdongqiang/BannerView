//
//  JDBannerView.m
//  JDAdView
//
//  Created by JADON on 16/7/26.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDBannerView.h"
#import "JDBannerImageView.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@interface JDBannerView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) CGFloat lastContentX;
/**
 *  存放用于展示广告页的View
 */
@property (copy , nonatomic) NSMutableArray *bannerImageViews;

//banner数量
@property (assign , nonatomic) NSInteger datasCount;
//当前显示的页码
@property (assign , nonatomic) NSInteger currentPage;

- (void) startAnimation;
- (void) stopAnimation;


@end


@implementation JDBannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _pageIndicatorTintColor = [UIColor grayColor];
        _currentPageIndicatorTintColor = [UIColor whiteColor];
        _intervalTime = 2.0f;
        _isNeedAutoScroll = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame placeholderImg:(UIImage *)placeholderImg {
    JDBannerView *bannerView = [self initWithFrame:frame];
    bannerView.placeholderImg = placeholderImg;
    return bannerView;
}

- (NSMutableArray *)bannerImageViews {
    if (_bannerImageViews == nil) {
        _bannerImageViews = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            CGRect frame = CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT);
            JDBannerImageView *bannerImageView = [[JDBannerImageView alloc] initWithFrame:frame];
            bannerImageView.linkAction = ^(NSString *link){
                [self bannerAction:link];
            };
            [_bannerImageViews addObject:bannerImageView];
        }
    }
    return _bannerImageViews;
}

- (void)bannerAction:(NSString *)link {
    
}

- (NSInteger)currentPage {
    return self.pageControl.currentPage;
}

- (void)setDatas:(NSMutableArray *)datas {
    _datas = datas;
    _datasCount = datas.count;
    if (_datasCount <= 0) return;
    if (_datasCount == 1) {
        JDBannerImageView *bannerImageView = [[JDBannerImageView alloc] initWithFrame:self.bounds];
        bannerImageView.linkAction = ^(NSString *link){
            [self bannerAction:link];
        };
        bannerImageView.dic = datas[0];
        [self addSubview:bannerImageView];
        return;
    }
}

- (void)setScrollView {
    self.lastContentX = WIDTH;
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollview.delegate = self;
    scrollview.pagingEnabled = YES;
    scrollview.bounces = YES;
    scrollview.showsHorizontalScrollIndicator = NO;
    CGSize size = CGSizeMake(WIDTH * 3, HEIGHT);
    scrollview.contentSize = size;
    for (int i = 0; i < self.bannerImageViews.count; i++) {
        JDBannerImageView *imageV = self.bannerImageViews[i];
        imageV.dic = _datas[i%_datas.count];
        [scrollview addSubview:imageV];
    }
    
    [scrollview setContentOffset:CGPointMake(WIDTH, 0)];
    
    [self addSubview:scrollview];
    self.scrollView = scrollview;
}











@end
