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
@property (weak, nonatomic) IBOutlet UIView *surveyView;
@property (weak, nonatomic) IBOutlet UILabel *questionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) HRBlockSurvey *survey;
@property NSUInteger currentQuestion;
@property NSUInteger totalQuestions;
@property (strong, nonatomic) NSMutableArray *surveyButtons;
@property (strong, nonatomic) NSMutableString *dataString;

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSLog(@"Survey language is English? %hhd", self.inEnglish);
    
    // init survey object (UID, question strings (en, sp), pretty date string, data file name, etc)
    
    self.survey = [[HRBlockSurvey alloc] init];
    
    self.currentQuestion = 0;
    self.totalQuestions = [self.survey.surveyQuestions count];
    self.surveyButtons = [[NSMutableArray alloc] init];
    self.dataString = [[NSMutableString alloc] initWithString:self.survey.surveyDateTaken];
    [self.dataString appendString:self.survey.UID];
        
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
        
        buttonY = buttonY + buttonHeight + buttonSpacing;
        index++;
    }
    
}

- (IBAction)surveyNext:(UIButton *)sender {
    if (self.currentQuestion + 1 < self.totalQuestions) {
        self.currentQuestion++;
        // update self.dataString
        
        int index = 0;
        
        for (UIButton *button in self.surveyButtons) {
            if ( [button.currentImage isEqual:[UIImage imageNamed:@"survey_option_bg2.png"]] ) { // add OR statement for style 2
                [self.dataString appendString:[NSString stringWithFormat:@"%d|", index + 1]];
            }
            index++;
        }
        
        // remove trailing pipe character from end of selected options
        [self.dataString replaceCharactersInRange:NSMakeRange(self.dataString.length - 1, 1) withString:@","];
        
        NSLog(@"dataString contents: %@", self.dataString);
       
        [self updateUI];
        
    } else {
        NSLog(@"last question");
        
        // write self.dataString to file
        // jump to thank you screen
    }
}

- (UIButton*)makeOptionButton:(NSString*)option usingButtonStyle:(NSUInteger)style {
    UIButton *button = [[UIButton alloc] init];

    // style changes:
    // buttonImage: style 0 has image, style 1 has no image (or has rounded rect bg image? TBD)

    if (style) {
        // style "1" here
        
    } else {
        // style "2" here
    }
    [button setTitle:option forState: UIControlStateNormal];
    [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Regular" size:20.0];
    UIImage *buttonImage = [UIImage imageNamed:@"survey_option_bg1.png"];
    [button setImage:buttonImage forState:UIControlStateNormal];

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
        // style "1" here
    } else {
        // style "2" here
        if ( [sender.currentImage isEqual:[UIImage imageNamed:@"survey_option_bg1.png"]] ) {
            UIImage *buttonImage = [UIImage imageNamed:@"survey_option_bg2.png"];
            [sender setImage:buttonImage forState:UIControlStateNormal];
            sender.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            sender.titleEdgeInsets = UIEdgeInsetsMake(0, 21, 0, 0);
        } else {
            UIImage *buttonImage = [UIImage imageNamed:@"survey_option_bg1.png"];
            [sender setImage:buttonImage forState:UIControlStateNormal];
            sender.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            sender.titleEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
        }
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
