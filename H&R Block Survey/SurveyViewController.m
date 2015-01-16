//
//  SurveyViewController.m
//  H&R Block Survey
//
//  Created by Patrick Shea on 1/5/15.
//  Copyright (c) 2015 MotionKick. All rights reserved.
//

#import "SurveyViewController.h"
#import "HRBlockSurvey.h"
#import "CSVData.h"

@interface SurveyViewController ()

@property (weak, nonatomic) IBOutlet UIView *surveyBG;
@property (weak, nonatomic) IBOutlet UIView *surveyView;
@property (weak, nonatomic) IBOutlet UILabel *questionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *surveyNextButton;
@property (strong, nonatomic) HRBlockSurvey *survey;
@property NSUInteger currentQuestion;
@property NSUInteger totalQuestions;
@property (strong, nonatomic) NSMutableArray *surveyButtons;
@property (strong, nonatomic) NSMutableString *dataString;
@property (strong, nonatomic) CSVData *csvWriter;

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.survey = [[HRBlockSurvey alloc] init];
    self.currentQuestion = 0;
    self.totalQuestions = [self.survey.surveyQuestions count];
    self.surveyButtons = [[NSMutableArray alloc] init];
    self.dataString = [[NSMutableString alloc] initWithString:self.survey.surveyDateTaken];
    [self.dataString appendString:self.survey.UID];
    
    NSString *langCode = [[NSString alloc] init];
    
    if (self.inEnglish) {
        langCode = @"EN,";
        [self.surveyNextButton setBackgroundImage:[UIImage imageNamed:@"survey_next.png"] forState:UIControlStateNormal];
        self.surveyNextButton.hidden = YES;
    } else {
        langCode = @"ES,";
        [self.surveyNextButton setBackgroundImage:[UIImage imageNamed:@"survey_next_ES.png"] forState:UIControlStateNormal];
            self.surveyNextButton.hidden = YES;
    }
    
    [self.dataString appendString:langCode];
    self.csvWriter = [[CSVData alloc] init];
        
    [self updateUI];
    
}

- (void)updateUI {
    
    [self updateQuestionLabels];
    [self updateQuestionOptions];
    self.surveyNextButton.hidden = YES;
    
    if (self.currentQuestion < self.totalQuestions) {
        [self performSelector:@selector(animateOn) withObject:nil afterDelay:.4];
    }
    
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
    
    self.questionNumberLabel.text = [NSString stringWithFormat:@"%@ %lu %@ %lu", questionString, self.currentQuestion + 1, ofString, (unsigned long)self.totalQuestions];
    self.questionLabel.text = self.survey.surveyQuestions[self.inEnglish][self.currentQuestion];
}

- (void)updateQuestionOptions {
    // if buttons exist, remove them from the view and the buttons array
    if ([self.surveyButtons count]) {
        for (UIButton *button in self.surveyButtons) {
            [button removeFromSuperview];
        }
        [self.surveyButtons removeAllObjects];
    }
    
    int buttonY = 170;
    int buttonHeight = 50;
    int surveyViewHeight = 475;
    int numberOfOptions = [self.survey.surveyOptions[self.inEnglish][self.currentQuestion] count];
    int buttonSpacing = (surveyViewHeight - ( numberOfOptions * buttonHeight ) ) / numberOfOptions;
    int index = 0;
    
    for (NSString *option in self.survey.surveyOptions[self.inEnglish][self.currentQuestion]) {
        // NSLog(@"option %d: %@", count, option);
        CGRect buttonFrame = CGRectMake( 41, buttonY, 650, buttonHeight );
        UIButton *button = [self makeOptionButton:option usingButtonStyle:self.currentQuestion];
        button.frame = buttonFrame;
        button.tag = index;
        [self.surveyButtons addObject:button];
        [self.surveyView addSubview:button];
        
        if (self.currentQuestion) { // style 2, question array [1]
            UILabel *buttonLetterLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, -2, 50, 50)];
            
            [buttonLetterLabel setTextColor:[UIColor whiteColor]];
            [buttonLetterLabel setFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:23.0]];
            
            unichar labelChar = 'A';
            labelChar += index;
            
            buttonLetterLabel.text = [NSString stringWithFormat:@"%C.", labelChar];
            [button addSubview:buttonLetterLabel];
        }
        
        buttonY = buttonY + buttonHeight + buttonSpacing;
        index++;
    }
    
}

- (IBAction)surveyNext:(UIButton *)sender {
    if (self.currentQuestion + 1 < self.totalQuestions) {
        self.currentQuestion++;
       
        // update self.dataString for Q1
        int index = 0;
        
        for (UIButton *button in self.surveyButtons) {
            if ( [button.currentImage isEqual:[UIImage imageNamed:@"survey_option_bg2.png"]] ) {
                [self.dataString appendString:[NSString stringWithFormat:@"%d|", index + 1]];
            }
            index++;
        }
        
        // remove trailing pipe character from end of selected options
        [self.dataString replaceCharactersInRange:NSMakeRange(self.dataString.length - 1, 1) withString:@","];
        
        // NSLog(@"dataString contents: %@", self.dataString);
        
        [self animateOff];
        
        [self performSelector:@selector(updateUI) withObject:nil afterDelay:.1];

        // [self updateUI];
        
    } else {
        // NSLog(@"last question");
        self.currentQuestion++;

        // update self.dataString for Q2
        int index = 0;
        unichar labelChar = 'A';
        
        for (UIButton *button in self.surveyButtons) {
            if ( [button.currentBackgroundImage isEqual:[UIImage imageNamed:@"survey_option_bg4.png"]] ) {
                labelChar += index;
                [self.dataString appendString:[NSString stringWithFormat:@"%C\n", labelChar]];
            }
            index++;
        }
 
        NSLog(@"dataString contents: %@", self.dataString);
        
        // write self.dataString to file
        [self.csvWriter updateCSV:self.survey.surveyDataFile withEntry:self.dataString];
        
        // jump to thank you screen
        
        [self animateOff];
        
    }
}

- (UIButton*)makeOptionButton:(NSString*)option usingButtonStyle:(NSUInteger)style {
    UIButton *button = [[UIButton alloc] init];

    [button setTitle:option forState: UIControlStateNormal];
    [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    button.titleLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Regular" size:20.0];
    
    // style variations:
    // buttonImage: style 0 has image, style 1 has rounded rect BG image
    
    if (style) {
        // style "1" here (question array index [1])
        UIImage *buttonImage = [UIImage imageNamed:@"survey_option_bg3.png"];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);

    } else {
        // style "2" here (question array index [0])
        UIImage *buttonImage = [UIImage imageNamed:@"survey_option_bg1.png"];
        [button setImage:buttonImage forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);

    }
    
    [button addTarget: self
               action: @selector(surveyButtonClicked:)
     forControlEvents: UIControlEventTouchUpInside];
    
    return button;
}

- (void)surveyButtonClicked:(UIButton*)sender {
    // NSLog(@"button state = %u", sender.state);
    
    int style = self.currentQuestion;
    
    // update to handle multiple button styles
    
    if (style) {
        // style "1" here (question array index [1])

        // swap BG images
        if ( [sender.currentBackgroundImage isEqual:[UIImage imageNamed:@"survey_option_bg3.png"]] ) {
            UIImage *buttonImage = [UIImage imageNamed:@"survey_option_bg4.png"];
            [sender setBackgroundImage:buttonImage forState:UIControlStateNormal];
            
            // reset all other buttons to deselected state -- this style allows only one option selection
            for (UIButton *button in self.surveyButtons) {
                if ( [button.currentBackgroundImage isEqual:[UIImage imageNamed:@"survey_option_bg4.png"]] && !([button isEqual:sender]) ) {
                    [button setBackgroundImage:[UIImage imageNamed:@"survey_option_bg3.png" ] forState:UIControlStateNormal];
                }
            }
            self.surveyNextButton.hidden = NO;
 
        } else {
            UIImage *buttonImage = [UIImage imageNamed:@"survey_option_bg3.png"];
            [sender setBackgroundImage:buttonImage forState:UIControlStateNormal];
            // sender.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            // sender.titleEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
            
            for (UIButton *button in self.surveyButtons) {
                if ( [button.currentBackgroundImage isEqual:[UIImage imageNamed:@"survey_option_bg4.png"]] ) {
                    self.surveyNextButton.hidden = NO;
                    break;
                } else {
                    self.surveyNextButton.hidden = YES;
                }
            }
        }

        
    } else {
        // style "2" here (question array index [0])
        if ( [sender.currentImage isEqual:[UIImage imageNamed:@"survey_option_bg1.png"]] ) {
            UIImage *buttonImage = [UIImage imageNamed:@"survey_option_bg2.png"];
            [sender setImage:buttonImage forState:UIControlStateNormal];
            sender.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            sender.titleEdgeInsets = UIEdgeInsetsMake(0, 21, 0, 0);
            self.surveyNextButton.hidden = NO;
        } else {
            UIImage *buttonImage = [UIImage imageNamed:@"survey_option_bg1.png"];
            [sender setImage:buttonImage forState:UIControlStateNormal];
            sender.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            sender.titleEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
            
            for (UIButton *button in self.surveyButtons) {
                if ( [button.currentImage isEqual:[UIImage imageNamed:@"survey_option_bg2.png"]] ) {
                    self.surveyNextButton.hidden = NO;
                    break;
                } else {
                    self.surveyNextButton.hidden = YES;
                }
            }
            
        }
    }
    
}

- (void)animateOn {
    // slide in survey view from right

    [UIView animateWithDuration:.25 animations:^{
    
        CGRect surveyViewFrame = self.surveyView.frame;
        surveyViewFrame.origin.x = 0;
        self.surveyView.frame = surveyViewFrame;
    
    }];
    

    

}

- (void)animateOff {
    // slide off survey view to left

    [UIView animateWithDuration:.3 animations:^{
        
        CGRect surveyViewFrame = self.surveyView.frame;
        surveyViewFrame.origin.x = -1000;
        self.surveyView.frame = surveyViewFrame;
        
    }
             completion:^(BOOL finished) {
                 
                 // after last question fade and animate to thank you segue
                 
                 if (self.currentQuestion + 1 > self.totalQuestions) {
                     [UIView animateWithDuration:.3 animations:^{
                         self.surveyBG.alpha = 0;
                     }
                                      completion:^(BOOL finished) {
                                          self.view.hidden = YES;
                                          [self performSelector:@selector(beginSegue) withObject:nil afterDelay:.3];
                                      }];
                 }
             }];
}

- (void)beginSegue {
    [self performSegueWithIdentifier:@"segueToThankYou" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SurveyViewController *destinationViewController = [segue destinationViewController];
    destinationViewController.inEnglish = self.inEnglish;
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
