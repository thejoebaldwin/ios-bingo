//
//  BingoViewController.m
//  bingo
//
//  Created by Joseph Baldwin on 3/16/13.
//  Copyright (c) 2013 Humboldt Technology Group, LLC. All rights reserved.
//

#import "BingoViewController.h"

@interface BingoViewController ()

@end

@implementation BingoViewController

@synthesize BingoBallLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        BingoBalls = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)GoButtonClick:(id)sender {

    if (ballCounter < 75)
    {
    
    bool isNewNumber = false;
    int NewBingoBall = 0;
    
    
    
    while (!isNewNumber)
    {
        NewBingoBall = (rand() % 75) + 1;
        NSLog(@"Testing New Number: %i", NewBingoBall);
        NSNumber *newNumber =   [[NSNumber alloc] initWithInt:NewBingoBall];
        bool contains = false;

        for (int i = 0; i < [BingoBalls count]; i++)
        {
            NSNumber *tempValue = [BingoBalls objectAtIndex:i];
            if ([tempValue intValue] == [newNumber intValue])
            {
                contains = true;
                break;
            }
        }
        if (contains == false)
        {
         isNewNumber = true;
         [BingoBalls addObject:newNumber];
         UILabel *label = (UILabel *)[[self view] viewWithTag:NewBingoBall];
                   
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
            label.textColor = [UIColor blackColor];
         NSLog(@"Number is New");
            ballCounter++;
        }
        else
        {
            NSLog(@"Number Exists");
        }
    }
    

    NSString *letter;
    switch (NewBingoBall)
    {
        case 1 ... 15:
            letter =  [[NSString alloc] initWithFormat:@"B%i", NewBingoBall ];
            break;
        case 16 ... 30:
            letter =  [[NSString alloc] initWithFormat:@"I%i", NewBingoBall ];
            break;
        case 31 ... 45:
            letter =  [[NSString alloc] initWithFormat:@"N%i", NewBingoBall ];
            break;
        case 46 ... 60:
            letter =  [[NSString alloc] initWithFormat:@"N%i", NewBingoBall ];
            break;
        case 61 ... 75:
            letter =  [[NSString alloc] initWithFormat:@"O%i", NewBingoBall ];
            break;
        
        
     
    }
        
               [BingoBallLabel setText:letter];
    
    }
    
}

- (IBAction)ClearButtonClick:(id)sender {
    
    
    ballCounter = 0;
    
    for (int i = 1; i <= 75; i++)
    {
        UILabel *label = (UILabel *)[[self view] viewWithTag:i];
        
        label.font = [UIFont fontWithName:@"Helvetica" size:17];
        label.textColor = [UIColor grayColor];

        
        
    }
    
    
}
@end
