//
//  NSDictionary+LineFunExt.h
//  lineFunTest
//
//  Created by zhao.feng on 16/10/10.
//  Copyright © 2016年 com.zhaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^FilterKeyValueCondition)(id key,id value);

typedef id(^SelectorKeyValueCondition)(id key,id value);

@interface NSDictionary (LineFunExt)

/**
 根据condition 返回合适的数组
 @param condition 过滤条件
 */
- (NSDictionary *)filterWhereCondition:(FilterKeyValueCondition)condition;

/**
 字典中的数据源是否都符合condition的过滤条件
 */
- (BOOL)filterConditionAll:(FilterKeyValueCondition)condition;

/**
 字典中的数据源是否有符合condition的过滤条件
 */
- (BOOL)filterConditionAny:(FilterKeyValueCondition)condition;

/**
 根据condition 映射新的数据源
 
 @param condition 映射条件
 @param mapNil     是否能映射nil数据源
 
 */
- (NSDictionary *)mapSelectorCondition:(SelectorKeyValueCondition)condition mapNil:(BOOL)mapNil;

/**
 字典转对象数组

 @param condition 转换条件
 */
- (NSArray*) dictionaryToArray:(SelectorKeyValueCondition)condition;

@end
