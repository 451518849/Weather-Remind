//
//  Scroll&PageVIewController.m
//  W&R
//
//  Created by vt on 16/1/2.
//  Copyright © 2016年 vt. All rights reserved.
//

#import "Scroll&PageVIewController.h"
#import "WeatherController.h"
#import <iAd/iAd.h>

@interface Scroll_PageVIewController ()<UIScrollViewDelegate,setScrollDelegate,ADBannerViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic)  UIScrollView *scrolView;
@property UIPageControl *pageController;
@property(nonatomic,retain)ADBannerView *adView ;
@end

@implementation Scroll_PageVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self scrollAndPageInit];
    
}
-(void)scrollAndPageInit
{
    self.scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrolView.pagingEnabled = YES;
    self.scrolView.showsHorizontalScrollIndicator = NO;
    self.scrolView.showsVerticalScrollIndicator = NO;
    self.scrolView.delegate = self;
    self.scrolView.bounces = NO;
    self.scrolView.contentSize = CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height);
    WeatherController *weatherVC = [self.storyboard instantiateViewControllerWithIdentifier:@"weather"];
    UIViewController *noteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"remainderView"];
    weatherVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    noteVC.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.scrolView addSubview:weatherVC.view];
    [self.scrolView addSubview:noteVC.view];
    [self.scrolView addSubview:self.pageController];
    [self.view addSubview:self.scrolView];
    
    weatherVC.setScrollDelegate = self;
    
    //广告条
    _adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    
    _adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    
    // 登陆ADBannerView的delegate，这里我们设定其父窗口自己
    
    _adView.delegate = self;
    
    // 在父窗口下方表示
    _adView.frame = CGRectOffset(_adView.frame, self.view.frame.size.width, self.view.frame.size.height - _adView.frame.size.height);
    
    // 添加到父窗口中
    
    [self.scrolView addSubview:_adView];

    
}
-(void)jumpToCard
{
    [self.scrolView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
    int currentPage = scrollView.contentOffset.x/self.view.frame.size.width;
    if (currentPage == 0) {
        self.pageController.currentPage = currentPage;
    }
    else if (currentPage == 1)
    {
        self.pageController.currentPage = currentPage;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)disableScroll
{
    self.scrolView.scrollEnabled = NO;
}
-(void)enableScroll
{
    self.scrolView.scrollEnabled = YES;
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError * )error{
    
    // 切换ADBannerView表示状态，显示→隐藏
    
    // _adView.frame = CGRectOffset(_adView.frame, self.view.frame.size.width, self.view.frame.size.height);
    
}



// 成功读取广告

- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    // 切换ADBannerView表示状态，隐藏→显示
    
   //  _adView.frame = CGRectOffset(_adView.frame, self.view.frame.size.width, self.view.frame.size.height - _adView.frame.size.height);
    
}



// 用户点击广告是响应，返回值BOOL指定广告是否打开

// 参数willLeaveApplication是指是否用其他的程序打开该广告

// 一般在该函数内让当前View停止，以及准备全画面表示广告

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    
    NSLog(@"bannerViewActionShouldBegin:willLeaveApplication: is called.");
    return YES;
}



// 全画面的广告表示完了后，调用该接口

// 该接口被调用之后，当前程序一般会作为后台程序运行

// 该接口中需要回复之前被中断的处理（如果有的话）

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    
    NSLog(@"bannerViewActionDidFinish: is called.");
    
}


@end
