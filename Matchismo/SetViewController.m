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

@interface SetViewController ()
@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet PlayingSetCardView *playingSetView;
@end

@implementation SetViewController

- (Deck *)deck
{
    if (!_deck) _deck = [[SetCardDeck alloc] init];
    return _deck;
}

- (void)drawRandomPlayingCard
{
    Card *card = [self.deck drowRandomCard];
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        self.playingSetView.rank = setCard.rank;
        self.playingSetView.symbol = setCard.symbol;
    }
}
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    if (!self.playingSetView.faceUp) [self drawRandomPlayingCard];
    self.playingSetView.faceUp = !self.playingSetView.faceUp;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
