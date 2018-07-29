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
-(NSNumber *)getOrdersNumber;
-(NSArray *)getOrdersWithRange:(NSRange)range;
-(NSNumber *)getLeastCommentNumber;
-(NSDictionary *)getRewardAndPunishRulesDictionary;

@end
