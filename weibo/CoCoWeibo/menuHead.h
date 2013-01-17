//
//  menuHead.h
//  CoCoWeibo
//
//  Created by coobei on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuHead : UIView
{
    UIImage *_bgImages;
    UIImageView * _headImage;
    UILabel *_userName;
}
@property (nonatomic, retain)UIImage *bgImages;
@property (nonatomic,retain)UIImageView * headImage;
@property (nonatomic, retain)UILabel *userName;
@end
