//
//  StatusHead.m
//  superWeiBo6-leslie
//
//  Created by coobei on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StatusHead.h"

@implementation StatusHead
@synthesize userImg;
@synthesize userName;
@synthesize postTime;
@synthesize statusHeadImage;
@synthesize lightColor = _lightColor;
@synthesize darkColor = _darkColor;
@synthesize delegate = _delegate;
@synthesize user = _user;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
    }
    return self;
}


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

//绘制玻璃高光
-(void)drawGlossAndGradient:(CGContextRef) context Rect:(CGRect) rect startColor:(CGColorRef) startColor
            endColor:(CGColorRef) endColor 
{
    
    [self drawLinearGradient:context Rect:rect startColor:startColor endColor:endColor];
                    
    CGColorRef glossColor1 = [UIColor colorWithRed:1.0 green:1.0 
                                              blue:1.0 alpha:0.35].CGColor;
    CGColorRef glossColor2 = [UIColor colorWithRed:1.0 green:1.0 
                                              blue:1.0 alpha:0.1].CGColor;
    
    CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y, 
                                rect.size.width, rect.size.height/2);
    
    //线性渐变
     [self drawLinearGradient:context Rect:topHalf startColor:glossColor1 endColor:glossColor2];
    
}

-(CGRect) rectFor1PxStroke:(CGRect) rect{
    return CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, 
                      rect.size.width - 1, rect.size.height - 1);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect
{
    /*
    self.lightColor = [UIColor colorWithRed:105.0f/255.0f green:179.0f/255.0f 
                                       blue:216.0f/255.0f alpha:1.0];
    self.darkColor = [UIColor colorWithRed:21.0/255.0 green:92.0/255.0 
                                      blue:136.0/255.0 alpha:1.0];  
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    CGColorRef whiteColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f].CGColor;
    CGColorRef lightColor = _lightColor.CGColor;
    CGColorRef darkColor = _darkColor.CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5].CGColor;
    
    CGContextSetFillColorWithColor(context, whiteColor);
    CGRect paperRect = CGRectMake(4, 0, self.frame.size.width-8, self.frame.size.height);
    CGContextFillRect(context, paperRect);
    CGRect contentRect = CGRectMake(2, 0, self.frame.size.width-4, self.frame.size.height-4);
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor);
    CGContextFillRect(context, contentRect);
    CGContextRestoreGState(context);
//    drawGlossAndGradient(context, _coloredBoxRect, lightColor, darkColor);  
    [self drawGlossAndGradient:context Rect:contentRect startColor:lightColor endColor:darkColor];
    // Draw stroke
    CGContextSetStrokeColorWithColor(context, darkColor);
    CGContextSetLineWidth(context, 1.0);    
    CGContextStrokeRect(context, [self rectFor1PxStroke:contentRect]);
   
    UIImage *ar3 = [UIImage imageNamed:@"ar3.png"];
    [ar3 drawAtPoint:CGPointMake(40, 38)];
     */
    UIImage *bg = [UIImage imageNamed:@"cellhead_bg.png"];
    [bg drawAtPoint:CGPointMake(5, 0)];
}


- (void)dealloc {
    [userName release];
    [postTime release];
    [userImg release];
    [statusHeadImage release];
    [super dealloc];
}

- (IBAction)statuheadImageClicked:(id)sender {
    [_delegate statusHeadImageClicked:self.user];
}

@end
