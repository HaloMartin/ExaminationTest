//
//  MCDriver.m
//  ExaminationTest
//
//  Created by M君 on 29/07/2018.
//  Copyright © 2018 M君. All rights reserved.
//


#import "MCDriver.h"

#pragma mark - MCClientOrder
@interface MCClientOrder ()

@end
@implementation MCClientOrder

-(instancetype)initWithOrderNumber:(NSString *)orderNumber comment:(MCClientComment)comment
{
    self = [super init];
    if (self) {
        _orderNumber = orderNumber;
        _comment = comment;
    }
    return self;
}

@end

#pragma mark - MCDriver
@interface MCDriver ()

@property (nonatomic, strong) NSMutableArray *orders;

@end
@implementation MCDriver

-(instancetype)init
{
    self = [super init];
    if (self) {
        _orders = [NSMutableArray array];
        //模拟生成100个订单数据，实际应该从服务器获取
        for (int i = 1; i <= 100; i ++) {
            MCClientOrder *order = [[MCClientOrder alloc] init];
            order.orderNumber = [NSString stringWithFormat:@"%d",i];
            if (i%20 == 0) {//每隔20个订单，随机一个评分
                int r = rand() % 3;
                order.comment = (MCClientComment)r;
            }else {//固定订单数量占比在90%以上
                order.comment = MCClientCommentPraise;
            }
            [_orders addObject:order];
        }
    }
    return self;
}
-(NSNumber *)getOrdersNumber
{
    return @(_orders.count);
}
-(NSArray *)getOrdersWithRange:(NSRange)range
{
    NSArray *resultArray = nil;
    if (_orders.count < (range.location +range.length)) {
        return nil;
    }
    //如果订单信息中包含日期的话，可以根据日期来进行排序，以保证取到的值都是最新的，这里默认新的会插在后面，所以取的是后面的
    //Insert Code
    resultArray = [_orders subarrayWithRange:range];
    return resultArray;
}
-(NSNumber *)getLeastCommentNumber
{
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfCommentsFromDriver:)]) {//1.返回数量
        return [_delegate numberOfCommentsFromDriver:self];
    }
    return @0;
}
-(NSDictionary *)getRewardAndPunishRulesDictionary
{
    if (_delegate && [_delegate respondsToSelector:@selector(rewardAndPunishRulesOfCommentsFromDriver:)]) {//2.获取奖惩规则
        return [_delegate rewardAndPunishRulesOfCommentsFromDriver:self];
    }
    return nil;
}

#pragma mark - MCDriverService
-(NSNumber *)calculateScoreWithOrder:(MCClientOrder *)order
{
    //录入最新的订单评分信息
    [_orders addObject:order];
    if (_delegate && [_delegate respondsToSelector:@selector(scoreOfCommentsFromDriver:)]) {
        return [_delegate scoreOfCommentsFromDriver:self];;
    }
    return @0;
}


@end
