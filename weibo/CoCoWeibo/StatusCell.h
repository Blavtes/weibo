//
//  TimeLineTableCell.h
//  TimeLineVIew
//
//  Created by coobei on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSTwitterCoreTextView.h"
#define IMAGE_VIEW_HEIGHT 120.0f
#define CELL_WIDTH 300.0f
#define CONTENT_WIDTH 280.0f
#define PADDING_TOP 4.0
#define PADDING_LEFT 4.0
#define FONT_SIZE 13.0
#define FONT @"Arial"
#define TEXT_VIEW_SIZE CGSizeMake(240, 1000)
@class StatusCell;
@class Status;
@protocol StatusCellDelegate;
@interface StatusCell : UITableViewCell <UITextViewDelegate, JSCoreTextViewDelegate,UIGestureRecognizerDelegate>
{
        id<StatusCellDelegate>  delegate;
}

@property (retain,  nonatomic)id<StatusCellDelegate>  delegate;
@property (retain, nonatomic)UIImageView *bg;
@property (retain, nonatomic)Status *status;
@property (retain, nonatomic)UIImageView *repostBg;
@property (retain, nonatomic) UIView *weiboView ;
@property (retain, nonatomic) UIView *repostView ;
@property (retain, nonatomic) JSTwitterCoreTextView *weiboContent;
@property (retain, nonatomic) JSTwitterCoreTextView *repostContent;
@property (retain, nonatomic) UIImageView *weiboImg;
@property (retain, nonatomic) UIImageView *repostImg;
@property (assign,nonatomic)CGFloat cellHeight;

//动态设置界面布局
-(void)updateCellWith:(Status *)weibo;


//返回Cell高度
-(CGFloat)contentHeight:(CGFloat )cellHeight;
@end

@protocol StatusCellDelegate <NSObject>

-(void)statusImageClicked:(Status *)theStatus;
//-(void)cellImageDidTaped:(StatusCell *)theCell image:(UIImage*)image;
//-(void)cellLinkDidTaped:(StatusCell *)theCell link:(NSString*)link;
//-(void)cellTextDidTaped:(StatusCell *)theCell;
-(void)customViews;
@end
