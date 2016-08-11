//
//  GPPopoverView.m
//  侧滑Demo
//
//  Created by MS on 15-9-10.
//  Copyright (c) 2015年 GaoPanpan. All rights reserved.
//

#import "GPPopoverView.h"

#define kArrowHeight 10.f

#define kArrowCurvature 6.f

#define SPACE 2.f

#define ROW_HEIGHT 44.f

#define TITLE_FONT [UIFont systemFontOfSize:15]

#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

@interface GPPopoverView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)NSArray * imageArray;
@property (nonatomic)CGPoint showPoint;
@property (nonatomic,strong)UIButton * handerView;

@end

@implementation GPPopoverView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.borderColor = RGB(200, 199, 204);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images
{
    if (self == [super init]) {
        self.showPoint = point;
        self.titleArray = titles;
        self.imageArray = images;
        
        self.frame = [self getViewFrame];
        
        [self addSubview:self.tableView];
    }
    return self;
}
- (CGRect)getViewFrame
{
    CGRect frame = CGRectZero;
    frame.size.height = [self.titleArray count] * ROW_HEIGHT + SPACE +kArrowHeight;
    for (NSString * title in self.titleArray) {
        NSAttributedString * attrStr = [[NSAttributedString alloc]initWithString:title];
        NSRange range = NSMakeRange(0,attrStr.length);
        NSDictionary * dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
        CGSize textSize = [title boundingRectWithSize:CGSizeMake(300, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        frame.size.width = textSize.width;
    }
    if ([self.titleArray count]==[self.imageArray count]) {
        frame.size.width = 10 + 25 + 10 + frame.size.width+40;
    }else
    {
        frame.size.width = 10 + frame.size.width + 40;
    }
    frame.origin.x = self.showPoint.x - frame.size.width/2;
    frame.origin.y = self.showPoint.y;
    
    if (frame.origin.x < 5) {
        frame.origin.x = 5;
    }
    if ((frame.origin.x + frame.size.width) > [UIScreen mainScreen].bounds.size.width - 5) {
        frame.origin.x = [UIScreen mainScreen].bounds.size.width - frame.size.width - 5;
    }
    return frame;
}

- (void)show
{
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.handerView.frame = [UIScreen mainScreen].bounds;
    self.handerView.backgroundColor = [UIColor clearColor];
    [self.handerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.handerView addSubview:self];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.handerView];
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    
    self.layer.anchorPoint = CGPointMake(arrowPoint.x/self.frame.size.width, arrowPoint.y/self.frame.size.height);
    self.frame = [self getViewFrame];
    
    self.alpha = 0.f;
    
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05, 1.05);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}
- (void)dismiss
{
    [self dismiss:YES];
}
- (void)dismiss:(BOOL)animated
{
    if (!animated) {
        [self.handerView removeFromSuperview];
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.handerView removeFromSuperview];
    }];
}
#pragma mark - UITableView

- (UITableView *)tableView
{
    if (_tableView != nil) {
        return _tableView;
    }
    CGRect rect = self.frame;
    rect.origin.x = SPACE;
    rect.origin.y = kArrowHeight + SPACE;
    rect.size.width -= SPACE * 2;
    rect.size.height -= (SPACE-kArrowHeight);
    
    self.tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alwaysBounceHorizontal = NO;
    _tableView.alwaysBounceVertical = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundView = [[UIView alloc]init];
    cell.backgroundView.backgroundColor = RGB(245, 245, 245);
    
    if ([_imageArray count] == [_titleArray count]) {
        cell.imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    }
    cell.textLabel.font = TITLE_FONT;
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return cell;
}
#pragma mark -UITableView delegate-

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectRowAtIndex
        ) {
        self.selectRowAtIndex(indexPath.row);
    }
    [self dismiss:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

- (void)drawRect:(CGRect)rect
{
    [self.borderColor set];
    CGRect frame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height - kArrowHeight);
    float xMin = CGRectGetMinX(frame);
    float yMin = CGRectGetMinY(frame);
    
    float xMax = CGRectGetMaxX(frame);
    float yMax = CGRectGetMaxY(frame);
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:self.handerView];
    UIBezierPath * popoverPath = [UIBezierPath bezierPath];
    [popoverPath moveToPoint:CGPointMake(xMin, yMin)];
    
    /**********向上的箭头*******/
    [popoverPath addLineToPoint:CGPointMake(arrowPoint.x - kArrowHeight, yMin)];
    [popoverPath addCurveToPoint:arrowPoint controlPoint1:CGPointMake(arrowPoint.x - kArrowHeight + kArrowCurvature, yMin) controlPoint2:arrowPoint];
    [popoverPath addCurveToPoint:CGPointMake(arrowPoint.x + kArrowHeight, yMin) controlPoint1:arrowPoint controlPoint2:CGPointMake(arrowPoint.x + kArrowHeight - kArrowCurvature, yMin)];
    
    [popoverPath addLineToPoint:CGPointMake(xMax, yMin)];
    [popoverPath addLineToPoint:CGPointMake(xMax, yMax)];
    [popoverPath addLineToPoint:CGPointMake(xMin, yMax)];
    
    [RGB(245, 245, 245) setFill];
    [popoverPath fill];
    [popoverPath closePath];
    [popoverPath stroke];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
