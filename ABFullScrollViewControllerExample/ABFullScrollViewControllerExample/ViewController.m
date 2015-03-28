//
//  ViewController.m
//  ABFullScrollViewControllerExample
//
//  Created by Andrés Brun on 17/01/14.
//  Copyright (c) 2014 Brun's Software. All rights reserved.
//

#import "ViewController.h"

const CGFloat headerStandardHeight = 60;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *headerContainerView;

@end

@implementation ViewController

#pragma mark - UITableView data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Cell %ld", (long)indexPath.row]];
    [cell.textLabel setTextColor:[UIColor colorWithWhite:1-(indexPath.row/40.0) alpha:1]];
    [cell setBackgroundColor:[UIColor colorWithWhite:indexPath.row/40.0 alpha:0.3]];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

#pragma mark - ABMFullScroll Delegates
- (void)scroll:(UIScrollView *)scroll animationForHeaderView:(UIView *)view percent:(CGFloat)percent {
    [self.headerContainerView setAlpha:percent];
    
    CGFloat transform = MIN(percent+0.5, 1);
    [self.headerContainerView setTransform:CGAffineTransformMakeScale(transform, transform)];
}

@end
