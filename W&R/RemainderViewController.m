//
//  ViewController.m
//  W&R
//
//  Created by vt on 15/12/22.
//  Copyright © 2015年 vt. All rights reserved.
//

#import "RemainderViewController.h"
#import "SearchInformation.h"
#import "SSStackedPageView.h"
#import "UIColor+CatColors.h"
#import "Functions.h"
#import "WeatherNotification.h"
#import "CardTextView.h"
#import "WeatherController.h"


@interface RemainderViewController ()<SSStackedViewDelegate>

@property SearchInformation *SIModel;
@property NSMutableArray *database;
@property Functions *FUNC;
@property (strong,nonatomic)  SSStackedPageView *stackView;
@property (strong, nonatomic)  UIImageView *backGroundImageView;
@property (strong, nonatomic)  UIButton *addButton;
@property (strong, nonatomic)  UIButton *reEditButton;
@property (strong, nonatomic)  UIButton *delButton;
@property (strong, nonatomic)  UISwitch *statusSwitch;
@property (strong, nonatomic)  UIView *cardMenuView;



@property NSMutableArray *views;
@property NSMutableArray *userDefaultArray;
extern NSInteger currentPage;    //当前点击的page
@property NSInteger currentEvent;   //当前点击的page的内容的数组位置
@property UIViewController *textViewController;
@property UIViewController *firstCardViewController;
@property CGFloat screenWidth;
@property CGFloat screenHeight;
@property NSMutableArray *cardsView;

extern NSMutableArray *eventTitle;
extern NSMutableArray *eventNotes;
extern NSMutableArray *eventTime;
extern NSMutableArray *eventStatus;
extern NSMutableArray *colors;
extern NSMutableArray *eventDate;
extern NSMutableArray *eventString;


//@property NSInteger viewsCount;

extern NSInteger colorSelect;
extern NSInteger flag;
extern NSInteger reflag;


@end


@implementation RemainderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self.addButton setHidden:NO];
    
    if(flag)
    {
        int count = (int)eventTitle.count;
        CardTextView *cardView = [[CardTextView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) andTitle:eventTitle[count -1] andNote:eventNotes[count - 1] andTime:eventDate[count - 1]];

        [self.FUNC saveDataByUserDefault];
        
        switch (colorSelect) {
            case 0:
                cardView.backgroundColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/225.0 alpha:100];
                break;
            case 1:
                cardView.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:102/255.0 alpha:100];
                break;
            case 2:
                cardView.backgroundColor = [UIColor colorWithRed:80/255.0 green:170/255.0 blue:51/255.0 alpha:100];
                break;
            case 3:
                cardView.backgroundColor = [UIColor colorWithRed:0/255.0 green:128/255.0 blue:255/255.0 alpha:100];
                break;
            case 4:
                cardView.backgroundColor = [UIColor colorWithRed:0/255.0 green:128/255.0 blue:64/255.0 alpha:100];
                break;
            case 5:
                cardView.backgroundColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue                                                                       :179/255.0 alpha:100];
                break;
            case 6:
                cardView.backgroundColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue                                                                       :128/255.0 alpha:100];
                break;
            default:
                break;
        }
        if (reflag) {
            [self recreateCards];
            [self hideCardMenu];
        }else
        {
        [self.views addObject:cardView];
        [self.stackView layoutSubviews];
        NSLog(@"addd");
        }
       
    }
}

-(void)showCardMenu
{

    
    NSInteger colorInt = [[colors objectAtIndex:currentPage] integerValue];
    switch (colorInt) {
        case 0:
            self.cardMenuView.backgroundColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/225.0 alpha:100];
            break;
        case 1:
            self.cardMenuView.backgroundColor =[UIColor colorWithRed:255/255.0 green:204/255.0 blue:102/255.0 alpha:100];
            break;
        case 2:
            self.cardMenuView.backgroundColor = [UIColor colorWithRed:80/255.0 green:170/255.0 blue:51/255.0 alpha:100];
            break;
        case 3:
            self.cardMenuView.backgroundColor = [UIColor colorWithRed:0/255.0 green:128/255.0 blue:255/255.0 alpha:100];
            break;
        case 4:
            self.cardMenuView.backgroundColor = [UIColor colorWithRed:0/255.0 green:128/255.0 blue:64/255.0 alpha:100];
            break;
        case 5:
            self.cardMenuView.backgroundColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue                                                                       :179/255.0 alpha:100];
            break;
        case 6:
            self.cardMenuView.backgroundColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue                                                                       :128/255.0 alpha:100];
            break;
        default:
            break;
    }
    [self.cardMenuView setHidden:NO];
    [UIView animateWithDuration:0.4f animations:^{
        self.cardMenuView.frame = CGRectMake(0.05 * self.view.frame.size.width, -5, 0.9 * self.view.frame.size.width, 0.2 * self.view.frame.size.height);
        [self.addButton setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [self.addButton setHidden:YES];
    }];
    
    if (currentPage < eventStatus.count) {
        if ([eventStatus[currentPage] isEqualToString:@"YES"]) {
            [self.statusSwitch setOn:YES];
        }else
            [self.statusSwitch setOn:NO];
    }
    NSLog(@"show menu");
}
-(void)hideCardMenu
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    self.cardMenuView.frame = CGRectMake(0.05 * self.view.frame.size.width, -5, 0.9 * self.view.frame.size.width, -0.2 * self.view.frame.size.height);
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:0.25f target:self selector:@selector(hiden) userInfo:nil repeats:NO];
    NSLog(@"hide menu");
}
-(void)hiden
{
    [self.addButton setHidden:NO];
    [UIView animateWithDuration:0.2f animations:^{
        [self.addButton setAlpha:1.0f];
    } completion:^(BOOL finished) {
    }];
}
-(void)initCardMenu
{

    [self.delButton setTitle:@"删除事件" forState:normal];
    self.delButton.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:100];
    self.delButton.layer.cornerRadius = 5;
                [self.delButton addTarget:self action:@selector(delPages) forControlEvents:UIControlEventTouchUpInside];
    [self.reEditButton setTitle:@"编辑事件" forState:normal];
    self.reEditButton.backgroundColor = [UIColor colorWithRed:1 green:128/255.0 blue:0/255.0 alpha:100];
    self.reEditButton.layer.cornerRadius = 5;
    [self.reEditButton addTarget:self action:@selector(rePages) forControlEvents:UIControlEventTouchUpInside];
    
//    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight
//                                    ];
//    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [blurView setEffect:blurEffect];
    [self.cardMenuView setHidden:YES];
    
}
-(void)recreateCards
{
    int count = (int)self.views.count;
    
    for (int i = 0; i < count; i ++) {
        [self.views removeObjectAtIndex:0];
        [self.stackView removePageAtIndex:0];
        [self.stackView layoutSubviews];
    }
    
    for (int i = 0; i < eventTitle.count; i++) {
        CardTextView *view = [[CardTextView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) andTitle:eventTitle[i] andNote:eventNotes[i] andTime:eventDate[i]];
        NSInteger colorInt = [[colors objectAtIndex:i] integerValue];
        switch (colorInt) {
            case 0:
                view.backgroundColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/225.0 alpha:100];
                break;
            case 1:
                view.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:102/255.0 alpha:100];
                break;
            case 2:
                view.backgroundColor = [UIColor colorWithRed:80/255.0 green:170/255.0 blue:51/255.0 alpha:100];
                break;
            case 3:
                view.backgroundColor = [UIColor colorWithRed:0/255.0 green:128/255.0 blue:255/255.0 alpha:100];
                break;
            case 4:
                view.backgroundColor = [UIColor colorWithRed:0/255.0 green:128/255.0 blue:64/255.0 alpha:100];
                break;
            case 5:
                view.backgroundColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue                                                                       :179/255.0 alpha:100];
                break;
            case 6:
                view.backgroundColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue                                                                       :128/255.0 alpha:100];
                break;
            default:
                break;
        }
        [self.views addObject:view];
    }
    
    
    reflag = 0;
    [self.stackView layoutSubviews];
    self.stackView.theScrollView.scrollEnabled = YES;

}
-(void)reCard
{
    self.views = [[NSMutableArray alloc]init];
    self.FUNC = [[Functions alloc]init];
    eventTitle = [[NSMutableArray alloc]init];
    eventNotes = [[NSMutableArray alloc]init];
    eventStatus = [[NSMutableArray alloc]init];
    eventTime = [[NSMutableArray alloc]init];
    colors = [[NSMutableArray alloc]init];
    eventDate = [[NSMutableArray alloc]init];
    eventString = [[NSMutableArray alloc]init];
    self.cardsView = [[NSMutableArray alloc]init];
    
    
    flag = 0;
    reflag = 0;
    self.screenHeight = self.view.frame.size.height;
    self.screenWidth = self.view.frame.size.width;
    self.addButton.layer.cornerRadius = 21;
    self.stackView.delegate = self;
    self.stackView.pagesHaveShadows = YES;
    self.userDefaultArray = [[NSMutableArray alloc]init];
    
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self.FUNC getDataFromUserDefault]];
    
    if (array.count!=0) {
        NSArray *title = [NSArray arrayWithArray:[array objectAtIndex:0]];
        NSArray *note = [NSArray arrayWithArray:[array objectAtIndex:1]];
        NSArray *status = [NSArray arrayWithArray:[array objectAtIndex:2]];
        NSArray *time = [NSArray arrayWithArray:[array objectAtIndex:3]];
        NSArray *color = [NSArray arrayWithArray:[array objectAtIndex:4]];
        NSArray *date = [NSArray arrayWithArray:[array objectAtIndex:5]];
        NSArray *string = [NSArray arrayWithArray:[array objectAtIndex:6]];
        
        for (int i =0; i<title.count; i++) {
            [eventTitle addObject:[title objectAtIndex:i]];
            [eventNotes addObject:[note objectAtIndex:i]];
            [eventStatus addObject:[status objectAtIndex:i]];
            [colors addObject:[color objectAtIndex:i]];
            [eventTime addObject:[time objectAtIndex:i]];
            [eventDate addObject:[date objectAtIndex:i]];
            [eventString addObject:[string objectAtIndex:i]];
            
            
            CardTextView *view = [[CardTextView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) andTitle:eventTitle[i] andNote:eventNotes[i] andTime:eventDate[i]];
            if ([eventStatus[i] isEqualToString:@"YES"]) {
                [view finish];
            }else if ([eventStatus[i] isEqualToString:@"NO"])
            {
                [view unfinish];
            }
            [self.views addObject:view];
            NSInteger colorInt = [[color objectAtIndex:i] integerValue];
            switch (colorInt) {
                case 0:
                    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/225.0 alpha:100];
                    break;
                case 1:
                    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:102/255.0 alpha:100];
                    break;
                case 2:
                    view.backgroundColor = [UIColor colorWithRed:80/255.0 green:170/255.0 blue:51/255.0 alpha:100];
                    break;
                case 3:
                    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:128/255.0 blue:255/255.0 alpha:100];
                    break;
                case 4:
                    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:128/255.0 blue:64/255.0 alpha:100];
                    break;
                case 5:
                    view.backgroundColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue                                                                       :179/255.0 alpha:100];
                    break;
                case 6:
                    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue                                                                       :128/255.0 alpha:100];
                    break;
                default:
                    break;
            }
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initCardMenu];
    [self reCard];
//    WeatherController *weatherVC = [self.storyboard instantiateViewControllerWithIdentifier:@"weather"];
//    weatherVC.helpDelegate = self;
    }
//-(void)makeHelpCards
//{
//    NSArray *titleArray = [[NSArray alloc]initWithObjects:@"1.获取最近的天气",@"2.用卡片管理事件",@"3.根据天气来安排你的日程",nil];
//    
//    NSArray *noteArray = [[NSArray alloc]initWithObjects:@"向左滑动可以转到天气界面，了解最近的天气情况。",@"当前界面下可以创建、编辑、删除事件卡片。每一张卡片都可以设定日期、颜色、以及是否完成的标记。",@"天气变幻莫测？不要害怕，app会根据卡片设定的日期，提前将天气信息告诉你，再也不用担心忘记查看天气了。", nil];
//    for (int i = 0; i < 3; i ++) {
//        CardTextView *card = [[CardTextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andTitle:titleArray[i] andNote:noteArray[i] andTime:@"70 - 1 -1"];
//        [self.views addObject:card];
//    }
//    [self.stackView layoutSubviews];
//
//}
-(void)initUI
{
    self.backGroundImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.backGroundImageView.image = [UIImage imageNamed:@"background2.jpg"];
    self.backGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backGroundImageView];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    
    
    self.stackView = [[SSStackedPageView alloc]init];
    self.addButton = [[UIButton alloc]init];
    self.delButton = [[UIButton alloc]init];
    self.reEditButton = [[UIButton alloc]init];
    self.statusSwitch = [[UISwitch alloc]init];
    self.cardMenuView = [[UIView alloc]init];
//    self.cardMenuView.backgroundColor = [UIColor purpleColor];
//    self.stackView.backgroundColor = [UIColor purpleColor];
    
    self.stackView.frame = CGRectMake(0.0 * width, 0.2 * height, 1.0 * width, 0.8 * height);
    self.addButton.frame = CGRectMake(20, 28, width - 40, 42);
    self.addButton.backgroundColor = [UIColor colorWithRed:62 / 255.0 green:213 / 255.0 blue:255 / 255.0 alpha:1];
    [self.addButton setTitle:@"新建事件卡片" forState:normal] ;
    self.addButton.titleLabel.textColor = [UIColor whiteColor];
    self.addButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:27];
    [self.addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    self.cardMenuView.frame = CGRectMake(0.05 * width, 0, 0.9 * width, -0.2 * height);
    self.cardMenuView.layer.cornerRadius = 5;
    
    
    [self.cardMenuView.layer setShadowOffset:CGSizeMake(1, 1)];
    [self.cardMenuView.layer setShadowRadius:3];
    [self.cardMenuView.layer setShadowOpacity:0.5];
    [self.cardMenuView.layer setShadowColor:[UIColor blackColor].CGColor];
    
    CGFloat menuWidth = self.cardMenuView.frame.size.width;
    CGFloat menuHeight = self.cardMenuView.frame.size.height;
    
    self.reEditButton.frame = CGRectMake(0.05 * menuWidth, 0.2 * menuHeight, 0.6 * menuWidth, 0.3 * menuHeight);
    self.delButton.frame = CGRectMake(0.05 * menuWidth, 0.6 * menuHeight, 0.9 * menuWidth, 0.3 * menuHeight);
    self.statusSwitch.frame = CGRectMake(0.7 * menuWidth, 0.2 * menuHeight, self.statusSwitch.frame.size.width, self.statusSwitch.frame.size.height);
    [self.statusSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];

    
    [self.cardMenuView addSubview:self.reEditButton];
    [self.cardMenuView addSubview:self.statusSwitch];
    [self.cardMenuView addSubview:self.delButton];
    
    [self.view addSubview:self.stackView];
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.cardMenuView];
}
- (IBAction)add:(id)sender {
    reflag = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *newViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"newEvent"];
        [self presentViewController:newViewController animated:YES completion:nil];
    });
}
- (void)switchValueChange:(UISwitch *)sender {
    if (![sender isOn]) {
        [self.views[currentPage] unfinish];
        eventStatus[currentPage] = @"NO";
    }else
    {
        [self.views[currentPage] finish];
        eventStatus[currentPage] = @"YES";
    }
    [self.FUNC saveDataByUserDefault];
}
-(void)showDelAlert
{
    NSString *title = NSLocalizedString(@"删除", nil);
    NSString *message = NSLocalizedString(@"是否要删除此卡片？", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"是", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"否", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self.views removeObjectAtIndex:currentPage];
//        [self.stackView removePageAtIndex:currentPage];
//        [self.stackView layoutSubviews];
        
        //取消闹钟
        [WeatherNotification cancelNotesNotificationWithkey:[eventDate objectAtIndex:_currentEvent]];

        [eventTitle removeObjectAtIndex:currentPage];
        [eventNotes removeObjectAtIndex:currentPage];
        [eventStatus removeObjectAtIndex:currentPage];
        [colors removeObjectAtIndex:currentPage];
        [eventTime removeObjectAtIndex:currentPage];
        [eventDate removeObjectAtIndex:currentPage];
        [eventString removeObjectAtIndex:currentPage];
        
        [self hideCardMenu];
        
        self.currentEvent = 0;
        [self.FUNC saveDataByUserDefault];
        
        [self recreateCards];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)delPages
{
    [self showDelAlert];
}

- (void)rePages {
    reflag = 1;
        UIViewController *newViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"newEvent"];
        [self presentViewController:newViewController animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// stack-----------------------
- (UIView *)stackView:(SSStackedPageView *)stackView pageForIndex:(NSInteger)index
{
    UIView *thisView = [stackView dequeueReusablePage];
    if (!thisView) {
        thisView = [self.views objectAtIndex:index];
        thisView.frame = CGRectMake(0.f, 0.f, 200.f, 200.f);
        thisView.layer.cornerRadius = 5;
        thisView.layer.masksToBounds = YES;
    }
    return thisView;
}

- (NSInteger)numberOfPagesForStackView:(SSStackedPageView *)stackView
{
    return [self.views count];
}

- (void)stackView:(SSStackedPageView *)stackView selectedPageAtIndex:(NSInteger) index
{
    NSLog(@"selected page: %i",(int)index);
    currentPage = (int)index;
}

@end
