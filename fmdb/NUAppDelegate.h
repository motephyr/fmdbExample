//
//  NUAppDelegate.h
//  fmdb
//
//  Created by motephyr on 13/3/28.
//  Copyright (c) 2013年 motephyr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface NUAppDelegate : UIResponder <UIApplicationDelegate>{
    BOOL success;
    NSError *error;
    NSFileManager *fm;
    NSArray *paths;
    NSString *documentsDirectory;
    NSString *writableDBPath;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) FMDatabase *db;

@end
