//
//  QYPerson.m
//  PredicateDemo
//
//  Created by qingyun on 15-1-30.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYPerson.h"

@implementation QYPerson

- (id)init
{
    if (self = [super  init]) {
        _name = @"zhangxu";
        _money = 20000;
    }
    return self;
}

- (id)initWithName:(NSString *)name andMoney:(int)money
{
    if (self = [super  init]) {
        _name = name;
        _money = money;
    }
    return self;
}

- (NSString *)description
{
    return _name;
}


@end
