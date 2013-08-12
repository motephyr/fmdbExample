//
//  TbNote.m
//  fmdb
//
//  Created by motephyr on 13/3/29.
//  Copyright (c) 2013年 motephyr. All rights reserved.
//

#import "TbNote.h"

@implementation TbNote
@synthesize title, body;

- (id)initWithIndex:(int)newIndex Title:(NSString *)newTitle Body:(NSString *)newBody{
    if(self = [super init]){
        index = newIndex;
        self.title = newTitle;
        self.body = newBody;
    }
    return self;
}

- (int)getIndex{
    return index;
}

@end