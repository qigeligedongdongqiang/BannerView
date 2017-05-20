//
//  JDBannerView.h
//  BannerViewDemo
//
//  Created by Ngmm_Jadon on 2017/5/20.
//  Copyright © 2017年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDBannerView;

@protocol JDBannerViewDelegate <NSObject>

@optional
- (void)bannerView:(JDBannerView *)bannerView didselectImageWithLink:(NSString *)link;

@end

@interface JDBannerView : UIView

/**
 *是否自动滚动，默认yes
 */
@property (nonatomic, assign) BOOL needAutoScroll;

/**
 *图片切换时间，默认2s
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *存图片信息的数组
 */
@property (strong, nonatomic) NSArray<NSDictionary *> *imageArray;

/**
 *占位图，本地图片可以不设置，网络图片建议设置
 */
@property (nonatomic, strong) UIImage *placeholderImage;

/**
 *页面指示器选中颜色，默认白色
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

/**
 *页面指示器未选中颜色，默认灰色
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

@property (nonatomic, weak) id<JDBannerViewDelegate> delegate;

- (instancetype)initWithImageArray:(NSArray <NSDictionary *>*)imageArray frame:(CGRect)frame;

@end
