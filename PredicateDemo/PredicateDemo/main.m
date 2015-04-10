//
//  main.m
//  PredicateDemo
//
//  Created by qingyun on 15-1-30.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QYPerson.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // 创建谓词对象，所有与谓词相关的操作都是靠谓词对象来实现的
        
        // 谓词中的所有关键词可以小写也可以大写，我建议大写，能轻易分辨是关键词
        
        
        // 1.谓词中的关系运算符
        // < > <= >= == != 这些关系运算符都可以使用
        // self就是发消息的这个对象本身
        NSPredicate *predTest = [NSPredicate predicateWithFormat:@"self > 100"];
        
        NSArray *arr1 = @[@11,@100,@1209,@111,@1241];
        // 使用谓词对数组进行过滤
        NSArray *arr11 = [arr1 filteredArrayUsingPredicate:predTest];
        NSLog(@"arr11 >>>>> %@", arr11);
        
        
        // 2.也可以使用逻辑运算符
        // and或者&& or或者||
        predTest = [NSPredicate predicateWithFormat:@"self > 100 and self < 1200"];
        NSArray *arr21 = [arr1 filteredArrayUsingPredicate:predTest];
        NSLog(@"arr21 >>>>> %@", arr21);
        
        // 测试对对象数组的过滤
        NSArray *arr22 = @[
                           [[QYPerson alloc] initWithName:@"kaiguo" andMoney:200],
                           [[QYPerson alloc] initWithName:@"zhangxu" andMoney:200001],
                           [[QYPerson alloc] initWithName:@"dongdong" andMoney:10001],
                           [[QYPerson alloc] initWithName:@"zhaopeng" andMoney:2001],
                           [[QYPerson alloc] initWithName:@"liqi" andMoney:2022221],
                           ];
        // 如果键路径是以self.开始，可以省略self
        predTest = [NSPredicate predicateWithFormat:@"money > 2000 and money < 200000"];
        NSArray *arr23 = [arr22 filteredArrayUsingPredicate:predTest];
        NSLog(@"arr23 >>>>> %@", arr23);
        
        // 3.向谓词对象发消息，来帮助检测数组中符不符合某个条件
        // 两个关键词 ALL ANY
        predTest = [NSPredicate predicateWithFormat:@"ALL money > 200000"];
        if ([predTest evaluateWithObject:arr22]) {
            NSLog(@"有高富帅!");
        }
        predTest = [NSPredicate predicateWithFormat:@"ANY money > 200000"];
        if ([predTest evaluateWithObject:arr22]) {
            NSLog(@"有一个就算高富帅!");
        }
        
        // 4.范围查找
        // 关键词：BETWEEN IN
        predTest = [NSPredicate predicateWithFormat:@"money IN {201,2000,20000}"];
        NSLog(@"arr41 >>>>> %@", [arr22 filteredArrayUsingPredicate:predTest]);
        predTest = [NSPredicate predicateWithFormat:@"money BETWEEN {201,20000}"];
        NSLog(@"arr42 >>>>> %@", [arr22 filteredArrayUsingPredicate:predTest]);
        
        
        // 5.字符串操作
        //关键字 BEGINSWITH ENDSWITH CONTAINS
        // [c]代表不区分大小写 [d]代表不区分发音符号
        NSPredicate *predStr = [NSPredicate predicateWithFormat:@"name BEGINSWITH 'zh'"];
        NSLog(@"arr51 >>>>> %@", [arr22 filteredArrayUsingPredicate:predStr]);
        predStr = [NSPredicate predicateWithFormat:@"name beginswith[cd] 'ZH'"];
        NSLog(@"arr52 >>>>> %@", [arr22 filteredArrayUsingPredicate:predStr]);
        
        
        // 6.通配符的使用(通用的，在其他很多系统的命令中都可以使用)
        // ?代表一个任意字符 *代表任意多个字符
        // 另外一个关键字 LIKE
        predStr = [NSPredicate predicateWithFormat:@"name LIKE[cd] '?a*'"];
        NSLog(@"arr61 >>>>> %@", [arr22 filteredArrayUsingPredicate:predStr]);
        predStr = [NSPredicate predicateWithFormat:@"name LIKE[cd] '*a*'"];
        NSLog(@"arr62 >>>>> %@", [arr22 filteredArrayUsingPredicate:predStr]);
        predStr = [NSPredicate predicateWithFormat:@"name LIKE[cd] '??a*'"];
        NSLog(@"arr63 >>>>> %@", [arr22 filteredArrayUsingPredicate:predStr]);
        
        // 7.1谓词模板(格式化一个模板)
        // 关键词 %K，代表一个键
        NSString *key = @"money";
        NSNumber *number = @2000;
        //NSString *key1 = @"age";
        //NSNumber *n1 = @20;
        NSPredicate *predTheme = [NSPredicate predicateWithFormat:@"%K > %@", key, number];
        for (QYPerson *person in arr22) {
            if ([predTheme evaluateWithObject:person]) {
                NSLog(@"person >>>>>> %@", person);
            } else {
                NSLog(@"%@ 继续努力!", person);
            }
        }
        
        // 7.2谓词模板(使用变量)
        // 关键词  $NAME(标量名字)，生成谓词用predicateWithSubstitutionVariables方法，传入一个字典，字典中将变量名字和值写成键值形式
        NSPredicate *predTheme1 = [NSPredicate predicateWithFormat:@"name == $NAME and money == $MONEY"];
        NSDictionary *dict = @{@"NAME":@"kaiguo",@"MONEY":@200};
        NSPredicate *pretDict = [predTheme1 predicateWithSubstitutionVariables:dict];
        for (QYPerson *person in arr22) {
            if ([pretDict evaluateWithObject:person]) {
                NSLog(@"你是开国，继续努力！");
            } else {
                NSLog(@"ok!");
            }
        }
    }
       
    
    
    
    
    
    
    
    return 0;
}

