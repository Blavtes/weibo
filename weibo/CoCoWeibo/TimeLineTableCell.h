//
//  TimeLineTableCell.h
//  TimeLineVIew
//
//  Created by coobei on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSTwitterCoreTextView.h"
#define IMAGE_VIEW_HEIGHT 80.0f
#define PADDING_TOP 4.0
#define PADDING_LEFT 4.0
#define FONT_SIZE 13.0
#define FONT @"Arial"
#define TEXT_VIEW_SIZE CGSizeMake(240, 1000)
@class StatusCell;
@class Status;
@protocol StatusCellDelegate <NSObject>

-(void)cellImageDidTaped:(StatusCell *)theCell image:(UIImage*)image;
-(void)cellLinkDidTaped:(StatusCell *)theCell link:(NSString*)link;
-(void)cellTextDidTaped:(StatusCell *)theCell;

@end
@interface TimeLineTableCell : UITableViewCell <UITextViewDelegate, JSCoreTextViewDelegate>
{
        id<StatusCellDelegate>  delegate;
        
        JSTwitterCoreTextView *_JSContentTF;    //微博正文富文本框
        JSTwitterCoreTextView *_JSRetitterContentTF; //转发富文本框
}
@property (retain,  nonatomic)id<StatusCellDelegate>  delegate;
@property (assign, nonatomic)CGFloat cellHeight;
//@property (assign, nonatomic)NSInteger
//界面元素
@property (retain, nonatomic) IBOutlet UIImageView *userImg; 
@property (retain, nonatomic) IBOutlet UILabel *userName;
@property (retain, nonatomic) IBOutlet UILabel *postTime;
@property (retain, nonatomic) IBOutlet UIImageView *vipImg;
//微博
@property (retain, nonatomic) JSTwitterCoreTextView *JSContentTF;
@property (retain, nonatomic) IBOutlet UIImageView *weiboImg;
//转发
@property (retain, nonatomic) IBOutlet UIView *repostView;
@property (retain, nonatomic) JSTwitterCoreTextView *JSRetitterContentTF;
@property (retain, nonatomic) IBOutlet UIImageView *repostImg;
@property (retain, nonatomic) IBOutlet UIImageView *repostBg;

//动态设置界面布局
-(void)setContenWithHaveImage:(BOOL)haveImage haveRepostImages:(BOOL)haveRepostImages;
-(void)updateCellTextWith:(Status *)status;
//返回Cell高度
-(CGFloat)contentHeight;
@end
