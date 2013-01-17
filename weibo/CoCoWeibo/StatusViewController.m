//
//  StatusViewController.m
//  superWeiBo6-leslie
//
//  Created by coobei on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StatusViewController.h"
#import "Test.h"
#import "TimeLineViewDetailController.h"
#import "AcountManager.h"
#import "ImagesViewer.h"
#import <QuartzCore/QuartzCore.h>
#import "ZJTHelpler.h"
//#import "UIImage+CutUIImage.h"
#import "StatusViewDetailController.h"
#import "EGORefreshTableHeaderView.h"
#import "MansInfoViewController.h"
#import "ImageViewConreoller.h"

@implementation StatusViewController
@synthesize weiboTable = _weiboTable;
@synthesize listData;
@synthesize user = _user;
@synthesize cellArray;
@synthesize showWhichIndex;
@synthesize customUserID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        messageManager = [[WeiBoMessageManager getInstance]retain];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


//如果保证平滑
//为是么用异步， 就是为了肥皂滑 ui流畅
//1.图片数据异步从网络上下载
//2.tableview中图片是需要的时候（滚动停下来 可见的cell）才加载
//3.下载完的图片 缓存起来
//加载可见图片
-(void)loadVisuableImage:(UITableView *)scrollView
{
    NSArray *array  = [scrollView visibleCells];
    
    for ( StatusCell *cell  in array) {
        NSIndexPath *path =  [scrollView indexPathForCell:cell];
        
        Status *weibo  = [listData objectAtIndex:path.section];
//        StatusHead *head =(StatusHead *) [self tableView:_weiboTable viewForHeaderInSection:path.section];
//        NSLog(@"head section %d", path.section);
//        NSLog(@"head %@", head);
//        NSLog(@"status user name%@", weibo.user.name);
        //使用SDWebImageManager类：可以进行一些异步加载的工作。
        SDWebImageManager *sdManager = [SDWebImageManager sharedManager];
        
//        //下载头像
//        head.userName.text = [weibo.user name];
//        [head.userImg setImageWithURL:[NSURL URLWithString:weibo.user.profileImageUrl]];
//        [head.userImg.layer setMasksToBounds:YES];
//        [head.userImg.layer setCornerRadius:5];
//        
//        NSLog(@"head - user - name :%@", head.userName.text);
//        [head setNeedsDisplay];
        //下载微博图片
    if (cell.weiboImg.image == [UIImage imageNamed:@"loadingIMG.png"] || 
        cell.repostImg.image == [UIImage imageNamed:@"loadingIMG.png"]) 
        {
            if (cell.weiboImg.hidden == NO) {
                //判断是否有本地缓存
                NSURL *imgURL = [NSURL URLWithString:weibo.thumbnailImageUrl];
                UIImage *cachedImage = [sdManager imageWithURL:imgURL];
                if (cachedImage) {
                    //如果cache命中，则直接利用缓存的图片进行有关操作
                    [UIView animateWithDuration:0.3 animations:^{
                        cell.weiboImg.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                         cell.weiboImg.alpha = 1.0f;
                         [cell.weiboImg setImage:cachedImage];
                    }];
                }else{
                    //如果没有命中，则去指定url下载图片
                    //增加进度条
                    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    [cell.weiboImg addSubview:loading];
                    loading.center = cell.weiboImg.center;
                    [loading startAnimating];
                    [UIView animateWithDuration:0.3 animations:^{
                        cell.weiboImg.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.3 animations:^{
                            cell.weiboImg.alpha = 1.0f;
                            [cell.weiboImg setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"loadingIMG.jpg"]];
                            [loading stopAnimating];
                            [loading removeFromSuperview];
                            [loading release];
                        } ];
                    }];
                 }
            }
            if (cell.repostImg.hidden == NO) {
                NSURL *imgURL = [NSURL URLWithString:weibo.retweetedStatus.thumbnailImageUrl];
                UIImage *cachedImage = [sdManager imageWithURL:imgURL];
                if (cachedImage) {
                    [UIView animateWithDuration:0.3 animations:^{
                        cell.weiboImg.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        cell.weiboImg.alpha = 1.0f;
                        [cell.repostImg setImage:cachedImage];
                    }];
                }
                else{
                    cell.repostImg.image =  [ UIImage imageNamed:@"loadingIMG.png"];
                    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    [cell.weiboImg addSubview:loading];
                    loading.center = cell.weiboImg.center;
                    [loading startAnimating];
                    [UIView animateWithDuration:0.3 animations:^{
                        cell.repostImg.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.3 animations:^{
                            cell.repostImg.alpha = 1.0f;
                            [cell.repostImg setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"loadingIMG.jpg"]];
                            [loading stopAnimating];
                            [loading removeFromSuperview];
                            [loading release];
                        }];
                    }];
                }
            }
        }
         [cell setNeedsDisplay];
    }
}

#pragma mark - WeiBoMessageManager 广播

-(void)didGetHomeLine:(NSNotification *)sender
{
    [headView setState:EGOOPullRefreshLoading];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    _weiboTable.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    [UIView commitAnimations];

    if ([sender.object isKindOfClass:[NSArray class]]) {
        NSArray * tempArr = [sender.object retain];
        if (isAddToListData) {
            [listData addObjectsFromArray:tempArr];
        }else{
            listData = [sender.object retain];
        }
        [_weiboTable reloadData];
        [self loadVisuableImage:_weiboTable];
    }
    isloading = NO;
}

//获取微博
-(void)getWeibo:(id)sender
{
    //用于解决网络请求失败时  多次弹窗的bug
    alertCount = 0;
      //int count = 100,page = 0;
#if 1
    messageManager  = [WeiBoMessageManager getInstance];
    
    switch (showWhichIndex) {
        case HomeIndex:
        {
            if (SharedApp.currentWeiboindex == sinaIndex) {
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
                NSDictionary *privDict = [sinaOAuthManager getCommonParams];
                [params addEntriesFromDictionary:privDict];
                NSLog(@"点击获取微博");
                NSLog(@"params%@",params);
                if (isAddToListData) {
                    NSLog(@"sinaPageCount:%d",sinaPageCount);
                [messageManager  getHomeLine:0 maxID:0 count:10 page:sinaPageCount baseApp:0 feature:0];
                    sinaPageCount++;
                }else{
                [messageManager  getHomeLine:0 maxID:0 count:10 page:1 baseApp:0 feature:0];
                }
            }else if(SharedApp.currentWeiboindex == tencentIndex){
                //    if(SharedApp.currentWeiboindex == tencentIndex){
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
                NSDictionary *privDict = [tencentOAuthManager getCommonParams];
                [params addEntriesFromDictionary:privDict];
                NSLog(@"点击获取微博");
                NSLog(@"params%@",params);
                
                NSString * oauth_consumer_key = TENCENT_APP_KEY;
                NSString * access_token = [params objectForKey:@"access_token"];
                NSString * openid = [params objectForKey:@"openid"];
                NSString * clientip = [params objectForKey:@"clientip"];
                NSString * oauth_version = [params objectForKey:@"oauth_version"];
                NSString * scope = @"all";
                
                if (isAddToListData) {
                    [messageManager getTencentHomeLine:@"json" pageflag:tencentpageCount pagetime:0 reqnum:10 type:0 contenttype:0x80 oauth_consumer_key:oauth_consumer_key access_token: access_token openid:openid clientip:clientip oauth_version:oauth_version scope:scope];
                    tencentpageCount ++;
                }else{
                    [messageManager getTencentHomeLine:@"json" pageflag:0 pagetime:0 reqnum:10 type:0 contenttype:0x80 oauth_consumer_key:oauth_consumer_key access_token: access_token openid:openid clientip:clientip oauth_version:oauth_version scope:scope];
                }
                
            }
        }
            break;
        case CustomHomeIndex:{
            [messageManager getUserStatusUserID:customUserID sinceID:0 maxID:0 count:10 page:1 baseApp:0 feature:0];
        }
            break;
            case MessageIndex:
        {
            [messageManager getMetionsStatuses];
        }
            break;
        default:
            break;
    }
           
            
   #else  //测试数据
    listData = [[NSMutableArray alloc]initWithArray: [Test createWeiboModel:20]];
    for (Status *weibo in listData) {
        NSLog(@"假数据 ：%@", weibo.text);
    }
    [self didGetHomeLine:listData];
#endif
}

-(void)loadUserData
{
    NSString *userID = nil;
    if (_user) {
        userID = [NSString stringWithFormat:@"%lld",_user.userId];
    }
    else {
        userID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
    }
    [messageManager getUserInfoWithUserID:[userID longLongValue]];
}


-(void)getUserInfo:(NSNotification *)sender
{
    User * user = sender.object;
    self.user = user;
    NSLog(@"self.user:%d",user.followersCount);
    [ZJTHelpler getInstance].user = user;
}


#pragma mark - 判断当前的登陆状态 -

-(void)isAlreadyLoginAndGetWeibo
{
    if (SharedApp.currentWeiboindex == sinaIndex) {
        if ([sinaOAuthManager isAlreadyLogin]) {
            NSLog(@"isAlreadyLogin");
    
            if (isSinaFirstShow == YES) {
                NSLog(@"isAlreadyLogin then get weibo");
                 [self getWeibo:nil];
            }
            isSinaFirstShow = NO;
        }else{
             NSLog(@"notAlreadyLogin");
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sina登陆" message:@"请登陆后再进行操作" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"登陆", nil];
            alert.delegate  = self;
            [alert show];
            isSinaFirstShow = YES;
        }
    }else if(SharedApp.currentWeiboindex == tencentIndex){
        if ([tencentOAuthManager isAlreadyLogin]) {
            if (isTencentFirstShow == YES) {
                 [self getWeibo:nil];
            }
            isTencentFirstShow = NO;
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Tencent登陆" message:@"请登陆后再进行操作" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"登陆", nil];
            alert.delegate  = self;
            [alert show];
            isTencentFirstShow = YES;
        }
    }    
}

-(void)removeNotiFicationOfFiledRequest
{
    NSNotificationCenter * notification = [NSNotificationCenter defaultCenter];
      [notification removeObserver:MMSinaRequestFailed];
}

-(void)alertToCution:(NSNotification *)noti
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常" message:@"您的请求不成功！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        alertCount = 0;
    if (alertCount == 0) {
          [alert show];
        alertCount++;
    }
    [self  removeNotiFicationOfFiledRequest];
    alert.delegate = self;
}


#pragma mark - UIAlertViewDelegate -

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        AcountManager * acount = [[AcountManager alloc] init];
        [self.navigationController pushViewController:acount animated:YES];
    }
}

# pragma  mark -headImageClick 

-(void)statusHeadImageClicked:(User *)user
{
    MansInfoViewController * mansInfo = [[MansInfoViewController alloc] init];
    
    mansInfo.user = user;
    mansInfo.showCarebtn = YES;
    [self.navigationController pushViewController:mansInfo animated:YES ];
    [mansInfo release];
}

#pragma mark - tableViewDelegate
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"weiboCell";
    
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Status *weibo  = [listData objectAtIndex:indexPath.section];
    NSLog(@"---------- 微博:%@", weibo.text);
    NSLog(@"---------- 转发:%@", weibo.retweetedStatus.text);
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell updateCellWith:weibo];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.weiboImg.image = [UIImage imageNamed:@"loadingIMG.png"];
    cell.repostImg.image = [UIImage imageNamed:@"loadingIMG.png"];
    //不能在这个地方来下载图片
    //如果这个函数cellForRowAtIndexPath
    //如果从0行翻到999行，这个函数就会至少调用1000次
    //NSLog(@"section %d ",indexPath.section);
    // [cell updateCellWith:[listData objectAtIndex:row]];
     
    [cell updateCellWith:weibo];
     cell.delegate =self;
//    [cell setNeedsDisplay];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.section;
    static NSString *cellIdentifier = @"weiboCell";
    Status *weibo  = [listData objectAtIndex:row];
    StatusCell *cell  = [[[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    [cell updateCellWith:weibo];
   
    NSLog(@"section %d ： height: %f",row,cell.cellHeight);
    return cell.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SharedApp.currentWeiboindex == tencentIndex) {
        return;
    }
    StatusViewDetailController * Detail = [[StatusViewDetailController alloc] init];
    Detail.weibo = [listData objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:Detail animated:YES];
   // [Detail release];
}

//时间转换
-(NSString *)dateInFormat:(time_t)dateTime 
{
    NSString  *stringFormat = @"%Y.%m.%d %H:%M:%S";    
    char buffer[80];
    const char *format = [stringFormat UTF8String];
    struct tm * timeinfo;
    timeinfo = localtime(&dateTime);
    strftime(buffer, 80, format, timeinfo);
    return [NSString  stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

//页眉
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{   
    StatusHead *head = [[[NSBundle mainBundle] loadNibNamed:@"StatusHead" owner:self options:nil] lastObject];
    Status *status = [listData objectAtIndex:section];
    NSLog(@"status user name%@", status.user.name);
    head.userName.text = [status.user name];
    [head.userImg setImageWithURL:[NSURL URLWithString:status.user.profileImageUrl]];
    [head.postTime setText:status.timeTamp];
    head.user = status.user;
    head.delegate = self;
    return head;
}

//页脚
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    StatusFoot *view =[[[NSBundle mainBundle] loadNibNamed:@"StatusFoot" owner:self options:nil]lastObject];
    //
    Status *weibo = [listData objectAtIndex:section];
//    view.backgroundColor = [UIColor colorWithRed: 0.3f green:0.8f blue:0.9f alpha:1.0f];
    view.commentCount.text = [NSString stringWithFormat:@"评论:%d", weibo.commentsCount];
    
    view.repostCount.text = [NSString stringWithFormat:@"转发:%d",weibo.repostsCount];
    view.weibo = weibo;
    view.delegate = self;
    return view;
}

//转发微博
-(void)repostWeibo:(Status *)weibo
{
    PostViewController *postView = [[PostViewController alloc]init];
    postView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    postView.delegate = self;
    postView.status = weibo;
    postView.witchOperating = repost;
    [self presentModalViewController: postView animated:YES];
}

//评论微博
-(void)commentWeibo:(Status *)weibo
{
    PostViewController *postView = [[PostViewController alloc]init];
    postView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    postView.delegate = self;
    postView.witchOperating = comment;
    [self presentModalViewController: postView animated:YES];
}
//关闭发送视图
-(void)closePostView:(id)sender
{
    [sender dismissModalViewControllerAnimated:YES];
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 36;
}
-(void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    NSLog(@"图片下载完毕");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <-65&&isloading == NO) {
        [headView setState:EGOOPullRefreshPulling];
    }else if(scrollView.contentOffset.y >-65 && isloading==NO){
        [headView setState:EGOOPullRefreshNormal];
    }
}

//手指离开屏幕时候调用
//if decelerate == YES 说明tableview正在减速，说明在快速滑动
//if decelerage == NO 说明tableview 没有在减速， 而且已经停止下来了，说明在缓慢滑动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (scrollView.contentOffset.y<-65) {
        isloading = YES;
        [headView setState:EGOOPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        _weiboTable.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        [UIView commitAnimations];
        [self performSelector:@selector(getWeibo:) withObject:nil afterDelay:1];
        isAddToListData = NO;
    }

    if (decelerate == YES) {
        //不需要加载
    }else if(decelerate == NO){
        //需要加载当前可见tableviewcell图片
    }
}

////只要这个函数调用，就说明之前是在减速，是在快速滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadVisuableImage:(UITableView *)scrollView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [listData count];
}
-(void)closeViewer:(id)sender
{
    UIView *view = (UIView *)sender;
    [UIView animateWithDuration:0.5 animations:^{
        view.frame  = CGRectMake(0, -460, 320, 460);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}


#pragma mark - imageClick
-(void)statusImageClicked:(Status *)theStatus
{
    ImagesViewer *viewer = [[ImagesViewer alloc]initWithFrame:self.view.bounds];
    viewer.delegate = self;
   
    UIActivityIndicatorView *loadingView  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView startAnimating];
    [viewer addSubview:loadingView];
    [loadingView release];
    loadingView = nil;
    viewer.frame  = CGRectMake(0, -460, 320, 460);
    [self.view.superview addSubview:viewer];
    viewer.imges.alpha = 0;
    [UIView animateWithDuration:0.5
                    animations:^{
                        viewer.frame  = CGRectMake(0, -20, 320, 460);
                        viewer.imges.alpha = 1.0f;
                        
                        [viewer.imges setImageWithURL:[NSURL URLWithString:theStatus.middleImageUrl]];
//                        viewer.imageUrl = theStatus.middleImageUrl;
                        NSLog(@"URLWithString:theStatus.middleImageUrl:%@",theStatus.middleImageUrl);
                    } completion:^(BOOL finished) {
                        [loadingView stopAnimating];
                        [loadingView removeFromSuperview];
                    }];
    
//    ImageViewConreoller * imageView = [[ImageViewConreoller alloc] init];
//    imageView.imageUrl = theStatus.middleImageUrl;
//    
//    [self presentModalViewController:imageView animated:YES];
    
}


-(void)getMoreWeiboFromnet
{
    isAddToListData = YES;
    [self getWeibo:nil];
    
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

-(void)dealloc
{
    self.weiboTable = nil;
    self.cellArray = nil;
    self.listData = nil;
    self.weiboTable = nil;
    self.user=nil;
    [sinaOAuthManager release];
    sinaOAuthManager = nil;
    [tencentOAuthManager release];
    tencentOAuthManager = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    sinaPageCount = 2;
    tencentpageCount = 1;
//     [self.view setBackgroundColor:[UIColor colorWithRed:229/255.0f green:235/255.0f blue:242/255.0f alpha:1.0f]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]]];
    NSLog(@"self navigationController  is :%@" ,[self navigationController]);
    cellArray = [[NSMutableArray alloc]initWithCapacity:0];
    sinaOAuthManager = [[OAuthManager alloc]initWithOAuthManager:SINA_WEIBO];
    tencentOAuthManager = [[OAuthManager alloc]initWithOAuthManager:TENCENT_WEIBO];
    listData = [[NSMutableArray alloc]initWithCapacity:0];
    isSinaFirstShow = YES;
    isTencentFirstShow = YES;
    messageManager = [WeiBoMessageManager getInstance];
    //注册广播
    
    self.weiboTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStylePlain];
    _weiboTable.delegate = self;
    _weiboTable.dataSource = self;
    
    UIButton * footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerBtn setBackgroundImage:[[UIImage imageNamed:@"tabbar_greenbtn"]resizableImageWithCapInsets:UIEdgeInsetsMake(8, 16, 8, 16)] forState:UIControlStateNormal];
    footerBtn.frame = CGRectMake(0, 0, 320, 44);
    [footerBtn setTitle:@"加载更多" forState:UIControlStateNormal];
    [footerBtn addTarget:self action:@selector(getMoreWeiboFromnet) forControlEvents:UIControlEventTouchUpInside];
    _weiboTable.tableFooterView = footerBtn;
    [_weiboTable setBackgroundColor: [UIColor clearColor]];
    [_weiboTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_weiboTable];
}

-(void)createPullRefreshHead
{
    headView  = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -200, 320, 200)];
    [_weiboTable addSubview:headView];
   // [_weiboTable bringSubviewToFront:head]
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSNotificationCenter * notification = [NSNotificationCenter defaultCenter];
    //注册广播
    [notification addObserver:self selector:@selector(didGetHomeLine:) name:MMSinaGotHomeLine object:nil];
    [notification addObserver:self selector:@selector(didGetHomeLine:) name:MMSinaGotUserStatus object:nil];
      [notification addObserver:self selector:@selector(didGetHomeLine:) name:MMSinaGotMetionsStatuses object:nil];
    [notification addObserver:self selector:@selector(getUserInfo:) name:MMSinaGotUserInfo object:nil];
    [notification addObserver:self selector:@selector(alertToCution:) name:MMSinaRequestFailed object:nil];
    
    [self loadUserData];
    [self  createPullRefreshHead];
    [self isAlreadyLoginAndGetWeibo];
    [self.weiboTable reloadData];
    [self.weiboTable reloadSectionIndexTitles];
    [self loadVisuableImage:_weiboTable];
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSNotificationCenter *defaultNotifCenter  = [NSNotificationCenter defaultCenter];
    //移除广播
    [defaultNotifCenter removeObserver:self name:MMSinaGotHomeLine object:nil];
    
    [defaultNotifCenter removeObserver:self name:MMSinaGotUserStatus object:nil];
    
    [defaultNotifCenter removeObserver:self  name:MMSinaGotUserInfo object:nil];
    
    [defaultNotifCenter removeObserver:self name:MMSinaGotMetionsStatuses object:nil];
    
    [defaultNotifCenter removeObserver:self name:MMSinaRequestFailed object:nil];
}

//-(void)viewDidUnload
//{
//        NSNotificationCenter *defaultNotifCenter  = [NSNotificationCenter defaultCenter];
//        
//        //移除广播
//        [defaultNotifCenter removeObserver:self name:MMSinaGotHomeLine object:nil];
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
