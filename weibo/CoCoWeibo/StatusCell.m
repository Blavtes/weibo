    //
//  TimeLineTableCell.m
//  TimeLineVIew
//
//  Created by coobei on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StatusCell.h"
#import "JSTwitterCoreTextView.h"
#import "AHMarkedHyperlink.h"
#import "User.h"
#import "Status.h"
#import "UIImageView+WebCache.h"
#import "PhotoViewer.h"
#import <QuartzCore/QuartzCore.h>
@implementation StatusCell
@synthesize status;
@synthesize delegate;
@synthesize weiboView ;
@synthesize repostView ;
@synthesize weiboContent;
@synthesize repostContent;
@synthesize weiboImg;
@synthesize repostImg;
@synthesize cellHeight;
@synthesize bg;
@synthesize repostBg;

typedef enum {
    WeiboImages,
    RepostImages
}_viewTag;


//线性渐变
-(void) drawLinearGradient:(CGContextRef )context Rect:(CGRect) rect startColor:(CGColorRef) startColor
                  endColor:(CGColorRef) endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor, (id)endColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, 
                                                        (CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

-(void)drawRect:(CGRect)rect
{
    rect =  CGRectMake(5, 0, rect.size.width-10, rect.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context,50/255.0f, 56/255.0f, 65/255.0f, 1.0f);
    CGContextFillRect(context, rect);
    
//    //阴影
//    CGContextSaveGState(context);
//    CGColorRef shadowColor  = [UIColor blackColor].CGColor;
//    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 5.0, shadowColor);
//    CGContextFillRect(context, rect);
//    CGContextRestoreGState(context);
    //画线
    
    CGContextSetLineWidth(context, 4);
    
    if (repostView.hidden == NO) {
        
        //画repost区域
        CGRect rect= CGRectMake(12, repostView.frame.origin.y, repostView.frame.size.width-4, repostView.frame.size.height-4);
        CGContextSetRGBFillColor(context,42/255.0f, 47/255.0f, 54/255.0f, 1.0f);
        CGContextFillRect(context, rect);
        
        CGContextSetRGBStrokeColor(context, 0.3f, 0.8f, 0.9f, 1.0f);
        CGContextMoveToPoint(context, 12, repostView.frame.origin.y);
        CGContextAddLineToPoint(context, 12, repostView.frame.size.height + repostView.frame.origin.y - 4);
        CGContextStrokePath(context);
    }
      
//    UIImage *img = [[UIImage imageNamed:@"cellbg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 8, 16, 8)];
//    [img drawInRect:rect]; 
}

#pragma mark - 自定义视图

-(JSTwitterCoreTextView*)GetJSTwitterCoreTextView
{   

        JSTwitterCoreTextView *coreTextView = [[JSTwitterCoreTextView alloc]initWithFrame:CGRectZero];
        [coreTextView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [coreTextView setDelegate:self];
        [coreTextView setFontName:FONT];
        [coreTextView setFontSize:FONT_SIZE];
        //[_JSRetitterContentTF setHighlightColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
        //[_JSRetitterContentTF setBackgroundColor:[UIColor clearColor]];
        [coreTextView setPaddingTop:PADDING_TOP];
        [coreTextView setPaddingLeft:PADDING_LEFT];
        //        _JSRetitterContentTF.userInteractionEnabled = NO;
        coreTextView.exclusiveTouch = YES;
        coreTextView.userInteractionEnabled = NO;
        coreTextView.backgroundColor = [UIColor whiteColor];
        coreTextView.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
        coreTextView.linkColor = [UIColor colorWithRed:96/255.0 green:138/255.0 blue:176/255.0 alpha:1];
        return [coreTextView autorelease];
}
-(void)imageClicked:(UITapGestureRecognizer *)sender
{
    if([sender isKindOfClass:[UITapGestureRecognizer class]]){
        if (sender.numberOfTapsRequired == 1) {
            [delegate statusImageClicked:self.status];
        }
    }

    NSLog(@"------------------------ img clicked:%@", sender);
}
-(void)repostImageClicked:(UITapGestureRecognizer *)sender
{

    if([sender isKindOfClass:[UITapGestureRecognizer class]]){
        if (sender.numberOfTapsRequired == 1) {
            [delegate statusImageClicked:self.status.retweetedStatus];
        }
    }
    NSLog(@"图片被点击");
}
-(void)customViews
{
    //背景图
//    self.repostBg = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"repost-bg.png"]stretchableImageWithLeftCapWidth:28 topCapHeight:28]];
    
    //微博视图
    self.weiboView = [[UIView alloc]initWithFrame:CGRectZero];
    //转发视图
    self.repostView = [[UIView alloc]initWithFrame:CGRectZero];
    self.weiboView.backgroundColor = [UIColor clearColor];
    self.repostView.backgroundColor = [UIColor clearColor];
    
    //微博内容
   // weiboContent = [[JSTwitterCoreTextView alloc]initWithFrame:CGRectZero];
    self.weiboContent = [self GetJSTwitterCoreTextView];
    self.weiboContent.backgroundColor = [UIColor clearColor];
    //转发内容
    //repostContent = [[JSTwitterCoreTextView alloc]initWithFrame:CGRectZero];
    self.repostContent = [self GetJSTwitterCoreTextView] ;
    self.repostContent.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *weiboImgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];

    UITapGestureRecognizer *repostImgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(repostImageClicked:)];

    //微博图片
    self.weiboImg = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.weiboImg.layer setMasksToBounds:YES];
    [self.weiboImg.layer setCornerRadius:4];
    self.weiboImg.contentMode = UIViewContentModeScaleAspectFit;
    self.weiboImg.tag = WeiboImages;
    //转发图片
    self.repostImg = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.repostImg.layer setMasksToBounds:YES];
    [self.repostImg.layer setCornerRadius:4];
    self.repostImg.tag = RepostImages;
    
    self.repostImg.userInteractionEnabled = YES;
    self.repostImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.repostImg addGestureRecognizer:repostImgTap];
    [repostImgTap release];
    repostImgTap = nil;
    
    self.weiboImg.userInteractionEnabled = YES;
    [self.weiboImg addGestureRecognizer:weiboImgTap];
    [weiboImgTap release];
    weiboImgTap = nil;
    
    [self setFrame:CGRectMake(0, 0, 300, 0)];
    [self.layer setCornerRadius:4];
    
    [self addSubview:weiboView];
    [self addSubview:repostView];
    
    [self.weiboView setUserInteractionEnabled:YES];
    [self.weiboView addSubview:weiboImg];
    [self.weiboView addSubview:weiboContent];
    [self.repostView addSubview:repostBg];
    [self.repostView addSubview:repostImg];
    [self.repostView addSubview:repostContent];
}

#pragma mark - 更新Cell

//获取富文本框高度
+(CGFloat)getJSHeight:(NSString*)text jsViewWidth:(CGFloat)width
{
    CGFloat height = [JSCoreTextView measureFrameHeightForText:text
                                                      fontName:FONT 
                                                      fontSize:FONT_SIZE 
                                            constrainedToWidth:width - (PADDING_LEFT * 2)
                                                    paddingTop:PADDING_TOP 
                                                   paddingLeft:PADDING_LEFT];
    return height;
}

//设置Cell
-(void)setContent:(Status *)weibo
{
    weiboContent.text = weibo.text;
    Status  *repostWeibo = weibo.retweetedStatus;
    CGFloat height = 0;
    height = [[self class] getJSHeight:weiboContent.text jsViewWidth:CONTENT_WIDTH];
    CGRect frame;
    frame =  weiboView.frame;
    frame.origin.y = 8;
    frame.origin.x = 8;
    //有weibo图
    if (self.weiboImg.hidden == NO) {
        self.weiboImg.frame  = CGRectMake(8,8, CONTENT_WIDTH, IMAGE_VIEW_HEIGHT);
        self.weiboContent.frame  = CGRectMake(8, weiboImg.frame.origin.y+weiboImg.frame.size.height+4, weiboImg.frame.size.width, height+8);
    }else{//无微博图
        self.weiboContent.frame  = CGRectMake(8, 4, CONTENT_WIDTH, height+8);
    }
    self.weiboView.frame  = CGRectMake(12, 8, CELL_WIDTH, weiboContent.frame.origin.y+weiboContent.frame.size.height + 4);

    //有转发
    if (self.repostView.hidden == NO) {
        frame =  repostView.frame;
        frame.origin.y = weiboView.frame.origin.y + weiboView.frame.size.height-8;
        frame.origin.x = 8;
        frame.size.width = CELL_WIDTH;
        self.repostView.frame = frame;
        self.repostContent.text = [NSString stringWithFormat:@"@%@:%@",repostWeibo.user.name,repostWeibo.text];
        height = [[self class]getJSHeight:repostContent.text jsViewWidth:CONTENT_WIDTH];
        //有转发图
        if (self.repostImg.hidden ==NO) {
            self.repostImg.frame = CGRectMake(12, 16, CONTENT_WIDTH, IMAGE_VIEW_HEIGHT);
            self.repostContent.frame  = CGRectMake(8, repostImg.frame.origin.y+ repostImg.frame.size.height, CONTENT_WIDTH, height+8);
            
        }else{//无转发图
            self.repostContent.frame = CGRectMake(8, 8, CONTENT_WIDTH, height+8);
        }
        
        frame.size.height  = repostContent.frame.origin.y + repostContent.frame.size.height;
        self.repostView.frame = frame;
//        self.repostBg.frame = CGRectMake(2, 0, 300, repostView.frame.size.height);
        self.cellHeight = repostView.frame.size.height + repostView.frame.origin.y;
    }else{ //无转发
        self.cellHeight = weiboView.frame.size.height + weiboView.frame.origin.y;
    }
    self.frame = CGRectMake(0, 0, 320, cellHeight);
}

//更新Cell
-(void)updateCellWith:(Status *)weibo
{
    self.status = weibo;
    Status  *repostWeibo = weibo.retweetedStatus;
//    User *theUser = weibo.user;
//    weiboContent.text = weibo.text;
    
    NSString *url = weibo.thumbnailImageUrl;
    NSLog(@"weibo.thumbnailImageUrl:%@",url);
    //有图
    if (url!=nil) {
        self.weiboImg.hidden = NO;
    }else{
        self.weiboImg.hidden = YES;
    }

    //有转发
    if (repostWeibo && ![repostWeibo isEqual:[NSNull null]]) 
    {
        self.repostView.hidden = NO;
//        repostContent.text = [NSString stringWithFormat:@"@%@:%@",repostWeibo.user.name,repostWeibo.text];
        
        NSString *url = repostWeibo.thumbnailImageUrl;
         NSLog(@"有转发:weibo.thumbnailImageUrl:%@",url);
        //有图
        if (url!=nil) {
            self.repostImg.hidden = NO;
        }else{
            self.repostImg.hidden = YES;
        }
    }
    //无转发
    else
    {
        self.repostView.hidden = YES;
    }
    [self setContent:weibo];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        [self customViews]; //自定义Cell
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    self.weiboView = nil;
    self.repostView = nil;
    self.weiboContent = nil;
    self.repostContent = nil;
    self.weiboImg = nil;
//    self.repostBg = nil;
    self.repostView = nil;
    self.bg = nil;
    self.status = nil;
    [super dealloc];
}
@end
