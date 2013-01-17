//
//  TabManagerController.m
//  superWeiBo6-leslie
//
//  Created by  on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TabManagerController.h"

@implementation TabManagerController

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

-(void)editClicked:(id)sender
{
    if (isEditing) {
        isEditing = NO;
         self.navigationItem.rightBarButtonItem.title = @"编辑";
        [myTableView setEditing:NO animated:YES];

    }else{
        self.navigationItem.rightBarButtonItem.title = @"完成";
        [myTableView setEditing:YES animated:YES];
        isEditing = YES;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
       
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]]];
    NSString *  filepath = NSHomeDirectory();
    filepath = [filepath stringByAppendingPathComponent:@"Documents/tab.plist"];
    NSString *  noWeibofilepath = NSHomeDirectory();
    noWeibofilepath = [noWeibofilepath stringByAppendingPathComponent:@"Documents/noWeibotab.plist"];

    contactsArray = [[NSMutableArray alloc] initWithContentsOfFile:filepath];
    if (contactsArray == nil) {
        contactsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
  
    nocontactsArray = [[NSMutableArray alloc] initWithContentsOfFile:noWeibofilepath];
    if (nocontactsArray == nil) {
        nocontactsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    NSLog(@"nocontactsArray:%@",nocontactsArray);
    
    
    dataSource = [[NSMutableArray alloc]initWithCapacity:0];
    [dataSource addObject:contactsArray];
    [dataSource addObject:nocontactsArray];
    
    NSLog(@"dataSource:%@",dataSource);
    
    
    sectionStrArray = [[NSArray alloc] initWithObjects:@"已添加的微博",@"未添加的微博", nil];
        
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStyleGrouped];
    //传递当前类的实例的指针给表格控件
    myTableView.delegate=self;
    myTableView.backgroundColor  = [UIColor colorWithRed:229/255.0f green:235/255.0f blue:242/255.0f alpha:1.0f];
    myTableView.dataSource=self;

    //myTableView.alpha = 0.5;
//     [ myTableView.backgroundView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_pattern_wood.png"]]];
    [self.view addSubview:myTableView];
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(editClicked:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    //self.navigationItem.rightBarButtonItem = [self editButtonItem];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionStrArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataSource objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId  = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        [cell autorelease];
    }
   // cell.alpha = 0.5;
    cell.textLabel.text = [[dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSLog(@"dataSource:%@",[[dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    //NSLog(@"array:%@",[contactsArray objectAtIndex:indexPath.row]);
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView*)tableView canMoveRowAtIndexPath:(NSIndexPath*)indexPath {
    // 最后单元之外的情况下YES
   // return ( contactsArray.count > indexPath.row + 1 );
    
    if (indexPath.section == 1) {
        return NO;
    }
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
       return  [sectionStrArray objectAtIndex:section];
}

//添加和删除动画未加，加动画的话存在BUG
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *  filepath = NSHomeDirectory();
    filepath = [filepath stringByAppendingPathComponent:tabIndexFilePathDocumentsdir];
    NSString *  noWeibofilepath = NSHomeDirectory();
    noWeibofilepath = [noWeibofilepath stringByAppendingPathComponent:tabNoAddToTabWeiboFilePathDocumentsdir];
   // NSLog(@"filepath:%@",filepath);
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       // NSLog(@"predataSorce:%@",dataSource);
        NSString * tempStr = [[dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [[dataSource objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
           
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      //   NSLog(@"editingStyledataSource0 before:%@",dataSource);
        [[dataSource objectAtIndex:0] writeToFile:filepath atomically:YES];
      
        [[dataSource objectAtIndex:1] addObject:tempStr];
      //   NSLog(@"editingStyledataSource1 before:%@",dataSource);
        [[dataSource objectAtIndex:1] writeToFile:noWeibofilepath atomically:YES];
        [myTableView reloadData];

    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        NSString * tempStr = [[dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
               
        [[dataSource objectAtIndex:0] addObject:tempStr];
      //  NSLog(@"dataSource0 before:%@",dataSource);
        [[dataSource objectAtIndex:0] writeToFile:filepath atomically:YES];
        
        [[dataSource objectAtIndex:1] removeObjectAtIndex:indexPath.row];
       //  NSLog(@"dataSource1 before:%@",dataSource);
        [[dataSource objectAtIndex:1] writeToFile:noWeibofilepath atomically:YES];

        
        [myTableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString * filepath = NSHomeDirectory();
    filepath = [filepath stringByAppendingPathComponent:@"Documents/tab.plist"];
    NSString *  noWeibofilepath = NSHomeDirectory();
    noWeibofilepath = [noWeibofilepath stringByAppendingPathComponent:@"Documents/noWeibotab.plist"];

    if (sourceIndexPath.section == destinationIndexPath.section) {
               
        NSString * strWeibo = [[dataSource objectAtIndex:sourceIndexPath.section] objectAtIndex:sourceIndexPath.row];
        [strWeibo copy];
        [[dataSource objectAtIndex:0] removeObjectAtIndex:sourceIndexPath.row];
        [[dataSource objectAtIndex:0] insertObject:strWeibo atIndex:destinationIndexPath.row];
        [[dataSource objectAtIndex:0] writeToFile:filepath atomically:YES];
        [myTableView reloadData];
    }else{
    
       NSString * tempStr = [[dataSource objectAtIndex:sourceIndexPath.section] objectAtIndex:sourceIndexPath.row];
       [[dataSource objectAtIndex:sourceIndexPath.section] removeObjectAtIndex:sourceIndexPath.row];
       [[dataSource objectAtIndex:destinationIndexPath.section] insertObject:tempStr atIndex:destinationIndexPath.row];
        if (sourceIndexPath.section == 0) {
            [[dataSource objectAtIndex:sourceIndexPath.section] writeToFile:filepath atomically:YES];
             [[dataSource objectAtIndex:destinationIndexPath.section] writeToFile:noWeibofilepath atomically:YES];
        }else{
            [[dataSource objectAtIndex:sourceIndexPath.section] writeToFile:noWeibofilepath atomically:YES];
             [[dataSource objectAtIndex:destinationIndexPath.section] writeToFile:filepath atomically:YES];
        }

    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.editing&&indexPath.section == 0) {
        return UITableViewCellEditingStyleDelete;
    }else if(tableView.editing&&indexPath.section == 1)
    {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
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

@end
