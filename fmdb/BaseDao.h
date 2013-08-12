//
//  BaseDao.h
//  fmdb
//
//  Created by motephyr on 13/3/29.
//  Copyright (c) 2013年 motephyr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface BaseDao : NSObject {
    FMDatabase *db;
}

@property (nonatomic, strong) FMDatabase *db;

-(NSString *)setTable:(NSString *)sql;

@end
