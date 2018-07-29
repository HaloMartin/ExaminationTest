//
//  MCInterfaceHeader.h
//  ExaminationTest
//
//  Created by M君 on 29/07/2018.
//  Copyright © 2018 M君. All rights reserved.
//

#ifndef MCDriverInterface_h
#define MCDriverInterface_h

@class MCClientOrder;
#pragma mark - MCDriverService
///协议接口，司机对象服务接口
@protocol MCDriverService <NSObject>

/** 接口：计算服务分
 * @param order 最近一单的信息，包含评分情况
 * @result 返回服务分
 */
-(NSNumber *)calculateScoreWithOrder:(MCClientOrder *)order;

@end

@class MCDriver;
#pragma mark - MCDriverCommentRules
///协议接口，司机评分规则接口，实现协议方法以定义规则
@protocol MCDriverCommentRules <NSObject>

///规则1，取最近的不多于X单（多于X单则取最近的X单），返回X
-(NSNumber *)numberOfCommentsFromDriver:(MCDriver *)driver;
///规则2，对于每一单，返回评分规则，好评差评投诉对应的奖惩规则,要求key为MCClientComment，value为对应的奖惩分数，元素都是NSNumber
-(NSDictionary *)rewardAndPunishRulesOfCommentsFromDriver:(MCDriver *)driver;
///规则3，服务分计算规则
-(NSNumber *)scoreOfCommentsFromDriver:(MCDriver *)driver;

@end

#endif /* MCDriverInterface_h */
