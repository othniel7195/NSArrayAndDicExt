//
//  Person.h
//  lineFunTest
//
//  Created by zhao.feng on 16/10/10.
//  Copyright © 2016年 com.zhaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic, assign)int age;
@property(nonatomic, copy)NSString *name;
- (instancetype)initWithAge:(int)age name:(NSString *)name;
@end
