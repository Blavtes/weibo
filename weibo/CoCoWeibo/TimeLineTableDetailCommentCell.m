//
//  TimeLineTableDetailCommentCell.m
//  superWeiBo6-leslie
//
//  Created by  on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TimeLineTableDetailCommentCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@implementation TimeLineTableDetailCommentCell
@synthesize headImageView = _headImageView;
@synthesize isVipImage = _isVipImage;
@synthesize commentPersonNameLable = _commentPersonNameLable;
@synthesize lastTimeLong = _lastTimeLong;
@synthesize cellHeight = _cellHeight;
@synthesize commentContent = _commentContent;
@synthesize  user = _user;
@synthesize weiboDetailCommentInfo  = _weiboDetailCommentInfo;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      UIView * view =   [self createCellView];
        [self.contentView addSubview:view];
    }
    return self;
}



-(UIView *)createCellView
{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    [_headImageView.layer  setMasksToBounds:YES];
    [_headImageView.layer  setMasksToBounds:YES];
    [_headImageView.layer setCornerRadius:10];
    _isVipImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 12, 12)];
    _isVipImage.image = [UIImage imageNamed:@"avatar_vip.png"];
 //   _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touxiang_40x40"]];
    
    _commentPersonNameLable = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 200, 20)];
    _commentPersonNameLable.text = @"user";
    _commentPersonNameLable.textAlignment = UITextAlignmentLeft;
    _commentPersonNameLable.font = [UIFont systemFontOfSize:18.0f];
    _commentPersonNameLable.lineBreakMode = UILineBreakModeHeadTruncation;
    
    _lastTimeLong = [[UILabel alloc]initWithFrame:CGRectMake(230, 5, 80, 35)];
    _lastTimeLong.text = @"10分钟";
    _lastTimeLong.textAlignment = UITextAlignmentCenter;
    _lastTimeLong.font = [UIFont systemFontOfSize:18.0f];
    _lastTimeLong.lineBreakMode = UILineBreakModeHeadTruncation;
    
    _commentContent  = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 160, 0)];
   // _commentContent.backgroundColor = [UIColor orangeColor];
    _commentContent.textAlignment = UITextAlignmentLeft;
    _commentContent.font = [UIFont systemFontOfSize:12.0f];
    _commentContent.font = [UIFont fontWithName:@"Zapfino" size:12.0f];
    _commentContent.lineBreakMode = UILineBreakModeCharacterWrap;
    _commentContent.numberOfLines = 0;
    
    [bgView addSubview:_headImageView];
    [bgView addSubview:_isVipImage];
    [bgView addSubview:_commentPersonNameLable];
    [bgView addSubview:_lastTimeLong];
    [bgView addSubview:_commentContent];
    
    return bgView;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setWeiboDetailCommentInfo:(Comment *)wcInfo
{
    if (_weiboDetailCommentInfo!=wcInfo) {
        [_weiboDetailCommentInfo release];
        _weiboDetailCommentInfo = [wcInfo retain];
        
        [_headImageView setImageWithURL:[NSURL URLWithString:wcInfo.user.profileImageUrl]];
        
        if (wcInfo.user.verified == NO) {
            _isVipImage.hidden = YES;
        }
        _commentPersonNameLable.text = wcInfo.user.name;
        _commentContent.text = wcInfo.text;
        
        _lastTimeLong.text = wcInfo.timestamp;
    }
}
 
-(void)dealloc
{
    [_headImageView release];
    [_commentPersonNameLable release];
    [_lastTimeLong release];
}
@end
