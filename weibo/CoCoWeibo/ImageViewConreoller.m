//
//  ImageViewConreoller.m
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageViewConreoller.h"
#import "HHNetDataCacheManager.h"
@implementation ImageViewConreoller
@synthesize imges = _imges;
@synthesize imageUrl = _imageUrl;

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
    // Do any additional setup after loading the view from its nib.
      NSNotificationCenter * noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(addImageToViwer:) name: HHNetDataCacheNotification object:nil];
    
    [[HHNetDataCacheManager getInstance] getDataWithURL:self.imageUrl withIndex:1];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)addImageToViwer:(NSNotification *)noti
{
    NSData * data = noti.object;
    UIImage * image = [UIImage imageWithData:data];
    NSLog(@"[UIImage imageWithData:data]:%@",image);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
