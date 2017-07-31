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
#import "JMImageCache.h"
#import "FBNetworkReachability.h"

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
    
    FBNetworkReachabilityConnectionMode mode = [FBNetworkReachability sharedInstance].connectionMode;
    if (mode!=FBNetworkReachableNon)
    {
    
        igdbAPIConnection *newIGDBconnection=[[igdbAPIConnection alloc] init];
        gamesIndexes=[newIGDBconnection getGamesIndexes];
        arrGames=[newIGDBconnection getGamesInfo:gamesIndexes pageNumber:0];
// Класс не имплементирует этот протокол
        [Appodeal setBannerDelegate:self];
// Можно было добавить оффсет на вьюшку с коллекцией, чтобы баннер не перекрывал
// контент
        [Appodeal showAd:AppodealShowStyleBannerBottom rootViewController:self];
        
        
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Network problems! Connect to the internet, please!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arrGames.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GameCell* currentCell= [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    GameBriefData* item = arrGames[row];
    currentCell.gameLabel.text = item.gameName;

//Небезопастный вызов - возможна утечка памяти
    [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:item.gameImgUrl] completionBlock:^(UIImage *downloadedImage) {
        currentCell.gameImg.image = downloadedImage;
    }];
  
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
//Небезопастный каст к классу
    GameCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle= NSNumberFormatterDecimalStyle;
    selectedID=[f numberFromString:cell.idLabel.text];
    GameShowViewController *transferController=segue.destinationViewController;
    transferController.gameId=selectedID;
}

@end
