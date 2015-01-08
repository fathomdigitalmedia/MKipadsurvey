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
@property (strong, nonatomic) NSArray *englishOptionsQ0;
@property (strong, nonatomic) NSArray *englishOptionsQ1;
@property (strong, nonatomic) NSArray *spanishOptionsQ0;
@property (strong, nonatomic) NSArray *spanishOptionsQ1;
@property (strong, nonatomic) NSArray *spanishOptions;
@property (strong, nonatomic) NSArray *englishOptions;

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
        
        
        self.englishOptionsQ0 = [NSArray arrayWithObjects:
                                 @"I use my refund to pay off debt (e.g., student loands, credit card debt)",
                                 @"I spend my refund on something practical (e.g., utility bills, groceries, home repairs)",
                                 @"I splurge on something for myself",
                                 @"I splurge on something for my family/friends",
                                 @"I put my refund in savings",
                                 @"Other",
                                 @"I have never received a tax refund",
                                 nil];
        
        self.englishOptionsQ1 = [NSArray arrayWithObjects:
                                 @"A vacation for me and my family",
                                 @"A new electronic device (e.g., television, smartphone, computer, tablet)",
                                 @"A new outfit or accessory",
                                 @"A surprise gift for a family member or friend",
                                 @"A new car",
                                 @"Sports or concert tickets",
                                 @"Other",
                                 @"None",
                                 nil];
        
        self.spanishOptionsQ0 = [NSArray arrayWithObjects:
                                 @"ESP: I use my refund to pay off debt (e.g., student loands, credit card debt)",
                                 @"ESP: I spend my refund on something practical (e.g., utility bills, groceries, home repairs)",
                                 @"ESP: I splurge on something for myself",
                                 @"ESP: I splurge on something for my family/friends",
                                 @"ESP: I put my refund in savings",
                                 @"ESP: Other",
                                 @"ESP: I have never received a tax refund",
                                 nil];
        
        self.spanishOptionsQ1 = [NSArray arrayWithObjects:
                                 @"ESP: A vacation for me and my family",
                                 @"ESP: A new electronic device (e.g., television, smartphone, computer, tablet)",
                                 @"ESP: A new outfit or accessory",
                                 @"ESP: A surprise gift for a family member or friend",
                                 @"ESP: A new car",
                                 @"ESP: Sports or concert tickets",
                                 @"ESP: Other",
                                 @"ESP: None",
                                 nil];
        
        self.spanishOptions = [NSArray arrayWithObjects:
                               self.spanishOptionsQ0,
                               self.spanishOptionsQ1,
                               nil];

        self.englishOptions = [NSArray arrayWithObjects:
                               self.englishOptionsQ0,
                               self.englishOptionsQ1,
                               nil];
        
        
        self.surveyOptions = [NSArray arrayWithObjects:
                              self.spanishOptions,
                              self.englishOptions,
                              nil];
        

        self.surveyDateTaken = [self createSurveyDate];
        
        self.surveyDataFile = @"survey_data.csv";
        
    }
    
    return self;
}

- (NSString *)createUID {
    
    NSDate *now = [NSDate date];
    NSUInteger tmpUID = [now timeIntervalSince1970];
    NSString *uid = [NSString stringWithFormat:@"%d,", tmpUID];
    
    return uid;
}

- (NSString*)createSurveyDate {

    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yy.MM.dd HH:mm zzz"];
  
    return [NSString stringWithFormat:@"%@,", [dateFormatter stringFromDate:now]];
    
}


@end

