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

@property (nonatomic, strong) NSMutableArray *chosenCards;    //of cards to be matched (subset of cards)

@property (nonatomic, strong, readwrite) NSMutableString *matchResults;

@end

@implementation CardMatchingGame

static const int SET_MATCH_BONUS = 5;
static const int SET_MATCH_PENALTY = 2;
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(NSMutableArray *)cards{
    if(!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(NSMutableArray *)chosenCards{
    if(!_chosenCards){
        _chosenCards = [[NSMutableArray alloc] init];
    }
    return _chosenCards;
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
    _matchResults = [NSMutableString string];
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil ;
}

-(void)resetCardsToMatch:(BOOL)reset{
    if (reset) {
        for (Card *c  in self.chosenCards) {
            for (Card *cards in self.cards) {
                if([c.contents isEqualToString:cards.contents])
                    cards.eliminated = TRUE;
            }
        }
        _chosenCards = nil;
    }
    
}
-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    NSMutableString *rsp = [NSMutableString string];
    [rsp appendString:[NSString stringWithFormat:@"Card Chosen: %@\n", card.contents]];
    NSLog(@"Card Chosen: %@", card.contents);
    int hitCount = 0;
    int chosenCount = 0;
    for(Card *otherCard in self.chosenCards){
        chosenCount++;
        if(![card.contents isEqualToString:otherCard.contents]){
            [rsp appendString:[NSString stringWithFormat:@"Card To Match: %@\n", otherCard.contents]];
            int matchScore = [card match:@[otherCard]];
            if(matchScore){
                [rsp appendString:[NSString stringWithFormat:@"MATCH_BONUS - Current Score: %d\tAdding: %d\n", self.score, matchScore * MATCH_BONUS]];
                NSLog(@"BEFORE MATCH_BONUS - Current Score: %d", self.score);
                self.score += matchScore * MATCH_BONUS;
                NSLog(@"AFTER MATCH_BONUS - New Score: %d", self.score);
                otherCard.matched=YES;
                card.matched=YES;
                hitCount++;
            } else {
                [rsp appendString:[NSString stringWithFormat:@"MISMATCH_PENALTY - Current Score: %d\tSubtracting: %d\n", self.score, MISMATCH_PENALTY]];
                NSLog(@"BEFORE MISMATCH_PENALTY - Current Score: %d", self.score);
                self.score -= MISMATCH_PENALTY;
                NSLog(@"AFTER MISMATCH_PENALTY - Current Score: %d", self.score);
            }
        }
    }
    if(self.matchMode == MatchThree){
        if(chosenCount == 2){
            if(hitCount == 2) {
                [rsp appendString:[NSString stringWithFormat:@"SET_MATCH_BONUS - Current Score: %d\tMultipling Score By: %d\n", self.score, SET_MATCH_BONUS]];
                NSLog(@"SET_MATCH_BONUS - Current Score: %d", self.score);
                self.score *= SET_MATCH_BONUS;
                NSLog(@"SET_MATCH_BONUS - Current Score: %d", self.score);
            }
            else {
                [rsp appendString:[NSString stringWithFormat:@"SET_MATCH_PENALTY - Current Score: %d\tReducing Score By: %d\n", self.score, SET_MATCH_PENALTY]];
                NSLog(@"SET_MATCH_PENALTY - Current Score: %d", self.score);
                self.score -= SET_MATCH_PENALTY ;
                NSLog(@"SET_MATCH_PENALTY - Current Score: %d", self.score);
            }
        }
    }
    if (chosenCount > 0) {
        [rsp appendString:[NSString stringWithFormat:@"COST_TO_CHOOSE - Current Score: %d\tReducing Score By: %d\n", self.score, COST_TO_CHOOSE]];
        NSLog(@"@BEFORE COST_TO_CHOOSE- Current Score: %d", self.score);
        self.score -= COST_TO_CHOOSE;
        NSLog(@"@AFTER COST_TO_CHOOSE - Current Score: %d", self.score);
    }
    [self.chosenCards addObject:card];
    card.chosen=YES;
    [self.matchResults appendString:rsp];
}

//-(void)chooseCardAtIndex:(NSUInteger)index{
//    Card *card = [self cardAtIndex:index];
//    NSLog(@"@Card Chosen: %@", card.contents);
//    BOOL applyPenalty = FALSE;
//    if(!card.isMatched && !card.isEliminated){
//        //match against other chosen cards
//        for(Card *otherCard in self.cards){
//            if(![card.contents isEqualToString:otherCard.contents]){
//                if(otherCard.isChosen && !otherCard.isMatched){
//                    int matchScore = [card match:@[otherCard]];
//                    if(matchScore){
//                        NSLog(@"@BEFORE MATCH_BONUS - Current Score: %d", self.score);
//                        self.score += matchScore * MATCH_BONUS;
//                        NSLog(@"@AFTER MATCH_BONUS - New Score: %d", self.score);
//                        otherCard.matched=YES;
//                        card.matched=YES;
//                    } else {
//                        NSLog(@"@BEFORE MISMATCH_PENALTY - Current Score: %d", self.score);
//                        self.score -= MISMATCH_PENALTY;
//                        NSLog(@"@AFTER MISMATCH_PENALTY - Current Score: %d", self.score);
//                        //otherCard.chosen = NO;
//                    }
//                }
//            }
//            if(!applyPenalty && otherCard.hasBeenPlayed){
//                applyPenalty = TRUE;
//            }
//    
//        }
//        if(applyPenalty){
//            NSLog(@"@BEFORE COST_TO_CHOOSE- Current Score: %d", self.score);
//            self.score -= COST_TO_CHOOSE;
//            NSLog(@"@AFTER COST_TO_CHOOSE - Current Score: %d", self.score);
//            
//        }
//        card.chosen=YES;
//        card.played = TRUE;
//    }
//}


-(void)setMatchMode:(cardMatchMode)mode{
    _matchMode = mode;
}

@end
