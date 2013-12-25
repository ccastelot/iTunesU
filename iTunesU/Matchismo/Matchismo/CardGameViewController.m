//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Chris Castelot on 12/18/13.
//  Copyright (c) 2013 Chris Castelot. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

-(CardMatchingGame *)game{
    if(!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

-(Deck *)createDeck {
    return [[PlayingCardDeck alloc]init];
}
- (IBAction)resetCardButton:(UIButton *)sender {
    [self resetUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {

    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void)updateUI{
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self setBackgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}
-(NSString *)titleForCard:(Card *)card{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)setBackgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen  ? @"cardFront" : @"cardBack"];
}
-(void)resetUI{
    _game = nil;
    [self game];
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self setBackgroundImageForCard:card] forState:UIControlStateNormal];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        cardButton.enabled = !card.isMatched;
    }
}
@end
