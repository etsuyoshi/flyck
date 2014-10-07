//
//  ViewController.m
//  flyck
//
//  Created by EndoTsuyoshi on 2014/10/04.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//

#import "ViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define LENGTH_MAX_IMAGE 50

@import Photos;

@interface ViewController (){
    
}

@end


//一度likeした写真はそのままにする

@implementation ViewController{
    MDCSwipeToChooseViewOptions *options;
    
    
    UIImageView *imageView;
    UILabel *label_property;
    UILabel *label_operation;
    
//    NSMutableArray *arrImage;
    NSMutableArray *arrAllAssets;//
//    NSMutableArray *arrAssetsOnDisplay;//画面上に表示されているアセット(フリックしたら消去)
    
    UIButton *btnTrash;
    
    BOOL isFirstDisplay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBannerAd];
    
    // Do any additional setup after loading the view, typically from a nib.
    [SVProgressHUD showWithStatus:@"写真取得中..."];
    self.title = @"flyck";
    
    isFirstDisplay = false;
    
//    arrImage = [NSMutableArray array];
    arrAllAssets = [NSMutableArray array];
    
    label_operation = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,70)];
    label_operation.center =
    CGPointMake(self.view.bounds.size.width/2,
                label_operation.bounds.size.height);
//                self.view.bounds.size.height-label_operation.bounds.size.height);
    label_operation.textAlignment = NSTextAlignmentCenter;
    [label_operation setText:@"move left to trash or right to save"];
    [label_operation setTextColor:[UIColor blackColor]];
    [self.view addSubview: label_operation];
    
    
    
    label_property = [[UILabel alloc]init];
    label_property.frame = CGRectMake(0, 0, self.view.bounds.size.width,
                                      50);
    label_property.center =
    CGPointMake(self.view.bounds.size.width/2,
                self.view.bounds.size.height-label_property.bounds.size.height*3/2);
    [label_property setTextAlignment:NSTextAlignmentCenter];
    [label_property setTextColor: [UIColor blackColor]];
    label_property.font = [UIFont systemFontOfSize:20];
    [label_property setText:@"property"];
    [self.view addSubview:label_property];
    
}


-(void)initBannerAd{
    
    
    NSLog(@"initBannerAd");
    int heightBanner = 50;
    //バナーViewの初期化とサイズ、位置の設定
    BannerAd = [[NADView alloc]
                initWithFrame:
                CGRectMake(0,self.view.bounds.size.height-heightBanner,
                           self.view.bounds.size.width,heightBanner)];
    
    NSLog(@"bannerad = %@", BannerAd);
    
    //apiKeyとspotIDを設定
    [BannerAd setNendID:@"3378e28dae0341823c82afed0ae89affff7720d9"
                 spotID:@"245237"];
    
    //デリゲートオブジェクトの指定
    [BannerAd  setDelegate:self];
//    BannerAd.delegate = self;
    
    //バナーをViewに追加
    [self.view addSubview:BannerAd];
    
    
    
    
    [BannerAd setBackgroundColor:[UIColor blueColor]];
    
    
    
//    [BannerAd load:nil];
    
    
    
    //広告をロードする
    [BannerAd load];
    
    
//    BannerAd.center = CGPointMake(self.view.bounds.size.width/2,
//                                  self.view.bounds.size.height/2);
    
    NSLog(@"initBannerAd");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
//http://dev.classmethod.jp/references/ios8-photo-kit-2/
    
//    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"b0.jpg"]];
//    imageView.frame = CGRectMake(0, 0, 200, 200);
//    imageView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:imageView];
//
//    label2 = [[UILabel alloc]init];
//    label2.text=@"サイズ";
//    [self.view addSubview:label2];
    
    
    //1. PHCollectionListの取得
    // type: PHCollectionListTypeMomentList
    // subtype: PHCollectionListSubtypeAny
    PHFetchResult *momentLists = [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeMomentList subtype:PHCollectionListSubtypeAny options:nil];
    
    // type: PHCollectionListTypeFolder
    // subtype: PHCollectionListSubtypeAny
//    PHFetchResult *folderLists = [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeFolder subtype:PHCollectionListSubtypeAny options:nil];
    
    // type: PHCollectionListTypeSmartFolder
    // subtype: PHCollectionListSubtypeAny
//    PHFetchResult *smartFolderList = [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeSmartFolder subtype:PHCollectionListSubtypeAny options:nil];
    
    
    [momentLists enumerateObjectsUsingBlock:^(PHCollectionList *momentCollectionList, NSUInteger idx, BOOL *stop) {
        NSLog(@"momentCollectionList:%@", momentCollectionList);
        
        //2.PHAssetCollectionを取得
        PHFetchResult *moments = [PHAssetCollection fetchMomentsInMomentList:momentCollectionList options:nil];
//        moments = [PHAssetCollection
//                   fetchMomentsInMomentList:momentCollectionList
//                   options:nil];
        
        
        [moments enumerateObjectsUsingBlock:^(PHAssetCollection *momentAssetCollection, NSUInteger idx, BOOL *stop) {
            NSLog(@"momentAssetCollection:%@", momentAssetCollection);
            
            
            
            // 3.PHAssetを取得
            PHFetchResult *assets = [PHAsset fetchAssetsInAssetCollection:momentAssetCollection options:nil];
            [assets enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
                NSLog(@"asset:%@", asset);
                
                NSLog(@"arrAssets.count = %d", (int)arrAllAssets.count);
                
                
                if(arrAllAssets.count < LENGTH_MAX_IMAGE){
                    
                    [arrAllAssets addObject:asset];
                    
                    //既定数LengthMaxImageを超えた場合
                    if(!isFirstDisplay &&
                       !(arrAllAssets.count < LENGTH_MAX_IMAGE)){
                        isFirstDisplay = true;
                        [self setAssetToMDCSwipe];
                        
                        return ;
                    }
//                    //4.画像取得
//                    [[PHImageManager defaultManager]
//                     requestImageForAsset:asset
//                     targetSize:self.view.bounds.size//CGSizeMake(300,300)
//                     contentMode:PHImageContentModeAspectFit
//                     options:nil
//                     resultHandler:^(UIImage *result, NSDictionary *info) {
//                         if (result) {
//                             NSLog(@"result %d = %@",(int)arrImage.count, result);
//    //                         _weakSelf.imageView.image = result;
//    //                         _weakSelf.label.text = [NSString stringWithFormat:@"UIImage:%@", NSStringFromCGSize(result.size)];
//    //                         _weakSelf.label2.text = [NSString stringWithFormat:@"imageView:%@", NSStringFromCGSize(self.imageView.frame.size)];
//                             
//                             
//                             [arrImage addObject:result];
//
//                             if(arrImage.count > 30){//arrImageが30以上の要素を持つ時
//                                 NSLog(@"arrImageが30以上の要素を持つ");
//                                 if(!isFirstDisplay){//まだ表示してなければ
//                                     label.text = @"大久保君、感想待ってる！";
//                                     label.font = [UIFont systemFontOfSize:17];
//                                     
//                                     isFirstDisplay = true;//表示済ステータスにする
//                                     [self displayimage];
//                                 }
//                                 
//                             }
//                             
//                             
////                         imageView.image = result;
////                         label.text =
////                         [NSString
////                          stringWithFormat:@"UIImage:%@",
////                          NSStringFromCGSize(result.size)];
////                         label2.text =
////                         [NSString
////                          stringWithFormat:@"imageView:%@",
////                          NSStringFromCGSize(imageView.frame.size)];
////                         
////                         return ;
//
//                         }
//                     }];
                }
                
//                    NSLog(@"arrimage.count = %d", (int)arrImage.count);
//                    if(arrImage.count > 10){
//                        NSLog(@"return");
//                        return;
//                    }
                
                
            }];
            
//            NSLog(@"arrimage.count = %d", (int)arrImage.count);
//            if(arrImage.count > 10){
//                
//                NSLog(@"return");
//                return;
//            }
            
        }];
        
//        NSLog(@"arrimage.count = %d", (int)arrImage.count);
//        if(arrImage.count > 10){
//            NSLog(@"return");
//            return;
//        }
        
    }];
    
    
    
    
//    PHFetchResult *assets = [PHAsset fetchAssetsInAssetCollection:momentAssetCollection options:nil];
//    [assets enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
//        NSLog(@"asset:%@", asset);
//    }];
}



    


-(void)setAssetToMDCSwipe{
    [SVProgressHUD dismiss];
    NSLog(@"setAssetToMDCSwipe for asset.count = %d", (int)arrAllAssets.count);
    
    
    PHAsset *asset;
    
    asset = [arrAllAssets lastObject];
    //label_property:更新
    [label_property setText:
     [NSString stringWithFormat:@"%d:%@",(int)arrAllAssets.count, asset.creationDate]];
    
    options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.likedText = @"Like";
    options.likedColor = [UIColor blueColor];
    options.nopeText = @"Dis";
    options.onPan = ^(MDCPanState *state){
        if(state.thresholdRatio == 1.f &&
           state.direction == MDCSwipeDirectionLeft){
            NSLog(@"Let go now to delete the photo!");
        }
        
        
        
    };
    
    
    //カスタム仕様にすることで文字データを内包できると思った(がやってない)
//    MDCSwipeToChooseView *viewSwipe;
    CustomisedMDCSwipeToChooseView *viewSwipe;
    for(int i = 0;i < arrAllAssets.count;i++){
        NSLog(@"asset %d = %@", i, arrAllAssets[i]);
        viewSwipe =
        [[CustomisedMDCSwipeToChooseView alloc]
         initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/1.5f,
                                  self.view.bounds.size.height/1.5f)
         options:options];
        viewSwipe.center = self.view.center;
        viewSwipe.tag = 0;
        
        asset = (PHAsset *)arrAllAssets[i];
        [[PHImageManager defaultManager]
         requestImageForAsset:asset
         targetSize:self.view.bounds.size//CGSizeMake(300,300)
         contentMode:PHImageContentModeAspectFit
         options:nil
         resultHandler:^(UIImage *result, NSDictionary *info) {
             if (result) {
                 NSLog(@"uiimage of asset = %@", result);
                 
                 viewSwipe.imageView.image = result;
                 viewSwipe.tag = i;
                 
                 
             }
         }];
        
        [self.view addSubview:viewSwipe];

    }
}


#pragma delegate method of mdcswipe
// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    
    if(view == nil || [view isEqual:[NSNull null]]){
        return ;
    }
    int selectedNo = (int)view.tag;
    
    //順番通りに配置(当該メソッドも呼び出)されるとは限らないので注意が必要！
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
        
        PHAsset *nowAsset = arrAllAssets[selectedNo];
        // 編集処理がサポートされているか
        if ([nowAsset canPerformEditOperation:PHAssetEditOperationDelete]) {
            // 変更をリクエストするblockを実行
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // Assetをlibraryから削除
                [PHAssetChangeRequest deleteAssets:@[nowAsset]];
            } completionHandler:^(BOOL success, NSError *error) {
                if (success) {
                    NSLog(@"%s delete success.", __PRETTY_FUNCTION__);
                } else {
                    NSLog(@"%s delete failure. Error: %@", __PRETTY_FUNCTION__, error);
                }
            }];
        }
        nowAsset = nil;
        
    } else {
        NSLog(@"Photo saved! at no = %d", selectedNo);
        
        
        PHAsset *nextAsset;
        if(selectedNo > 0){
            //次のassetを取得する
            nextAsset = arrAllAssets[selectedNo-1];
        }else{//次がなければnilとする
            nextAsset = nil;
        }
        
        //次がなければall processedとする
        if(nextAsset == nil || [nextAsset isEqual:[NSNull null]]){
            [label_property setText:@"all processed"];
            [label_property setTextColor:[UIColor redColor]];
        }else{
            [label_property setText:
             [NSString stringWithFormat:@"%d:%@",
              selectedNo,
              nextAsset.creationDate]];
        }
        
        nextAsset = nil;
    }
    
    
    //非表示状態になった(like or dislike両方)assetを削除する
//    [arrAllAssets removeObjectAtIndex:selectedNo];
    
}




#pragma ad delegate
// Adの初回読み込み完了
-(void) nadViewDidFinishLoad:(NADView *)adView{
    NSLog(@"Ad初回読み込み成功");
}



// Adの読み込み完了通知
-(void) nadViewDidReceiveAd:(NADView *)adView{
    NSLog(@"Ad読み込み成功");
}

// Adの読み込み失敗通知
-(void) nadViewDidFailToReceiveAd:(NADView *)adView{
    NSLog(@"Ad読み込み失敗");
}


@end
