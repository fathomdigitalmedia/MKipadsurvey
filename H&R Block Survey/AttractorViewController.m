//
//  AttractorViewController.m
//  H&R Block Survey
//
//  Created by Patrick Shea on 1/5/15.
//  Copyright (c) 2015 MotionKick. All rights reserved.
//

#import "AttractorViewController.h"
#import "SurveyViewController.h"

@interface AttractorViewController ()
@property BOOL inEnglish;
@property (weak, nonatomic) IBOutlet UIButton *spanishButton;
@property (weak, nonatomic) IBOutlet UIButton *englishButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UIImageView *chooseLanguageImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;


@end

@implementation AttractorViewController

- (void)viewWillAppear:(BOOL)animated {
    // add code to check that attract screen visual elements are visible and in the proper x,y positions (after segue unwind)
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)languageButtonPressed:(UIButton *)sender {
    
    if (sender.tag == 0) {
        // NSLog(@"Language chosen: Spanish");
        self.inEnglish = NO;
    } else if (sender.tag == 1){
        // NSLog(@"Language chosen: English");
        self.InEnglish = YES;
    } else {
        NSLog(@"Language chosen: error");
    }

    [self animatedHomeTransition:sender];

    [self performSelector:@selector(beginSegue:) withObject:sender afterDelay:.6];

}

- (void)animatedHomeTransition:(UIButton *)sender {
    
    if (sender.tag) {                                   // if chosen language is english
        [UIView animateWithDuration:.25 animations:^{
            self.spanishButton.alpha = 0;
            self.chooseLanguageImage.alpha = 0;
        }];
        
        [UIView animateWithDuration:.55 animations:^{
            self.englishButton.alpha = 0;
        }];
        
    } else {                                            // if chosen language is spanish
        [UIView animateWithDuration:.25 animations:^{
            self.englishButton.alpha = 0;
            self.chooseLanguageImage.alpha = 0;
        }];
        
        [UIView animateWithDuration:.55 animations:^{
            self.spanishButton.alpha = 0;
        }];
    }
    
    [UIView animateWithDuration:.5 animations:^{
        CGRect titleFrame = self.titleImage.frame;
        CGRect logoFrame = self.logoImage.frame;
        CGRect bgFrame = self.backgroundImage.frame;
        titleFrame.origin.y -= 1000;
        logoFrame.origin.y += 1000;
        bgFrame.origin.y +=1000;
        self.titleImage.frame = titleFrame;
        self.logoImage.frame = logoFrame;
        self.backgroundImage.frame = bgFrame;
        self.titleImage.alpha = 0;
        self.backgroundImage.alpha = 0;
        self.logoImage.alpha = 0;
    }];
}

- (void)beginSegue:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueToSurvey1" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SurveyViewController *destinationViewController = [segue destinationViewController];
    destinationViewController.inEnglish = self.inEnglish;
    
}

@end
