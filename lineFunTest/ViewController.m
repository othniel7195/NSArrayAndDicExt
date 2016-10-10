//
//  ViewController.m
//  lineFunTest
//
//  Created by zhao.feng on 16/9/30.
//  Copyright © 2016年 com.zhaofeng. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+LineFunExt.h"
#import "NSDictionary+LineFunExt.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.
    NSArray *testArray = @[@10,@11,@3,@8,@100,@2];
    
    testArray = [testArray filterWhereCondition:^BOOL(NSNumber *item,NSUInteger idx) {
        
        return item.integerValue > 10;
    }];
    
    NSLog(@"testArray where item > 10  :%@",testArray);
    
    //2.
    NSArray *testArray2 = @[@10,@11,@18,@0,@100];
    testArray2 = [testArray2 mapSelectorCondition:^id(NSNumber *item,NSUInteger idx) {
        
        if (item.integerValue != 0) {
            
            return [NSString stringWithFormat:@"string_%ld",(long)item.integerValue];
        }
        
        return nil;
        
    } mapNil:YES];
    
    
    NSLog(@"testArray2 map int to string :%@",testArray2);
    
    NSArray *testArray3 = [self createPersons];
    
    testArray3 = [testArray3 distinctSelectorCondition:^id(Person *item,NSUInteger idx) {
        
        return @(item.age);
    }];
    
    NSLog(@"testArray3 distinct age :%@",testArray3);
    
    NSArray *testArray4 = @[[self personInit:11 name:@"A"],[self personInit:18 name:@"B"],[self personInit:20 name:@"C"]];
    NSArray *testArray5 = @[[self personInit:18 name:@"C"],[self personInit:18 name:@"E"],[self personInit:20 name:@"F"]];
    NSArray *testArray6 = @[[self personInit:11 name:@"G"],[self personInit:12 name:@"E"],[self personInit:22 name:@"A"]];
    
    NSArray *testArray7=[testArray4 concatSelectorCondition:^id(Person *item,NSUInteger idx) {
        return @(item.age);
    } arrays:testArray5,testArray6,nil];
    
    NSLog(@"testArray7 concat age :%@",testArray7);
    
    NSArray *testArray8 = [testArray4 concatFilterCondition:^BOOL(Person *item,NSUInteger idx) {
        
        return item.age > 15;
    } arrays:testArray5,testArray6,nil];
    
    NSLog(@"testArray8 concat age :%@",testArray8);
    
    
    
    NSArray *testArray9=[testArray4 intersectionSelectorCondition:^id(Person *item,NSUInteger idx) {
        return @(item.age);
    } arrays:testArray5,testArray6,nil];
    
    NSLog(@"testArray9 intersection age :%@",testArray9);
    
    BOOL i1 = [testArray4 filterConditionAll:^BOOL(Person *item, NSUInteger idx) {
        
        return item.age >16;
    }];

    NSLog(@"i1:%d",i1);
    
    BOOL i2 = [testArray4 filterConditionAny:^BOOL(Person *item, NSUInteger idx) {
        
        return item.age >18;
    }];
    
    NSLog(@"i2:%d",i2);
    
    
    NSDictionary *testDic1 = @{@"A":@11,@"B":@18,@"C":@20,@"D":@8};
    
    NSDictionary *testDic2=[testDic1 filterWhereCondition:^BOOL(id key, NSNumber *value) {
        
        return value.integerValue >= 20;
    }];
    
    NSLog(@"testDic2:%@",testDic2);
    
    BOOL di1 = [testDic1 filterConditionAll:^BOOL(id key, NSNumber *value) {
        return value.integerValue >= 20;
    }];
    NSLog(@"di1:%d",di1);
    
    BOOL di2 = [testDic1 filterConditionAny:^BOOL(id key, NSNumber *value) {
        return value.integerValue >= 20;
    }];
    NSLog(@"di2:%d",di2);
    
    NSDictionary *testDic3 = [testDic1 mapSelectorCondition:^id(id key, NSNumber *value) {
        
        if (value.integerValue != 11) {
            return [NSString stringWithFormat:@"xxx_%ld",value.integerValue];
        }
        return nil;
        
    } mapNil:YES];
    
    NSLog(@"testDic3:xxx_%@",testDic3);
    
    NSArray *arr = [testDic1 dictionaryToArray:^id(id key, NSNumber *value) {
        return [[Person alloc] initWithAge:(int)value.integerValue name:key];
    }];
    
    NSLog(@"dic to arr:%@",arr);

}

- (NSArray *)createPersons
{
    NSMutableArray *m = [[NSMutableArray alloc] init];
    
    Person *p1 = [[Person alloc] initWithAge:20 name:@"AA"];
    Person *p2 = [[Person alloc] initWithAge:25 name:@"BB"];
    Person *p3 = [[Person alloc] initWithAge:20 name:@"CC"];
    Person *p4 = [[Person alloc] initWithAge:30 name:@"DD"];
    Person *p5 = [[Person alloc] initWithAge:25 name:@"EE"];
    
    [m addObject:p1];
    [m addObject:p2];
    [m addObject:p3];
    [m addObject:p4];
    [m addObject:p5];
    
    
    return m;
    
}

- (Person *)personInit:(int)age name:(NSString *)name
{
    Person *p = [[Person alloc] initWithAge:age name:name];
    
    return p;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
