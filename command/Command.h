//
//  Command.h
//  com.aloe-project.learn1
//
//  Created by shimoigi on 12/09/02.
//  Copyright (c) 2012年 webMaterial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Command : NSObject{
    dispatch_queue_t queue;
    dispatch_block_t callbackBlock;
    BOOL isRoot;
}

/**
 * 実行
 */
-(void)execute:(NSObject*)data;

/**
 * 使用するqueueを明示して実行
 */
//-(void)execute:(dispatch_queue_t)queue_;

/**
 * 親コマンドから実行されるとき
 * TODO ださい
 */
//-(void)childExecute:(dispatch_queue_t)queue_;

/**
 * コールバックせっと
 * とりあえずはブロックでいいか
 */
-(void)setCallback:(dispatch_block_t)callbackBlock_;

/**
 * 完了
 */
-(void)complete;

/**
 * 実際の実行
 * コマンドごとに上書きする
 */
-(void)internalExecute;

/**
 * 後処理
 * コマンドごとにうわがきする
 * なきゃないでよし
 */
-(void)internalComplete;

@end
