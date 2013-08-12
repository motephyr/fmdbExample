//
//  BaseDao.m
//  fmdb
//
//  Created by motephyr on 13/3/29.
//  Copyright (c) 2013年 motephyr. All rights reserved.
//

#import "NUAppDelegate.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "BaseDao.h"

@implementation BaseDao
@synthesize db;

- (id)init{
    if(self = [super init]){
        // 由 AppDelegate 取得打开的数据库
        NUAppDelegate *appDelegate = (NUAppDelegate *)[[UIApplication sharedApplication] delegate];
        db = [appDelegate db];
    }
    return self;
}
// 子类中实现
-(NSString *)setTable:(NSString *)sql{
    return NULL;
}



@end