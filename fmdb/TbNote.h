//
//  TbNote.h
//  fmdb
//
//  Created by motephyr on 13/3/29.
//  Copyright (c) 2013年 motephyr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TbNote : NSObject {
    int index;
    NSString *title;
    NSString *body;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *body;

- (id)initWithIndex:(int)newIndex Title:(NSString *)newTitle Body:(NSString *)newBody;
- (int)getIndex;

@end