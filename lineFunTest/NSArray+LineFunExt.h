//
//  NSArray+LineFunExt.h
//  lineFunTest
//
//  Created by zhao.feng on 16/10/10.
//  Copyright © 2016年 com.zhaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  过滤数组结果
 */
typedef BOOL(^FilterCondition)(id item,NSUInteger idx);

typedef id(^SelectorCondition)(id item,NSUInteger idx);


@interface NSArray (LineFunExt)

/**
 根据condition 返回合适的数组
 
 @param condition 过滤条件
 
 */
- (NSArray *)filterWhereCondition:(FilterCondition)condition;


/**
 数组中的数据源是否都符合condition的过滤条件
 */
- (BOOL)filterConditionAll:(FilterCondition)condition;

/**
 数组中的数据源是否有符合condition的过滤条件
 */
- (BOOL)filterConditionAny:(FilterCondition)condition;

/**
 根据condition 映射新的数据源

 @param condition 映射条件
 @param mapNil     是否能映射nil数据源

 */
- (NSArray *)mapSelectorCondition:(SelectorCondition)condition mapNil:(BOOL)mapNil;

/**
 根据condition 返回去重后的数组

 @param condition 去重条件
 */
- (NSArray *)distinctSelectorCondition:(SelectorCondition)condition;

/**
 根据条件合并数组
 */
- (NSArray *)concatFilterCondition:(FilterCondition)condition arrays:(NSArray *)param, ...;

/**
 根据去重复条件合并数组
 */
- (NSArray *)concatSelectorCondition:(SelectorCondition)condition arrays:(NSArray *)param, ...;

/**
 根据条件获取多个数组里面重复的
 */
- (NSArray *)intersectionSelectorCondition:(SelectorCondition)condition arrays:(NSArray *)param, ...;

@end
