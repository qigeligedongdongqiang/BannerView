//
//  ViewController.m
//  JDAdView
//
//  Created by JADON on 16/7/23.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "ViewController.h"
#import "JDBannerView.h"

@interface ViewController ()<JDBannerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    NSArray *imageArray = @[
                              @{@"img" : @"pic1.jpg",
                                  @"link" : @"pic1"},
                              @{@"img" : @"pic2.jpg",
                                @"link" : @"pic2"},
                              @{@"img" : @"pic3.jpg",
                                @"link" : @"pic3.jpg"},
                              @{@"img" : @"pic4.jpg",
                                @"link" : @"pic4"},
                            ];
    JDBannerView *bannerView = [[JDBannerView alloc] initWithImageArray:imageArray frame:CGRectMake(0, 200, self.view.bounds.size.width, 200)];
    bannerView.delegate = self;
    [self.view addSubview:bannerView];
}

- (void)bannerView:(JDBannerView *)bannerView didselectImageWithLink:(NSString *)link {
    NSLog(@"点击了%@",link);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
