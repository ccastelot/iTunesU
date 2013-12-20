//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Chris Castelot on 12/18/13.
//  Copyright (c) 2013 Chris Castelot. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@end

@implementation CardGameViewController

-(void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"FlipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if([sender.currentTitle length]){
        [sender setBackgroundImage:[UIImage imageNamed:@"backImage"]
                          forState:UIControlStateNormal];
        [sender setTitle:@""
                forState:UIControlStateNormal];
    } else{
        [sender setBackgroundImage:[UIImage imageNamed:@"frontImage"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"A♣︎"
                forState:UIControlStateNormal];
    }
    self.flipCount++;
}

@end
