//
//  FQFullScrollViewController.h
//  MovieQuiz
//
//  Created by Andrés Brun on 13/01/14.
//  Copyright (c) 2014 Andrés Brun. All rights reserved.
//


@interface ABFullScrollViewController : UIViewController <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//Polimorph methods
- (UIView *) headerView:(UIView *)view forTableView:(UITableView *)tableView;
- (float) headerHeightForTableView:(UITableView *)tableView;
- (UIColor *) toolbarBackgroundColor;
- (float) minHeightWithoutHide;

@end
