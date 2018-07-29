//
//  MCUtil.h
//  ExaminationTest
//
//  Created by M君 on 29/07/2018.
//  Copyright © 2018 M君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCUtil : NSObject

/** 模拟加法运算,计算字符串类型的加数和被加数
 * @param summand 被加数,正整数，长度不超过30个字节的字符串
 * @param addend 加数,正整数，长度不超过30个字节的字符串
 * @result 返回和数
 */
+(NSString *)additionWithSummand:(NSString *)summand andAddend:(NSString *)addend;

/** 数字字符串映射关系，根据映射关系，返回数字对应的字符串
 * @param number 输入的数字
 * @result 返回对应的字符串
 */
+(NSString *)stringFromNumber:(NSInteger)number;

/** 十进制转任意进制，返回的是一个数组，代表mFormat进制下对应位上的值
 * @param number 需要转换的十进制数
 * @param mFormat 需要转到的标的进制
 * @result 返回数组,元素为NSNumber，索引从低到高对应数值的低位到高位
 */
+ (NSArray *)convertDecimal:(NSInteger)number toMFormat:(NSInteger)mFormat;

@end
