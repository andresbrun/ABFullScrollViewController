//
//  ABMFullScrollBehavior.m
//  ABFullScrollViewControllerExample
//
//  Created by Andres Brun Moreno on 28/03/15.
//  Copyright (c) 2015 Brun's Software. All rights reserved.
//

#import "ABMFullScrollBehavior.h"
#import <objc/runtime.h>

@interface ABMFullScrollBehavior ()

@property(nonatomic, strong) NSNumber *initialYPosition;
@property(nonatomic, assign) CGFloat initialYContentOffset;
@property(nonatomic, assign) CGFloat previousYOffset;
@property(nonatomic, assign) BOOL dragging;
@property(nonatomic, assign) BOOL draggingScrollDown;

@end

@implementation ABMFullScrollBehavior

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Otherwise IBOutlet are nil. Didn't find any other way to do it
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setUpInitialValues];
    });
}

- (void) setUpInitialValues {
    
    self.initialYContentOffset = 0;
    self.previousYOffset = self.initialYContentOffset;
    
    if (self.scrollView && self.headerView) {
        UIEdgeInsets edges = self.scrollView.contentInset;
        [self.scrollView setContentInset:UIEdgeInsetsMake(CGRectGetHeight(self.headerView.frame), edges.left, edges.bottom, edges.right)];
        [self.scrollView setScrollIndicatorInsets:self.scrollView.contentInset];
    }
}


#pragma mark - Scroll delegates
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    float delta= self.previousYOffset - scrollView.contentOffset.y;
    [self moveHeaderToY: delta];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!self.initialYPosition) {
        self.initialYPosition = @(CGRectGetMinY(self.headerView.frame));
    }
    self.dragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(self.headerView && self.dragging) {
        
        //Move toolbar
        float yCurrentOffset = scrollView.contentOffset.y;
        
        //Avoid a wrong behaviour when scroll bounce to top
        if(yCurrentOffset > self.initialYContentOffset) {
            float delta = _previousYOffset - yCurrentOffset;
            [self moveHeaderToY: self.headerView.frame.origin.y + delta];
        }
        
        _previousYOffset = yCurrentOffset;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    self.dragging=NO;

    if (velocity.y == 0) {
        self.draggingScrollDown = [self currentHeaderPositionPercent] < 0.5;
        [self imantateToNearPosition];
    } else {
        self.draggingScrollDown = velocity.y > 0;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.previousYOffset = scrollView.contentOffset.y;
    
    [self imantateToNearPosition];
}

#pragma mark - Private methods
- (void)imantateToNearPosition {
    if (self.imantate) {
        [UIView animateWithDuration:0.1 animations:^{
            [self moveHeaderToY:self.draggingScrollDown ? [self headerViewInitialYPos] : [self headerViewFinalYPos]];
        }];
    }
}

- (void)moveHeaderToY:(CGFloat)y {
    [self moveHeaderInsideBoundToY:y];
    
    if ([self.delegate respondsToSelector:@selector(scroll:animationForHeaderView:percent:)]) {
        [self.delegate scroll:self.scrollView animationForHeaderView:self.headerView percent:[self currentHeaderPositionPercent]];
    }
}

- (void)moveHeaderInsideBoundToY:(CGFloat)y {
    CGRect rect = self.headerView.frame;
    rect.origin.y = MAX(MIN(y, [self headerViewFinalYPos]), [self headerViewInitialYPos]);
    [self.headerView setFrame:rect];
}

- (CGFloat)headerViewInitialYPos {
    return [self.initialYPosition floatValue] +  self.minVisibleHeight - self.headerView.frame.size.height;
}

- (CGFloat)headerViewFinalYPos {
    return [self.initialYPosition floatValue];
}

- (CGFloat)currentHeaderPositionPercent {
    return 1.0 - ((self.headerView.frame.origin.y - [self headerViewFinalYPos])/([self headerViewInitialYPos] - [self headerViewFinalYPos]));
}

@end
