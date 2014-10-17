//
//  Thread1.m
//  LBGCD
//
//  Created by libo on 14-10-11.
//  Copyright (c) 2014年 LB. All rights reserved.
//

#import "LBThread.h"


@implementation LBThread


+ (instancetype)manager{
    return [[self alloc] initManager];
}

/* + 调用 [[self class] networkRequestThread] */
+ (NSThread *)startThread{
    static NSThread *LBStartThread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LBStartThread = [[NSThread alloc] initWithTarget:self
                                                selector:@selector(startThreadEntryPoint:)
                                                  object:nil];
        [LBStartThread start];
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    return LBStartThread;
}

//__unused:    This attribute, attached to a function, means that the function is meant to be possibly unused. GCC will not produce a warning for this function.
+ (void)startThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"startThread"];
        NSLog(@"%@",[NSThread currentThread]);
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}


+ (NSThread *)stopThread {
    static NSThread *LBStopThread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LBStopThread = [[NSThread alloc] initWithTarget:self
                                           selector:@selector(stopThreadEntryPoint:)
                                             object:nil];
        [LBStopThread start];
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    return LBStopThread;
}

+ (void)stopThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"stopThread"];
        NSLog(@"%@",[NSThread currentThread]);
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

- (instancetype)initManager{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.runLoopModes = [NSSet setWithObject:NSRunLoopCommonModes];
    self.operationQueue = [[NSOperationQueue alloc] init];
    return self;
}






- (void)start {
    [self performSelector:@selector(threadName)
                 onThread:[[self class] startThread]//libo 自己调用实例方法
               withObject:nil
            waitUntilDone:NO
                    modes:[self.runLoopModes allObjects]];
    
}

- (void)stop {
    [self performSelector:@selector(threadName)
                 onThread:[[self class] stopThread]//libo 自己调用实例方法
               withObject:nil
            waitUntilDone:NO
                    modes:[self.runLoopModes allObjects]];
    
}

- (void)threadName{
    NSLog(@"%@",[NSThread currentThread]);
}






@end
