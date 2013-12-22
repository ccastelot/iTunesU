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
@property (strong, nonatomic) Deck *deck;
@end

@implementation CardGameViewController

-(Deck *)deck{
    if (!_deck) {
        _deck = [self createDeck];
    }
    return _deck;
}
    

-(Deck *)createDeck {
    return [[PlayingCardDeck alloc]init];
}


-(void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"FlipCount: %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if([sender.currentTitle length]){
        [sender setBackgroundImage:[UIImage imageNamed:@"backImage"]
                          forState:UIControlStateNormal];
        [sender setTitle:@""
                forState:UIControlStateNormal];
    } else{
        Card *card = [[self deck] drawRandomCard];
        if(card){
            [sender setBackgroundImage:[UIImage imageNamed:@"frontImage"]
                              forState:UIControlStateNormal];
            [sender setTitle:card.contents
                    forState:UIControlStateNormal];
        }
        else{
            self.flipsLabel.text = [NSString stringWithFormat:@"No More Cards to Flip: %d", self.flipCount];
        }
        
    }
    NSLog(@"\tCards Remain in Deck: %d", self.deck.cards.count);
    if(self.deck.cards.count)
        self.flipCount++;
}

@end
