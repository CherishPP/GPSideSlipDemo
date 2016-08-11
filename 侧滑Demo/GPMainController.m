//
//  GPMainController.m
//  侧滑Demo
//
//  Created by MS on 15-9-10.
//  Copyright (c) 2015年 GaoPanpan. All rights reserved.
//

#import "GPMainController.h"
#import "GPPopoverView.h"
@interface GPMainController ()

@end

@implementation GPMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}

- (void)createView
{
    UIImageView * iamgeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"155422qorq8o0t0o8896bg"]];
    iamgeView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:iamgeView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    button.frame = CGRectMake(mainSize.width - 55, 20, 50, 50);
    [button addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
    iamgeView.userInteractionEnabled = YES;
    [iamgeView addSubview:button];
}
- (void)menuClick:(UIButton *)btn
{
    CGPoint point = CGPointMake(btn.frame.origin.x+btn.frame.size.width/2, btn.frame.origin.y +btn.frame.size.height);
    NSArray * titles = @[@"扫一扫",@"摇一摇",@"面对面"];
    GPPopoverView * pop = [[GPPopoverView alloc]initWithPoint:point titles:titles images:nil];
    [pop setSelectRowAtIndex:^(NSInteger index) {
        NSLog(@"选择了第%ld个",index);
    }];
    [pop show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
