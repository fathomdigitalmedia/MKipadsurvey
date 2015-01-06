//
//  SurveyViewController.m
//  H&R Block Survey
//
//  Created by Patrick Shea on 1/5/15.
//  Copyright (c) 2015 MotionKick. All rights reserved.
//

#import "SurveyViewController.h"
#import "HRBlockSurvey.h"

@interface SurveyViewController ()

@property (weak, nonatomic) IBOutlet UIView *surveyBG;
@property (weak, nonatomic) IBOutlet UILabel *questionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) HRBlockSurvey *survey;
@property NSUInteger currentQuestion;
@property NSUInteger totalQuestions;

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"Survey language is English? %hhd", self.inEnglish);
    
    // init survey object (UID, question strings (en, sp), pretty date string, data file name, etc)
    
    self.survey = [[HRBlockSurvey alloc] init];
    
    self.currentQuestion = 0;
    self.totalQuestions = [self.survey.surveyQuestions count];
        
    [self updateQuestionLabels];
    
}

- (void)updateQuestionLabels {
    self.questionNumberLabel.text = [NSString stringWithFormat:@"QUESTION %d OF %d", self.currentQuestion + 1, self.totalQuestions];
    self.questionLabel.text = self.survey.surveyQuestions[self.inEnglish][self.currentQuestion];
}


- (void)viewDidAppear:(BOOL)animated {

    // check that screen visual elements are visible and in the proper x,y positions (after segue unwind)
    // [ where best to do this? ]d
    

    // animate elements onscreen
    
    [self animateOnLoad];

}

- (void)animateOnLoad {
    // slide in green background from right
    
    [UIView animateWithDuration:.25 animations:^{
        CGRect surveyBGFrame = self.surveyBG.frame;
        surveyBGFrame.origin.x = 0;
        self.surveyBG.frame = surveyBGFrame;
        // self.surveyBG.alpha = 1;

    }completion:^(BOOL finished) {
        // slide in survey question and options from left
    
        
    }];
    

}


@end
