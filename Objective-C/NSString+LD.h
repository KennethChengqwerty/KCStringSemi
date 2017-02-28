//
//  NSString+LD.h
//
//  Created by Kenneth Cheng on 14-7-3.
//  Copyright (c) 2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LD)
/**
 * 比较俩串的不同,并返回具体不同在哪
 */
+(NSArray * )LDCompareOriString:(NSString * )ori withCompareString:(NSString *)compare;
+(NSArray *)getMatrix:(NSString *)a withStringB:(NSString *)b;
+(NSMutableArray *)generate2DArrayWithRow:(int)row :(int)col;
@end
