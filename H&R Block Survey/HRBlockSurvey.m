//
//  HRBlockSurvey.m
//  H&R Block Survey
//
//  Created by Patrick Shea on 1/5/15.
//  Copyright (c) 2015 MotionKick. All rights reserved.
//

#import "HRBlockSurvey.h"

@interface HRBlockSurvey()

@property (strong, nonatomic) NSArray *englishQuestions;
@property (strong, nonatomic) NSArray *spanishQuestions;
@property (strong, nonatomic) NSArray *englishOptionsQ1;
@property (strong, nonatomic) NSArray *englishOptionsQ2;
@property (strong, nonatomic) NSArray *spanishOptionsQ1;
@property (strong, nonatomic) NSArray *spanishOptionsQ2;

@end

@implementation HRBlockSurvey

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.UID = [self createUID];
        
        self.englishQuestions = [NSArray arrayWithObjects:
                              @"When you receive a tax refund, what do you typically spend it on? Please select all that apply.",
                              @"What \"fun\" thing would you like to spend your tax refund on?",
                              nil];
        
        self.spanishQuestions = [NSArray arrayWithObjects:
                                 @"Cuando tu recibes un tax refundo, typicamente que compre? Por favor selecte todos que applicar.",
                                 @"Que tipo de cosa \"divertida\" comprare con su tax refundo?",
                                 nil];

        self.surveyQuestions = [NSArray arrayWithObjects:
                                self.spanishQuestions,
                                self.englishQuestions,
                                nil];
        
        
        self.englishOptionsQ1 = [NSArray arrayWithObjects:
                                  @"Lighter weight",
                                  @"Increased cycling life",
                                  @"Improved reliability",
                                  @"Improved charge acceptance",
                                  @"Improved depth of discharge",
                                  @"Reduced internal resistance",
                                  nil];
        
        self.englishOptionsQ2 = [NSArray arrayWithObjects:
                                 @"Lighter weight",
                                 @"Increased cycling life",
                                 @"Improved reliability",
                                 @"Improved charge acceptance",
                                 @"Improved depth of discharge",
                                 @"Reduced internal resistance",
                                 nil];
        
        self.spanishOptionsQ1 = [NSArray arrayWithObjects:
                                 @"Lighter weight",
                                 @"Increased cycling life",
                                 @"Improved reliability",
                                 @"Improved charge acceptance",
                                 @"Improved depth of discharge",
                                 @"Reduced internal resistance",
                                 nil];
  
        self.spanishOptionsQ2 = [NSArray arrayWithObjects:
                                 @"Lighter weight",
                                 @"Increased cycling life",
                                 @"Improved reliability",
                                 @"Improved charge acceptance",
                                 @"Improved depth of discharge",
                                 @"Reduced internal resistance",
                                 nil];
        
        /*
         @property (strong, nonatomic) NSArray *surveyOptions;
         @property (strong, nonatomic) NSDate *surveyDateTaken;
         @property (strong, nonatomic) NSString *surveyDataFile;
         */
        

    }
    
    return self;
}

- (NSUInteger*)createUID {
    //stub
    
    return 0;
}


@end

