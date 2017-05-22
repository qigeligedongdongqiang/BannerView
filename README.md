JDBannerView is a commonly used for loading both webImage and localImage.

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like WaterFlowCollectionViewLayout in your projects.

To integrate WaterFlowCollectionViewLayout into your Xcode project using CocoaPods, specify it in your `Podfile`:

```objective-c
target 'TargetName' do
pod 'JDBannerView', '~> 0.0.1'
end
```

## How to use

You can use it like this:

```objective-c
NSArray *imageArray = @[
                        @{@"img" : @"pic1.jpg",
                            @"link" : @"pic1"},
                        @{@"img" : @"http://pic2.jpg",
                          @"link" : @"pic2"},
                        @{@"img" : @"https://pic3.jpg",
                          @"link" : @"pic3.jpg"},
                        ];
    JDBannerView *bannerView = [[JDBannerView alloc] initWithImageArray:imageArray frame:CGRectMake(0, 200, self.view.bounds.size.width, 200)];
    [self.view addSubview:bannerView];
```

and you set a placeholderImage for loading webImage:

```objective-c
bannerView.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
```

if you want to listen the click of image,you can write like the following:

```objective-c
bannerView.delegate = self;

- (void)bannerView:(JDBannerView *)bannerView didselectImageWithLink:(NSString *)link {
    NSLog(@"点击了%@",link);
}
```

what's more,you can custom the appearence by yourself.

```objective-c
/**
 *是否自动滚动，默认yes
 */
@property (nonatomic, assign) BOOL needAutoScroll;

/**
 *图片切换时间，默认2s
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *页面指示器选中颜色，默认白色
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

/**
 *页面指示器未选中颜色，默认灰色
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
```

## OverView

![bannerView](bannerView.gif)

## License

Released under the MIT license. See LICENSE for details.