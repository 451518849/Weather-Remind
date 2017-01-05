//
//  SearchInformation.h
//  W&R
//
//  Created by vt on 15/12/22.
//  Copyright © 2015年 vt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchInformation : NSObject

+(NSMutableArray *)searshForActives:(NSArray*) dataBase andInputedString:(NSString*) _string ;
+(BOOL)weatherAnalyse:(NSArray*) dataBase andInputedString:(NSString*) _string ;
@end
