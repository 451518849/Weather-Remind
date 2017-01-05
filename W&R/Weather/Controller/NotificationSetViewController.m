//
//  NotificationSetViewController.m
//  Weather&Remind
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "NotificationSetViewController.h"
#import "WeatherNotification.h"
#import "Macro.h"
#import "EventsCollection.h"

@interface NotificationSetViewController ()
@property(nonatomic,strong)UITableView *tableView;
extern BOOL animationFlag;
@end

@implementation NotificationSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-65,30, 50, 30)];
    [backButton setTitle:@"关闭" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToWeaterController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToWeaterController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"setNofifcation";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UISwitch *notificationSwitch = [[UISwitch alloc]init];
    NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];

    cell.accessoryView = notificationSwitch;
    
    //今日推送暂且关闭
//    if (indexPath.row == 0)
//    {
//        cell.textLabel.text = @"今日天气推送";
//        NSString *todayNofifcation = [userDefualts objectForKey:TODAY_NOTIFICATION];
//
//        if ( [todayNofifcation isEqualToString:CLOSE])
//        {
//            notificationSwitch.on = NO;
//        }
//        else
//        {
//            notificationSwitch.on = YES;
//        }
//        [notificationSwitch addTarget:self action:@selector(cancelLocalNotificationOfTodayWeather:) forControlEvents:UIControlEventValueChanged];
//    }
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"明日天气推送";
        cell.detailTextLabel.text = @"当明天有坏天气时，会提前告知";
        NSString *tomorrowNotification = [userDefualts objectForKey:TOMORROW_NOTIFICATION];
        if ( [tomorrowNotification isEqualToString:CLOSE])
        {
            notificationSwitch.on = NO;
        }
        else
        {
            notificationSwitch.on = YES;
        }
        [notificationSwitch addTarget:self action:@selector(cancelLocalNotificationOfTomorrowWeather:) forControlEvents:UIControlEventValueChanged];
    }
    else if(indexPath.row == 1)
    {
        cell.textLabel.text = @"温馨提示";
        cell.detailTextLabel.text = @"当明天天气差并且有任务时，会提前告知";
        NSString *notesNotification = [userDefualts objectForKey:NOTESNOTIFICATION];
        if ( [notesNotification isEqualToString:CLOSE])
        {
            notificationSwitch.on = NO;
        }
        else
        {
            notificationSwitch.on = YES;
        }
        [notificationSwitch addTarget:self action:@selector(cancelLocalNotificationOfNotes:) forControlEvents:UIControlEventValueChanged];
    }
    else
    {
        cell.textLabel.text = @"定位刷新";
        NSString *notesNotification = [userDefualts objectForKey:LOCATION];
        if ( [notesNotification isEqualToString:CLOSE])
        {
            notificationSwitch.on = NO;
        }
        else
        {
            notificationSwitch.on = YES;
        }
        [notificationSwitch addTarget:self action:@selector(cancelLocationOrientation:) forControlEvents:UIControlEventValueChanged];
    }
    return cell;
}

-(void)cancelLocalNotificationOfTodayWeather:(UISwitch*)sender
{
    NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];

    if ([sender isOn])
    {
        [userDefualts setObject:OPEN forKey:TODAY_NOTIFICATION];
    }
    else
    {
        [userDefualts setObject:CLOSE forKey:TODAY_NOTIFICATION];
        [WeatherNotification cancelLocalNotificationWithkey:TODAY_WEATHER_NOTIFICATION_KEY];
    }
}

-(void)cancelLocalNotificationOfTomorrowWeather:(UISwitch*)sender
{
    NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];

    if ([sender isOn])
    {
        [userDefualts setObject:OPEN forKey:TOMORROW_NOTIFICATION];
    }
    else
    {
        [userDefualts setObject:CLOSE forKey:TOMORROW_NOTIFICATION];
        [WeatherNotification cancelLocalNotificationWithkey:TOMORROW_WEATHER_NOTIFICATION_KEY];
    }

}

-(void)cancelLocalNotificationOfNotes:(UISwitch*)sender
{
    NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];

    if ([sender isOn])
    {
        [userDefualts setObject:OPEN forKey:NOTESNOTIFICATION];
    }
    else
    {
        [userDefualts setObject:CLOSE forKey:NOTESNOTIFICATION];
        [WeatherNotification cancelLocalNotificationWithkey:TOMORROW_EVENT_NOTIFICATION_KEY];
    }

}

-(void)cancelLocationOrientation:(UISwitch*)sender
{
    NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
    
    if ([sender isOn])
    {
        [userDefualts setObject:OPEN forKey:LOCATION];
    }
    else
    {
        [userDefualts setObject:CLOSE forKey:LOCATION];
    }

}

@end
