//
//  menuHead.m
//  CoCoWeibo
//
//  Created by coobei on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "menuHead.h"
#import "ZJTHelpler.h"
#import "UIImageView+WebCache.h"
@implementation menuHead
@synthesize bgImages = _bgImages;
@synthesize userName = _userName;
@synthesize headImage = _headImage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"menu head init");
        
        ZJTHelpler * zjt = [ZJTHelpler getInstance];
        User * user = zjt.user;
        
        
        self.bgImages = [UIImage imageNamed:@"skin01_headimage.png"];
        self.userName = [[UILabel alloc]initWithFrame:CGRectMake(120, self.frame.size.height - 36, 180, 28)];
        self.userName.backgroundColor = [UIColor clearColor];
        self.userName.text = user.name;
        self.userName.textColor = [UIColor whiteColor];
        self.userName.shadowColor  = [UIColor blackColor];
        self.userName.shadowOffset = CGSizeMake(0, 1);
        
        self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.frame.size.height-42, 40, 40)];
        [self.headImage.layer setMasksToBounds:YES];
        [self.headImage.layer setCornerRadius:10];
        [self.headImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
        [self addSubview:_headImage];
        [self addSubview:_userName];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor(context, 0.3, 0.3, 0.3, 1.0f);
//    CGContextFillRect(context, rect);
//    UIImage *bg = [UIImage imageNamed:@"testImg2.jpg"];
    [_bgImages drawAtPoint:CGPointMake(rect.origin.x-1, rect.origin.y-1)];
    UIImage *headerShadow  = [UIImage imageNamed:@"menu_head_shadow.png"];
    [headerShadow drawInRect:CGRectMake(-1, rect.origin.y + rect.size.height - 44, 320, 45)];
    
    // Drawing code
}


@end
