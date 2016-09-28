//
//  NSString+translation.m
//  ViewDemo
//
//  Created by sunhong on 16/9/13.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "NSString+translation.h"

@implementation NSString (translation)

+ (NSString *)translation:(NSString *)arebic {
    
    /*
    if (arebic.length == 0 || ([arebic floatValue] == 0)) {
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
     */
    
    NSInteger pointLoc = -1;
    
    //当字符串删除到空时，放回"" || 数字输入有多个0
    if ((arebic.length == 0) || ([arebic floatValue] == 0)) {
        return @"";
    }
    
    NSString *str = arebic;
    
    BOOL isPoint = [arebic containsString:@"."];
    NSString *availStr;
    if (isPoint) {//包含小数点
        NSRange range  =[arebic rangeOfString:@"."];
        pointLoc = range.location;
        
        //当第一个是点时
        if (pointLoc == 0) {
            str = @"0";
        } else {
            str = [arebic substringToIndex:pointLoc];
        }
        availStr = [arebic substringFromIndex:(pointLoc+1)];
        
        //防止出现多个小数点
        if ([availStr containsString:@"."]) {
            availStr = [availStr stringByReplacingOccurrencesOfString:@"." withString:@""];
        }
    }
    
    //防止出现多个0，如：0000098
    NSInteger zeroCount = 0;
    for (int i = 1; i < str.length+1; i++) {
        NSString *subStr = [arebic substringToIndex:i];
        NSLog(@"%ld",[subStr integerValue]);
        if ([subStr integerValue] != 0) {
            zeroCount = i-1;
            break;
        }
    }
    str = [str substringFromIndex:zeroCount];
    
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    if (str.length > digits.count) {//防止数字超过兆导致崩溃
        str = [str substringToIndex:digits.count];
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
