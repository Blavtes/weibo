//
//  FriendsSectionManager.m
//  superWeiBo6-leslie
//
//  Created by  on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendsSectionManager.h"

@implementation FriendsSectionManager
@synthesize friendsSectionArray;
@synthesize filePath;

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.filePath = NSHomeDirectory();
    self.filePath = [self.filePath stringByAppendingPathComponent:sinaFriendsSectionFilePathDocmentsdir];
    self.friendsSectionArray = [NSArray arrayWithContentsOfFile:self.filePath];
    
    friendsTable  =  [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStylePlain];
    friendsTable.delegate = self;
    friendsTable.dataSource = self;
    [self.view addSubview:friendsTable];
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    isEditing = NO;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (editing) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.friendsSectionArray.count  inSection:0 ];
        [self.friendsSectionArray addObject:@"添加好友分组"];
        [friendsTable insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [friendsTable setEditing:YES animated:YES];
    }else{
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.friendsSectionArray.count-1  inSection:0 ];
        [self.friendsSectionArray removeLastObject];
        [friendsTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [friendsTable setEditing:NO animated:YES];
    }
    [super setEditing:editing animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.textLabel.text = [self.friendsSectionArray objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.friendsSectionArray count];
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    // 编辑模式的情况下，将最后的Row变成插入模式
    if ( tableView.editing && self.friendsSectionArray.count <= indexPath.row + 1 ) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"index:%d",indexPath.row);
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"修改组名" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle= UIAlertViewStylePlainTextInput;
    alert.delegate = self;
    alert.tag = alertUpateTag;
    
    for (id ui in [alert subviews]) {
        if ([ui isKindOfClass:[UIButton class]]) {
            if ([((UIButton *)ui).titleLabel.text isEqualToString:@"OK"]) {
                // ((UIButton *)ui).enabled = NO;
                okBtn = (UIButton *)ui;
            }
        }
    }
    okBtn.enabled = NO;
    UITextField * textfiled = [alert textFieldAtIndex:0];
    textfiled.delegate = self;
    textfiled.text = [self.friendsSectionArray objectAtIndex:indexPath.row];
    cellIndex = indexPath.row;
    [alert show];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.friendsSectionArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [self.friendsSectionArray writeToFile:self.filePath atomically:YES];
    }else if(UITableViewCellEditingStyleInsert == editingStyle){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"添加分组" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        for (id ui in [alert subviews]) {
            if ([ui isKindOfClass:[UITextField class]]) {
                ((UITextField *)ui).placeholder = @"填写新的好友分组";
            }
        }
        alert.delegate = self;
        alert.tag = alertInsertTag;
        [alert show];
        
        for (id ui in [alert subviews]) {
            if ([ui isKindOfClass:[UIButton class]]) {
                if ([((UIButton *)ui).titleLabel.text isEqualToString:@"OK"]) {
                    // ((UIButton *)ui).enabled = NO;
                    okBtn = (UIButton *)ui;
                }
            }
        }
        okBtn.enabled = NO;
        UITextField * textfiled = [alert textFieldAtIndex:0];
        textfiled.delegate = self;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   //string为当前写在textfiled上的字符
    NSLog(@"textFiled:%@",textField.text);
    NSLog(@"string:%@",string);
    static  int flag = 0;
    static  int flagcount = 0;
    
    if (flag == 0) {
        if ([string isEqualToString:@""]) {
            okBtn.enabled = NO;
        }else{
            okBtn.enabled = YES;
        }
        flag = 1;
    }else{
        if ([textField.text length] == 1) {
            if (flagcount%2 == 0) {
                 okBtn.enabled = NO;
            }
            flagcount ++;
            flag = 0;
        }else if([textField.text length] == 0 ){
            okBtn.enabled = YES;
        }
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"editend");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     UITextField * textfiled = [alertView textFieldAtIndex:0];
    if (alertView.tag == alertInsertTag) {
        if (buttonIndex == 1) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.friendsSectionArray.count-1 inSection:0];
            [self.friendsSectionArray insertObject:textfiled.text atIndex:self.friendsSectionArray.count-1];
            [friendsTable insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
    }else if(alertView.tag == alertUpateTag){
        if (buttonIndex == 1) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:cellIndex inSection:0];
            [self.friendsSectionArray removeObjectAtIndex:cellIndex];
            
            [friendsTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            [self.friendsSectionArray insertObject:textfiled.text atIndex:cellIndex];
            [friendsTable insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }
    }
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
