//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Andrei-Daniel Anton on 08/07/14.
//  Copyright (c) 2014 Andrei-Daniel Anton. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end


@implementation CardMatchingGame

- (NSUInteger)numberOfCards {
    if (!_numberOfCards) {
        _numberOfCards = 2;
    }
    return _numberOfCards;
}

- (void)setNewScore:(NSInteger)newScore {
    self.score = 0;
}

-(void)unchooseCards {
    for(Card *otherCard in self.cards) {
        otherCard.matched = NO;
        otherCard.chosen = NO;
    }
}

-(NSMutableArray *)cards {
    if(!_cards){
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
{
    self = [super init];
    if(self){
        for(int i = 0; i<count; i++){
            Card *card = [deck drowRandomCard];
            if(card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return index < [self.cards count] ? self.cards[index] : nil;
}

static const int MISMATCH_PENALITY=2;
static const int MATCH_BONUS=4;
static const int COST_TO_CHOOSE=1;

// Too large, should refactor
-(void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = self.cards[index];
    self.rezult = [NSString stringWithFormat:@"%@",card.contents];
    NSString *otherCardsContets = @"";
    
    if(!card.isMatched){
        if(card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *otherCards=[[NSMutableArray alloc]init];
            
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    [otherCards addObject:otherCard];
                }
            }
            
            // The following code should be included into another method
            if([otherCards count] == self.numberOfCards-1) {
                int matchScore = [card match:otherCards];
                if(matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    
                    for(Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                        otherCardsContets = [otherCardsContets stringByAppendingString:otherCard.contents];
                    }
                    card.matched = YES;
                    self.rezult=[NSString stringWithFormat:@"Matched %@ %@ for score: %d", self.rezult, otherCardsContets, matchScore * MATCH_BONUS];
                } else {
                    self.score -= MISMATCH_PENALITY;
                    for(Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                    self.rezult = [NSString stringWithFormat:@" %@ %@ don’t match! %d point penalty!", self.rezult, otherCardsContets, MISMATCH_PENALITY];
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
