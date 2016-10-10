//
//  Person.m
//  lineFunTest
//
//  Created by zhao.feng on 16/10/10.
//  Copyright © 2016年 com.zhaofeng. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithAge:(int)age name:(NSString *)name
{
    self = [super init];
    if (self) {
        _age = age;
        _name = name;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@ -- age:%d",_name,_age];
}
@end
