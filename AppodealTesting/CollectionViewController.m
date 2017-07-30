//
//  CollectionViewController.m
//  Lesson 5
//
//  Created by Mikhail Lutskiy on 02.03.14.
//  Copyright (c) 2014 Apple Journal. All rights reserved.
//

#import "CollectionViewController.h"
#import "GameShowViewController.h"
#import "igdbAPIConnection.h"
#import "Appodeal/Appodeal.h"
#import "GameCell.h"
#import "GameBriefData.h"

@interface CollectionViewController (){
    NSArray *gamesIndexes;
    NSDictionary* headers;
    NSMutableArray* arrGames;
    NSNumber* selectedID;
}

@end

@implementation CollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    
    igdbAPIConnection *newIGDBconnection=[[igdbAPIConnection alloc] init];
    gamesIndexes=[newIGDBconnection getGamesIndexes];
    arrGames=[newIGDBconnection getGamesInfo:gamesIndexes];

    
    [Appodeal setTestingEnabled: YES];
    [Appodeal setBannerDelegate:self];
    [Appodeal showAd:AppodealShowStyleBannerBottom rootViewController:self];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arrGames.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GameCell* currentCell= [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    GameBriefData* item = arrGames[row];
    currentCell.gameLabel.text = item.gameName;
    currentCell.gameImg.image = item.gameImg;
    currentCell.idLabel.text = [item.gameId stringValue];
    
    return currentCell;
 
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    GameCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle= NSNumberFormatterDecimalStyle;
    selectedID=[f numberFromString:cell.idLabel.text];
    GameShowViewController *transferController=segue.destinationViewController;
    transferController.gameId=selectedID;
}

@end
