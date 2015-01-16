//
//  ThankYouViewController.m
//  H&R Block Survey
//
//  Created by Patrick Shea on 1/14/15.
//  Copyright (c) 2015 MotionKick. All rights reserved.
//

#import "ThankYouViewController.h"

@interface ThankYouViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UIImageView *title2Image;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) NSTimer *timeoutTimer;

@end

@implementation ThankYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.inEnglish) {
        [self.titleImage setImage:[UIImage imageNamed:@"thanks_title.png"]];
        [self.title2Image setImage:[UIImage imageNamed:@"thanks_title2.png"]];
    } else {
        [self.titleImage setImage:[UIImage imageNamed:@"thanks_title_ES.png"]];
        [self.title2Image setImage:[UIImage imageNamed:@"thanks_title2_ES.png"]];
    }
    
    [self startTimer];

}

- (void)viewWillDisappear:(BOOL)animated {
    [self stopTimer];
}

- (void)startTimer {
    if (self.timeoutTimer == nil) {
        self.timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(animateOff) userInfo:nil repeats:NO];
        // NSLog(@"TY TIMER STARTED");
    } else {
        NSLog(@"DUPLICATE TIMERS!");
    }
}

- (void)stopTimer {
    if (self.timeoutTimer) {
        [self.timeoutTimer invalidate];
        self.timeoutTimer = nil;
    }
    // NSLog(@"TY TIMER STOPPED");
}

- (void)animateOff {
    [UIView animateWithDuration:.5 animations:^{
        CGRect titleFrame = self.titleImage.frame;
        CGRect title2Frame = self.title2Image.frame;
        CGRect logoFrame = self.logoImage.frame;
        CGRect bgFrame = self.backgroundImage.frame;
        titleFrame.origin.y -= 1000;
        title2Frame.origin.y -= 1000;
        logoFrame.origin.y += 1000;
        bgFrame.origin.y +=1000;
        self.titleImage.frame = titleFrame;
        self.title2Image.frame = title2Frame;
        self.logoImage.frame = logoFrame;
        self.backgroundImage.frame = bgFrame;
        self.titleImage.alpha = 0;
        self.backgroundImage.alpha = 0;
        self.logoImage.alpha = 0;
    } completion:^(BOOL finished) {
        [self unwindToAttractor];
    }];
    
}

- (void)unwindToAttractor {
    // NSLog(@"exiting to attractor view");
    
    [self performSegueWithIdentifier:@"unwindToStart" sender:self];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
