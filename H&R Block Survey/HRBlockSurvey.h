//
//  HRBlockSurvey.h
//  H&R Block Survey
//
//  Created by Patrick Shea on 1/5/15.
//  Copyright (c) 2015 MotionKick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRBlockSurvey : NSObject

@property (strong, nonatomic) NSString *UID;
@property (strong, nonatomic) NSArray *surveyQuestions;
@property (strong, nonatomic) NSArray *surveyOptions;
@property (strong, nonatomic) NSString *surveyDateTaken;
@property (strong, nonatomic) NSString *surveyDataFile;

@end

