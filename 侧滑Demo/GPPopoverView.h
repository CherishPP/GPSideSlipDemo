//
//  GPPopoverView.h
//  侧滑Demo
//
//  Created by MS on 15-9-10.
//  Copyright (c) 2015年 GaoPanpan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPPopoverView : UIView

@property (nonatomic,strong)UIColor * borderColor;

@property (nonatomic,copy)void(^selectRowAtIndex)(NSInteger index);

- (id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;

- (void)show;

- (void)dismiss;

- (void)dismiss:(BOOL)animated;

@end
