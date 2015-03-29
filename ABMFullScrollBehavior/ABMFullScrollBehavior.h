//
//  ABMFullScrollBehavior.h
//  ABFullScrollViewControllerExample
//
//  Created by Andres Brun Moreno on 28/03/15.
//  Copyright (c) 2015 Brun's Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ABMFullScrollBehaviorDelegate <NSObject>
- (void)scroll:(UIScrollView *)scroll animationForHeaderView:(UIView *)view percent:(CGFloat)percent
;
@end

@interface ABMFullScrollBehavior : NSObject <UIScrollViewDelegate>

@property (nonatomic) IBInspectable CGFloat minVisibleHeight;
@property (nonatomic) IBInspectable BOOL imantate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak) IBOutlet id<ABMFullScrollBehaviorDelegate> delegate;

@end
