//
//  MCUtil.m
//  ExaminationTest
//
//  Created by M君 on 29/07/2018.
//  Copyright © 2018 M君. All rights reserved.
//

#import "MCUtil.h"

#define numberFormat 10//默认十进制，可以加接口传入

@implementation MCUtil

+(NSString *)additionWithSummand:(NSString *)summand andAddend:(NSString *)addend
{
    NSString *reverseSummand = @"";//反转后的被加数
    NSString *reverseAddend = @"";//反转后的加数
    BOOL carryFlag = NO;//进位标志
    NSString *reverseResult = @"";
    NSString *result = @"";
    //反转加熟、被加数
    for (NSInteger i = summand.length-1; i >= 0; i --) {
        NSRange range = NSMakeRange(i, 1);
        reverseSummand = [reverseSummand stringByAppendingString:[summand substringWithRange:range]];
    }
    for (NSInteger j = addend.length - 1; j >= 0; j --) {
        NSRange range = NSMakeRange(j, 1);
        reverseAddend = [reverseAddend stringByAppendingString:[addend substringWithRange:range]];
    }
    //长度对齐，用0补齐
    NSInteger maxLength = summand.length > addend.length ? summand.length:addend.length;
    if (summand.length > addend.length) {
        for (NSInteger i = reverseAddend.length; i < maxLength; i ++) {
            reverseAddend = [reverseAddend stringByAppendingString:@"0"];
        }
    }else if (summand.length < addend.length) {
        for (NSInteger j = reverseSummand.length; j < maxLength; j ++) {
            reverseSummand = [reverseSummand stringByAppendingString:@"0"];
        }
    }else {
        //相等时不用用0补齐
    }
    //对反转后的数进行计算
    for (NSInteger loc = 0; loc < maxLength; loc ++) {
        NSRange range = NSMakeRange(loc, 1);
        NSInteger s = [reverseSummand substringWithRange:range].integerValue;
        NSInteger a = [reverseAddend substringWithRange:range].integerValue;
        NSInteger sum = s + a + (carryFlag ? 1 : 0);
        if (sum >= numberFormat) {//进一位,因为是加法，所以进位最多也就1
            sum -=numberFormat;//去掉高位，留下地位
            carryFlag = YES;
        }else {
            carryFlag = NO;
        }
        reverseResult = [reverseResult stringByAppendingString:[NSString stringWithFormat:@"%zd",sum]];//拼接运算结果
    }
    if (carryFlag) {//如果进位标志还是YES，说明溢出一位，需要再增加，例如，999+1=1000
        reverseResult = [reverseResult stringByAppendingString:@"1"];
    }
    //反转reverseResult生成运算结果，同时，需要把末尾那些补齐的0去掉
    BOOL isNeedTrimEnd = YES;//是否需要修剪结尾
    for (NSInteger loc = reverseResult.length-1; loc >= 0;  loc --) {
        NSRange range = NSMakeRange(loc, 1);
        NSString *bit = [reverseResult substringWithRange:range];
        if (isNeedTrimEnd && [bit isEqualToString:@"0"]) {//是否需要修剪结尾，并且是否为0
            continue;
        }else {
            isNeedTrimEnd = NO;
        }
        result = [result stringByAppendingString:bit];//去掉无用的0后，逐位添加到结果
    }
    //
    return result;
}
//相当于十进制转自定义26进制的过程
+(NSString *)stringFromNumber:(NSInteger)number
{
    NSString *result = @"";//保存结果
    NSString *reverseResult = @"";//反转的结果
    NSMutableDictionary *mappingDict = [NSMutableDictionary dictionary];
    //添加基础映射关系
    for (int i = 0; i < 26; i ++) {
        [mappingDict setObject:[NSString stringWithFormat:@"%c",'Z'-i] forKey:@(i)];
    }
    //十进制转26进制,并保存
    NSArray *alphabetFormatArray = [MCUtil convertDecimal:number-1 toMFormat:26];//因为数字是从1开始的，所以需要number-1
    for (NSNumber *obj in alphabetFormatArray) {
        NSString *bit = [mappingDict objectForKey:obj];
        reverseResult = [reverseResult stringByAppendingString:bit];
    }
    //得到的是一个反转的结果，需要转回来
    for (NSInteger loc = reverseResult.length -1; loc >= 0; loc --) {
        NSRange range = NSMakeRange(loc, 1);
        result = [result stringByAppendingString:[reverseResult substringWithRange:range]];
    }
    return result;
}

+ (NSArray *)convertDecimal:(NSInteger)number toMFormat:(NSInteger)mFormat
{
    NSMutableArray *mFormatArray = [NSMutableArray array];
    NSInteger dividend = number;//被除数
    do {
        NSInteger remainder = dividend % mFormat;//得到余数
        NSInteger quotient = dividend / mFormat;//等到商
        dividend = quotient;//赋值，进入下一轮计算
        //        [mFormatArray addObject:[NSString stringWithFormat:@"%zd",remainder]];
        [mFormatArray addObject:@(remainder)];
    } while (dividend);//如果被除数为0的话，说明计算已经结束
    return [NSArray arrayWithArray:mFormatArray];
}

@end
