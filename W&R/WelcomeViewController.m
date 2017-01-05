//
//  WelcomeViewController.m
//  W&R
//
//  Created by LIU KAIYANG on 16/2/27.
//  Copyright © 2016年 vt. All rights reserved.
//

#import "WelcomeViewController.h"
#import "EventsCollection.h"

@interface WelcomeViewController ()
@property (nonatomic,strong)UIButton *button1;
@property (nonatomic,strong)UIButton *button2;
@property (nonatomic,strong)UIButton *button3;
@property (nonatomic,strong)UIView *view1;
@property (nonatomic,strong)UIView *view2;
@property (nonatomic,strong)UIView *view3;
@property (nonatomic,strong)UIImageView *animationView1;
@property (nonatomic,strong)UIView *animationView2;
@property (nonatomic,strong)UIImageView *animationView3;
@property (nonatomic,strong)UIImageView *subview1;
@property (nonatomic,strong)UIView *subview2;

@property (nonatomic) BOOL animationFlag;
extern BOOL animationFlag;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animationFlag = YES;
    [self initViews];
}
-(void)initViews
{
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    _view1.backgroundColor = [UIColor clearColor];
    _view2.backgroundColor = [UIColor clearColor];
    _view3.backgroundColor = [UIColor clearColor];
    
    [_view1 setHidden:YES];
    [_view2 setHidden:YES];
    [_view3 setHidden:YES];
    
    [_view1 setUserInteractionEnabled:NO];
    [_view2 setUserInteractionEnabled:NO];
    [_view3 setUserInteractionEnabled:NO];
    
    UITextView *textView1 = [[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.1, self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.3)];
    UITextView *textView2 = [[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.1, self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.3)];
    UITextView *textView3 = [[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.1, self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.3)];
    
    textView1.text = @"初始界面为天气界面，可以了解今天的天气。向上滑动可以看详细的天气。";
    textView2.text = @"向右滑动可以进入卡片界面，在这里可以创建、编辑、删除事件卡片。每一张卡片都可以设定日期、颜色、以及是否完成的标记。";
    textView3.text = @"天气变幻莫测？不要害怕，app会根据卡片设定的日期，提前将天气信息告诉你，再也不用担心忘记查看天气了。";
    textView1.backgroundColor = [UIColor clearColor];
    textView2.backgroundColor = [UIColor clearColor];
    textView3.backgroundColor = [UIColor clearColor];
    
    textView1.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    textView2.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    textView3.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    
    [textView1 setTextColor:[UIColor whiteColor]];
    [textView2 setTextColor:[UIColor whiteColor]];
    [textView3 setTextColor:[UIColor whiteColor]];
    
    [_view1 addSubview:textView1];
    [_view2 addSubview:textView2];
    [_view3 addSubview:textView3];
    
    [self initAnimationViews];
    
    UILabel *view1Label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.06, self.view.frame.size.width * 0.8, 30)];
    view1Label.text = @"欢迎使用雨记，在这里你可以...";
    [view1Label setTextColor:[UIColor whiteColor]];
    view1Label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:37];
    view1Label.adjustsFontSizeToFitWidth = YES;
    
    self.button1 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.3, self.view.frame.size.height * 0.15, self.view.frame.size.width * 0.4, self.view.frame.size.width * 0.4)];
    self.button2 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.3, self.view.frame.size.height * 0.4, self.view.frame.size.width * 0.4, self.view.frame.size.width * 0.4)];
    self.button3 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.3, self.view.frame.size.height * 0.65, self.view.frame.size.width * 0.4, self.view.frame.size.width * 0.4)];
    
    _button1.layer.cornerRadius = self.view.frame.size.width * 0.2;
    _button2.layer.cornerRadius = self.view.frame.size.width * 0.2;
    _button3.layer.cornerRadius = self.view.frame.size.width * 0.2;
    
    _button1.tag = 11;
    _button2.tag = 21;
    _button3.tag = 31;
    
    _button1.backgroundColor = [UIColor colorWithRed:255/255.0 green:189/255.0 blue:45/255.0 alpha:1];
    _button2.backgroundColor = [UIColor colorWithRed:255/255.0 green:110/255.0 blue:116/255.0 alpha:1];
    _button3.backgroundColor = [UIColor colorWithRed:52/255.0 green:214/255.0 blue:178/255.0 alpha:1];
    
    [_button1 setTitle:@"查看天气" forState:UIControlStateNormal];
    [_button2 setTitle:@"记录事件" forState:UIControlStateNormal];
    [_button3 setTitle:@"安排计划" forState:UIControlStateNormal];
    
    [_button1 addTarget:self action:@selector(buttonAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [_button2 addTarget:self action:@selector(buttonAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [_button3 addTarget:self action:@selector(buttonAnimation:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *finishButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.9, self.view.frame.size.width * 0.6, 30)];
    [finishButton setBackgroundColor:[UIColor redColor]];
    finishButton.layer.cornerRadius = 15;
    [finishButton setTitle:@"我知道了" forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
    [self.view addSubview:view1Label];
    [self.view addSubview:_button1];
    [self.view addSubview:_button2];
    [self.view addSubview:_button3];
    [self.view addSubview:_view1];
    [self.view addSubview:_view2];
    [self.view addSubview:_view3];
    
    [self animation1:YES];
    [self animation2:YES];
}
-(void)back
{
    self.animationFlag = NO;
    [self animation1:NO];
    [self animation2:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)initAnimationViews
{
    self.animationView1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.45, self.view.frame.size.width * 0.6, self.view.frame.size.height * 0.5)];
    self.animationView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.45, self.view.frame.size.width * 0.6, self.view.frame.size.height * 0.5)];
    self.animationView3 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.45, self.view.frame.size.width * 0.6, self.view.frame.size.width * 0.6)];
    
    [self.animationView1 setImage:[UIImage imageNamed:@"welcome1.png"]];
    [self.animationView3 setImage:[UIImage imageNamed:@"APP图标.png"]];
    
    //self.animationView1.backgroundColor = [UIColor brownColor];
    self.animationView2.backgroundColor = [UIColor brownColor];
    self.animationView3.backgroundColor = [UIColor clearColor];
    
    self.animationView1.clipsToBounds = YES;
    self.animationView2.clipsToBounds = YES;
    self.animationView3.clipsToBounds = YES;
    
    self.animationView1.layer.cornerRadius = 5;
    self.animationView2.layer.cornerRadius = 5;
    self.animationView3.layer.cornerRadius = 5;
    
    _subview1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.animationView1.frame.size.width * 0.1, self.animationView1.frame.size.height, self.animationView1.frame.size.width * 0.8, self.animationView1.frame.size.width * 0.8)];
    //_subview1.backgroundColor = [UIColor whiteColor];
    _subview1.layer.cornerRadius = 10;
    _subview1.clipsToBounds = YES;
    [_subview1 setImage:[UIImage imageNamed:@"3"]];
    
    _subview2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.animationView2.frame.size.width * 2, self.animationView2.frame.size.height)];
    UIImageView *weatherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.animationView2.frame.size.width, self.animationView2.frame.size.height)];
    UIImageView *cardImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.animationView2.frame.size.width, 0, self.animationView2.frame.size.width, self.animationView2.frame.size.height)];
    
    [weatherImageView setImage:[UIImage imageNamed:@"welcome1.png"]];
    [cardImageView setImage:[UIImage imageNamed:@"welcome2.png"]];
//    weatherImageView.contentMode = UIViewContentModeScaleAspectFill;
//    cardImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_subview2 addSubview:weatherImageView];
    [_subview2 addSubview:cardImageView];
    
    [self.animationView1 addSubview:self.subview1];
    [self.animationView2 addSubview:self.subview2];
    
    [self.view1 addSubview:self.animationView1];
    [self.view2 addSubview:self.animationView2];
    [self.view3 addSubview:self.animationView3];
}
-(void)buttonAnimation:(UIButton *)sender
{
    NSString *title = [NSString stringWithString:sender.titleLabel.text];
    [self.button1 setHidden:YES];
    [self.button2 setHidden:YES];
    [self.button3 setHidden:YES];
    [sender setHidden:NO];
    [sender setTitle:@"" forState:UIControlStateNormal];
    if (sender.tag %10 == 1) {
        sender.tag = (sender.tag / 10) * 10 ;
        [UIView animateWithDuration:0.5f animations:^{
            sender.transform = CGAffineTransformMakeScale(10, 10);
        }completion:^(BOOL finished) {
            int x = (int)sender.tag / 10;
            switch (x) {
                case 1:
                    [self.view1 setHidden:NO];
                    break;
                case 2:
                    [self.view2 setHidden:NO];
                    break;
                case 3:
                    [self.view3 setHidden:NO];
                    break;
                default:
                    break;
            }
        }];
    }else if(sender.tag % 10 == 0){
        sender.tag = (sender.tag / 10) * 10 + 1;
        [self.view1 setHidden:YES];
        [self.view2 setHidden:YES];
        [self.view3 setHidden:YES];
        [UIView animateWithDuration:0.5f animations:^{
            sender.transform = CGAffineTransformMakeScale(1, 1);
        }completion:^(BOOL finished) {
            [sender setTitle:title forState:UIControlStateNormal];
            [self.button1 setHidden:NO];
            [self.button2 setHidden:NO];
            [self.button3 setHidden:NO];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)animation1:(BOOL)flag
{
    if (flag) {
        [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.subview1.frame = CGRectMake(self.animationView1.frame.size.width * 0.1, self.animationView1.frame.size.height * 0.1, self.animationView1.frame.size.width * 0.8, self.animationView1.frame.size.width * 0.8);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0f animations:^{
                self.subview1.frame = CGRectMake(self.animationView1.frame.size.width * 0.1, self.animationView1.frame.size.height , self.animationView1.frame.size.width * 0.8, self.animationView1.frame.size.width * 0.8);
            } completion:^(BOOL finished) {
                [self animation1:self.animationFlag];
            }];
        }];
    }
}

-(void)animation2:(BOOL)flag
{
    if (flag) {
        [UIView animateWithDuration:1.0f animations:^{
            self.subview2.frame = CGRectMake(-self.animationView2.frame.size.width, 0, self.animationView2.frame.size.width, self.animationView2.frame.size.height);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0f animations:^{
                self.subview2.frame = CGRectMake(0, 0, self.animationView2.frame.size.width, self.animationView2.frame.size.height);
            }completion:^(BOOL finished) {
                [self animation2:self.animationFlag];
            }];
        }];
    }
}
@end
