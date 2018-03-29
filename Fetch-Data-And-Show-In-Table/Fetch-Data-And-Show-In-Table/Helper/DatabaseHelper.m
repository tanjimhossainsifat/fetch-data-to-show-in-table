//
//  DatabaseHelper.m
//  Fetch-Data-And-Show-In-Table
//
//  Created by Arafat Mahmood Rahat on 30/3/18.
//  Copyright © 2018 Tanjim.org. All rights reserved.
//

#import "DatabaseHelper.h"
#import "FMDB.h"
#import <sqlite3.h>

@implementation DatabaseHelper
{
    FMDatabase *db;
}

+ (instancetype) sharedInstance {
    
    static dispatch_once_t once_token;
    static DatabaseHelper *sharedInstance = nil;
    
    dispatch_once(&once_token, ^{
       
        sharedInstance = [[DatabaseHelper alloc] init];
        BOOL isDBCreated = [sharedInstance create];
        
        if(!isDBCreated) {
            sharedInstance = nil;
        }
        
    });
    
    return sharedInstance;
}

- (BOOL) create
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
    db = [FMDatabase databaseWithPath:path];
    
    if(!db)
        return false;
    
    if (![db open]) {
        db = nil;
        return false;
    }
    
    NSString *sql = @"create table if not exists table1 (id integer primary key, info1 text, info2 text, info3 text);";
    
    BOOL isTableCreated = [db executeStatements:sql];
    
    [db close];
    
    return isTableCreated;
    
}

- (BOOL) insertInfoList:(NSArray<Info *>*) infoList {
    
    if (![db open]) {
        db = nil;
        return false;
    }
    
    NSMutableString *sql;
    
    for (Info *eachInfo in infoList) {
        
        NSInteger id = eachInfo.id;
        NSString *info1 = eachInfo.info1;
        NSString *info2 = eachInfo.info2;
        NSString *info3 = eachInfo.info3;
        
        
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO table (id, info1, info2, info3) VALUES(%ld, '%@', '%@','%@') ON DUPLICATE KEY UPDATE info1='%@', info2='%@', info3='%@';",id,info1, info2, info3, info1, info2, info3];
        
        [sql appendString:insertSql];
    }
    
    BOOL isInserted = [db executeStatements:sql];
    
    [db close];
    
    return isInserted;
    
}

- (NSArray<Info *> *) getAllInfo {
    
    if (![db open]) {
        db = nil;
        return nil;
    }
    
    NSMutableArray *infoList = [[NSMutableArray alloc] init];
    
    FMResultSet *s = [db executeQuery:@"SELECT * FROM table1"];
    while ([s next]) {
        
        Info *info = [[Info alloc] init];
        
        info.id = [s intForColumn:@"id"];
        info.info1 = [s stringForColumn:@"info1"];
        info.info2 = [s stringForColumn:@"info2"];
        info.info3 = [s stringForColumn:@"info3"];
        
        [infoList addObject:info];
        
    }
    
    [db close];
    
    return infoList;
    
}

@end
