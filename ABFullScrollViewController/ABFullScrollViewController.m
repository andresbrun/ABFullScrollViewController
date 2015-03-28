//
//  FQFullScrollViewController.m
//  MovieQuiz
//
//  Created by Andrés Brun on 13/01/14.
//  Copyright (c) 2014 Andrés Brun. All rights reserved.
//

#import "ABFullScrollViewController.h"

const CGFloat defaultHeaderHeight = 44;
const CGFloat statusBarHeight = 20;

@interface ABFullScrollViewController (){
    float _initialYContentOffset;
    float _previousYOffset;
    float _headerViewHeight;
    
    BOOL _dragging;
}

@property (strong, nonatomic) UIView *headerView;
@end

@implementation ABFullScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUInteger headerViewTmpTag = 1001;
    
    if (self.tableView) {
        
        self.headerView = [self headerView:[self createDefaultHeaderView] forTableView:self.tableView];
        [self.headerView setTag:headerViewTmpTag];
        
        _headerViewHeight = [self headerHeightForTableView:self.tableView];
        
        UIEdgeInsets edges = self.tableView.contentInset;
        [self.tableView setContentInset:UIEdgeInsetsMake(_headerViewHeight, edges.left, edges.bottom, edges.right)];
        
        _initialYContentOffset = 0;
        _previousYOffset = _initialYContentOffset;
    }
    
    if(self.toolbar) {
        [self.toolbar setBarTintColor:[self toolbarBackgroundColor]];
        [self.toolbar setFrame:CGRectMake(0,
                                          0,
                                          self.view.frame.size.width,
                                          _headerViewHeight)];
        
        if(self.headerView){
            [[self.toolbar viewWithTag:headerViewTmpTag] removeFromSuperview];
            [self.toolbar addSubview:self.headerView];
            [self.headerView setAlpha:1.0];
        }
        
    }
}

#pragma mark - UIScrollView Delegates
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    float delta = _previousYOffset-scrollView.contentOffset.y;
    [self moveHeaderToY:delta];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _dragging=YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(self.toolbar && _dragging){
        
        //Move toolbar
        float yCurrentOffset =  scrollView.contentOffset.y;
        
        //Avoid a wrong behaviour when scroll bounce to top
        if(yCurrentOffset>_initialYContentOffset){
            
            float delta = _previousYOffset-yCurrentOffset;
            [self moveHeaderToY:self.toolbar.frame.origin.y + delta];
        }
        _previousYOffset = yCurrentOffset;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _dragging=NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _previousYOffset=scrollView.contentOffset.y;
}

#pragma mark - Private methods
- (void) moveHeaderToY:(float)y {
    float toolbarInitialY = -self.toolbar.frame.size.height+[self minHeightWithoutHide];
    
    //Move the toolbar inside the bounds
    CGRect rect = self.toolbar.frame;
    rect.origin.y =MAX(MIN(y, 0), toolbarInitialY);
    [self.toolbar setFrame:rect];
    
    //Fit the alpha of headerView
    [self keyframeAnimationForHeaderView:self.headerView
                                withStep:1-(self.toolbar.frame.origin.y/toolbarInitialY)];
}

- (UIView *) createDefaultHeaderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, defaultHeaderHeight)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

#pragma mark - Polymorph methods
-(UIView *) headerView:(UIView *)view forTableView:(UITableView *)tableView {
    return view;
}

-(float) headerHeightForTableView:(UITableView *)tableView {
    return defaultHeaderHeight;
}

- (UIColor *) toolbarBackgroundColor {
    return self.tableView.backgroundColor;
}

- (float) minHeightWithoutHide {
    return statusBarHeight;
}

- (void) keyframeAnimationForHeaderView: (UIView *) view withStep: (float)step {
    if(self.headerView){
        [self.headerView setAlpha:step];
    }
}

@end
