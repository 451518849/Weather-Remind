//
//  EventsCollection.m
//  W&R
//
//  Created by vt on 15/12/23.
//  Copyright © 2015年 vt. All rights reserved.
//

#import "EventsCollection.h"
@implementation EventsCollection

NSMutableArray *eventTitle; //save eventTitle
NSMutableArray *eventNotes; //save eventNotes
NSMutableArray *eventTime;    //save NSString of date
NSMutableArray *eventDate;   //save NSdate
NSMutableArray *eventStatus; //save status
NSMutableArray *colors;
NSMutableArray *eventString;

NSInteger colorSelect;
NSInteger flag;
NSInteger reflag;
NSInteger currentPage;
BOOL animationFlag;




@end