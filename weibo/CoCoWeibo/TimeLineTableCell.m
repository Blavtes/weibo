//
//  TimeLineTableCell.m
//  TimeLineVIew
//
//  Created by coobei on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TimeLineTableCell.h"
#import "JSTwitterCoreTextView.h"
#import "AHMarkedHyperlink.h"
#import "User.h"
#import "Status.h"
@implementation TimeLineTableCell
@synthesize delegate;
@synthesize userImg;
@synthesize userName;
@synthesize postTime;
@synthesize vipImg;
@synthesize weiboImg;
@synthesize repostView;
@synthesize repostImg;
@synthesize repostBg;
@synthesize cellHeight;
@synthesize JSContentTF =  _JSContentTF;
@synthesize JSRetitterContentTF = _JSRetitterContentTF;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
    }
    return self;
}

-(JSTwitterCoreTextView*)JSContentTF
{
    
    if (_JSContentTF == nil) {
        _JSContentTF = [[JSTwitterCoreTextView alloc] initWithFrame:CGRectMake(52, 30, 250, 80)];
        [_JSContentTF setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [_JSContentTF setDelegate:self];
        [_JSContentTF setFontName:FONT];
        [_JSContentTF setFontSize:FONT_SIZE];
        //[_JSContentTF setHighlightColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
        //[_JSContentTF setBackgroundColor:[UIColor clearColor]];
        [_JSContentTF setPaddingTop:PADDING_TOP];
        [_JSContentTF setPaddingLeft:PADDING_LEFT];
        //        _JSContentTF.userInteractionEnabled = NO;
        _JSContentTF.backgroundColor = [UIColor clearColor];
        _JSContentTF.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        _JSContentTF.linkColor = [UIColor colorWithRed:96/255.0 green:138/255.0 blue:176/255.0 alpha:1];
        [self.contentView addSubview:_JSContentTF];
    }
    
    return _JSContentTF;
}

-(JSTwitterCoreTextView*)JSRetitterContentTF
{    
    if (_JSRetitterContentTF == nil) {
        _JSRetitterContentTF = [[JSTwitterCoreTextView alloc] initWithFrame:CGRectMake(8, 5, 250, 80)];
        [_JSRetitterContentTF setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [_JSRetitterContentTF setDelegate:self];
        [_JSRetitterContentTF setFontName:FONT];
        [_JSRetitterContentTF setFontSize:FONT_SIZE];
        //[_JSRetitterContentTF setHighlightColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
        //[_JSRetitterContentTF setBackgroundColor:[UIColor clearColor]];
        [_JSRetitterContentTF setPaddingTop:PADDING_TOP];
        [_JSRetitterContentTF setPaddingLeft:PADDING_LEFT];
        //        _JSRetitterContentTF.userInteractionEnabled = NO;
        _JSRetitterContentTF.backgroundColor = [UIColor clearColor];
        _JSRetitterContentTF.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _JSRetitterContentTF.linkColor = [UIColor colorWithRed:96/255.0 green:138/255.0 blue:176/255.0 alpha:1];
        [self.repostView addSubview:_JSRetitterContentTF];
    }
    
    return _JSRetitterContentTF;
}


//获取富文本框高度
+(CGFloat)getJSHeight:(NSString*)text jsViewWith:(CGFloat)with
{
    CGFloat height = [JSCoreTextView measureFrameHeightForText:text
                                                      fontName:FONT 
                                                      fontSize:FONT_SIZE 
                                            constrainedToWidth:with - (PADDING_LEFT * 2)
                                                    paddingTop:PADDING_TOP 
                                                   paddingLeft:PADDING_LEFT];
    return height;
}

//设置富文本框高度
-(void)adjustTheHeightOf:(JSTwitterCoreTextView *)jsView withText:(NSString*)text
{
    CGFloat height = [TimeLineTableCell getJSHeight:text jsViewWith:jsView.frame.size.width];
    CGRect textFrame = [jsView frame];
    textFrame.size.height = height;
    [jsView setFrame:textFrame];
}

#if 1
-(void)updateCellTextWith:(Status *)status
{
    self.userName.text = status.user.screenName;
    //timeLB.text = status.timestamp;
    Status  *retWeibo = status.retweetedStatus;
    User *theUser = status.user;
    self.JSContentTF.text = status.text;
    vipImg.hidden = !theUser.verified;
    BOOL haveImage = NO;
    userName.text = theUser.name;
   // CGRect frame;
    //frame = countLB.frame;
   // CGFloat padding = 320 - frame.origin.x - frame.size.width;

    //转发数
//    frame = repostImg.frame;
//    CGSize size = [[NSString stringWithFormat:@"%d",weibo.repostsCount] sizeWithFont:[UIFont systemFontOfSize:12.0]];
//    frame.origin.x = 320 - padding - size.width - repostImg.frame.size.width - 5;
//    repostImg.frame = frame;
//    
//    frame = commentCountImageView.frame;
//    size = [[NSString stringWithFormat:@"%d     :%d",status.commentsCount,status.retweetsCount] sizeWithFont:[UIFont systemFontOfSize:12.0]];
//    frame.origin.x = 320 - padding - size.width - commentCountImageView.frame.size.width - 5;
//    commentCountImageView.frame = frame;
//    
    //有转发
    if (retWeibo && ![retWeibo isEqual:[NSNull null]]) 
    {
        self.repostView.hidden = NO;
        self.JSRetitterContentTF.text = [NSString stringWithFormat:@"@%@:%@",retWeibo.user.name,retWeibo.text];
        self.weiboImg.hidden = YES;
        
        NSString *url = retWeibo.thumbnailImageUrl;
        self.repostImg.hidden = url != nil && [url length] != 0 ? NO : YES;
        haveImage = !self.repostImg.hidden;
        [self setContenWithHaveImage:NO 
                haveRepostImages:url != nil && [url length] != 0 ? YES : NO];//计算cell的高度，以及背景图的处理
    }
    
    //无转发
    else
    {
        self.repostView.hidden = YES;
        NSString *url = status.thumbnailImageUrl;
        self.weiboImg.hidden = url != nil && [url length] != 0 ? NO : YES;
        haveImage = !self.weiboImg.hidden;
        [self setContenWithHaveImage:url != nil && [url length] != 0 ? YES : NO 
                haveRepostImages:NO];//计算cell的高度，以及背景图的处理
    }
//    haveImageFlagImageView.hidden = !haveImage;
}
#else

#endif
#pragma mark -----------动态布局tableviewcell------------

//设置Cell的内容并计算高度
-(void )setContenWithHaveImage:(BOOL)haveImage haveRepostImages:(BOOL)haveRepostImages
{
    //设置文本区域适应
   
    [self adjustTheHeightOf:_JSRetitterContentTF withText:_JSRetitterContentTF.text];
    
     [self adjustTheHeightOf:_JSContentTF withText:_JSContentTF.text];
    CGRect frame;
    
    //正文图片的位置
    frame = weiboImg.frame;
    frame.origin.y = _JSContentTF.frame.origin.y + _JSContentTF.frame.size.height + 5;
    weiboImg.frame = frame;
    
    //设置转发微博区域
    frame = repostView.frame;
    
    //设置位置
    //如果有正文图片
    if (haveImage) {
        frame.origin.y  =  _JSContentTF.frame.origin.y + _JSContentTF.frame.size.height + IMAGE_VIEW_HEIGHT;
    }else{ //没有图片
        weiboImg.hidden = YES;
        frame.origin.y  = _JSContentTF.frame.origin.y + _JSContentTF.frame.size.height ;
    }
    //设置高度
    //如果有转发图片
    if (haveRepostImages) {
        frame.size.height = _JSRetitterContentTF.frame.origin.y  + _JSRetitterContentTF.frame.size.height + IMAGE_VIEW_HEIGHT;
    }else{ //无转发图片
        repostImg.hidden = YES;
        frame.size.height = _JSRetitterContentTF.frame.origin.y  +  _JSRetitterContentTF.frame.size.height ;
    }
    repostView.frame = frame;
    
    //转发图片的位置
    frame = repostImg.frame;
    frame.origin.y = _JSRetitterContentTF.frame.origin.y + _JSRetitterContentTF.frame.size.height +  5;
    repostImg.frame = frame;
    
    //转发背景图适应
    UIImage *rebg =  [UIImage imageNamed:@"timeline_rt_border"];
    [repostBg setImage:[rebg stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
    repostBg.frame = CGRectMake(0, 0, repostView.frame.size.width, repostView.frame.size.height+ 5);
    
    if (repostView.hidden == NO) {
        cellHeight = self.repostView.frame.origin.y + self.repostView.frame.size.height + 10.0f;
        NSLog(@"repostView.hidden == NO : %f", cellHeight);
    }else if(haveImage){
        cellHeight = self.weiboImg.frame.origin.y + IMAGE_VIEW_HEIGHT + 10.0f;
        NSLog(@"haveImage : %f", cellHeight);
    }else{
        cellHeight = _JSContentTF.frame.origin.y + _JSContentTF.frame.size.height + 10.0f;
        NSLog(@"-- : %f", cellHeight);
    }
}

//返回Cell高度
-(CGFloat)contentHeight
{
        NSLog(@"---%f", cellHeight);
       return cellHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [userImg release];
    [userName release];
    [postTime release];
    [weiboImg release];
    [repostImg release];
    [repostBg release];
    [repostView release];
    [vipImg release];
    [super dealloc];
}
@end
