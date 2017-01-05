//
//  ViewController.m
//  Weather&Remind
//
//  Created by apple on 16/1/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "WeatherController.h"
#import "WaterProgressView.h"
#import "WeatherNotification.h"
#import "NotificationSetViewController.h"
#import <MapKit/MKMapView.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "Macro.h"
#import "SearchInformation.h"
#import "AppDelegate.h"
#import "DateHelper.h"

#define WATER_BORDER_COLOR [[UIColor colorWithRed:209/255.0f green:124/255.0f blue:59/255.0f alpha:1]CGColor];


extern NSMutableArray *eventTitle;
extern NSMutableArray *eventNotes;
extern NSMutableArray *eventTime;
extern NSMutableArray *eventStatus;
extern NSMutableArray *colors;
extern NSMutableArray *eventDate;
extern NSMutableArray *eventString;

@interface WeatherController ()<CLLocationManagerDelegate,restartAnimationsDelegate>

@property(nonatomic,copy)NSString *todayWeather;
@property(nonatomic,copy)NSString *nowTemperature;
@property(nonatomic,copy)NSString *lowAndhighTemperature;
@property(nonatomic,copy)NSString *windDirection;
@property(nonatomic,copy)NSString *windLevel;
@property(nonatomic,copy)NSString *airQuilty;
@property(nonatomic,copy)NSString *weatherRemark;
@property(nonatomic,strong)UIImage *weatherIcon;

@property(nonatomic,copy)NSString *futureDate1;
@property(nonatomic,copy)NSString *futureDate2;
@property(nonatomic,copy)NSString *futureDate3;

@property(nonatomic,copy)NSString *futureDay1Temperature;
@property(nonatomic,copy)NSString *futureDay2Temperature;
@property(nonatomic,copy)NSString *futureDay3Temperature;

@property(nonatomic,copy)NSString *futureDay1Weather;
@property(nonatomic,copy)NSString *futureDay2Weather;
@property(nonatomic,copy)NSString *futureDay3Weather;

@property(nonatomic,strong)UIImage *furtureDay1WeaIcon;
@property(nonatomic,strong)UIImage *furtureDay2WeaIcon;
@property(nonatomic,strong)UIImage *furtureDay3WeaIcon;

//WaterProgress 上面的温度、天气、星期
@property(nonatomic,strong)UILabel *temperature;
@property(nonatomic,strong)UILabel *weather;
@property(nonatomic,strong)UILabel *weekday;
@property(nonatomic,strong)UILabel *city;

@property(nonatomic,strong)WaterProgressView *Timeprogress;
@property(nonatomic,strong)UIPageControl *weatherControl;


@property(nonatomic,assign)float tempPointY;
@property(nonatomic,assign)float tempTimeHour;
@property(nonatomic,assign)BOOL isPopView;
@property(nonatomic,assign)int popCount;
@property(nonatomic,assign)NSInteger blurCount;

@property(nonatomic,strong)UIImageView *backgroundImage;
@property(nonatomic,strong)UIView *blurView;
@property(nonatomic,strong)UIView *popView;

@property(nonatomic,strong)UISwipeGestureRecognizer *recognizerUp;
@property(nonatomic,strong)UISwipeGestureRecognizer *recognizerDown;

@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,copy)NSString *localCity;
@property(nonatomic,assign)BOOL isLocated;
extern BOOL isPop;
extern BOOL animationFlag;

//bankground animation
@property (nonatomic,strong) UIImageView *sun;
@property double sunAngle;
@property (nonatomic,strong) UIImageView *wheel;
@property int wheelAngel;
@property (nonatomic,strong) UIImageView *cloud;
@property (nonatomic,strong) UIImageView *rain;
@property (nonatomic,strong) UIImageView *snow;
@property (nonatomic,strong) UIView *mist;

@property (nonatomic,strong) AppDelegate *app;
@end

@implementation WeatherController

-(void)showPopView
{
    //losking mark
    [self.setScrollDelegate disableScroll];
    
    _isPopView = true;
    _popCount++;
    _blurCount = 1;
    if (_popCount == 1)
    {
        
        _popView = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height + 20, 250, self.view.frame.size.height - 300)];
        [self initWithVisualEffectVie:_popView blurNSInteger:1];
        _popView.layer.masksToBounds = YES;
        _popView.layer.cornerRadius = 15.0;
        [self.view addSubview:_popView];
        [self initPopScrollView];
        
        [self initWithVisualEffectVie:_blurView blurNSInteger:3];
        [_backgroundImage addSubview:_blurView];
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _popView.center = CGPointMake(self.view.center.x, self.view.center.y - 30);
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    _popView.center = CGPointMake(self.view.center.x, self.view.center.y);
                    
                } completion:^(BOOL finished) {
                    [self popViewAnimation:_popView];
                }];
            }
        }];
        
    }
    
    
}

-(void)hidePopView
{
    //losking mark
    [self.setScrollDelegate enableScroll];
    
    _isPopView = false;
    _popCount = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _popView.center = CGPointMake(self.view.center.x, self.view.frame.size.height*2);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [_popView removeFromSuperview];
            [_blurView removeFromSuperview];
        }
    }];
    
}

-(void)popViewAnimation:(UIView*)view
{
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _popView.transform = CGAffineTransformMakeRotation(2.0/360.0);
        if (!_isPopView)
        {
            _popView.center = CGPointMake(self.view.center.x-2, self.view.center.y + 2);
            
        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            
            [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _popView.transform = CGAffineTransformMakeRotation(-1/360.0);
                _popView.center =CGPointMake(self.view.center.x+2, self.view.center.y);
                
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
                        _popView.transform = CGAffineTransformMakeRotation(0);
                        _popView.center = CGPointMake(self.view.center.x, self.view.center.y - 2);
                        
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
                                _popView.transform = CGAffineTransformMakeRotation(2.0/360.0);
                                _popView.center = CGPointMake(self.view.center.x-2, self.view.center.y + 2);
                                
                            } completion:^(BOOL finished) {
                                [self popViewAnimation:_popView];
                            }];
                        }
                        
                    }];
                }
            }];
        }
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    if (page == 0) {
        _weatherControl.currentPage = 0;
    }
    else if (page == 1)
    {
        _weatherControl.currentPage = 1;
    }
    else if (page == 2)
    {
        _weatherControl.currentPage = 2;
    }
    else if (page == 3)
    {
        _weatherControl.currentPage = 3;
    }
}

-(void)initPopScrollView
{
    UIScrollView *weaScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 0, 240, _popView.frame.size.height - 80)];
    weaScrView.contentSize = CGSizeMake(960, _popView.frame.size.height-80);
    weaScrView.pagingEnabled = YES;
    weaScrView.showsHorizontalScrollIndicator = NO;
    weaScrView.showsVerticalScrollIndicator = NO;
    weaScrView.delegate = self;
    [_popView addSubview:weaScrView];
    
    _weatherControl = [[UIPageControl alloc]init];
    _weatherControl.center = CGPointMake(125, _popView.frame.size.height-20);
    _weatherControl.numberOfPages = 4;
    _weatherControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _weatherControl.currentPage = 0;
    [_popView addSubview:_weatherControl];
    
    //今日天气
    UILabel *todayWeaDescrible = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 100, 20)];
    UILabel *helpAdvice = [[UILabel alloc]initWithFrame:CGRectMake(320, 20, 100, 20)];
    UILabel *futureWeather = [[UILabel alloc]initWithFrame:CGRectMake(550, 20, 100, 20)];
    UILabel *arragement = [[UILabel alloc]initWithFrame:CGRectMake(800, 20, 100, 20)];
    
    todayWeaDescrible.textColor = [UIColor whiteColor];
    helpAdvice.textColor = [UIColor whiteColor];
    futureWeather.textColor = [UIColor whiteColor];
    arragement.textColor = [UIColor whiteColor];
    todayWeaDescrible.text = @"今日天气";
    helpAdvice.text = @"贴心提示";
    futureWeather.text = @"未来3天天气";
    arragement.text = @"今日安排";
    
    [weaScrView addSubview:helpAdvice];
    [weaScrView addSubview:futureWeather];
    [weaScrView addSubview:arragement];
    
    
    UILabel *weatherQuiltyLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 70, 80, 10)];
    UILabel *nowTemperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 90, 80, 10)];
    UILabel *lowAndHighTempLabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 110, 90, 10)];
    UILabel *windDirectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(68, 130, 50, 10)];
    UILabel *windLevelLabel = [[UILabel alloc]initWithFrame:CGRectMake(68, 150, 50, 10)];
    UILabel *airQuiltyLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 170, 80, 10)];
    
    UILabel *weatherQuilty = [[UILabel alloc]initWithFrame:CGRectMake(120, 70, 80, 10)];
    UILabel *nowTemperature = [[UILabel alloc]initWithFrame:CGRectMake(120, 90, 80, 10)];
    UILabel *lowAndHighTemp = [[UILabel alloc]initWithFrame:CGRectMake(120, 110, 90, 10)];
    UILabel *windDirection = [[UILabel alloc]initWithFrame:CGRectMake(120, 130, 50, 10)];
    UILabel *windLevel = [[UILabel alloc]initWithFrame:CGRectMake(120, 150, 50, 10)];
    UILabel *airQuilty = [[UILabel alloc]initWithFrame:CGRectMake(120, 170, 100, 10)];
    
    
    UIImageView *weatherIcon = [[UIImageView alloc]initWithFrame:CGRectMake(40, 20, 20, 20)];
    
    nowTemperatureLabel.textColor = [UIColor whiteColor];
    lowAndHighTempLabel.textColor = [UIColor whiteColor];
    windDirectionLabel.textColor = [UIColor whiteColor];
    windLevelLabel.textColor = [UIColor whiteColor];
    weatherQuiltyLabel.textColor = [UIColor whiteColor];
    airQuiltyLabel.textColor = [UIColor whiteColor];
    
    weatherQuilty.textColor = [UIColor whiteColor];
    nowTemperature.textColor = [UIColor whiteColor];
    lowAndHighTemp.textColor = [UIColor whiteColor];
    windDirection.textColor = [UIColor whiteColor];
    windLevel.textColor = [UIColor whiteColor];
    airQuilty.textColor = [UIColor whiteColor];
    
    nowTemperatureLabel.font = [UIFont systemFontOfSize:14.0f];
    lowAndHighTempLabel.font = [UIFont systemFontOfSize:14.0f];
    windDirectionLabel.font = [UIFont systemFontOfSize:14.0f];
    windLevelLabel.font = [UIFont systemFontOfSize:14.0f];
    weatherQuiltyLabel.font = [UIFont systemFontOfSize:14.0f];
    airQuiltyLabel.font = [UIFont systemFontOfSize:14.0f];
    
    nowTemperature.font = [UIFont systemFontOfSize:14.0f];
    lowAndHighTemp.font = [UIFont systemFontOfSize:14.0f];
    windDirection.font = [UIFont systemFontOfSize:14.0f];
    windLevel.font = [UIFont systemFontOfSize:14.0f];
    weatherQuilty.font = [UIFont systemFontOfSize:14.0f];
    airQuilty.font = [UIFont systemFontOfSize:14.0f];
    
    weatherQuiltyLabel.text = @"天气状况：";
    nowTemperatureLabel.text = @"现在温度：";
    lowAndHighTempLabel.text = @"最高/低温度：";
    windDirectionLabel.text = @"风向：";
    windLevelLabel.text = @"风力：";
    airQuiltyLabel.text = @"空气质量：";
    
    nowTemperature.text = _nowTemperature;
    lowAndHighTemp.text = _lowAndhighTemperature;
    windDirection.text = _windDirection;
    windLevel.text = _windLevel;
    weatherQuilty.text = _todayWeather;
    airQuilty.text = _airQuilty;
    weatherIcon.image = _weatherIcon;
    
    [weaScrView addSubview:todayWeaDescrible];
    [weaScrView addSubview:nowTemperatureLabel];
    [weaScrView addSubview:lowAndHighTempLabel];
    [weaScrView addSubview:windDirectionLabel];
    [weaScrView addSubview:windLevelLabel];
    [weaScrView addSubview:weatherQuiltyLabel];
    [weaScrView addSubview:airQuiltyLabel];
    
    [weaScrView addSubview:nowTemperature];
    [weaScrView addSubview:lowAndHighTemp];
    [weaScrView addSubview:windDirection];
    [weaScrView addSubview:windLevel];
    [weaScrView addSubview:weatherQuilty];
    [weaScrView addSubview:airQuilty];
    [weaScrView addSubview:weatherIcon];
    
    //贴心提示
    UILabel *intimateRemark = [[UILabel alloc]initWithFrame:CGRectMake(280, 40, 150, 50)];
    
    intimateRemark.textColor = [UIColor whiteColor];
    intimateRemark.font = [UIFont systemFontOfSize:12.0f];
    intimateRemark.numberOfLines = 3;
    
    intimateRemark.text = _weatherRemark;
    
    [weaScrView addSubview:intimateRemark];
    
    //未来三天天气
    UIImageView *futureWeatherIcon1 = [[UIImageView alloc]initWithFrame:CGRectMake(500, 80, 25, 25)];
    UIImageView *futureWeatherIcon2 = [[UIImageView alloc]initWithFrame:CGRectMake(580, 80, 25, 25)];
    UIImageView *futureWeatherIcon3 = [[UIImageView alloc]initWithFrame:CGRectMake(660, 80, 25, 25)];
    
    UILabel *futureDate1 = [[UILabel alloc]initWithFrame:CGRectMake(495, 120, 45, 10)];
    UILabel *futureDate2 = [[UILabel alloc]initWithFrame:CGRectMake(575, 120, 45, 10)];
    UILabel *futureDate3 = [[UILabel alloc]initWithFrame:CGRectMake(655, 120, 45, 10)];
    
    UILabel *futureWeather1 = [[UILabel alloc]initWithFrame:CGRectMake(475, 140, 80, 10)];
    UILabel *futureWeather2 = [[UILabel alloc]initWithFrame:CGRectMake(555, 140, 80, 10)];
    UILabel *futureWeather3 = [[UILabel alloc]initWithFrame:CGRectMake(635, 140, 80, 10)];
    
    UILabel *futureWeaTempretaure1 = [[UILabel alloc]initWithFrame:CGRectMake(492, 160, 60, 10)];
    UILabel *futureWeaTempretaure2 = [[UILabel alloc]initWithFrame:CGRectMake(572, 160, 60, 10)];
    UILabel *futureWeaTempretaure3 = [[UILabel alloc]initWithFrame:CGRectMake(652, 160, 60, 10)];
    
    futureDate1.textColor = [UIColor whiteColor];
    futureDate2.textColor = [UIColor whiteColor];
    futureDate3.textColor = [UIColor whiteColor];
    
    futureWeather1.textColor = [UIColor whiteColor];
    futureWeather2.textColor = [UIColor whiteColor];
    futureWeather3.textColor = [UIColor whiteColor];
    
    futureWeaTempretaure1.textColor = [UIColor whiteColor];
    futureWeaTempretaure2.textColor = [UIColor whiteColor];
    futureWeaTempretaure3.textColor = [UIColor whiteColor];
    
    
    futureDate1.font = [UIFont systemFontOfSize:11.0f];
    futureDate2.font = [UIFont systemFontOfSize:11.0f];
    futureDate3.font = [UIFont systemFontOfSize:11.0f];
    futureWeather1.font = [UIFont systemFontOfSize:11.0f];
    futureWeather2.font = [UIFont systemFontOfSize:11.0f];
    futureWeather3.font = [UIFont systemFontOfSize:11.0f];
    futureWeaTempretaure1.font = [UIFont systemFontOfSize:11.0f];
    futureWeaTempretaure2.font = [UIFont systemFontOfSize:11.0f];
    futureWeaTempretaure3.font = [UIFont systemFontOfSize:11.0f];
    
    futureDate1.textAlignment = NSTextAlignmentCenter;
    futureDate2.textAlignment = NSTextAlignmentCenter;
    futureWeather1.textAlignment = NSTextAlignmentCenter;
    futureWeather2.textAlignment = NSTextAlignmentCenter;
    futureWeather3.textAlignment = NSTextAlignmentCenter;
    futureWeaTempretaure1.textAlignment = NSTextAlignmentCenter;
    futureWeaTempretaure2.textAlignment = NSTextAlignmentCenter;
    futureWeaTempretaure3.textAlignment = NSTextAlignmentCenter;
    
    futureWeatherIcon1.image = _furtureDay1WeaIcon;
    futureWeatherIcon2.image = _furtureDay2WeaIcon;
    futureWeatherIcon3.image = _furtureDay3WeaIcon;
    
    futureDate1.text = _futureDate1;
    futureDate2.text = _futureDate2;
    futureDate3.text = _futureDate3;
    futureWeather1.text = _futureDay1Weather;
    futureWeather2.text = _futureDay2Weather;
    futureWeather3.text = _futureDay3Weather;
    futureWeaTempretaure1.text = _futureDay1Temperature;
    futureWeaTempretaure2.text = _futureDay2Temperature;
    futureWeaTempretaure3.text = _futureDay3Temperature;
    
    [weaScrView addSubview:futureWeatherIcon1];
    [weaScrView addSubview:futureWeatherIcon2];
    [weaScrView addSubview:futureWeatherIcon3];
    
    [weaScrView addSubview:futureDate1];
    [weaScrView addSubview:futureDate2];
    [weaScrView addSubview:futureDate3];
    [weaScrView addSubview:futureWeather1];
    [weaScrView addSubview:futureWeather2];
    [weaScrView addSubview:futureWeather3];
    [weaScrView addSubview:futureWeaTempretaure1];
    [weaScrView addSubview:futureWeaTempretaure2];
    [weaScrView addSubview:futureWeaTempretaure3];
    
    //    UILabel *arragement = [[UILabel alloc]initWithFrame:CGRectMake(800, 20, 100, 20)];

    //获取当日时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *todayDate = [formatter stringFromDate:[NSDate new]];
    
    for (int i = 0; i < eventTime.count; i++)
    {
        if ([todayDate isEqualToString:[eventTime objectAtIndex:i]])
        {
            NSString *todayEventTitle = [eventTitle objectAtIndex:i];
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(715, 50, 240, 20)];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = todayEventTitle;
            [weaScrView addSubview:titleLabel];
            break;
        }
    }
}

//初始化时间水球
-(void)initWaterProgress
{
    
    if (_tempPointY <= _tempTimeHour * 6.25)
    {
        _Timeprogress.currentLinePointY = _tempPointY;
        _tempPointY++;
    }
}

-(void)judgeWeatherCondiation
{
    NSString *weatherCondition = _todayWeather;
    
    //    NSRange rainyRange = [weatherCondition rangeOfString:@"雨"];
    //    NSRange sunnyRange = [weatherCondition rangeOfString:@"晴"];
    //    NSRange cloudRange = [weatherCondition rangeOfString:@"云"];
    //    NSRange mistyRange = [weatherCondition rangeOfString:@"雾"];
    //    NSRange snowRange = [weatherCondition rangeOfString:@"雪"];
    
    if([SearchInformation weatherAnalyse:@[@"雨"] andInputedString:weatherCondition])
    {
        [self initRainViews];
        [self cloudly1:animationFlag];
        [self rainy:animationFlag];
    }
    if([SearchInformation weatherAnalyse:@[@"晴"] andInputedString:weatherCondition])
    {
        [self initSunnyViews];
        [self sunny:animationFlag];
    }
    if([SearchInformation weatherAnalyse:@[@"阴",@"多云"] andInputedString:weatherCondition])
    {
        [self initSunnyViews];
        [self sun:animationFlag];
        [self initCloudViews];
        [self cloudly1:animationFlag];
    }
    if([SearchInformation weatherAnalyse:@[@"雪"] andInputedString:weatherCondition])
    {
        [self initSnowViews];
        [self cloudly1:animationFlag];
        [self snow:animationFlag];
    }
    //    if(![SearchInformation weatherAnalyse:@[@"优",@"良"] andInputedString:_airQuilty])
    //    {
    //        [self initSunnyViews];
    //        [self sun:animationFlag];
    //        [self initMistViews];
    //        [self misty:animationFlag];
    //    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self restartAnimations];
    
}

//计算星期
-(NSString*)weekdayStringFromDate:(NSDate*)inputDate
{
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null],@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",nil];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}


//模糊效果
- (void)initWithVisualEffectVie:(UIView*)addToView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0,addToView.frame.size.width,addToView.frame.size.height)];
    [addToView addSubview:view];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [visualEffectView setFrame:view.bounds];
    [view addSubview:visualEffectView];
    
}

//模糊效果
- (void)initWithVisualEffectVie:(UIView*)addToView blurNSInteger:(NSInteger)blurInteger
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0,addToView.frame.size.width,addToView.frame.size.height)];
    [addToView addSubview:view];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:blurInteger];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [visualEffectView setFrame:view.bounds];
    [view addSubview:visualEffectView];
    
}

-(void)getBackgroundImage
{
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",BACKGROUND_IMAGE_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:imageUrl];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if ([httpResponse statusCode]== 200)
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:data forKey:@"backgroundImage"];
        }
        else
        {
            //断网处理
        }
    }];
    
}

//定位每个城市
-(void)getLocationCityName
{
    if ([CLLocationManager locationServicesEnabled])
    {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        [_locationManager startUpdatingLocation];
    }
    else {
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
}

#pragma mark - CoreLocation Delegate 获取城市
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    
    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                                            objectForKey:@"AppleLanguages"];
    
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil]
                                              forKey:@"AppleLanguages"];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [_locationManager stopUpdatingLocation];
    
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    
    CLLocation *currentLocation = [locations lastObject];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     
     {
         if (array.count > 0)
             
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             //将获得地理位置的详细信息
             NSLog(@"placemark:%@",placemark.name);
             //获取城市
             NSString *city = placemark.locality;
             _localCity = [city substringToIndex:city.length-1];
             NSLog(@"city:%@",_localCity);
             
             if (!city)
             {
                 
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
                 _localCity = [city substringToIndex:city.length-1];
                 
             }
             
             _city.text = city;
             
             NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
             [userDefualts setObject:_localCity forKey:CITY];
            
             if (!_isLocated ) {
                 
                 [self initTodayWeather];
               //  [self initWeatherQuilty];
                 [self initFutureThreeDaysWeather];
                 _isLocated = YES;
             }
             
             
             
         }
         
         else if (error == nil && [array count] == 0)
             
         {
             
             NSLog(@"No results were returned.");
             
         }
         
         else if (error != nil)
             
         {
             
             NSLog(@"An error occurred = %@", error);
             
         }
         // 还原Device 的语言
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];

     }];
}


- (void)locationManager:(CLLocationManager *)manager

       didFailWithError:(NSError *)error {
    
    if (error.code == kCLErrorDenied) {
        
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
        
    }
    
}

-(void)initUIComponnets
{
    //当日天气和温度
    _temperature = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 100)];
    _weather = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 100)];
    _weekday = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 100)];
    
    _temperature.backgroundColor = [UIColor clearColor];
    _weather.backgroundColor = [UIColor clearColor];
    _city.backgroundColor = [UIColor clearColor];
    
    _temperature.textColor = [UIColor whiteColor];
    _weather.textColor = [UIColor whiteColor];
    _weekday.textColor = [UIColor whiteColor];
    _city.textColor = [UIColor whiteColor];
    
    _temperature.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:60.0f];
    _weather.font = [UIFont systemFontOfSize:13.0f];
    _weekday.font = [UIFont systemFontOfSize:13.0f];
    _city.font = [UIFont systemFontOfSize:15.0f];
    
    NSDate *date = [NSDate new];
    _weekday.text = [self weekdayStringFromDate:date];
    
    //  获取当日小时
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate setDateFormat:@"HH"];
    NSString *timeHourStr = [formate stringFromDate:[NSDate date]];
    _tempTimeHour = [timeHourStr floatValue];
    
    _Timeprogress = [[WaterProgressView alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height-180, 150, 150)];
    _Timeprogress.layer.borderColor = WATER_BORDER_COLOR;
    _Timeprogress.layer.borderWidth = 1.0;
    _Timeprogress.layer.cornerRadius = 75.0f;
    
    _temperature.center = _Timeprogress.center;
    _weather.center = CGPointMake(_Timeprogress.center.x+70, _Timeprogress.center.y-5);
    _weekday.center = CGPointMake(_Timeprogress.center.x+70, _Timeprogress.center.y+13);
    _city.center = CGPointMake(_Timeprogress.center.x+60, _Timeprogress.center.y+30);
    
    [_backgroundImage addSubview:_Timeprogress];
    [_backgroundImage addSubview:_city];
    [_backgroundImage addSubview:_weather];
    [_backgroundImage addSubview:_weekday];
    [_backgroundImage addSubview:_temperature];
    _tempPointY = 0;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    animationFlag = YES;
    _isLocated = NO;
    [self wheelAnimation:animationFlag];
    [self initWeatherViews];
    self.app = [[AppDelegate alloc]init];
    self.app.delegate = self;
    
    self.sunAngle = 0;
    self.wheelAngel = 0;
    
    _backgroundImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    _backgroundImage.image = [UIImage imageNamed:@"city.png"];
    _backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImage.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:89/255.0 green:178/255.0 blue:172/255.0 alpha:1];
    _backgroundImage.userInteractionEnabled = YES;
    [self.view addSubview:_backgroundImage];
    
    self.view.backgroundColor = [UIColor colorWithRed:89/255.0 green:178/255.0 blue:172/255.0 alpha:1];
    
    //losking mark
    UIButton *helpButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 30, 30, 30)];
    helpButton.backgroundColor = [UIColor whiteColor];
    helpButton.layer.cornerRadius = 15;
    [helpButton setTitle:@"?" forState:UIControlStateNormal];
    [helpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(help) forControlEvents:UIControlEventTouchDown];
    
    _city = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //城市定位
    
    NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
    NSString *isOpenLocationOrientation = [userDefualts objectForKey:LOCATION];
    if ([isOpenLocationOrientation isEqualToString:CLOSE])
    {
        NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
        NSString *cityName = [userDefualts objectForKey:CITY];
        _localCity = cityName ;
        _city.text = cityName;
        [self initWeatherQuilty];
        [self initTodayWeather];
        //[self initWeatherQuilty];
        [self initFutureThreeDaysWeather];
    }
    else
    {
    
        [self getLocationCityName];

    }
    
    //初始化UI
    [self initUIComponnets];

    
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(initWaterProgress) userInfo:nil repeats:YES];
    
    //模糊背景添加
    _blurView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self initWithVisualEffectVie:_blurView];
    
    //添加手势
    _recognizerUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showPopView)];
    _recognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:_recognizerUp];
    
    _recognizerDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hidePopView)];
    _recognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:_recognizerDown];
    
    UIButton *setNotificationButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, self.view.frame.size.height-30, 30, 30)];
    [setNotificationButton setBackgroundImage:[UIImage imageNamed:@"setting icon"]forState:UIControlStateNormal];
    [setNotificationButton addTarget:self action:@selector(jumpToSetNotificationViewController) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImage addSubview:setNotificationButton];
    [_backgroundImage addSubview:helpButton];
}

-(void)jumpToSetNotificationViewController
{
    animationFlag = NO;
    NotificationSetViewController *setVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationSetViewController"];
    [self.view.window.rootViewController presentViewController:setVC animated:YES completion:nil];
}


//当日天气更新
-(void)initTodayWeather
{
    
    NSString *urlString = [NSString stringWithFormat:WEATHER_URL,WEATHER_BASIC_URL,TODAY,_localCity,APPKEY,SIGN];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSURL *weatherUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:weatherUrl];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        
        if ([httpResponse statusCode]== 200)
        {
            
            NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *realTimePredicition = [weatherDic objectForKey:@"result"];
            
            _todayWeather = [realTimePredicition objectForKey:@"weather"];
            _nowTemperature = [realTimePredicition objectForKey:@"temperature_curr"];
            _lowAndhighTemperature = [realTimePredicition objectForKey:@"temperature"];
            _windDirection = [realTimePredicition objectForKey:@"wind"];
            _windLevel = [realTimePredicition objectForKey:@"winp"];
            
            NSString *imageUrl = [realTimePredicition objectForKey:@"weather_icon"];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            _weatherIcon = [UIImage imageWithData:imageData];
            
            _temperature.text = _nowTemperature;
            _weather.text = _todayWeather;
            
            //获取出数字温度，然后拼接带有摄氏度的字符串
            NSString *getTemperatureNumber = [_nowTemperature substringToIndex:_temperature.text.length-1];
            _temperature.text = [NSString stringWithFormat:@"%@˚",getTemperatureNumber];
            
            [self judgeWeatherCondiation];
            
        }
        else
        {
            //断网处理
            UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"网络错误" message:@"请检查网络" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alterView show];
        }
    }];
}

//空气质量更新
-(void)initWeatherQuilty
{
    NSString *pm25UrlStr =[NSString stringWithFormat:WEATHER_URL,WEATHER_BASIC_URL,PM25,_localCity,APPKEY,SIGN];
    pm25UrlStr = [pm25UrlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSURL *pm25Url = [NSURL URLWithString:pm25UrlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:pm25Url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if ([httpResponse statusCode]== 200)
        {
            
            NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *realTimePredicition = [weatherDic objectForKey:@"result"];
            _airQuilty = [realTimePredicition objectForKey:@"aqi_levnm"];
            _weatherRemark = [realTimePredicition objectForKey:@"aqi_remark"];
            
            NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
            NSString *isOpenNotification = [userDefualts objectForKey:TODAY_NOTIFICATION];
            if (![isOpenNotification isEqualToString:CLOSE]) {  //判断是否开启推送
                //空气质量监测
                [self getTodayAirQuilty:_airQuilty airRemark:_weatherRemark]; //今日天气推送暂时关闭
            }

            
        }
        else
        {
            //断网处理
        }
    }];
    
}

//未来三天天气更新
-(void)initFutureThreeDaysWeather
{
    NSString *futureWeaUrlStr =[NSString stringWithFormat:WEATHER_URL,WEATHER_BASIC_URL,FUTURE,_localCity,APPKEY,SIGN];
    futureWeaUrlStr = [futureWeaUrlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSURL *futureWeaUrl = [NSURL URLWithString:futureWeaUrlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:futureWeaUrl];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if ([httpResponse statusCode]== 200)
        {
            
            NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *realTimePredicition = [weatherDic objectForKey:@"result"];
            NSMutableArray *weathers = [[NSMutableArray alloc]init];
            for(NSDictionary *weatherDic in realTimePredicition)
            {
                [weathers addObject:weatherDic];
            }
            
            NSDictionary *futureWeather1 = [weathers objectAtIndex:1];
            NSDictionary *futureWeather2 = [weathers objectAtIndex:2];
            NSDictionary *futureWeather3 = [weathers objectAtIndex:3];
            
            _futureDate1 = [futureWeather1 objectForKey:@"week"];
            _futureDate2 = [futureWeather2 objectForKey:@"week"];
            _futureDate3 = [futureWeather3 objectForKey:@"week"];
            
            _futureDay1Temperature = [futureWeather1 objectForKey:@"temperature"];
            _futureDay2Temperature = [futureWeather2 objectForKey:@"temperature"];
            _futureDay3Temperature = [futureWeather3 objectForKey:@"temperature"];
            
            _futureDay1Weather = [futureWeather1 objectForKey:@"weather"];
            _futureDay2Weather = [futureWeather2 objectForKey:@"weather"];
            _futureDay3Weather = [futureWeather3 objectForKey:@"weather"];
            
            NSString *weather1Icon = [futureWeather1 objectForKey:@"weather_icon"];
            NSString *weather2Icon = [futureWeather2 objectForKey:@"weather_icon"];
            NSString *weather3Icon = [futureWeather3 objectForKey:@"weather_icon"];
            
            NSData *image1Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:weather1Icon]];
            NSData *image2Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:weather2Icon]];
            NSData *image3Data = [NSData dataWithContentsOfURL:[NSURL URLWithString:weather3Icon]];
            
            _furtureDay1WeaIcon = [UIImage imageWithData:image1Data];
            _furtureDay2WeaIcon = [UIImage imageWithData:image2Data];
            _furtureDay3WeaIcon = [UIImage imageWithData:image3Data];
            
            //明天天气监测
            [self getTomorrowRainWeatherString:_futureDay1Weather tomorrowTemperture:_futureDay1Temperature];


        }
        else
        {
            //断网处理
        }
    }];
}

//今日天气质量监测
-(void)getTodayAirQuilty:(NSString*)airQuilty airRemark:(NSString*)remark
{
    NSArray *airQuiltyArray = [NSArray arrayWithObjects:@"霾",@"雾",@"重度",@"中度",nil];
    
    for (NSString *air in airQuiltyArray)
    {
        NSRange range = [airQuilty rangeOfString:air];
        if (range.length > 0)
        {
            NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
            [userDefualts setObject:airQuilty forKey:@"todayAirQuilty"];
            [userDefualts setObject:remark forKey:@"airRemark"];
            [WeatherNotification locationNotificationOfTodayWeather]; //开启今日推送

            break;
        }
    }
}

//明天天气监测是否推送
-(void)getTomorrowRainWeatherString:(NSString*)weather tomorrowTemperture:(NSString*)temperature
{
    //天气分析
//    NSArray *weatherArray = [NSArray arrayWithObjects:@"雨",@"雪",@"冰",@"多云", nil];
//    
//    for (NSString *wea in weatherArray)
//    {
//        NSRange range = [weather rangeOfString:wea];
//        
//        if (range.length > 0)
//        {
    if([SearchInformation weatherAnalyse:@[@"雨",@"雪",@"冰",@"多云",@"阴"] andInputedString:self.futureDay1Weather])
    {
            NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
            [userDefualts setObject:weather forKey:@"tomorrowWeather"];
            [userDefualts setObject:temperature   forKey:@"tomorrowTemperature"];
            NSString *isTomrrowOpenNotification = [userDefualts objectForKey:TOMORROW_NOTIFICATION];
            NSString *isRecentEventOpenNotification = [userDefualts objectForKey:RECENT_EVENT_NOTIFICATION_TIME];
            NSLog(@"isTomrrowOpenNotification:%@",isTomrrowOpenNotification);
            if (![isTomrrowOpenNotification isEqualToString:CLOSE]) {
                [WeatherNotification locationNotificationOfFutureWeather];  //开启明日天气本地推送

            }
            if (![isRecentEventOpenNotification isEqualToString:CLOSE]) {
                [WeatherNotification locationNotificationToArragementEvent]; //开启事件和天气的推送
            }
    }
//        }
//        
//    }
    //温度分析
    float temp = [temperature floatValue];
    if (temp < 0)
    {
        NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
        [userDefualts setObject:weather forKey:@"tomorrowWeather"];
        [userDefualts setObject:temperature   forKey:@"tomorrowTemperature"];
        [WeatherNotification locationNotificationOfFutureWeather];  //开启本地推送
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)help
{
    animationFlag = NO;
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"helpView"];
    [self.view.window.rootViewController presentViewController:newViewController animated:YES completion:nil];
}
#pragma mark Weather Animation
-(void)initWeatherViews
{
    self.wheel = [[UIImageView alloc]initWithFrame:CGRectMake(0.35 * self.view.frame.size.width, 0.55 * self.view.frame.size.height, 0.4 * self.view.frame.size.width, 0.4 * self.view.frame.size.width)];
    self.wheel.image = [UIImage imageNamed:@"wheel.png"];
    [self.view addSubview:self.wheel];
}
-(void)initSunnyViews
{
    self.sun = [[UIImageView alloc]initWithFrame:CGRectMake(0.35 * self.view.frame.size.width, 0.01 * self.view.frame.size.height, 0.6 * self.view.frame.size.width, 0.6 * self.view.frame.size.width)];
    self.sun.image = [UIImage imageNamed:@"sun.png"];
    [self.view addSubview:self.sun];
}
-(void)initCloudViews
{
    self.cloud = [[UIImageView alloc]initWithFrame:CGRectMake(0.25 * self.view.frame.size.width, 0.1 * self.view.frame.size.height, 0.4 * self.view.frame.size.width, 0.45 * self.view.frame.size.width)];
    self.cloud.center = CGPointMake(0.65 * self.view.frame.size.width, 0.14 * self.view.frame.size.height);
    self.cloud.image = [UIImage imageNamed:@"cloud.png"];
    [self.view addSubview:self.cloud];
}
-(void)initMistViews
{
    self.mist = [[UIView alloc]initWithFrame:self.view.frame];
    self.mist.backgroundColor = [UIColor grayColor];
    self.mist.alpha = 0.6;
    [self.view addSubview:self.mist];
}
-(void)initSnowViews
{
    self.cloud = [[UIImageView alloc]initWithFrame:CGRectMake(0.25 * self.view.frame.size.width, 0.1 * self.view.frame.size.height, 0.4 * self.view.frame.size.width, 0.35 * self.view.frame.size.width)];
    self.cloud.center = CGPointMake(0.65 * self.view.frame.size.width, 0.14 * self.view.frame.size.height);
    self.cloud.image = [UIImage imageNamed:@"cloud.png"];
    [self.view addSubview:self.cloud];
}
-(void)initRainViews
{
    self.cloud = [[UIImageView alloc]initWithFrame:CGRectMake(0.25 * self.view.frame.size.width, 0.1 * self.view.frame.size.height, 0.4 * self.view.frame.size.width, 0.35 * self.view.frame.size.width)];
    self.cloud.center = CGPointMake(0.65 * self.view.frame.size.width, 0.14 * self.view.frame.size.height);
    self.cloud.image = [UIImage imageNamed:@"cloud.png"];
    [self.view addSubview:self.cloud];
}
-(void)sun:(BOOL) flag
{
    if (flag) {
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.sunAngle * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            _sun.transform = endAngle;
        } completion:^(BOOL finished) {
            self.sunAngle += 10;
            [self sun:animationFlag];
        }];
    }else
        [self.sun removeFromSuperview];
}
-(void)sunny:(BOOL) flag
{
    if (flag) {
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.sun.transform = CGAffineTransformMakeScale(1.4, 1.4);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.5 animations:^{
                self.sun.transform = CGAffineTransformMakeScale(0.7, 0.7);
            }];
            [self sunny:animationFlag];
        }];
    }else
        [self.sun removeFromSuperview];
}
-(void)wheelAnimation:(BOOL) flag
{
    if (flag) {
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.wheelAngel * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.wheel.transform = endAngle;
        } completion:^(BOOL finished) {
            self.wheelAngel -= 10;
            [self wheelAnimation:animationFlag];
        }];
    }
}
-(void)cloudly1:(BOOL) flag
{
    if (flag) {
        [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.cloud.center = CGPointMake(self.cloud.center.x + 10, self.cloud.center.y);
        } completion:^(BOOL finished) {
            if (self.cloud.center.x >= self.view.frame.size.width * 0.6) {
                [self cloudly2:animationFlag];
            }else
                [self cloudly1:animationFlag];
        }];
    }else
        [self.cloud removeFromSuperview];
}
-(void)cloudly2:(BOOL) flag
{
    if (flag) {
        [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.cloud.center = CGPointMake(self.cloud.center.x - 10, self.cloud.center.y);
        } completion:^(BOOL finished) {
            if (self.cloud.center.x <= self.view.frame.size.width * 0.2) {
                [self cloudly1:animationFlag];
            }else
                [self cloudly2:animationFlag];
        }];
    }else
        [self.cloud removeFromSuperview];
}
-(void)rainy:(BOOL) flag
{
    if (flag) {
        int random = arc4random() % (int)(self.cloud.frame.size.width) - 80;
        //    NSLog(@"%lf",self.cloud.frame.origin.x);
        UIImageView *rain = [[UIImageView alloc]initWithFrame:CGRectMake(self.cloud.frame.origin.x + 50 + random, self.cloud.frame.size.height, self.cloud.frame.size.width * 0.1, self.cloud.frame.size.width * 0.15)];
        rain.image = [UIImage imageNamed:@"rain"];
        [self.view addSubview:rain];
        [UIView animateWithDuration:0.3 animations:^{
            rain.frame = CGRectMake(rain.frame.origin.x, rain.frame.origin.y + self.view.frame.size.height * 0.6, self.cloud.frame.size.width * 0.2, self.cloud.frame.size.width * 0.3);
        } completion:^(BOOL finished) {
            [rain removeFromSuperview];
            [self rainy:animationFlag];
        }];
    }
}
-(void)snow:(BOOL) flag
{
    if (flag) {
        int random = arc4random() % (int)(self.cloud.frame.size.width) - 80;
        //    NSLog(@"%lf",self.cloud.frame.origin.x);
        UIImageView *rain = [[UIImageView alloc]initWithFrame:CGRectMake(self.cloud.frame.origin.x + 50 + random, self.cloud.frame.size.height, self.cloud.frame.size.width * 0.2, self.cloud.frame.size.width * 0.3)];
        rain.image = [UIImage imageNamed:@"snow"];
        [self.view addSubview:rain];
        [UIView animateWithDuration:3.0 animations:^{
            rain.frame = CGRectMake(rain.frame.origin.x, rain.frame.origin.y + self.view.frame.size.height * 0.6, self.cloud.frame.size.width * 0.3, self.cloud.frame.size.width * 0.3);
        } completion:^(BOOL finished) {
            [rain removeFromSuperview];
            [self snow:animationFlag];
        }];
    }
}
-(void)misty:(BOOL) flag
{
    if (flag) {
        [UIView animateWithDuration:3.0 animations:^{
            self.mist.alpha = 0.4;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:3.0 animations:^{
                self.mist.alpha = 0.6;
            } completion:^(BOOL finished) {
                [self misty:animationFlag];
            }];
        }];
    }else
        [self.mist removeFromSuperview];
}
-(void)restartAnimations
{
    if (!animationFlag) {
        animationFlag = YES;
        [self judgeWeatherCondiation];
        [self wheelAnimation:animationFlag];
    }
}



@end
