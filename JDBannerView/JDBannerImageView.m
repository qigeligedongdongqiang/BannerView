//
//  JDBannerImageView.m
//  JDAdView
//
//  Created by JADON on 16/7/23.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDBannerImageView.h"
#import "UIImageView+WebCache.h"

@interface JDBannerImageView()

@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation JDBannerImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
        _imgView = imgView;
        [self addTarget:self action:@selector(bannerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    NSString *imgURL = _dataDic[@"img"];
    if ([imgURL hasPrefix:@"http"]) {//网络图片
        [_imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:self.placeHolderImg options:SDWebImageRetryFailed];
    } else {
        _imgView.image = [UIImage imageNamed:imgURL];
    }
}

- (void)bannerAction {
    if (!_dataDic || !_dataDic[@"link"]) {
        return;
    }
    if (_linkAction) {
        NSString *link = _dataDic[@"link"];
        self.linkAction(link); 
    }
}

@end
