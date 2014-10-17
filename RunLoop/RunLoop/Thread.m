//
//  Thread.m
//  RunLoop
//
//  Created by libo on 14-8-27.
//  Copyright (c) 2014年 NQ. All rights reserved.
//

#import "Thread.h"

@interface Thread ()
@property (nonatomic, strong) NSThread *threadOne;
@property (nonatomic, strong) NSThread *threadTwo;
@property (nonatomic, assign) int tickets;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) NSLock *lock;
@end

@implementation Thread

- (void)ticket{
    _tickets = 100;
    _count = 0;
    _lock = [[NSLock alloc] init];
    
    _threadOne = [[NSThread alloc] initWithTarget:self
                                         selector:@selector(run)
                                           object:nil];
    [_threadOne setName:@"one"];
    [_threadOne start];
    
    _threadTwo = [[NSThread alloc] initWithTarget:self
                                         selector:@selector(run)
                                           object:nil];
    [_threadTwo setName:@"two"];
    [_threadTwo start];
    
    [NSThread detachNewThreadSelector:@selector(run)
                             toTarget:self
                           withObject:nil];
    
}

- (void)run{
    while (TRUE) {
        [_lock lock];
        
        if (_tickets > 0) {
            [NSThread sleepForTimeInterval:0.5];
            _count = 100 - _tickets;
            NSLog(@"当前票数:%d",_tickets);
            NSLog(@"售出票数:%d",_count);
            NSLog(@"线程名:%@",[[NSThread currentThread] name]);
        }else{
            break;
        }
        
        [_lock unlock];
    }
}


/**
    当前票数是:61,售出:39,线程名:Thread-1
    当前票数是:60,售出:40,线程名:Thread-2
    当前票数是:59,售出:41,线程名:
    当前票数是:58,售出:42,线程名:Thread-1
    当前票数是:57,售出:43,线程名:Thread-2
    当前票数是:56,售出:44,线程名:
    当前票数是:55,售出:45,线程名:Thread-1
    当前票数是:54,售出:46,线程名:Thread-2
    当前票数是:53,售出:47,线程名:
    当前票数是:52,售出:48,线程名:Thread-1
 */

@end
