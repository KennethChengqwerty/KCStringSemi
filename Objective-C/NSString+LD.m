//
//  NSString+LD.m
//
//  Created by Kenneth Cheng on 14-7-3.
//  Copyright (c) 2014. All rights reserved.

#import "NSString+LD.h"

@implementation NSString (LD)
+(NSArray * )LDCompareOriString:(NSString * )ori withCompareString:(NSString *)compare
{
    BOOL isSwap = NO;
    NSString * a =ori;
    NSString * b = compare;
    int lengthA =(int)a.length;
    int lengthB = (int)b.length;
    //row for the shorter String,colume for longer
    if(lengthB<lengthA){
        isSwap = YES;
        NSString * swap =@"";
        swap = a;
        a=b;
        b=swap;
        swap = nil;
        lengthA = (int)a.length;
        lengthB = (int)b.length;
    }
    
    NSMutableArray * arrayA = [[NSMutableArray alloc]initWithCapacity:lengthA];
    NSMutableArray * arrayB = [[NSMutableArray alloc]initWithCapacity:lengthB];
    for (int i=0; i<lengthA; i++) {
        [arrayA addObject:@""];
    }
    for (int i=0; i<lengthB; i++) {
        [arrayB addObject:@""];
    }
    
    NSMutableArray * matrix = [self getMatrix:a withStringB:b];
    
    //init array
    for(int i  =0;i<lengthA;i++){
        NSString * tempA = [a substringWithRange:NSMakeRange(i, 1)];
        [arrayA replaceObjectAtIndex:i withObject:tempA];
    }
    for(int i  =0;i<lengthB;i++){
        NSString * tempB = [b substringWithRange:NSMakeRange(i, 1)];
        [arrayB replaceObjectAtIndex:i withObject:tempB];
    }
    int nextI = (int)a.length;
    int nextJ = (int)b.length;
    
    NSString * SBA = @"";
    NSString * SBB = @"";
    
    //the end comes when next position to the first frid in matrix which present as matrix[0][0]
    while (!(nextI==0 && nextJ==0)) {
        // when the search path have already comes at the first row,the next position is the left frid
        if(nextI==0){
        //left
            SBA = [NSString stringWithFormat:@"%@%@",SBA,@"_"];
            SBB = [NSString stringWithFormat:@"%@%@",SBB,[arrayB objectAtIndex:nextJ-1]];
            nextI=0;
            nextJ = nextJ-1;
            continue;
        }
        
        //when the search path have already comes to the first colum,the next position is the up grid
        if(nextJ==0){
        //up
            SBA = [NSString stringWithFormat:@"%@%@",SBA,[arrayA objectAtIndex:nextI-1]];
            SBB = [NSString stringWithFormat:@"%@%@",SBB,@"_"];
            nextI = nextI-1;
            nextJ=0;
            continue;
        }
        
        //get the current string a and b to compare
        NSString * A = [arrayA objectAtIndex:nextI-1];
        NSString * B = [arrayB objectAtIndex:nextJ-1];
        
        int i = [[[matrix objectAtIndex:nextI]objectAtIndex:nextJ] intValue];
        if([A isEqualToString:B]){
        //the next position is the upleft grid from current position
            nextI = nextI-1;
            nextJ = nextJ-1;
            SBA = [NSString stringWithFormat:@"%@%@",SBA,A];
            SBB = [NSString stringWithFormat:@"%@%@",SBB,B];
        }else{
        //compare the left ,up,upeft grid and choose the minimize frid.the priorty sink to upleft,up and left gradually
            int index = 0;
            int left = 0;
            int up = 0;
            int upLeft = 0;
            int tempRst = 0;
            
            if(nextI == 0 || nextJ==0){
                if(nextI==0){
                //first row in matrix
                    left = [[[matrix objectAtIndex:0]objectAtIndex:nextJ-1] intValue];
                    up = -1;
                    upLeft = -1;
                    tempRst = left;
                }else{
                //first colume in matrix
                    left = -1;
                    up = [[[matrix objectAtIndex:nextI-1]objectAtIndex:0]intValue];
                    upLeft = -1;
                    tempRst = up;
                }
            }else{
                left = [[[matrix objectAtIndex:nextI]objectAtIndex:nextJ-1] intValue];
                up = [[[matrix objectAtIndex:nextI-1]objectAtIndex:nextJ] intValue];
                upLeft = [[[matrix objectAtIndex:nextI-1]objectAtIndex:nextJ-1] intValue];
                tempRst = MIN(MIN(upLeft, up), left);
            }
            
            if(tempRst == left){
                index +=1;
            }
            
            if(tempRst ==up){
                index +=2;
            }
            if(tempRst == upLeft){
                index +=4;
            }
            
            switch (index) {
                case 1:
                    //left
                    nextI =nextI;
                    nextJ = nextJ-1;
                    SBA = [NSString stringWithFormat: @"%@%@",SBA,@"_"];
                    SBB = [NSString stringWithFormat: @"%@%@",SBB,B];
                    break;
                case 2:
                    //up
                    nextI =nextI-1;
                    nextJ = nextJ;
                    SBA = [NSString stringWithFormat: @"%@%@",SBA,A];
                    SBB = [NSString stringWithFormat: @"%@%@",SBB,@"_"];
                    break;
                case 3:
                    //up
                    nextI =nextI-1;
                    nextJ = nextJ;
                    SBA = [NSString stringWithFormat: @"%@%@",SBA,A];
                    SBB = [NSString stringWithFormat: @"%@%@",SBB,@"_"];
                    break;
                case 4:
                    //midleft
                    nextI =nextI-1;
                    nextJ = nextJ-1;
                    SBA = [NSString stringWithFormat: @"%@%@",SBA,A];
                    SBB = [NSString stringWithFormat: @"%@%@",SBB,B];
                    break;
                case 5:
                    //midleft
                    nextI =nextI-1;
                    nextJ = nextJ-1;
                    SBA = [NSString stringWithFormat: @"%@%@",SBA,A];
                    SBB = [NSString stringWithFormat: @"%@%@",SBB,B];
                    break;
                case 6:
                    //midleft
                    nextI =nextI-1;
                    nextJ = nextJ-1;
                    SBA = [NSString stringWithFormat: @"%@%@",SBA,A];
                    SBB = [NSString stringWithFormat: @"%@%@",SBB,B];
                    break;
                case 7:
                    //midleft
                    nextI =nextI-1;
                    nextJ = nextJ-1;
                    SBA = [NSString stringWithFormat: @"%@%@",SBA,A];
                    SBB = [NSString stringWithFormat: @"%@%@",SBB,B];
                    break;
                    default:
                    break;
            }
        }
    }
    NSMutableArray * result = [[NSMutableArray alloc] init];
    if(isSwap){
        [result addObject:[self reverseSort:SBB]];
        [result addObject:[self reverseSort:SBA]];
    }else{
        [result addObject:[self reverseSort:SBA]];
        [result addObject:[self reverseSort:SBB]];
    }
    
    return result;
}

//返回一个二维数组内容为ab
+(NSMutableArray *)getMatrix:(NSString *)a withStringB:(NSString *)b
{
    int lengthA = (int)a.length;
    int lengthB = (int)b.length;
    NSMutableArray * matrix = [self generate2DArrayWithRow:lengthA+1 :lengthB+1];
    NSMutableArray *arrayA = [[NSMutableArray alloc]initWithCapacity:lengthA];
    NSMutableArray *arrayB = [[NSMutableArray alloc]initWithCapacity:lengthB];
    for (int i=0 ;i<lengthA;i++) {
        [arrayA addObject:@""];
    }
    for (int i=0 ;i<lengthB;i++) {
        [arrayB addObject:@""];
    }
    
    //init matrix
    
    //init array
    for (int i=0; i<lengthA; i++) {
        NSString * tempA = [a substringWithRange:NSMakeRange(i, 1)];
        [self setArrayValue:arrayA index:i value:tempA];
        [self set2DArrayintValue:matrix row:i+1 col:0 value:i+1];
    }
    for (int i=0; i<lengthB; i++) {
        NSString * tempB = [b substringWithRange:NSMakeRange(i, 1)];
        [self setArrayValue:arrayB index:i value:tempB];
        [self set2DArrayintValue:matrix row:0 col:i+1 value:i+1];
    }
    //calculate matrix value
    for (int i=1; i<=lengthA; i++) {
        for (int j=1; j<=lengthB; j++) {
            NSString * tempAi = (NSString*)[arrayA objectAtIndex:i-1];
            NSString * tempBj = (NSString*)[arrayB objectAtIndex:j-1];
            
            if([tempAi isEqualToString:tempBj]){
                NSNumber * matrixVlaue =[[matrix objectAtIndex:i-1]objectAtIndex:j-1];
                [self set2DArrayintValue:matrix row:i col:j value:[matrixVlaue intValue]];
            }else{
                NSNumber * minTN =[[matrix objectAtIndex:i-1]objectAtIndex:j-1];
                int minT = [minTN intValue];
                
                NSNumber * min1 = [[matrix objectAtIndex:i-1]objectAtIndex:j];
                int min1T = [min1 intValue];
                minT = MIN(minT, min1T);
                
                NSNumber * min2 = [[matrix objectAtIndex:i]objectAtIndex:j-1];
                int min2T = [min2 intValue];
                minT = MIN(minT, min2T);
                [self set2DArrayintValue:matrix row:i col:j value:minT+1];
            }
        }
    }
    return  matrix;
}

+(NSString *)reverseSort:(NSString *)str
{
    NSString * str2 = @"";
    for (int i = (int)str.length-1; i>-1;i--) {
        NSString * temp = [str substringWithRange:NSMakeRange(i, 1)];
        str2=[NSString stringWithFormat:@"%@%@",str2,temp];
    }
    return  str2;
}

+(void)setArrayValue:(NSMutableArray *)array index:(int)index value:(id)value
{
    [array replaceObjectAtIndex:index withObject:value];
}

+(void)setArrayintValue:(NSMutableArray *)array index:(int)index value:(int)value
{
    [array replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:value]];
}

+(void)set2DArrayValue:(NSMutableArray *)array row:(int)row col:(int)col value:(id)value
{
    [[array objectAtIndex:row] replaceObjectAtIndex:col withObject:value];
}

+(void)set2DArrayintValue:(NSMutableArray *)array row:(int)row col:(int)col value:(int)value
{
    [[array objectAtIndex:row] replaceObjectAtIndex:col withObject:[NSNumber numberWithInteger:value]];
}

//创建二维数组
+(NSMutableArray *)generate2DArrayWithRow:(int)row :(int)col
{
    NSMutableArray * collection = [[NSMutableArray alloc]initWithCapacity:row];
    for (int i=0; i<row; i++) {
        NSMutableArray * colArray = [[NSMutableArray alloc]initWithCapacity:col];
        for (int j=0; j<col; j++) {
            [colArray addObject:[NSNumber numberWithInteger:0]];
        }
        [collection addObject:colArray];
    }
    return collection;
}

@end
