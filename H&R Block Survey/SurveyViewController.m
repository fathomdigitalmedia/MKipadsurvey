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

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"Survey language is English? %hhd", self.inEnglish);
    
    // init survey object (UID, question strings (en, sp), pretty date string, data file name, etc)
    // animate survey view elements on screen
    
    [self animateOnLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    // add code to check that screen visual elements are visible and in the proper x,y positions (after segue unwind)

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the survey object to the new view controller.
    
}

- (void)animateOnLoad {
    NSLog(@"animateOnLoad survey x = %f", self.surveyBG.frame.origin.x);
    
    [UIView animateWithDuration:5 animations:^{
        NSLog(@"animateOnLoad animation block");
        CGRect surveyBGFrame = self.surveyBG.frame;
        surveyBGFrame.origin.x = 0;
        self.surveyBG.frame = surveyBGFrame;
        self.surveyBG.alpha = 0;
    }];
}


@end
