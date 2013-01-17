//
//  StatusFoot.m
//  CoCoWeibo
//
//  Created by coobei on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StatusFoot.h"

@implementation StatusFoot
@synthesize commentCount;
@synthesize repostCount;
@synthesize delegate;
@synthesize weibo;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)repostWeibo:(id)sender {
    [delegate repostWeibo:weibo];
}
- (IBAction)commentWeibo:(id)sender {
    [delegate commentWeibo:weibo];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect
{
    //rect  = CGRectMake(4, 0, rect.size.width-8, rect.size.height-10);
    
        
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorRef whiteColor  =[UIColor whiteColor].CGColor;
////    CGColorRef shadowColor = [UIColor blackColor].CGColor;
//    CGContextSetFillColorWithColor(context, whiteColor);
//    CGContextFillRect(context, rect);
//    CGContextSaveGState(context);
//     
//    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 5, shadowColor);
//    
//    CGContextRestoreGState(context);
    UIImage *bg = [UIImage imageNamed:@"cellfoot_bg"];
    [bg drawAtPoint:CGPointMake(5, 0)];
    UIImage *repost = [UIImage imageNamed:@"timeline_retweet_count_icon.png"];
    [repost drawAtPoint:CGPointMake(8, 8)];
    UIImage *comment = [UIImage imageNamed:@"timeline_comment_count_icon"];
    [comment drawAtPoint:CGPointMake(100, 8)];
    
}


- (void)dealloc {
    [commentCount release];
    [repostCount release];
    [super dealloc];
}
@end
