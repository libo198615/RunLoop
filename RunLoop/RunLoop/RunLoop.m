/*
 一个run loop是用来在线程上管理事件异步到达的基础设施。一个run loop为线程监测一个或多个事件源。当事件到达的时候，系统唤醒线程并调度事件到run loop,然后分配给指定程序。如果没有事件出现和准备处理，run loop把线程置于休眠状态。
 */

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
        runloopThread = [[NSThread alloc] initWithTarget:self
                                                selector:@selector(threadRunLoop)
                                                  object:nil];
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
