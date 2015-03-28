//
//  MultiplexerProxyBehavior.m
//  ABFullScrollViewControllerExample
//
//  Created by Andres Brun Moreno on 28/03/15.
//  Copyright (c) 2015 Brun's Software. All rights reserved.
//

#import "MultiplexerProxyBehavior.h"

@implementation MultiplexerProxyBehavior

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *sig = [super methodSignatureForSelector:sel];
    if (!sig) {
        for (id obj in self.targets) {
            if ((sig = [obj methodSignatureForSelector:sel])) {
                break;
            }
        }
    }
    return sig;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL base = [super respondsToSelector:aSelector];
    if (base) {
        return base;
    }
    
    for (id obj in self.targets) {
        if ([obj respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    for (id obj in self.targets) {
        if ([obj respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:obj];
        }
    }
}
@end
