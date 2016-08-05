//
//  JDBannerImageView.h
//  JDAdView
//
//  Created by JADON on 16/7/23.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDBannerImageView : UIControl
@property (nonatomic, copy) NSDictionary *dic;
@property (nonatomic, copy) void(^linkAction)(NSString *link);
@property (nonatomic, copy) UIImage *img;

@end
