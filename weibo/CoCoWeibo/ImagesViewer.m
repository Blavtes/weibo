//
//  ImagesViewer.m
//  CoCoWeibo
//
//  Created by coobei on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImagesViewer.h"
#import "HHNetDataCacheManager.h"
#import <QuartzCore/QuartzCore.h>
@implementation ImagesViewer
@synthesize imges = _imges;
@synthesize delegate;
@synthesize imageUrl = _imageUrl;

-(void)close:(id)sender
{
    [delegate closeViewer:self];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        UIActivityIndicatorView * active = [[UIActivityIndicatorView alloc] init];
//        active.center = self.center;
//        [active startAnimating];
//        [self addSubview:active];
        
        self.imges = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imges.contentMode = UIViewContentModeScaleAspectFit;
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 460)];
        CALayer *imageslayer = self.imges.layer;
        imageslayer.anchorPoint = CGPointMake(0.5, 0.5);
        scrollView.bounces = NO;
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.maximumZoomScale = 2.5f;
        scrollView.minimumZoomScale = 0.5f;
        scrollView.canCancelContentTouches=NO;
        scrollView.contentSize = self.imges.image.size;
        
        [scrollView addSubview:self.imges];

        [self addSubview:scrollView];
        [scrollView release];
        scrollView = nil;
        
        //关闭
        UIButton *backBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"closebutton"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(self.bounds.size.width-30, self.bounds.size.height, 28, 28);
        [backBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:backBtn];
        [backBtn release];
        backBtn = nil;
      
    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView

{
    return self.imges; //返回ScrollView上添加的需要缩放的视图
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView

{
    //缩放操作中被调用
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale

{
    //缩放结束后被调用
}
-(void)dealloc
{
    self.imges = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.8f);
    CGContextFillRect(context, rect);
    // Drawing code
}

@end
