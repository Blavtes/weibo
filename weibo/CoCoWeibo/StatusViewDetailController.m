//
//  StatusViewDetailController.m
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StatusViewDetailController.h"
#import "StatusHead.h"
#import "StatusCell.h"
#import "MyselfStatuHead.h"
#import "Status.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "TimeLineTableDetailCommentCell.h"
//#import "weiboDetailCommentInfo.h"
#import "Test.h"
#import "WeiBoMessageManager.h"
#import "Comment.h"
#import "MansInfoViewController.h"
@implementation StatusViewDetailController
@synthesize weibo = _weibo;
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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(CGFloat)cellHeight:(NSString*)contentText with:(CGFloat)with
{
    UIFont * font=[UIFont  systemFontOfSize:14];
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(with, 300000.0f) lineBreakMode: UILineBreakModeWordWrap];
    CGFloat height = size.height + 0.;
    return height;
}

-(void)getComments:(int)page
{ 
    [_active startAnimating];
    WeiBoMessageManager * message = [WeiBoMessageManager getInstance];
    [message getCommentListWithID:self.weibo.statusId maxID:0 page:page];
}

-(void)getMoreComments
{
    pageCount++;
    [self getComments:pageCount];
}

-(void)getCommentsFromNet:(NSNotification *)noti
{
    NSDictionary * dic = noti.object;
    NSLog(@"Commentsdic:%@",dic);
    NSArray * arr = [dic objectForKey:@"commentArrary"];
    commentsCount = [dic objectForKey:@"count"];
    if ([arr count] == 0) {
        [footerButton setTitle:@"全部评论加载完成" forState:UIControlStateNormal];
    }
    count += [arr count];
    [listCommentsArray addObjectsFromArray:arr];
   
    [detailTableView reloadData];
    //[_active removeFromSuperview];
}

-(void)delegateHeadClicked:(id)sender
{
    int  section = ((UIButton *)sender).tag;
    NSLog(@"section tag %d",section);
    flagHeader = !flagHeader;
    [detailTableView beginUpdates];
    [detailTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationRight];
    [detailTableView endUpdates];
    
    if (flagHeader) {
        if (![listCommentsArray count]==0) {
            footerButton.hidden = NO;
        }else{
            footerButton.hidden = YES;
        }
    }else{
        footerButton.hidden = NO;
    }
}

-(void)actionWithWeibo
{
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"你想做什么？" delegate:self cancelButtonTitle:@"取消操作" destructiveButtonTitle:nil otherButtonTitles:@"转发",@"评论", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self repostWeibo:self.weibo];
            break;
        case 1:
            [self commentWeibo:self.weibo];
            break;
        default:
            break;
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    flagHeader = (BOOL *)(malloc(10));
//    memset(flagHeader, NO, 10);
    
    listCommentsArray = [[NSMutableArray alloc]initWithCapacity:0];
    detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStylePlain];
    detailTableView.delegate =self;
    detailTableView.dataSource = self;
   
    NSLog(@"self.weibo text :%@",self.weibo.text);
    [self.view addSubview:detailTableView];
    pageCount = 1;
    count = 0;
    [self getComments:pageCount];
}

-(void)viewWillAppear:(BOOL)animated
{
    footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    footerButton.frame = CGRectMake(0, 0, 320, 33);
    [footerButton setTitle:@"加载更多" forState:UIControlStateNormal];
    footerButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [footerButton setBackgroundImage:[[UIImage imageNamed:@"button-black.png"] stretchableImageWithLeftCapWidth:8 topCapHeight:8] forState:UIControlStateNormal];
    [footerButton addTarget:self action:@selector(getMoreComments) forControlEvents:UIControlEventTouchUpInside];
    detailTableView.tableFooterView = footerButton;
    if ([listCommentsArray count] == 0) {
        footerButton.hidden = YES;
    }
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionWithWeibo)];
                             
    self.navigationItem.rightBarButtonItem = btn;

    NSNotificationCenter * notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(getCommentsFromNet:) name:MMSinaGotCommentList object:nil];
  //  [self loadVisuableImage:detailTableView];
}

# pragma  mark -headImageClick 

-(void)statusHeadImageClicked:(User *)user
{
    MansInfoViewController * mansInfo = [[MansInfoViewController alloc] init];
    
    mansInfo.user = user;
    [self.navigationController pushViewController:mansInfo animated:YES ];
    [mansInfo release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        MansInfoViewController * man = [[MansInfoViewController alloc] init];
        man.user = ((Comment *)[listCommentsArray objectAtIndex:indexPath.row]).user;
        man.showCarebtn = YES;
        [self.navigationController pushViewController:man animated:YES];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        if (flagHeader) {
            return [listCommentsArray count];
                   }
        else{
            return 0;
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;
    }else{
        return 30;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"tempCell";
        StatusCell *cell = [[[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        [cell updateCellWith:self.weibo];
        //[cell setContent];
//        NSLog(@"section %d ： height: %f",cell.cellHeight);
        return cell.cellHeight;
    }else{
        NSInteger row = indexPath.row;
                Comment * commentInfo = [listCommentsArray objectAtIndex:row];
                CGFloat  height = 0.0f;
               height  = [self cellHeight:commentInfo.text with:160.0f]+42;
                       NSLog(@"height:%f",height);
                return height;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        StatusHead *head = [[[NSBundle mainBundle] loadNibNamed:@"StatusHead" owner:self options:nil] lastObject];
        Status *status = _weibo;
        NSLog(@"status user name%@", status.user.name);
        head.userName.text = [status.user name];
        [head.userImg setImageWithURL:[NSURL URLWithString:status.user.profileImageUrl]];
        [head.userImg.layer setMasksToBounds:YES];
        [head.userImg.layer setCornerRadius:5];
        [head.postTime setText:status.timeTamp];
//         head.UserId = [NSString stringWithFormat:@"%lld",status.user.userId];
        head.user = status.user;
        head.delegate = self;
        return head;
    }else{
        _active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _active.frame = CGRectMake(280, 2, 20, 20);
        
        MyselfStatuHead * secondHead = [[[NSBundle mainBundle]loadNibNamed:@"MyselfStatuHead" owner:self options:nil]lastObject];
        [secondHead.weiboButton setTitle:[NSString stringWithFormat:@"评论共%d条，当前显示%d条",[(commentsCount) intValue],count] forState:UIControlStateNormal];
        secondHead.delegate = self;
        secondHead.headBtn.tag = section;
        [secondHead addSubview:_active];
        return secondHead;
    }
    return nil;
}

//页脚
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    StatusFoot *view =[[[NSBundle mainBundle] loadNibNamed:@"StatusFoot" owner:self options:nil]lastObject];
    //
//    Status *weibo = [listData objectAtIndex:section];
    //    view.backgroundColor = [UIColor colorWithRed: 0.3f green:0.8f blue:0.9f alpha:1.0f];
    view.commentCount.text = [NSString stringWithFormat:@"评论:%d", self.weibo.commentsCount];
    view.repostCount.text = [NSString stringWithFormat:@"转发:%d",self.weibo.repostsCount];
    view.weibo = self.weibo;
    view.delegate = self;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{   
    if (section == 0) {
        return 44;
    }else{
        return 0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"weiboCell";
        
        StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        cell.backgroundColor = [UIColor whiteColor];
        if (cell.weiboImg.hidden == NO) {
            [cell.weiboImg setImageWithURL:[NSURL URLWithString:self.weibo.thumbnailImageUrl]];
        }if(cell.repostImg.hidden == NO){
            [cell.repostImg setImageWithURL:[NSURL URLWithString:self.weibo.retweetedStatus.thumbnailImageUrl]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Status * weibo  = self.weibo;
        NSLog(@"weibotext----------:%@", weibo.text);
        //    [cell updateCellWith:[listData objectAtIndex:row]];
        [cell updateCellWith:weibo];
        
        return cell;
    }else{
        static NSString *cellIdentifier = @"commentCell";
        TimeLineTableDetailCommentCell  * cell = [[[TimeLineTableDetailCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        //填充所有内容
        if ([listCommentsArray count] == 0) {
            NSLog(@"评论没有");
        }else{
            Comment * comment = [listCommentsArray objectAtIndex:indexPath.row];
            cell.weiboDetailCommentInfo = comment;
            CGRect frame = cell.commentContent.frame;
            frame.size.height = [self cellHeight:comment.text with:160.0];
            cell.commentContent.frame = frame;
        }
        
        if (indexPath.row%2 == 0) {
            cell.contentView.backgroundColor  = [UIColor colorWithRed:229/255.0f green:235/255.0f blue:242/255.0f alpha:1.0f];
        }else{
            cell.backgroundColor = [UIColor whiteColor];
        }

        return cell;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc
{
    [self.weibo release];
    [_active release];
    [super release];
}
@end
