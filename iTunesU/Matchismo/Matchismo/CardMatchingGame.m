//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Chris Castelot on 12/22/13.
//  Copyright (c) 2013 Chris Castelot. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;

@property (nonatomic, strong) NSMutableArray *cards;    //of cards


@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(NSMutableArray *)cards{
    if(!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck{
    
    self = [super init];
    if(self){
        for(int i=0; i<count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            } else{
                self =nil;
                break;
            }
        }
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil ;
}

-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    NSLog(@"@Card Chosen: %@", card.contents);
    BOOL applyPenalty = FALSE;
    if(!card.isMatched){
        //match against other chosen cards
        for(Card *otherCard in self.cards){
            if(![card.contents isEqualToString:otherCard.contents]){
                if(otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        NSLog(@"@BEFORE MATCH_BONUS - Current Score: %d", self.score);
                        self.score += matchScore * MATCH_BONUS;
                        NSLog(@"@AFTER MATCH_BONUS - New Score: %d", self.score);
                        otherCard.matched=YES;
                        card.matched=YES;
                    } else {
                        NSLog(@"@BEFORE MISMATCH_PENALTY - Current Score: %d", self.score);
                        self.score -= MISMATCH_PENALTY;
                        NSLog(@"@AFTER MISMATCH_PENALTY - Current Score: %d", self.score);
                        otherCard.chosen = NO;
                    }
                }
            }
            if(!applyPenalty && otherCard.hasBeenPlayed){
                applyPenalty = TRUE;
            }
    
        }
        if(applyPenalty){
            NSLog(@"@BEFORE COST_TO_CHOOSE- Current Score: %d", self.score);
            self.score -= COST_TO_CHOOSE;
            NSLog(@"@AFTER COST_TO_CHOOSE - Current Score: %d", self.score);
            
        }
        card.chosen=YES;
        card.played = TRUE;

    }
}

@end
