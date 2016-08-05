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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imgView];
        _imgView = imgView;
        [self addTarget:self action:@selector(bannerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    NSString *imgURL = _dic[@"img"];
    if ([imgURL hasPrefix:@"http"]) {//网络图片
        [_imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:self.img options:SDWebImageRetryFailed];
    } else {
        _imgView.image = [UIImage imageNamed:imgURL];
    }
}

- (void)bannerAction {
    if (!_dic || !_dic[@"link"]) {
        return;
    }
    if (_linkAction) {
        NSString *link = _dic[@"link"];
        self.linkAction(link); 
    }
    
}

@end
