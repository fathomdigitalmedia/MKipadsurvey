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

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
        self.UID = [self createUID];
        
        self.englishQuestions = [NSArray arrayWithObjects:
                                 @"When you receive a tax refund, what do you typically spend it on? Please select all that apply.",
                                 @"What \"fun\" thing would you like to spend your tax refund on?",
                                 nil];
        
        self.spanishQuestions = [NSArray arrayWithObjects:
                                 @"¿Cómo te gastas típicamente tu reembolso de taxes? Selecciona todas la opciones que apliquen.",
                                 @"¿Si decidieras comprarte algo \"divertido\" con tu reembolso, ¿qué comprarías?",
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
                                 @"Pagando deudas (balances de tarjetas de crédito, préstamos\nestudiantiles, etc.)",
                                 @"En algo práctico (facturas de servicios públicos, comestibles, etc.)",
                                 @"En algo especial para mí",
                                 @"En algo especial para mi familia/mis amigos",
                                 @"Ahorros",
                                 @"En otra cosa",
                                 @"Nunca he recibido un reembolso",
                                 nil];
        
        self.spanishOptionsQ1 = [NSArray arrayWithObjects:
                                 @"Unas vacaciones",
                                 @"Un dispositivo electrónico",
                                 @"Ropa o accesorios",
                                 @"Un regalo sorpresa para algún familiar/amigo",
                                 @"Un auto",
                                 @"Boletos para un evento deportivo o un concierto",
                                 @"Otra cosa",
                                 @"Nada",
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
    NSString *uid = [NSString stringWithFormat:@"%lu,", (unsigned long)tmpUID];
    
    return uid;
}

- (NSString*)createSurveyDate {

    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yy.MM.dd HH:mm zzz"];
  
    return [NSString stringWithFormat:@"%@,", [dateFormatter stringFromDate:now]];
    
}


@end

