//
//  NSString+translation.m
//  ViewDemo
//
//  Created by sunhong on 16/9/13.
//  Copyright © 2016年 sunhong. All rights reserved.
//
/**
 *  待完善
 *
 *  @param translation 点
 *
 *  @return 小数点之后还没处理
 */

#import "NSString+translation.h"

@implementation NSString (translation)

+ (NSString *)translation:(NSString *)arebic {
    
    if (arebic.length == 0) {//当字符串删除到空时，放回""
        return @"";
    }
    NSString *str = arebic;
    BOOL isPoint = [arebic containsString:@"."];
    NSString *availStr;
    if (isPoint) {//包含小数点
        NSRange range  =[arebic rangeOfString:@"."];
        str = [arebic substringToIndex:range.location];
        availStr = [arebic substringFromIndex:(range.location+1)];
    }
    
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    if (str.length > digits.count) {//防止数字超过兆导致崩溃
        str = [arebic substringToIndex:digits.count];
    }
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSInteger digitIndex = str.length -i-1;
        NSString *b = digits[digitIndex];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    if (isPoint && availStr.length > 0) {
        
        [sums addObject:@"点"];

        for (int i = 0; i < availStr.length; i ++) {
            NSString *substr = [availStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            [sums addObject:a];
        }
    }
    [sums addObject:@"元"];
    NSString *sumStr = [sums componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length];
    
//    NSLog(@"%@",str);
//    NSLog(@"%@",chinese);
    return chinese;
}

/**
 *  数字格式化
 *
 *  划分千分位，保留两位小数
 */
+ (NSString *)generateValueFormatter:(NSString *)text {
    
    double number = [text doubleValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    
    return formattedNumberString;
}

@end
