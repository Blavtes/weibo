//
//  ImagesViewer.h
//  CoCoWeibo
//
//  Created by coobei on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImagesViewerDelegate;
@interface ImagesViewer : UIView<UIScrollViewDelegate>
{
    id<ImagesViewerDelegate> delegate;
    UIImageView *_imges;
    NSString * _imageUrl;
}
@property (nonatomic ,retain)UIImageView *imges;
@property (nonatomic ,retain)id<ImagesViewerDelegate> delegate;
@property (nonatomic,retain) NSString * imageUrl;
@end
@protocol ImagesViewerDelegate <NSObject>

-(void)closeViewer:(id)sender;

@end