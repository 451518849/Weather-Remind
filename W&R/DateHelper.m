//
//  DateHelper.m
//  W&R
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 vt. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

+(NSString*)getTodayDay;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd"];  //天数格式
    NSDate *today = [NSDate new];    //获取今天日期
    NSString *todayString = [formatter stringFromDate:today]; //得到今天的天数
    
    return todayString;
}

+(NSString*)getTodayMonth;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];  //天数格式
    NSDate *today = [NSDate new];    //获取今天日期
    NSString *todayMonth = [formatter stringFromDate:today]; //得到月数
    
    return todayMonth;
}

+(NSString*)getTodayYear;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];  //天数格式
    NSDate *today = [NSDate new];    //获取今天日期
    NSString *todayYear = [formatter stringFromDate:today]; //得到月数
    
    return todayYear;
 
}

+(NSString*)getTomorrowDateByYMD;
{
    NSString *todayYear = [DateHelper getTodayYear];
    NSString *todayMonth = [DateHelper getTodayMonth];
    NSString *todayDay = [DateHelper getTodayDay];
    
    int tommorrowDay = 0,tommorrowMonth = 0,tommorrowYear = 0;
    
    int year = [todayYear intValue];
    int month = [todayMonth intValue]; //将月数转换成整数
    int day = [todayDay intValue];      // 将天数转换成整数
    switch (month) {
        case 1:case 3:case 5:case 7:  //1,3,5,7,8,10大月
            case 8:case 10:
            if (day == 31)
            {
                tommorrowDay = 1;
                tommorrowMonth = month + 1;
                tommorrowYear = year;
            }
            else
            {
                tommorrowDay = day + 1;
                tommorrowMonth = month;
                tommorrowYear = year;
            }
            break;
        case 4:case 6:case 9:case 11: //4，6，9，11小月
            if (day == 30)
            {
                tommorrowDay = 1;
                tommorrowMonth = month + 1;
                tommorrowYear = year;
            }
            else
            {
                tommorrowDay = day + 1;
                tommorrowMonth = month;
                tommorrowYear = year;

            }
            break;
        case 2:
            if (day == 28)
            {
                tommorrowDay = 1;
                tommorrowMonth = month + 1;
                tommorrowYear = year;

            }
            else
            {
                tommorrowDay = day + 1;
                tommorrowMonth = month;
                tommorrowYear = year;

            }
            break;
        case 12:
            if (day == 31)
            {
                tommorrowDay = 1;
                tommorrowMonth = 1;
                tommorrowYear = year + 1;
            }
            else
            {
                tommorrowDay = day + 1;
                tommorrowMonth = month;
                tommorrowYear = year;
            }
            break;
        default:
            break;
    }
    
    NSString *tommorrowDateString = @"";
     if (tommorrowDay < 10 && tommorrowMonth < 10)
    {
        tommorrowDateString = [NSString stringWithFormat:@"%d年0%d月0%d日"
                               ,tommorrowYear,tommorrowMonth,tommorrowDay];
        
    }
    else if (tommorrowDay < 10)
    {
        tommorrowDateString = [NSString stringWithFormat:@"%d年%d月0%d日"
                                         ,tommorrowYear,tommorrowMonth,tommorrowDay];

    }
    else if (tommorrowMonth < 10)
    {
        tommorrowDateString = [NSString stringWithFormat:@"%d年0%d月%d日"
                                         ,tommorrowYear,tommorrowMonth,tommorrowDay];

    }
    else
    {
        tommorrowDateString = [NSString stringWithFormat:@"%d年%d月%d日"
                                         ,tommorrowYear,tommorrowMonth,tommorrowDay];

    }
    return tommorrowDateString;
}

+(NSString*)setRecentEventNotificationTime;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *todayDate = [NSDate new];
    NSString *todayDateString = [formatter stringFromDate:todayDate];
    NSString *setRecentEventTime = [NSString stringWithFormat:@"%@ %@",todayDateString,RECENT_EVENT_NOTIFICATION_TIME];
    
    return setRecentEventTime;
}

+(NSString*)setTommorrowWeatherNotificationTime;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *todayDate = [NSDate new];
    NSString *todayDateString = [formatter stringFromDate:todayDate];
    NSString *setTommorrowTime = [NSString stringWithFormat:@"%@ %@",todayDateString,TOMORROW_WEATHER_NOTIFICATION_TIME];

    return setTommorrowTime;
}

@end









