//
//  BingoViewController.h
//  bingo
//
//  Created by Joseph Baldwin on 3/16/13.
//  Copyright (c) 2013 Humboldt Technology Group, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BingoViewController : UIViewController
{
    NSMutableArray *BingoBalls;
    int ballCounter;
}

- (IBAction)GoButtonClick:(id)sender;
- (IBAction)ClearButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *BingoBallLabel;

@end
