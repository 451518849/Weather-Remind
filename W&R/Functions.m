//
//  Functions.m
//  W&R
//
//  Created by vt on 16/1/7.
//  Copyright © 2016年 vt. All rights reserved.
//

#import "Functions.h"

extern NSMutableArray *eventTitle;
extern NSMutableArray *eventNotes;
extern NSMutableArray *eventTime;
extern NSMutableArray *eventStatus;
extern NSMutableArray *colors;
extern NSMutableArray *eventDate;
extern NSMutableArray *eventString;

@implementation Functions
-(void)saveDataByUserDefault
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *titleArray = [NSArray arrayWithArray:eventTitle];
    NSArray *noteArray = [NSArray arrayWithArray:eventNotes];
    NSArray *timeArray = [NSArray arrayWithArray:eventTime];//nsstring of date
    NSArray *statusArray = [NSArray arrayWithArray:eventStatus];
    NSArray *colorArray = [NSArray arrayWithArray:colors];
    NSArray *dateArray = [NSArray arrayWithArray:eventDate];
    NSArray *stringArray = [NSArray arrayWithArray:eventString];
    
    [user setObject:titleArray forKey:@"title"];
    [user setObject:noteArray forKey:@"note"];
    [user setObject:timeArray forKey:@"time"];
    [user setObject:statusArray forKey:@"status"];
    [user setObject:colorArray forKey:@"color"];
    [user setObject:dateArray forKey:@"date"];
    [user setObject:stringArray forKey:@"string"];
}
-(NSMutableArray*)getDataFromUserDefault
{
    NSMutableArray *Datas = [[NSMutableArray alloc]init];
    NSArray *title = [[NSArray alloc]init];
    NSArray *note = [[NSArray alloc]init];
    NSArray *time = [[NSArray alloc]init];
    NSArray *status = [[NSArray alloc]init];
    NSArray *color = [[NSArray alloc]init];
    NSArray *date = [[NSArray alloc]init];
    NSArray *string = [[NSArray alloc]init];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    title = [user objectForKey:@"title"];
    note = [user objectForKey:@"note"];
    time = [user objectForKey:@"time"];
    status = [user objectForKey:@"status"];
    color = [user objectForKey:@"color"];
    date = [user objectForKey:@"date"];
    string = [user objectForKey:@"string"];
    
    if (title&&note&&time&&status&&color) {
        [Datas addObject:title];
        [Datas addObject:note];
        [Datas addObject:status];
        [Datas addObject:time];
        [Datas addObject:color];
        [Datas addObject:date];
        [Datas addObject:string];
    }

    
    return Datas;
}
@end
