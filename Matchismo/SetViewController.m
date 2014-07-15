//
//  SetViewController.m
//  Matchismo
//
//  Created by Andrei-Daniel Anton on 15/07/14.
//  Copyright (c) 2014 Andrei-Daniel Anton. All rights reserved.
//

#import "SetViewController.h"
#import "PlayingSetCardView.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetViewController ()
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(PlayingSetCardView) NSArray *playingSetCardView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation SetViewController

- (Deck *)deck
{
    if (!_deck) _deck = [[SetCardDeck alloc] init];
    return _deck;
}

- (Deck *)createDeak {
    return [[SetCardDeck alloc] init];
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.playingSetCardView count]
                                                  usingDeck:[self createDeak]];
    }
    return _game;
}


- (void)drawRandomPlayingCard:(NSUInteger) indexOfCard {
    Card *card = [self.deck drowRandomCard];
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        PlayingSetCardView *playingSetView = [self.playingSetCardView objectAtIndex:indexOfCard];
        playingSetView.rank = setCard.rank;
        playingSetView.symbol = setCard.symbol;
    }
}
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    int indexOfCard = [ self.playingSetCardView indexOfObject:[sender view]];
    PlayingSetCardView *playingSetView = [self.playingSetCardView objectAtIndex:indexOfCard];
    if (!playingSetView.faceUp) {
        [self drawRandomPlayingCard:indexOfCard];
    }
    playingSetView.faceUp = !playingSetView.faceUp;
    
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    int indexOfCard = [ self.playingSetCardView indexOfObject:[sender view]];
    [self.game chooseCardAtIndex:indexOfCard];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    [self updateUI];


}

- (void)updateUI {
    for (PlayingSetCardView *playingSetView in self.playingSetCardView){
        int cardIndex = [self.playingSetCardView indexOfObject:playingSetView];
        Card *card = [self.game cardAtIndex:cardIndex];
        if (card.isMatched) {
            playingSetView.alpha = 0.0;
            playingSetView.faceUp = NO;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.game.numberOfCards = 3;
    for (PlayingSetCardView *playingSetView in self.playingSetCardView){
        int indexOfCard = [ self.playingSetCardView indexOfObject:playingSetView];
        if (!playingSetView.faceUp) {
            [self drawRandomPlayingCard:indexOfCard];
        }
        playingSetView.faceUp = !playingSetView.faceUp;
        }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
