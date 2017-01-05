//
//  NewEventViewController.m
//  W&R
//
//  Created by vt on 15/12/22.
//  Copyright © 2015年 vt. All rights reserved.
//

#import "NewEventViewController.h"
#import "SearchInformation.h"
#import "WeatherNotification.h"
#import "myButton.h"


@interface NewEventViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *eventTitleInputField;
@property (weak, nonatomic) IBOutlet UITextView *eventTextView;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor1;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor2;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor3;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor4;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor5;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor6;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor7;

@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *pickerBackGround;

@property (nonatomic) BOOL titleIsTouched;
@property (nonatomic) BOOL textViewIsTouched;

@property (strong,nonatomic) myButton *titleButton;
@property (strong,nonatomic) myButton *textViewButton;

@property SearchInformation *SI;
@property NSArray *month;
@property NSArray *day;
@property NSInteger isFinished;
@property NSArray *tempDataBase;

@property float time;



extern NSMutableArray *eventTitle;
extern NSMutableArray *eventNotes;
extern NSMutableArray *eventTime;
extern NSMutableArray *eventStatus;
extern NSMutableArray *eventDate;
extern NSMutableArray *eventString;
extern NSMutableArray *colors;

extern NSInteger colorSelect;
extern NSInteger flag;
extern NSInteger reflag;
extern NSInteger selectedPage;
extern NSInteger currentPage;

@end
@implementation NewEventViewController
-(void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:YES];
//    [self inputEventNote:self.textViewButton];
//    [self inputEventNote:self.textViewButton];
//    [self inputEventTitle:self.titleButton];
//    [self inputEventTitle:self.titleButton];
//    NSLog(@"textView's width is: %f",self.eventTextView.frame.size.width);
//    NSLog(@"textView's height is: %f",self.eventTextView.frame.size.height);
//    NSLog(@"textField's width is: %f",self.eventTitleInputField.frame.size.width);
//    NSLog(@"textField's height is: %f",self.eventTitleInputField.frame.size.height);
    self.titleButton.frame = CGRectMake(self.eventTitleInputField.frame.origin.x, self.eventTitleInputField.frame.origin.y, self.eventTitleInputField.frame.size.width, self.eventTitleInputField.frame.size.height);
    
    self.textViewButton.frame = CGRectMake(self.eventTextView.frame.origin.x, self.eventTextView.frame.origin.y,self.eventTextView.frame.size.width, self.eventTextView.frame.size.height);
    self.time = 0.3f;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitButton];
    

    self.titleIsTouched = NO;
    self.textViewIsTouched = NO;
    
    self.pickerBackGround.layer.cornerRadius = 6;
    self.eventTextView.layer.cornerRadius = 5;
    
    self.titleButton = [[myButton alloc]initWithFrame:CGRectMake(self.eventTitleInputField.frame.origin.x, self.eventTitleInputField.frame.origin.y, self.eventTitleInputField.frame.size.width, self.eventTitleInputField.frame.size.height)];
    self.titleButton.backgroundColor = [UIColor colorWithRed:62/255.0 green:213/255.0 blue:255/255.0 alpha:1];
    self.textViewButton = [[myButton alloc]initWithFrame:CGRectMake(self.eventTextView.frame.origin.x, self.eventTextView.frame.origin.y,self.eventTextView.frame.size.width, self.eventTextView.frame.size.height)];
    self.textViewButton.backgroundColor = [UIColor colorWithRed:62/255.0 green:213/255.0 blue:255/255.0 alpha:1];
    [self.titleButton addTarget:self action:@selector(inputEventTitle:) forControlEvents:UIControlEventTouchUpInside];
    [self.textViewButton addTarget:self action:@selector(inputEventNote:) forControlEvents:UIControlEventTouchUpInside];
    [self.textViewButton setTitle:@"事件正文" forState:UIControlStateNormal];
    [self.titleButton setTitle:@"事件标题" forState:UIControlStateNormal];
    [self.titleButton setAlpha:0.7f];
    [self.textViewButton setAlpha:0.7f];
    self.titleButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    self.textViewButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    [self.view addSubview:self.titleButton];
    [self.view addSubview:self.textViewButton];
    
    self.tempDataBase = [[NSArray alloc]initWithObjects:@"篮球",@"羽毛球",@"看电影",@"看球",@"爬山", nil];
    self.SI = [[SearchInformation alloc]init];
 
    if (reflag == 1) {
        self.eventTitleInputField.text = [eventTitle objectAtIndex:currentPage];
        self.eventTextView.text = [eventNotes objectAtIndex:currentPage];
        [self.textViewButton setAlpha:0.4f];
        [self.titleButton setAlpha:0.4f];
    }

    colorSelect = 999;
    flag = 1;
    
    self.eventTitleInputField.delegate = self;
}


- (void)inputEventNote:(myButton *)sender {
    NSLog(@"textView's width is: %f",self.eventTextView.frame.size.width);
    NSLog(@"textView's height is: %f",self.eventTextView.frame.size.height);
    if (!self.textViewIsTouched) {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        if (self.titleIsTouched) {
            [self inputEventTitle:self.titleButton];
        }
        [UIView animateWithDuration:self.time animations:^{
            sender.frame = CGRectMake(self.eventTextView.frame.origin.x, self.eventTextView.frame.origin.y - 30, self.eventTextView.frame.size.width, 30);
            sender.layer.cornerRadius = sender.frame.size.height * 0.1;
            [sender setAlpha:1.0f];
        } completion:^(BOOL finished) {
            [self.eventTextView becomeFirstResponder];
        }];
        self.textViewIsTouched = YES;
    }else
    {
        [sender setTitle:@"事件正文" forState:UIControlStateNormal];
        [UIView animateWithDuration:self.time animations:^{
            sender.frame = CGRectMake(self.eventTextView.frame.origin.x, self.eventTextView.frame.origin.y, self.eventTextView.frame.size.width, self.eventTextView.frame.size.height);
            sender.layer.cornerRadius = sender.frame.size.height * 0.1;
            [sender setAlpha:0.4f];
            if (colorSelect != 999 && self.eventTitleInputField.text.length != 0 && self.eventTextView.text.length != 0) {
                [self.finishButton setTitle:@"完成" forState:normal];
                [self.finishButton setBackgroundColor:[UIColor colorWithRed:65/255.0  green:177/255.0 blue:255/255.0 alpha:1]];
            }else
            {
                [self.finishButton setTitle:@"取消" forState:normal];
                [self.finishButton setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
                self.isFinished = 0;
            }
        } completion:^(BOOL finished) {
            [self.eventTextView resignFirstResponder];
        }];
        self.textViewIsTouched = NO;
    }
}
- (void)inputEventTitle:(myButton *)sender {
    if (!self.titleIsTouched) {
        if (self.textViewIsTouched) {
            [self inputEventNote:self.textViewButton];
        }
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        [UIView animateWithDuration:self.time animations:^{
            sender.frame = CGRectMake(self.eventTitleInputField.frame.origin.x, self.eventTitleInputField.frame.origin.y - 30, self.eventTitleInputField.frame.size.width, self.eventTitleInputField.frame.size.height);
            [sender setAlpha:1.0f];
        } completion:^(BOOL finished) {
            [self.eventTitleInputField becomeFirstResponder];
        }];
        self.titleIsTouched = YES;
    }else
    {
        [sender setTitle:@"事件标题" forState:UIControlStateNormal];
        [UIView animateWithDuration:self.time animations:^{
            sender.frame = CGRectMake(self.eventTitleInputField.frame.origin.x, self.eventTitleInputField.frame.origin.y, self.eventTitleInputField.frame.size.width, self.eventTitleInputField.frame.size.height);
            [sender setAlpha:0.4f];
            if (colorSelect != 999 && self.eventTitleInputField.text.length != 0 && self.eventTextView.text.length != 0) {
                [self.finishButton setTitle:@"完成" forState:normal];
                [self.finishButton setBackgroundColor:[UIColor colorWithRed:65/255.0  green:177/255.0 blue:255/255.0 alpha:1]];
            }else
            {
                [self.finishButton setTitle:@"取消" forState:normal];
                [self.finishButton setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
                self.isFinished = 0;
            }
        } completion:^(BOOL finished) {
            [self.eventTitleInputField resignFirstResponder];
        }];
        self.titleIsTouched = NO;
    }
}
- (IBAction)isTitle:(id)sender {
    if (colorSelect != 999 && self.eventTitleInputField.text != nil) {
        self.isFinished = 1;
    }else
        self.isFinished = 0;
}
-(void)InitButton
{
    self.buttonColor1.layer.cornerRadius = 15.0f;
    self.buttonColor2.layer.cornerRadius = 15.0f;
    self.buttonColor3.layer.cornerRadius = 15.0f;
    self.buttonColor4.layer.cornerRadius = 15.0f;
    self.buttonColor5.layer.cornerRadius = 15.0f;
    self.buttonColor6.layer.cornerRadius = 15.0f;
    self.buttonColor7.layer.cornerRadius = 15.0f;
    self.finishButton.layer.cornerRadius = 21.0f;
    
    [self.finishButton setTitle:@"取消" forState:normal];
    [self.finishButton setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
    
    self.buttonColor1.tag = 0;
    self.buttonColor2.tag = 1;
    self.buttonColor3.tag = 2;
    self.buttonColor4.tag = 3;
    self.buttonColor5.tag = 4;
    self.buttonColor6.tag = 5;
    self.buttonColor7.tag = 6;
    
}
- (IBAction)selectColor:(UIButton *)sender {
    colorSelect = sender.tag;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 0.9, 0.9, 0.9, 1 });
    // 设置边框颜色
    sender.layer.borderColor = borderColorRef;
    if (sender.layer.borderWidth == 0) {
        self.buttonColor1.layer.borderWidth = 0;
        self.buttonColor2.layer.borderWidth = 0;
        self.buttonColor3.layer.borderWidth = 0;
        self.buttonColor4.layer.borderWidth = 0;
        self.buttonColor5.layer.borderWidth = 0;
        self.buttonColor6.layer.borderWidth = 0;
        self.buttonColor7.layer.borderWidth = 0;
        sender.layer.borderWidth = 2.0f;
    }else if (sender.layer.borderWidth == 2.0f)
    {
        sender.layer.borderWidth = 0;
    }
    
    if (colorSelect != 999 && self.eventTitleInputField.text.length != 0 && self.eventTextView.text.length != 0) {
        self.isFinished = 1;
        [self.finishButton setTitle:@"完成" forState:normal];
        [self.finishButton setBackgroundColor:[UIColor colorWithRed:65/255.0  green:177/255.0 blue:255/255.0 alpha:1]];
    }else
    {
        self.isFinished = 0;
    }
    

}
- (IBAction)finish:(id)sender {
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    /////
    NSDate *select = [self.datePicker date];
    /////
    [dateformatter setDateFormat: @"yyyy年MM月dd日"];
    NSString *date = [dateformatter stringFromDate:select];
    NSLog(@"%@------",date);
    NSMutableArray *reslut;
    NSMutableString *display;
    display=[[NSMutableString alloc]init];
    reslut=[[NSMutableArray alloc]initWithArray:[SearchInformation searshForActives:self.tempDataBase andInputedString:self.eventTextView.text]];
    
    for (int i=0; i<[reslut count]; i++) {
       
        [display appendString:[reslut objectAtIndex:i]];
            
    }
    NSString *colorString = [NSString stringWithFormat:@"%ld",(long)colorSelect];
    //添加闹钟
    [WeatherNotification locationNotificationOfNotesTitle:_eventTitleInputField.text notesDate:select];
    
    if (self.isFinished&&reflag == 0) {
        [eventTitle  addObject:self.eventTitleInputField.text];
        [eventNotes addObject:self.eventTextView.text];
        [eventStatus addObject:@"NO"];
        [eventTime addObject:date];
        [eventDate addObject:select];
        [eventString addObject:display];
        [colors addObject:colorString];
        
        NSLog(@"%@", date);
        flag = 1;
        NSLog(@"new");
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        if (self.isFinished&&reflag == 1) {
          
            [eventTitle replaceObjectAtIndex:currentPage withObject:self.eventTitleInputField.text];
            [eventNotes replaceObjectAtIndex:currentPage withObject:self.eventTextView.text];
            [eventDate replaceObjectAtIndex:currentPage withObject:select];
            [eventTime replaceObjectAtIndex:currentPage withObject:date];
            [eventString replaceObjectAtIndex:currentPage withObject:display];
            [colors replaceObjectAtIndex:currentPage withObject:colorString];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        flag = 0;
        NSLog(@"UnNew");
    }
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)exitInput:(id)sender {
    [sender resignFirstResponder];
}


@end
