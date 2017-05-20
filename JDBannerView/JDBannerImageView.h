//
//  JDBannerImageView.h
//  JDAdView
//
//  Created by JADON on 16/7/23.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDBannerImageView : UIControl

/**
 *数组，key1:img,value1:本地图片名或网络图片地址；
 *key2:link,value2:图片外部链接（可以不设置）；
 */
@property (nonatomic, copy) NSDictionary *dataDic;
@property (nonatomic, copy) void(^linkAction)(NSString *link);
@property (nonatomic, copy) UIImage *placeHolderImg;

@end
