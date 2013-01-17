//
//  TimeLineViewDetailController.m
//  superWeiBo6-leslie
//
//  Created by  on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TimeLineViewDetailController.h"
#import "TimeLineTableDetailCommentCell.h"
#import "Test.h"
#import "weiboDetailCommentInfo.h"
@implementation TimeLineViewDetailController
@synthesize weibo = _weibo;
@synthesize commentListArray = _commentListArray;
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
// 
// 
//
//}

#pragma mark - 获取评论列表
-(NSMutableArray *)getComments
{
    _commentListArray = [[NSMutableArray alloc] initWithArray:[Test createWeiboCommentModel:20]];
    return _commentListArray;
}

//计算text field 的高度。
-(CGFloat)cellHeight:(NSString*)contentText with:(CGFloat)with
{
    UIFont * font=[UIFont  systemFontOfSize:14];
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(with, 300000.0f) lineBreakMode: UILineBreakModeWordWrap];
    CGFloat height = size.height + 0.;
    return height;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    UITableView * timeLineDetailTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStylePlain];
    timeLineDetailTableView.delegate= self;
    timeLineDetailTableView.dataSource = self;
    
    [self.view addSubview:timeLineDetailTableView];
    [timeLineDetailTableView release];   
    [self getComments];
    self.title = @"微博详情";
        //[super viewDidLoad];
  }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
//    NSString *retImgUrl = self.weibo.thumbnailImageUrl;
//    NSString *imgUrl = self.weibo.thumbnailImageUrl;
//    
//    StatusViewController *cell = [[[NSBundle mainBundle]loadNibNamed:@"TimeLineTableCell" owner:self options:nil] lastObject];
//    [cell updateCellTextWith:_weibo];
//    
//    CGFloat height = 0.0f;
//    //有转发博文
//    if(self.weibo && [self.weibo isEqual:[NSNull null]]){
//        [cell setContenWithHaveImage:NO 
//                    haveRepostImages:retImgUrl != nil && [retImgUrl length] != 0 ? YES:NO];
//        height  = [cell contentHeight];
//    }else{ //无转发博文
//        [cell setContenWithHaveImage:imgUrl != nil && [imgUrl length] != 0 ? YES:NO 
//                    haveRepostImages:NO];
//        height = [cell contentHeight];
//    }
//    if (indexPath.section == 0) {
//        return height;    
//    }else{
//        NSInteger row = indexPath.row;
//        weiboDetailCommentInfo * commentInfo = [_commentListArray objectAtIndex:row];
//        CGFloat  height = 0.0f;
//       height  = [self cellHeight:commentInfo.commentContentStr with:228.0f]+42;
//               NSLog(@"height:%f",height);
//        return height;
//    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    NSString *string = @"weibo";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
          cell = [[[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string] autorelease];
    } 
        cell.backgroundColor = [UIColor whiteColor];
        NSInteger row = indexPath.section;
        if (row >= [listData count]) {
            return cell;
        }
        Status *weibo  = [listData objectAtIndex:row];
        NSLog(@"weibotext----------:%@", weibo.text);
        [cell updateCellWith:weibo];
        
      //  [cell setContent];
        return cell;
    }else{
        
        NSString * string = @"comment";
        
        //此处重用会导致第二页Cell行高错乱
        
//        TimeLineTableDetailCommentCell * cell = (TimeLineTableDetailCommentCell *)[tableView dequeueReusableCellWithIdentifier:string];
     //   if (!cell) {
            weiboDetailCommentInfo * weiboDetailCommentinfo = [_commentListArray objectAtIndex:indexPath.row];
         TimeLineTableDetailCommentCell  * cell = [[[TimeLineTableDetailCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string] autorelease];
            //填充所有内容
            cell.weiboDetailCommentInfo = weiboDetailCommentinfo;
            CGRect frame = cell.commentContent.frame;
         frame.size.height = [self cellHeight:weiboDetailCommentinfo.commentContentStr with:228.0];
            cell.commentContent.frame = frame;
        
        return cell;
    }
}


//复写父类的方法 使其不能点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
        return [_commentListArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"微博评论";
    }else
        return nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc
{
   // [timeLineDetailTableView release];
    [self.weibo release];
    [super release];
}

@end
