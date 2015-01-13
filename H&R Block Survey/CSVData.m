//
//  CSVData.m
//
//  Created by Patrick Shea on 11/26/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "CSVData.h"

@interface CSVData  ()


@end

@implementation CSVData


- (void)updateCSV:(NSString *)csvFile withEntry:(NSString *)newData {
    BOOL success;
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"survey_data" ofType:@"csv"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path =[[NSString alloc] initWithString:
                     [documentsDirectory stringByAppendingPathComponent:csvFile]];
    
    success = [fileManager fileExistsAtPath:path];
    
    if (success) {
        
        // append new data to file
        NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myHandle seekToEndOfFile];
        [myHandle writeData:[newData dataUsingEncoding:NSUTF8StringEncoding]];
        [myHandle closeFile];
        
    } else {
        success = [fileManager copyItemAtPath:filePath  toPath:path error:&error];
        // append new data to file
        NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myHandle seekToEndOfFile];
        [myHandle writeData:[newData dataUsingEncoding:NSUTF8StringEncoding]];
        [myHandle closeFile];
    }
    
}

@end
