//
//  JDBannerView.h
//  JDAdView
//
//  Created by JADON on 16/7/26.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JDBannerViewDataSource <NSObject>
@optional
- (UIPageControl *)pageControlOfJDBannerView;

@end

@interface JDBannerView : UIView
/**
 *  datas:字典数组，key:img,value:本地图片名或网络图片地址
 */
@property (copy , nonatomic) NSMutableArray *datas;
/**
 *  点击图片回调事件
 */
@property (copy , nonatomic) void(^linkAction)(NSString *link);

//未显示页颜色，默认灰色
@property (copy , nonatomic) UIColor *pageIndicatorTintColor;
//当前显示页的颜色，默认白色
@property (copy , nonatomic) UIColor *currentPageIndicatorTintColor;

@property (copy , nonatomic) UIImage *placeholderImg;
@property (weak , nonatomic) id<JDBannerViewDataSource> dataSouce;
//图片滚动间隔,默认为2.0秒
@property (assign , nonatomic) CGFloat intervalTime;
//是否需要自动滚动,默认为YES
@property (assign , nonatomic) BOOL isNeedAutoScroll;

- (instancetype) initWithFrame:(CGRect)frame placeholderImg:(UIImage *) placeholderImg;

@end
