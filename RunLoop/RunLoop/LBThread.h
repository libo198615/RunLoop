//
//  Thread1.h
//  LBGCD
//
//  Created by libo on 14-10-11.
//  Copyright (c) 2014年 LB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBThread : NSObject

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, strong) NSSet *runLoopModes;

+ (instancetype)manager;


- (void)start;
- (void)stop;

@end
