//
//  SearchInformation.m
//  W&R
//
//  Created by vt on 15/12/22.
//  Copyright © 2015年 vt. All rights reserved.
//

#import "SearchInformation.h"

@implementation SearchInformation
+(NSMutableArray *)searshForActives:(NSArray*) dataBase andInputedString: (NSString*) _string
{
    
    NSMutableString *tempString;
    NSString *keyWord;
    NSMutableArray *whatWeFound;
    
    whatWeFound=[[NSMutableArray alloc]init];
    
    for (int i=0; i<dataBase.count; i++) {
        keyWord=[dataBase objectAtIndex:i];
        for (int j=0; j<[_string length]; j++) {
            for (int k=0; (k<=[keyWord length])&&((k+j)<=[_string length]); k++) {
                tempString=[NSMutableString stringWithString:[_string substringWithRange:NSMakeRange(j, k)]];
                if ([tempString isEqualToString:keyWord])
                {
                    [whatWeFound addObject:tempString];
                }
                
            }
        }
    }
    return whatWeFound;
    //    if (whatWeFound.count != 0) {
    //        return YES;
    //    }else
    //        return NO;
}
+(BOOL)weatherAnalyse:(NSArray*) dataBase andInputedString:(NSString*) _string ;
{
    
    NSMutableString *tempString;
    NSString *keyWord;
    NSMutableArray *whatWeFound;
    
    whatWeFound=[[NSMutableArray alloc]init];
    
    for (int i=0; i<dataBase.count; i++) {
        keyWord=[dataBase objectAtIndex:i];
        for (int j=0; j<[_string length]; j++) {
            for (int k=0; (k<=[keyWord length])&&((k+j)<=[_string length]); k++) {
                tempString=[NSMutableString stringWithString:[_string substringWithRange:NSMakeRange(j, k)]];
                if ([tempString isEqualToString:keyWord])
                {
                    [whatWeFound addObject:tempString];
                }
                
            }
        }
    }
    if (whatWeFound.count != 0) {
        return YES;
    }else
        return NO;
}
@end
