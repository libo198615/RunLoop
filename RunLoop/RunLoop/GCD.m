//
//  GCD.m
//  RunLoop
//
//  Created by libo on 14-8-26.
//  Copyright (c) 2014年 NQ. All rights reserved.
//

#import "GCD.h"

@implementation GCD

- (void)gcd{
    // Dispatch Queue
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("com.gcd", NULL);
    // Concurrent Dispatch Queue
    dispatch_queue_t myConcurrentDispatchQueue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_CONCURRENT);
    
    // Main Dispatch Queue
    dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue();
    // Global Dispatch Queue 高优先级
    dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    // diapatch_after
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    // Dispatch Group
    {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_group_async(group, queue, ^{
            NSLog(@"block0");
        });
        dispatch_group_async(group, queue, ^{
            NSLog(@"block1");
        });
        dispatch_group_async(group, queue, ^{
            NSLog(@"block2");
        });
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"done");
        });
        
        /*
         block1, block2, block0, done
         **/
    }

    // dispatch_barrier_async 屏障
    {
        dispatch_queue_t queue = dispatch_queue_create("com.libo", DISPATCH_QUEUE_CONCURRENT);
        //并行
        dispatch_async(queue, ^{
            NSLog(@"read0");
        });
        dispatch_async(queue, ^{
            NSLog(@"read1");
        });
        dispatch_async(queue, ^{
            NSLog(@"read2");
        });
        dispatch_async(queue, ^{
            NSLog(@"read3");
        });
        //同时只执行一个
        dispatch_barrier_async(queue, ^{
            NSLog(@"write");
        });
        //并行
        dispatch_async(queue, ^{
            NSLog(@"read4");
        });
        dispatch_async(queue, ^{
            NSLog(@"read5");
        });
        dispatch_async(queue, ^{
            NSLog(@"read6");
        });
        
    }
    
}











@end
