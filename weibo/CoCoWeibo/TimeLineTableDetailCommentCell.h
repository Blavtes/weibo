//
//  TimeLineTableDetailCommentCell.h
//  superWeiBo6-leslie
//
//  Created by  on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "weiboDetailCommentInfo.h"
#import "Comment.h"

@interface TimeLineTableDetailCommentCell : UITableViewCell
{
    UIImageView * _headImageView ;
    UIImageView * _isVipImage;
    UILabel * _commentPersonNameLable;
    UILabel * _lastTimeLong;
    UILabel * _commentContent;
    CGFloat  _cellHeight;
//    weiboDetailCommentInfo * _weiboDetailCommentInfo;
    Comment * _weiboDetailCommentInfo;
   
}
@property (nonatomic,retain)UIImageView * headImageView;
@property (nonatomic,retain)UIImageView * isVipImage;
@property (nonatomic,retain)UILabel * commentPersonNameLable;
@property (nonatomic,retain)UILabel * lastTimeLong;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,retain)UILabel * commentContent;
@property (nonatomic,retain)User * user;

//@property (nonatomic,retain)weiboDetailCommentInfo * weiboDetailCommentInfo;

@property (nonatomic,retain)Comment * weiboDetailCommentInfo;
-(UIView *)createCellView;
@end
