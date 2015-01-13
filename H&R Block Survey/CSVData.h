//
//  CSVData.h
//
//  Created by Patrick Shea on 11/26/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSVData : NSObject

- (void)updateCSV:(NSString *)csvFile withEntry:(NSString *)newData;

@end
