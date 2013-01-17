//
//  MyselfPageViewControllerCell.m
//  superWeiBo6-leslie
//
//  Created by  on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyselfPageViewControllerCell.h"


@implementation MyselfPageViewControllerCell
@synthesize careBtn;
@synthesize weiboBtn;
@synthesize fansBtn;
@synthesize headImage;
@synthesize nameLable;
@synthesize isManImage;
@synthesize isVip;
@synthesize sampleUserInfo;
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)DetilBtnClicked:(id)sender {
    [delegate detailClicked:((UIButton *)sender).tag];
}

- (void)dealloc {
    [careBtn release];
    [weiboBtn release];
    [fansBtn release];
    [headImage release];
    [nameLable release];
    [isManImage release];
    [isVip release];
    [sampleUserInfo release];
    [super dealloc];
}
@end
