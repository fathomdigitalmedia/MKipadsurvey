//
//  SurveyViewController.m
//  H&R Block Survey
//
//  Created by Patrick Shea on 1/5/15.
//  Copyright (c) 2015 MotionKick. All rights reserved.
//

#import "SurveyViewController.h"
// #import "Survey2ViewController.h"

@interface SurveyViewController ()
@property (weak, nonatomic) IBOutlet UIView *surveyBG;
@property (weak, nonatomic) IBOutlet UILabel *questionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"Survey language is English? %hhd", self.inEnglish);
    
    // init survey object (UID, question strings (en, sp), pretty date string, data file name, etc)
    
    
}

- (void)viewWillLayoutSubviews {

}

- (void)viewWillAppear:(BOOL)animated {

    
}

- (void)viewDidAppear:(BOOL)animated {

    // check that screen visual elements are visible and in the proper x,y positions (after segue unwind)
    

    // animate elements onscreen
    
    [self animateOnLoad];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the survey object to the new view controller.
    
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
