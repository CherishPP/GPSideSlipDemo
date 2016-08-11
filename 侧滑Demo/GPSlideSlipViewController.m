//
//  GPSlideSlipViewController.m
//  侧滑Demo
//
//  Created by MS on 15-9-10.
//  Copyright (c) 2015年 GaoPanpan. All rights reserved.
//

#import "GPSlideSlipViewController.h"

@interface GPSlideSlipViewController ()

@end

@implementation GPSlideSlipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)initLeftView:(UIViewController *)left andMainView:(UIViewController *)main andRightView:(UIViewController *)right andBackgroundImage:(UIImage *)image
{
    if (self == [super init]) {
        self.speedf = 0.5;
        leftControl = left;
        mainControl = main;
        rightControl = right;
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [imageView setImage:image];
        [self.view addSubview:imageView];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [main.view addGestureRecognizer:pan];
        
        _slideslipTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_slideslipTapGes setNumberOfTapsRequired:1];
        [main.view addGestureRecognizer:_slideslipTapGes];
        
        left.view.hidden = YES;
        right.view.hidden = YES;
        
        [self.view addSubview:left.view];
        [self.view addSubview:right.view];
        
        [self.view addSubview:main.view];
    }
    return self;
}

- (void)handlePan:(UIPanGestureRecognizer * )rect
{
    CGPoint point = [rect translationInView:self.view];
    
    scalef = (point.x * _speedf + scalef);
    
    if (rect.view.frame.origin.x >= 0) {
        rect.view.center = CGPointMake(rect.view.center.x + point.x * _speedf, rect.view.center.y);
        rect.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1-scalef/1000, 1-scalef/1000);
        
        [rect setTranslation:CGPointMake(0, 0) inView:self.view];
        
        rightControl.view.hidden = YES;
        leftControl.view.hidden = NO;
    }
    else
    {
        rect.view.center = CGPointMake(rect.view.center.x + point.x * _speedf, rect.view.center.y);
        rect.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1+scalef/1000, 1+scalef/1000);
        
        [rect setTranslation:CGPointMake(0, 0) inView:self.view];
        
        rightControl.view.hidden = YES;
        leftControl.view.hidden = NO;
    }
    
    if (rect.state == UIGestureRecognizerStateEnded) {
        if (scalef>140*_speedf) {
            [self showLeftView];
        }else if (scalef<-140*_speedf){
            [self showRightView];
        }else
        {
            [self showMainView];
            scalef = 0;
        }
    }
}

#pragma mark -修改视图位置-
- (void)showMainView
{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

- (void)showLeftView
{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width+60, [UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}
- (void)showRightView
{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    mainControl.view.center = CGPointMake(-60, [UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)handleTap:(UIGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        [UIView commitAnimations];
        scalef = 1;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
