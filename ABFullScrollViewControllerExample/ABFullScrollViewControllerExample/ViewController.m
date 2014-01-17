//
//  ViewController.m
//  ABFullScrollViewControllerExample
//
//  Created by Andrés Brun on 17/01/14.
//  Copyright (c) 2014 Brun's Software. All rights reserved.
//

#import "ViewController.h"

#define HEADER_STANDARD_HEIGHT 60

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setAlpha:0.7];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Polymorph methods
-(UIView *) headerView:(UIView *)view forTableView:(UITableView *)tableView
{
    [view setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, HEADER_STANDARD_HEIGHT)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               20/*status bar*/,
                                                               view.frame.size.width,
                                                               view.frame.size.height-20)];
    [label setFont:[UIFont fontWithName:@"Copperplate" size:20]];
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"ABFullScrollViewController"];
    [view addSubview:label];
        
    return view;
}

-(float) headerHeightForTableView:(UITableView *)tableView
{
    return HEADER_STANDARD_HEIGHT;
}

- (UIColor *)toolbarBackgroundColor
{
    return [UIColor colorWithWhite:1.0 alpha:0.7];
}

- (float)minHeightWithoutHide
{
    return 20 /*status bar height*/;
}

#pragma mark - UITableView data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Cell %d", indexPath.row]];
    [cell.textLabel setTextColor:[UIColor colorWithWhite:1-(indexPath.row/40.0) alpha:1]];
    [cell setBackgroundColor:[UIColor colorWithWhite:indexPath.row/40.0 alpha:1]];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}


@end
