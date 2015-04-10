//
//  QYPerson.h
//  PredicateDemo
//
//  Created by qingyun on 15-1-30.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYPerson : NSObject

@property (strong,nonatomic) NSString *name;
@property (nonatomic) int money;


- (id)initWithName:(NSString *)name andMoney:(int)money;

@end
