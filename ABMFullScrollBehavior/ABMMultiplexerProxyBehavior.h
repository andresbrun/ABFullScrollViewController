//
//  MultiplexerProxyBehavior.h
//  ABFullScrollViewControllerExample
//
//  Created by Andres Brun Moreno on 28/03/15.
//  Copyright (c) 2015 Brun's Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABMMultiplexerProxyBehavior : NSObject

//! targets to propagate messages to
@property(nonatomic, strong) IBOutletCollection(id) NSArray *targets;

@end
