//
//  GPSlideSlipViewController.h
//  侧滑Demo
//
//  Created by MS on 15-9-10.
//  Copyright (c) 2015年 GaoPanpan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPSlideSlipViewController : UIViewController
{
    UIViewController * leftControl;
    UIViewController * mainControl;
    UIViewController * rightControl;
    
    UIImageView * imgBackground;
    CGFloat scalef;
}
@property (nonatomic,assign)CGFloat speedf;
@property (strong)UITapGestureRecognizer * slideslipTapGes;

- (instancetype)initLeftView:(UIViewController *)left andMainView:(UIViewController *)main andRightView:(UIViewController *)right andBackgroundImage:(UIImage *)image;
- (void)showLeftView;
- (void)showMainView;
- (void)showRightView;
@end
