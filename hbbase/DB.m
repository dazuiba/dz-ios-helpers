//
//  DB.m
//  BikeMap
//
//  Created by  on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DB.h"

@implementation DB 
FMDatabase* _fmDbSingleton;
#define kDestFileName @"cst2.sqlite"
+ (void)checkAndInstall{
    NSString* filePath = [[$ documentPath] stringByAppendingPathComponent:kDestFileName];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: filePath]) {
//        return NO;
    }else {
        NSError *error = nil;
        if([filemgr copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"mobile" ofType:@"sqlite3"] toPath:filePath error:&error]){
            NSLog(@"File successfully copied");
        } else {
            NSLog(@"Error description-%@ \n", [error localizedDescription]);
            NSLog(@"Error reason-%@", [error localizedFailureReason]);
        }
    }
}

+ (FMDatabase*)instance {
    if (!_fmDbSingleton) {
        NSString* filePath = [[$ documentPath] stringByAppendingPathComponent:kDestFileName];
        _fmDbSingleton = [[FMDatabase alloc] initWithPath:filePath];
        _fmDbSingleton.logsErrors = YES;
#if (TARGET_IPHONE_SIMULATOR)
//        _fmDbSingleton.traceExecution = YES;
#endif
        [_fmDbSingleton open];
        
//        if (![_fmDbSingleton tableExists:@"favs"]) {
//            [_fmDbSingleton executeUpdate:@"create table favs (id integer primary key, folder_id int,position int, spot_id int, spot_dict_cache text);"];
//            [_fmDbSingleton executeUpdate:@"create index if not exists favs_spot_id_idx on favs(spot_id)"];
//            [_fmDbSingleton executeUpdate:@"create index if not exists favs_folder_id_idx on favs(folder_id)"];
//        }
//        if (![_fmDbSingleton tableExists:@"folders"]) {
//            [_fmDbSingleton executeUpdate:@"create table folders (id integer primary key, name text, position int)"];
//        }
//
//        if (![_fmDbSingleton tableExists:@"spot_submits"]) {
//            [_fmDbSingleton executeUpdate:@"create table spot_submits (id integer primary key, geo text, spot_id int)"];
//            [_fmDbSingleton executeUpdate:@"create index if not exists spot_submits_spot_id_idx on spot_submits(spot_id)"];
//        }

    }
    return _fmDbSingleton;
}



// Close and save the database
+ (void)close {
    [_fmDbSingleton close];
    [_fmDbSingleton release];
    _fmDbSingleton = nil;
}
@end
