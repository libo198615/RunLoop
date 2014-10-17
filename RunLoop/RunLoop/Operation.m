/*
 
 线程池 NSOperation
 线程池的作用就是限制系统中执行线程的数量，用线程池控制线程数量，其他线程进入线程队列进行等待。一个任务执行完毕后，再从队列中取出最前面的任务开始执行
 
 
 以上是使用系统操作对列,可以使用 NSOperationQueue创建自己的线程对列
 
 
 
 NSOperationQueue *operationQueue;
 
 operationQueue = [[NSOperationQueue alloc] init]; //初始化操作队列
 [operationQueue setMaxConcurrentOperationCount:n]; // 可以设置队列的个数
 [operationQueue addOperation:otherOper];
 
 
 
 
 * NSOpertaionQueue用GCD构建，是GCD的高级抽象。
 * GCD只支持FIFO队列，而加入NSOperationQueue队列的操作可以被重新排序（重新设置优先级）。
 * NSOperationQueue支持在操作之间设置依赖关系，而GCD不支持。如果某个操作需要另一个操作生成的数据，可以让这个操作依赖另外的一个，NSOperationQueue会自动按照正确的顺序执行操作。而GCD没有内建的依赖关系支持。
 
 
 类方法:[NSThread detachNewThreadSelector:@selector(run:) toTarget:target withObject:obj];
 实例方法可以按到线程对象，便于以后终止线程：NSThread *newThread = [NSThread alloc] initWithTarget:target selector:@selector(run:) object:obj];

 */

#import "Operation.h"

@implementation Operation



@end
