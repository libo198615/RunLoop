//
//  NQViewController.m
//  RunLoop
//
//  Created by libo on 14-8-26.
//  Copyright (c) 2014年 NQ. All rights reserved.
//

#import "NQViewController.h"
#import "RunLoop.h"
#import "LBThread.h"

@interface NQViewController ()
@property (nonatomic, strong) NSRunLoop *currentLoop;
@end

@implementation NQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    RunLoop *runLoop = [[RunLoop alloc] init];
//    [runLoop action1];
    
//    [self click];
    
    [[LBThread manager] start];
}


//新线程
- (void)click{
    NSThread *thread = [[NSThread alloc] initWithTarget:self
                                               selector:@selector(playerThread)
                                                 object:nil];
    [thread start];
}
//nstimer 加到新线程的runloop中
- (void)playerThread{
    _currentLoop = (__bridge NSRunLoop *)(CFRunLoopGetCurrent());
    [self initPlayer];
    CFRunLoopRun();
}

- (void)initPlayer{
    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(checkState:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)checkState:(NSTimer *)timer{
    NSLog(@"runloop");
//    CFRunLoopStop((__bridge CFRunLoopRef)(_currentLoop));
//    [self.countTimer invalidate];
}

@end
