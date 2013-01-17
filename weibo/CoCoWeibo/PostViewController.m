//
//  PostViewController.m
//  superWeiBo6-leslie
//
//  Created by coobei on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PostViewController.h"
#import "WeiBoMessageManager.h"
#import "FriendsAndFansController.h"
#import "UICheckButton.h"
#import <QuartzCore/QuartzCore.h>
@implementation PostViewController
@synthesize delegate;
@synthesize status = _status;
@synthesize witchOperating;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

typedef enum {
    Camerabutton= 0,
    Locatebutton,
    Mentionbutton,
    Trendbutton
}_btnType;

-(void)postImagesAnimation
{
    CGRect frame = postTextView.frame;
    frame.size.width = 196;
    [UIView animateWithDuration:0.5 animations:^{
        postImages.hidden = NO;
        postImages.frame = CGRectMake(212, 32, 100, 80);
        postImages.alpha = 1.0;
        postTextView.frame = frame;
    }  completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            iconMark.hidden = NO;
            iconMark.frame = CGRectMake(72, -8, 26, 20);
            postImages.transform = CGAffineTransformRotate(CGAffineTransformMakeRotation(0), -M_PI/30.0);
            iconMark.transform = CGAffineTransformMakeRotation(M_PI/20);
        }];
    }];
}
-(void)postImagesRemoveAnimation{
    CGRect frame = postTextView.frame;
    frame.size.width = 300;
    [UIView animateWithDuration:0.25 animations:^{
        iconMark.transform = CGAffineTransformMakeRotation(0);
        iconMark.frame = CGRectMake(50, -60, 26, 20);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 animations:^{
            iconMark.hidden = YES;
            postImages.transform = CGAffineTransformMakeRotation(0);
            postImages.frame = CGRectMake(400, 300, 0, 0);
            postTextView.frame = frame;
        }completion:^(BOOL finished){
            postImages.hidden = YES;
        }];
    }];
}

-(void)removeImages:(id)sender
{
    [self postImagesRemoveAnimation];
}


#pragma mark - 系统相机委托
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    postImages.image = image;
    [picker dismissModalViewControllerAnimated:YES];
    [self postImagesAnimation];
}


- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //取消按钮
    if (buttonIndex == 2) {
        if (postImages.hidden == NO) {
            [self postImagesAnimation];
        }
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //调用
    UIImagePickerController *imagesPicker =  [[UIImagePickerController alloc]init];
    
    imagesPicker.delegate = self;
    imagesPicker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
        {
            //调用系统相册
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
                imagesPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSLog(@"UIImagePickerControllerSourceTypePhotoLibrary Clicked");
                [self presentModalViewController:imagesPicker animated:YES];
//                [delegate presentViewController:imagesPicker];
                [imagesPicker release];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"访问图片库错误"
                                      message:@""
                                      delegate:nil
                                      cancelButtonTitle:@"OK!"
                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
            
            break;
        case 1:
        {
            //调用系统相册
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                imagesPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                NSLog(@"UIImagePickerControllerSourceTypeCamera Clicked");
                [self presentModalViewController:imagesPicker animated:YES];
                [imagesPicker release]; 
            }else{
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"访问相机错误"
                                      message:@""
                                      delegate:nil
                                      cancelButtonTitle:@"OK!"
                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            
        }    
            break;
        default:
            break;
    }
    
    
}


#pragma mark - 底部按钮点击
-(void)btnClicked:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender; 
        switch (button.tag) {
            //获取图片
            case 100:
            {
                CGRect frame = postTextView.frame;
                frame.size.width = 300;
                [UIView animateWithDuration:0.25 animations:^{
                    iconMark.transform = CGAffineTransformMakeRotation(0);
                    iconMark.frame = CGRectMake(50, -60, 26, 20);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.6 animations:^{
                        iconMark.hidden = YES;
                        postImages.transform = CGAffineTransformMakeRotation(0);
                        postImages.frame = CGRectMake(400, 300, 0, 0);
                        postTextView.frame = frame;
                    }];
                }];
                UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"系统相册" otherButtonTitles:@"相机", nil];
                actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
                [actionSheet showInView:self.view];
                
            }
                break;
            case 101:
            {
                NSLog(@"Locatebutton Clicked");
            }
                break;
            case 102:
            {
                postTextView.text = [postTextView.text stringByAppendingString:@"@"];
//                //@某用户
//                FriendsAndFansController *vc = [[FriendsAndFansController alloc]init];
//                [self presentModalViewController:vc animated:YES];
//                [vc release];
//                NSLog(@"Mentionbutton Clicked");
            }
                break;
            case 103:
            {
                postTextView.text = [postTextView.text stringByAppendingString:@"#"];
                NSLog(@"Trendbutton Clicked");
            }
                break;
                
            default:
                break;
        }
    }
}

-(void)showAlertTocution:(NSString *)str
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
}


#pragma mark - 发布微博
-(void)didGetPostResult:(Status *)sts
{
    NSLog(@"发布成功微博");
}
-(void)postWeibo:(id)sender
{
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    titleLabel.text = @"正在发送...";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.alpha = 0.0f;
    NSLog(@"发送微博");
    if (postTextView.text.length == 0 &&  postImages.hidden == YES) {
        NSLog(@"发送内容不能为空");
        [self showAlertTocution:@"发送内容不能为空！"];
    }else{
        //发送图片微博
        if (postImages.hidden == NO) {
            for (NSString *weiboName in checkedArray) {
                if ([weiboName isEqualToString:@"新浪微博"]) {
//                    [messageManager methodForSelector:postSina];
                     [messageManager postWithText:postTextView.text  image:postImages.image];
                    NSLog(@"发布新浪 文字图片微博");
                }else if([weiboName isEqualToString:@"腾讯微博"]){
//                      [messageManager postWithText:postTextView.text  image:postImages.image];
                    [messageManager postTencentWithText:postTextView.text image:postImages.image];
                    NSLog(@"发布腾讯 文字图片微博");
                }
            }
            
//            [messageManager postWithText:postTextView.text  image:postImages.image];
            
            [self.view addSubview:titleLabel];
            [titleLabel release];

            [UIView animateWithDuration:0.6 animations:^{
                titleLabel.alpha = 1.0f;
                titleLabel.frame = CGRectMake(100, 60, 100, 24);
            }];
            NSLog(@"发送图片微博");
        }else{
            for (NSString *weiboName in checkedArray) {
                if ([weiboName isEqualToString:@"新浪微博"]) {
                    [messageManager postWithText:postTextView.text];
                     NSLog(@"发布新浪 文字微博");
                }else if([weiboName isEqualToString:@"腾讯微博"]){
                    [messageManager postTencentWithText:postTextView.text];
                    NSLog(@"发布腾讯 文字微博");
                }
            }
            [self.view addSubview:titleLabel];
            [titleLabel release];
            titleLabel.alpha = 0.0f;
            [UIView animateWithDuration:0.6 animations:^{
                titleLabel.alpha = 1.0f;
                titleLabel.frame = CGRectMake(100, 60, 100, 24);
            }];
            NSLog(@"发送文字微博");
        }
    }
}

-(void)commentWeibo
{
    [messageManager commentAStatus:[NSString  stringWithFormat:@"%lld",self.status.statusId] content:postTextView.text];
}

-(void)repostWeibo
{
    [messageManager repost:[NSString stringWithFormat:@"%lld",self.status.statusId] content:postTextView.text withComment:0];
}

-(void)clickCheckButton:(id)sender
{
    UICheckButton *button  = (UICheckButton *)sender;
    NSMutableArray *deleObjectArray = [[NSMutableArray alloc]initWithCapacity:0];
    if (button.isChecked) {
        [checkedArray addObject:button.checkedObject];
        NSLog(@"添加发送微博");
    }else{
        for ( id object in checkedArray) {
            if (object == button.checkedObject) {
//                [checkedArray removeObject:object];
                [deleObjectArray addObject:object];
                NSLog(@"移除发送微博");
            }
        }
        for (id object in deleObjectArray) {
            [checkedArray removeObject:object];
        }
    }
    for (id object in checkedArray) {
        NSLog(@"选中的微博:%@", object);
    }
}

-(void)closeView:(id)sender
{
    NSLog(@"关闭");
    [delegate closePostView:self];
}
-(void)createView
{
  checkedArray = [[NSMutableArray alloc]initWithCapacity:0];
    //发送多选框
    NSString * filePath = NSHomeDirectory();
    filePath = [filePath stringByAppendingPathComponent:@"Documents/tab.plist"];
    NSArray * currentWeiboArry = [NSArray arrayWithContentsOfFile:filePath];
    for (int i=0; i < [currentWeiboArry count]; i++) {
        UICheckButton *check = [[UICheckButton getUICheckButtonByBackgroundImage:[UIImage imageNamed:@"checkbutton.png"] AndChecked:[UIImage imageNamed:@"checkbutton_checked.png"]] retain];
        check.frame = CGRectMake(i%3*(100+10)+10,0, 28, 28);
         [check addTarget:self action:@selector(clickCheckButton:) forControlEvents:UIControlEventTouchUpInside];
               UILabel *label = [[UILabel alloc]init];
        if ([[currentWeiboArry objectAtIndex:i] isKindOfClass:[NSString class]]) {
            label.text = [currentWeiboArry  objectAtIndex:i];
        }
        label.frame = CGRectMake(i%3*(100+10)+40, 0, 80, 28);
        label.font = [UIFont systemFontOfSize:16];
        label.backgroundColor = [UIColor clearColor];
        label.textColor  = [UIColor whiteColor];
        check.checkedObject = label.text;
        if (witchOperating == postText) {
            [self.view addSubview:check];
        }
        [check release];
        [self.view addSubview:label];
        [label release];
    }
    
    //发送框背景
    UIImage *bgimg = [[UIImage imageNamed:@"cellbg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16)];
    UIImageView *textViewBg = [[UIImageView alloc]initWithImage:bgimg];
    textViewBg.frame = CGRectMake(0, 20, 320, 160);
    [self.view addSubview:textViewBg];

    //发送框
    postTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 16, 300, 110)];
    postTextView.scrollEnabled = NO;
    postTextView.backgroundColor = [UIColor clearColor];
    //    postTextView.layer.cornerRadius = 4.0f;
    [postTextView becomeFirstResponder];
    [textViewBg addSubview:postTextView];
    
    //按钮
    NSArray *btnArray = [NSArray arrayWithObjects:@"compose_camerabutton_background",@"compose_locatebutton_background",@"compose_mentionbutton_background",@"compose_trendbutton_background",nil];
    for (int i = 0; i < [btnArray count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:[btnArray objectAtIndex:i]] forState:UIControlStateNormal];
        btn.tag = 100+i;
        btn.frame = CGRectMake(i*40+16*(i+1),textViewBg.frame.origin.y + textViewBg.frame.size.height - 36,23 ,19 );
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        NSLog(@"添加按钮");
    }
    
    //发送按钮
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [postButton setBackgroundImage:[[UIImage imageNamed:@"button-black.png"] stretchableImageWithLeftCapWidth:8 topCapHeight:8] forState:UIControlStateNormal];
    postButton.frame = CGRectMake(10, textViewBg.frame.origin.y + textViewBg.frame.size.height-6, 300, 36);
    [postButton.titleLabel setShadowOffset:CGSizeMake(0, 1)];
    [postButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [postButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [postButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    [postButton setTitle:@"发送" forState:UIControlStateNormal];
    [postButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    switch (witchOperating) {
        case comment:
        {
            [postButton addTarget:self action:@selector(commentWeibo) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
            case repost:
        {
            [postButton addTarget:self action:@selector(repostWeibo) forControlEvents:UIControlEventTouchUpInside];
        }
            case postText:
        {
            [postButton addTarget:self action:@selector(postWeibo:) forControlEvents:UIControlEventTouchUpInside];
        }
         
        default:
            break;
    }
    
    
    
    
    //发送图片
    iconMark  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainFaceIconMark"]];
    iconMark.frame = CGRectMake(50, -12, 26, 20);
    iconMark.hidden = YES;
    iconMark.userInteractionEnabled = YES;
    
    postImages = [[UIImageView alloc]initWithFrame:CGRectMake(400, 300, 0, 0)];
    postImages.hidden = YES;
    postImages.backgroundColor = [UIColor blackColor];
    [postImages.layer setBorderColor:[UIColor clearColor].CGColor];
    [postImages.layer setBorderWidth:2.0];
    [postImages.layer setShadowColor:[UIColor blackColor].CGColor];
    [postImages.layer setShadowOffset:CGSizeMake(1, 2)];
    [postImages.layer setShadowOpacity:0.8];
    [postImages.layer setShadowRadius:2.0];
    postImages.layer.shouldRasterize = YES;
    
    [postImages addSubview:iconMark];
    postImages.image = [UIImage imageNamed:@"testimg.jpg"];
    
    //字数统计
    textCount = [[UILabel alloc]initWithFrame:CGRectMake(textViewBg.frame.size.width+textViewBg.frame.origin.x - 100 ,textViewBg.frame.size.height+textViewBg.frame.origin.y - 30, 100 ,30)];
    textCount.text = @"140";
    
    //删除图片
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeImages:)];
    tapRecognizer.delegate = self;
    postImages.userInteractionEnabled = YES;
    [iconMark addGestureRecognizer:tapRecognizer];
    [tapRecognizer release];
    
    //关闭
    UIButton *closeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"closebutton"] forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(320-30, 145, 28, 28);
    [closeButton addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    [self.view addSubview:postButton];
    [self.view addSubview:postImages];
    [self.view bringSubviewToFront:postImages];
    
}


-(void)repotResult:(NSNotification *)noti
{
    Status * status = noti.object;
    NSString * str;
    if (status!=nil) {
         NSLog(@"转发成功");
        str = @"转发成功";
    }else{
         NSLog(@"转发失败");
        str = @"转发失败";
       
    }
     [self showAlertTocution:str];
    [UIView animateWithDuration:0.6 animations:^{
        titleLabel.alpha = 0;
        titleLabel.frame = CGRectMake(0, 0, 0, 0);
    }];
}

-(void)commentResult:(NSNotification *)noti
{
    NSNumber * boo = noti.object;
    BOOL success = [boo boolValue];
    NSString * str;
    if (success) {
        NSLog(@"评论成功");
          str = @"评论成功";
       
    }else{
        NSLog(@"评论失败");
          str = @"评论失败";
    }
     [self showAlertTocution:str];
    [UIView animateWithDuration:0.6 animations:^{
        titleLabel.alpha = 0;
        titleLabel.frame = CGRectMake(0, 0, 0, 0);
    }];
    
}

-(void)postResult:(NSNotification *)noti
{
    Status * status = noti.object;
    NSString * str;
    if (status != nil) {
        NSLog(@"发送成功");
          str  = @"发送成功";
        
    }else{
        NSLog(@"发送失败");
          str = @"发送失败";
    }
       [self showAlertTocution:str];
    [UIView animateWithDuration:0.6 animations:^{
        titleLabel.alpha = 0;
        titleLabel.frame = CGRectMake(0, 0, 0, 0);
    }];
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 */
-(void)viewDidLoad
{
    [super viewDidLoad];
     [self.view setBackgroundColor:[UIColor colorWithRed:50/255.0f green:56/255.0f blue:65/255.0f alpha:1.0f]];
    messageManager = [WeiBoMessageManager  getInstance];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self createView];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSNotificationCenter * noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(repotResult:) name:MMSinaGotRepost object:nil];
    
    [noti addObserver:self selector:@selector(commentResult:) name:MMSinaCommentAStatus object:nil];
    [noti addObserver:self selector:@selector(postResult:) name:MMSinaGotPostResult object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
     NSNotificationCenter * noti = [NSNotificationCenter defaultCenter];
    [noti removeObserver:MMSinaGotRepost];
    [noti removeObserver:MMSinaCommentAStatus];
    [noti removeObserver:MMSinaGotPostResult];
}

-(void)dealloc
{
    [textCount release];
    textCount = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
