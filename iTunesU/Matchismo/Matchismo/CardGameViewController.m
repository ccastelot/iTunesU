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

@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegmentsOutlet;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) UISegmentedControl *modeSegments;
@property (weak, nonatomic) IBOutlet UITextView *textViewMatchResults;
@property (nonatomic) NSInteger playCount;
@end

@implementation CardGameViewController

-(CardMatchingGame *)game{
    if(!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (IBAction)playModeSegment:(UISegmentedControl *)sender {
    _modeSegments = sender;
    self.game.matchMode = self.modeSegments.selectedSegmentIndex;
}

-(UISegmentedControl *)modeSegments{
    if(!_modeSegments){
        self.modeSegments = self.modeSegmentsOutlet;
    }
    return _modeSegments;
}



-(Deck *)createDeck {
    return [[PlayingCardDeck alloc]init];
}
- (IBAction)resetCardButton:(UIButton *)sender {
    [self resetUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSLog(@"Playing Mode: %@", self.game.matchMode == MatchThree ? @"Play 3" : @"Play 2");
    self.playCount++;
    self.modeSegmentsOutlet.userInteractionEnabled=NO;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void)updateUI{
    if (self.game.matchMode == MatchTwo) {
        [self.game resetCardsToMatch:self.playCount % 2 == 0];
    }
    if (self.game.matchMode == MatchThree) {
        [self.game resetCardsToMatch:self.playCount % 3 == 0];
    }    
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self setBackgroundImageForCard:card] forState:UIControlStateNormal];
        if(card.isMatched || card.isEliminated ){
            cardButton.enabled = FALSE;
        }
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.textViewMatchResults.text = self.game.matchResults;
        [self.textViewMatchResults scrollRangeToVisible:NSMakeRange([self.textViewMatchResults.text length], 0)];
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
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.game.matchMode = self.modeSegments.selectedSegmentIndex;
    self.modeSegmentsOutlet.userInteractionEnabled=TRUE;
    self.playCount = 0;
    self.textViewMatchResults.text=@"";
}
@end
