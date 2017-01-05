//
//  main.m
//  W&R
//
//  Created by vt on 15/12/22.
//  Copyright © 2015年 vt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <tingyunApp/NBSAppAgent.h>
#import "AppDelegate.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
        [NBSAppAgent startWithAppID:@"3405c55a450d4cb98f35a8f9c6a1030a"];

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
