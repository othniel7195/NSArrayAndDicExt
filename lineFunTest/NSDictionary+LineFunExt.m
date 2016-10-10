//
//  NSDictionary+LineFunExt.m
//  lineFunTest
//
//  Created by zhao.feng on 16/10/10.
//  Copyright © 2016年 com.zhaofeng. All rights reserved.
//

#import "NSDictionary+LineFunExt.h"

@implementation NSDictionary (LineFunExt)

- (NSDictionary *)filterWhereCondition:(FilterKeyValueCondition)condition
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (condition(key,obj)) {
            
            [result setValue:obj forKey:key];
        }
        
    }];
    
    return result;
}

- (BOOL)filterConditionAll:(FilterKeyValueCondition)condition
{
    __block BOOL all = YES;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if (!condition(key,obj)) {
            all = NO;
            *stop = YES;
        }
        
    }];
    
    return all;
}

- (BOOL)filterConditionAny:(FilterKeyValueCondition)condition
{
    __block BOOL any = NO;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if (condition(key,obj)) {
            any = YES;
            *stop = YES;
        }
        
    }];
    return any;
}

- (NSDictionary *)mapSelectorCondition:(SelectorKeyValueCondition)condition mapNil:(BOOL)mapNil
{
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        id newValue = condition(key,obj);
        
        if (nil == newValue) {
            
            if (mapNil == YES) {
                
                [result setValue:[NSNull null] forKey:key];
            }
        }
        else
        {
            [result setValue:newValue forKey:key];
            
        }
        
    }];
    
    return result;
}


- (NSArray*) dictionaryToArray:(SelectorKeyValueCondition)condition
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        id arrayObj = condition(key,obj);
        
        if (arrayObj) {
            [result addObject:arrayObj];
        }
        
    }];
    
    return result;
}
@end
