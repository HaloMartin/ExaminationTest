//
//  MCDriverTest.m
//  ExaminationTest
//
//  Created by M君 on 29/07/2018.
//  Copyright © 2018 M君. All rights reserved.
//


#import "MCDriverTest.h"

///测试用例，实现协议MCDriverCommentRules中的三个规则，即可自定义规则，对于继承自MCDriver的对象，可以使用不同的规则
@interface MCDriverTest ()<MCDriverCommentRules>

@end

@implementation MCDriverTest

-(instancetype)init
{
    self = [super init];
    if (self) {
        _driver = [[MCDriver alloc] init];
        _driver.delegate = self;
    }
    return self;
}

#pragma mark - MCDriverCommentRules
-(NSNumber *)numberOfCommentsFromDriver:(MCDriver *)driver
{//自定义规则1，取最近的不多于50单（多于50单则取最近的50单）
    return @(50);
}
-(NSDictionary *)rewardAndPunishRulesOfCommentsFromDriver:(MCDriver *)driver
{//自定义规则2，对于每一单，乘客好评权重是1，差评是-1，投诉是-3
    return @{@(MCClientCommentPraise):@(1)
             , @(MCClientCommentNegative):@(-1)
             , @(MCClientCommentComplain):@(-3)
             };
}
-(NSNumber *)scoreOfCommentsFromDriver:(MCDriver *)driver
{//自定义规则3，服务分=总权重*100/总单数
    NSNumber *totalOrderNumber = [driver getOrdersNumber];//全部订单数
    NSNumber *atLeastCommentNumber = [driver getLeastCommentNumber];//符合要求的订单数量
    NSDictionary *rewardAndPunishDict = [driver getRewardAndPunishRulesDictionary];//奖惩规则
    NSArray *commentArray = nil;
    if (totalOrderNumber > atLeastCommentNumber) {
        commentArray = [driver getOrdersWithRange:NSMakeRange([totalOrderNumber integerValue]-[atLeastCommentNumber integerValue], [atLeastCommentNumber integerValue])];
    }else {
        commentArray = [driver getOrdersWithRange:NSMakeRange(0, [totalOrderNumber integerValue])];
    }
    //计算总权重
    NSInteger totalAggregateWeight = 0;
    for (MCClientOrder *obj in commentArray) {
        totalAggregateWeight += [[rewardAndPunishDict objectForKey:@(obj.comment)] integerValue];
        NSLog(@"OrderNo:%@ Comment:%zd totalAggregateWeight = %zd",obj.orderNumber,obj.comment,totalAggregateWeight);
    }
    return @(totalAggregateWeight*100/commentArray.count);
}
@end
