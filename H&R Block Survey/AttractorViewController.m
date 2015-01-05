//
//  AttractorViewController.m
//  H&R Block Survey
//
//  Created by Patrick Shea on 1/5/15.
//  Copyright (c) 2015 MotionKick. All rights reserved.
//

#import "AttractorViewController.h"

@interface AttractorViewController ()

@end

@implementation AttractorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)languageButtonPressed:(UIButton *)sender {
    if (sender.tag == 0) {
        NSLog(@"Language is Spanish");
    } else if (sender.tag == 1){
        NSLog(@"Language is English");
    } else {
        NSLog(@"Language selection ERROR!");
    }
    
    [self performSelector:@selector(beginSegue:) withObject:sender afterDelay:1.5];

}

-(void)beginSegue:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueToSurvey1" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
