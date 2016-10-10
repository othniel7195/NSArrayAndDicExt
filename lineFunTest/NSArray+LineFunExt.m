//
//  NSArray+LineFunExt.m
//  lineFunTest
//
//  Created by zhao.feng on 16/10/10.
//  Copyright © 2016年 com.zhaofeng. All rights reserved.
//

#import "NSArray+LineFunExt.h"
#import "Person.h"
@implementation NSArray (LineFunExt)

- (NSArray *)filterWhereCondition:(FilterCondition)condition
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (condition(obj,idx)) {
            
            [result addObject:obj];
        }
        
    }];
    
    return result;
}

- (BOOL)filterConditionAll:(FilterCondition)condition
{
    __block BOOL all = YES;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (!condition(obj,idx)) {
            all = NO;
            *stop = YES;
        }
        
    }];
    
    return all;
}

- (BOOL)filterConditionAny:(FilterCondition)condition
{
    __block BOOL any = NO;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (condition(obj,idx)) {
            any = YES;
            *stop = YES;
        }
        
    }];
    return any;
}

- (NSArray *)mapSelectorCondition:(SelectorCondition)condition mapNil:(BOOL)mapNil
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        id newValue = condition(obj,idx);
        
        if (nil == newValue) {
            
            if (mapNil == YES) {
            
                [result addObject:[NSNull null]];
            }
        }
        else
        {
            [result addObject:newValue];
        }
        
    }];
    
    return result;
}

- (NSArray *)distinctSelectorCondition:(SelectorCondition)condition
{
    NSMutableSet* keyValues = [[NSMutableSet alloc] init];
    NSMutableArray* distinctSet = [[NSMutableArray alloc] init];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id keyForItem = condition(obj,idx);
        if (!keyForItem)
            keyForItem = [NSNull null];
        if (![keyValues containsObject:keyForItem]) {
            [distinctSet addObject:obj];
            [keyValues addObject:keyForItem];
        }
    }];
    return distinctSet;
}

- (NSArray *)concatFilterCondition:(FilterCondition)condition arrays:(NSArray *)param, ...
{
    va_list varList;
    id arg;
    NSMutableArray *argsArray = [[NSMutableArray alloc]init];
    [argsArray addObjectsFromArray:self];
    [argsArray addObjectsFromArray:param];
    
    va_start(varList,param);
    while((arg = va_arg(varList, id))){
        
        [argsArray addObjectsFromArray:arg];
    }
    va_end(varList);
    
    return [argsArray filterWhereCondition:condition];

}

- (NSArray *)concatSelectorCondition:(SelectorCondition)condition arrays:(NSArray *)param, ...
{
    va_list varList;
    id arg;
    NSMutableArray *argsArray = [[NSMutableArray alloc]init];
    [argsArray addObjectsFromArray:self];
    [argsArray addObjectsFromArray:param];

    va_start(varList,param);
    while((arg = va_arg(varList, id))){
        
        [argsArray addObjectsFromArray:arg];
    }
    va_end(varList);

    return [argsArray distinctSelectorCondition:condition];
}

- (NSArray *)intersectionSelectorCondition:(SelectorCondition)condition arrays:(NSArray *)param, ...
{
    va_list varList;
    id arg;
    NSMutableArray *argsArray = [[NSMutableArray alloc]init];
    [argsArray addObjectsFromArray:self];
    [argsArray addObjectsFromArray:param];
    
    va_start(varList,param);
    while((arg = va_arg(varList, id))){
        
        [argsArray addObjectsFromArray:arg];
    }
    va_end(varList);
    
    
    NSMutableDictionary* keyValues = [[NSMutableDictionary alloc] init];
    NSMutableSet *result = [[NSMutableSet alloc] init];
    
    [argsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id keyForItem = condition(obj,idx);
        if (!keyForItem)
            keyForItem = [NSNull null];
        
        id oldValue = [keyValues objectForKey:keyForItem];
        
        if (oldValue) {
            [result addObject:oldValue];
            [result addObject:obj];
        }
        else
        {
            [keyValues setObject:obj forKey:keyForItem];
        }
        
    }];
    
    
    return result.allObjects;

}

@end
