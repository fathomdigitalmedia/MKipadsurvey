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
        
    [self updateUI];
    
}

- (void) updateUI {
    [self updateQuestionLabels];
    [self updateQuestionOptions];
}

- (void)updateQuestionLabels {
    
    NSString *questionString = @"";
    NSString *ofString = @"";
    
    if (self.inEnglish) {
        questionString = @"QUESTION";
        ofString = @"OF";
    } else {
        questionString = @"PREGUNTA";
        ofString = @"DE";
    }
    
    self.questionNumberLabel.text = [NSString stringWithFormat:@"%@ %d %@ %d", questionString, self.currentQuestion + 1, ofString, self.totalQuestions];
    self.questionLabel.text = self.survey.surveyQuestions[self.inEnglish][self.currentQuestion];
}

- (void)updateQuestionOptions {
    int count = 1;
    
    for (NSString *option in self.survey.surveyOptions[self.inEnglish][self.currentQuestion]) {
        NSLog(@"option %d: %@", count, option);
        count++;
    }
    
}

- (IBAction)surveyNext:(UIButton *)sender {
    if (self.currentQuestion + 1 < self.totalQuestions) {
        self.currentQuestion++;
        [self updateUI];
    } else {
        NSLog(@"last question");
        // write data to file
        // jump to thank you screen
    }
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
