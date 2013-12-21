//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Chris Castelot on 12/18/13.
//  Copyright (c) 2013 Chris Castelot. All rights reserved.
//

#import "CardGameViewController.h"
#import "Card.h"
#import "Deck.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h" 

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *cardDeck;
@end

@implementation CardGameViewController

-(void)setCardDeck:(Deck *)cardDeck{
    if (!cardDeck) {
        _cardDeck = [[PlayingCardDeck alloc]init];
        NSLog(@"Card Count: %d", [self.cardDeck.cards count]);
    }
    
}

-(void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"FlipCount: %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.flipCount++;
    if(!_cardDeck){
        [self setCardDeck:_cardDeck];
    }
    if ([self.cardDeck.cards count] > 0){
        if([sender.currentTitle length]){
            [sender setBackgroundImage:[UIImage imageNamed:@"backImage"]
                              forState:UIControlStateNormal];
            [sender setTitle:@""
                    forState:UIControlStateNormal];
        } else{
            Card *card = [[self cardDeck] drawRandomCard];
            [sender setBackgroundImage:[UIImage imageNamed:@"frontImage"]
                              forState:UIControlStateNormal];
            [sender setTitle:card.contents
                    forState:UIControlStateNormal];
        }
        NSLog(@"\tCards Remain in Deck: %d", [self.cardDeck.cards count]);
    }
    else{
        self.flipsLabel.text = [NSString stringWithFormat:@"No More Cards to Flip: %d", self.flipCount];
    }
}

@end
