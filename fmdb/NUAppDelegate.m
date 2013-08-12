//
//  NUAppDelegate.m
//  fmdb
//
//  Created by motephyr on 13/3/28.
//  Copyright (c) 2013年 motephyr. All rights reserved.
//

#import "NUAppDelegate.h"
#import "FMDatabase.h"

@implementation NUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) linkDatabase{
    NSError *error;
    fm = [NSFileManager defaultManager];
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    documentsDirectory = [paths objectAtIndex:0];
    writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"mwtDB.sqlite"];
    success = [fm fileExistsAtPath:writableDBPath];
    if(!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"mwtDB.sqlite"];
        
        success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath
                               error:&error];
        if(!success){
            NSLog([error localizedDescription]);
        }
    }
    
    //連接資料庫
    FMDatabase *db = [FMDatabase databaseWithPath:writableDBPath];
    if([db open]){
        [db setShouldCacheStatements:YES];
        
        
        // INSERT
        [db beginTransaction];
        int i = 0;
        while (i++ < 20) {
            [db executeUpdate:@"INSERT INTO TEST (name) values (?)" , [NSString stringWithFormat:@"number %d", i]];
            if ([db hadError]) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            }
        }
        [db commit];
        //SELECT
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM docData"];
        while ([rs next]){
            NSLog(@"%d,%@,%@",[rs intForColumn:@"m_Id"],[rs stringForColumn:@"m_Title"],[rs stringForColumn:@"m_Url"]);
        }
        [rs close];
        [db close];
    }else{
        NSLog(@"無法開啟資料庫");
    }
}

-(void) createDatabase{
    NSURL *appUrl = [[[NSFileManager defaultManager]
                      URLsForDirectory:NSDocumentDirectory
                      inDomains:NSUserDomainMask] lastObject];
    NSString *dbPath = [[appUrl path] stringByAppendingPathComponent:@"MyDatabase.db"];
    FMDatabase* db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"Could not open db");
    }else{
        if(![db executeUpdate:@"CREATE TABLE IF NOT EXISTS user (uid integer primary key asc autoincrement, name text, description text)"])
        {
            NSLog(@"Could not create table: %@", [db lastErrorMessage]);
        }
    }
}


-(void) appInit{
    NSMutableArray *_items = [NSMutableArray arrayWithCapacity:0];
    fm = [NSFileManager defaultManager];
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    documentsDirectory = [paths objectAtIndex:0];
    writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"mwtDB.sqlite"];
    if(!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"mwtDB.sqlite"];
        NSError *error;
        success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath
                               error:&error];
        if(!success){
            NSLog(@"Error");
        }
    }
    
    //連接資料庫
    FMDatabase *db = [FMDatabase databaseWithPath:writableDBPath];
    if([db open]){
        [db setShouldCacheStatements:YES];
        
        //SELECT
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM docData"];
        while ([rs next]){
            NSLog(@"%d,%@,%@",[rs intForColumn:@"m_Id"],[rs stringForColumn:@"m_Title"],[rs stringForColumn:@"m_Url"]);
            int m_id = [rs intForColumn:@"m_Id"];
            int m_title = [rs intForColumn:@"m_Title"];
            int m_url = [rs intForColumn:@"m_Url"];
            
            //將資料放入陣列中
            [_items addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:m_id],@"m_Id",m_title,@"m_Title",m_url,@"m_Url",nil]];
            
        }
        [rs close];
        [db close];
    }else{
        NSLog(@"無法開啟資料庫");
    }
}


@end
