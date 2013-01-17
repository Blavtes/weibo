//
//  ImageViewConreoller.h
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewConreoller : UIViewController
{
    UIImageView *_imges;
    NSString * _imageUrl;
}
@property (nonatomic ,retain)UIImageView *imges;

@property (nonatomic,retain) NSString * imageUrl;

@end
