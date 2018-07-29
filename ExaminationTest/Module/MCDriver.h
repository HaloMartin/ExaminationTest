//
//  MCDriver.h
//  ExaminationTest
//
//  Created by M君 on 29/07/2018.
//  Copyright © 2018 M君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCDriverInterface.h"

///MCClientComment，客户评价
typedef enum : NSUInteger {
    MCClientCommentPraise = 0x00,//好评
    MCClientCommentNegative,//差评
    MCClientCommentComplain,//投诉
} MCClientComment;

#pragma mark - MCClientOrder
@interface MCClientOrder : NSObject

@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic) MCClientComment comment;

-(instancetype)initWithOrderNumber:(NSString *)orderNumber comment:(MCClientComment)comment;

@end

#pragma mark - MCDriver
///司机对象，实现协议MCDriverService中的计算服务分即可
@interface MCDriver : NSObject <MCDriverService>

@property (nonatomic, weak) id<MCDriverCommentRules> delegate;

-(instancetype)init;
/** @brief 获取已完成的订单数量
 * @result 返回订单数量
 */
-(NSNumber *)getOrdersNumber;
/** @brief 获取指定范围内的订单信息
 * @param range 指定范围
 * @result 返回指定范围内的订单信息
 */
-(NSArray *)getOrdersWithRange:(NSRange)range;
/** @brief 获取计算服务分需要的最少的订单数量
 * @result 返回订单数量
 */
-(NSNumber *)getLeastCommentNumber;
/** @brief 获取奖惩规则
 * @result 返回奖惩规则
 */
-(NSDictionary *)getRewardAndPunishRulesDictionary;

@end
