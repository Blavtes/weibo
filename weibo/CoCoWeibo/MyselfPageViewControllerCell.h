//
//  MyselfPageViewControllerCell.h
//  superWeiBo6-leslie
//
//  Created by  on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol mydetailDelegate <NSObject>
-(void)detailClicked:(int)tagindex;
@end
@interface MyselfPageViewControllerCell : UITableViewCell
{
    id<mydetailDelegate>  delegate;
    
}
@property (retain, nonatomic) IBOutlet UIButton *careBtn;
@property (retain, nonatomic) IBOutlet UIButton *weiboBtn;
@property (retain, nonatomic) IBOutlet UIButton *fansBtn;
@property (retain, nonatomic) IBOutlet UIImageView *headImage;
@property (retain, nonatomic) IBOutlet UILabel *nameLable;
@property (retain, nonatomic) IBOutlet UIImageView *isManImage;
@property (retain, nonatomic) IBOutlet UIImageView *isVip;
@property (retain, nonatomic) IBOutlet UILabel *sampleUserInfo;
@property (nonatomic,assign)id<mydetailDelegate>  delegate;
- (IBAction)DetilBtnClicked:(id)sender;
@end
