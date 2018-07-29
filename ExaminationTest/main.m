//
//  main.m
//  ExaminationTest
//
//  Created by M君 on 29/07/2018.
//  Copyright © 2018 M君. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MCUtil.h"
#import "MCDriverTest.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Hello, World!");//保留
        /***************************题目1，计算两个由0-9数字组成的最长可达30个字符的字符串，计算整数和 Start***************************/
        //        NSString *num1 = @"9999999999999999999999999";
        //        NSString *num2 = @"9";
        //        NSString *sum = [MCUtil additionWithSummand:num1 andAddend:num2];
        //        NSLog(@"大整数相加运算：\n加数1：%@,长度:%zd位\n加数2:%@,长度:%zd位\n运算结果:%@,长度:%zd位", num1, num1.length, num2, num2.length, sum, sum.length);
        /***************************题目1，计算两个由0-9数字组成的最长可达30个字符的字符串，计算整数和 End***************************/
        
        /***************************题目2，给定一个数字，返回对应的字符串 Start***************************/
        //        NSLog(@"输出1到100对应的字符串");
        //        for (NSInteger number = 1; number <= 100; number ++) {
        //            NSString *str = [MCUtil stringFromNumber:number];
        //            NSLog(@"给定一个数字，返回对应的字符串:\t输入:%zd\t输出:%@",number,str);
        //        }
        /***************************题目2，给定一个数字，返回对应的字符串 End***************************/
        
        /***************************题目3，计算网约车司机的服务分 Start***************************/
        MCDriverTest *driverTest = [[MCDriverTest alloc] init];
        //模拟加入最新一单
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *orderNumber = [NSString stringWithFormat:@"P%@%@",[dateFormatter stringFromDate:[NSDate date]],@"0001"];
        MCClientOrder *order = [[MCClientOrder alloc] initWithOrderNumber:orderNumber comment:MCClientCommentNegative];
        NSNumber *score = [driverTest.driver calculateScoreWithOrder:order];
        {//打印所有模拟的订单数据
            NSLog(@"打印所有模拟的订单数据 Start");
            NSArray *array = [driverTest.driver getOrdersWithRange:NSMakeRange(0, [[driverTest.driver getOrdersNumber] integerValue])];
            for (MCClientOrder *obj in array) {
                switch (obj.comment) {
                    case MCClientCommentPraise:
                        NSLog(@"OrderNo：%@ Comment：MCClientCommentPraise",obj.orderNumber);
                        break;
                    case MCClientCommentNegative:
                        NSLog(@"OrderNo：%@ Comment：MCClientCommentNegative",obj.orderNumber);
                        break;
                    case MCClientCommentComplain:
                        NSLog(@"OrderNo：%@ Comment：MCClientCommentComplain",obj.orderNumber);
                        break;
                    default:
                        NSLog(@"Impossible");
                        break;
                }
            }
            NSLog(@"打印所有模拟的订单数据 End");
        }
        NSLog(@"计算网约车司机的服务分：\n输入订单：%zd\n输出服务分:%@",order.comment,score);
        /***************************题目3，计算网约车司机的服务分 End***************************/
    }
    return 0;
}
