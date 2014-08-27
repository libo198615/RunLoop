//
//  RunLoop.m
//  RunLoop
//
//  Created by libo on 14-8-26.
//  Copyright (c) 2014年 NQ. All rights reserved.
//

#import "RunLoop.h"

@interface RunLoop ()
+ (NSThread *)runloopThread;;
+ (void)threadRunLoop;
@end

@implementation RunLoop

+ (NSThread *)runloopThread{
    static NSThread *runloopThread;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        runloopThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRunLoop) object:nil];
        [runloopThread start];
    });
    
    return runloopThread;
}

+ (void)threadRunLoop{
    @autoreleasepool {
        [[NSThread currentThread] setName:@"runloopThread"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop run];
    }
}

#pragma mark -----
- (void)action1{
    [self performSelector:@selector(actionLog)
                 onThread:[[self class] runloopThread]
               withObject:nil
            waitUntilDone:NO];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}

- (void)actionLog{
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    NSLog(@"%@",[NSThread currentThread]);
}








@end
