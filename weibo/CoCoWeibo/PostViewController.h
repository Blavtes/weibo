//
//  PostViewController.h
//  superWeiBo6-leslie
//
//  Created by coobei on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoMessageManager.h"
#import "Status.h"
@protocol PostViewControlelDelegate;

typedef enum {
    comment,
    repost,
    postText,
}commentOrRepost;

@interface PostViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate,WeiBoHttpDelegate,UIGestureRecognizerDelegate>

{
    WeiBoMessageManager *messageManager;
    UITextView *postTextView;
    UIImageView *postImages;
    UIImageView * iconMark;
    UILabel *textCount;
    NSMutableArray *checkedArray;
    id<PostViewControlelDelegate> delegate;
    Status * _status;
    commentOrRepost  witchOperating;
    UILabel *titleLabel;
}
@property (retain,nonatomic) id<PostViewControlelDelegate> delegate;
@property (retain,nonatomic) Status * status;
@property (assign,nonatomic) commentOrRepost  witchOperating;
@end
@protocol PostViewControlelDelegate <NSObject>
-(void)presentViewController:(id)sender;
-(void)closePostView:(id)sender;
@end