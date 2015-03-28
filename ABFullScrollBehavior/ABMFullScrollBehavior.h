//
//  ABMFullScrollBehavior.h
//  ABFullScrollViewControllerExample
//
//  Created by Andres Brun Moreno on 28/03/15.
//  Copyright (c) 2015 Brun's Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ABMFullScrollBehaviorDelegate <NSObject>
- (void)keyframeAnimationForHeaderView:(UIView *) view percent:(CGFloat)step;
@end

@interface ABMFullScrollBehavior : NSObject <UIScrollViewDelegate>

@property (nonatomic) IBInspectable CGFloat minVisibleHeight;
@property (nonatomic) IBInspectable BOOL imantate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak) id<ABMFullScrollBehaviorDelegate> delegate;

@end
