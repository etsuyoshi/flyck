//
//  ViewController.m
//  flyck
//
//  Created by EndoTsuyoshi on 2014/10/04.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//

#import "ViewController.h"
@import Photos;

@interface ViewController ()

@end

@implementation ViewController{
    MDCSwipeToChooseViewOptions *options;
    
    
    UIImageView *imageView;
    UILabel *label;
    UILabel *label2;
    
//    NSMutableArray *arrImage;
    NSMutableArray *arrAssets;
    
    BOOL isFirstDisplay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"flyck";
    
    isFirstDisplay = false;
    
//    arrImage = [NSMutableArray array];
    arrAssets = [NSMutableArray array];
    
    
    
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
    label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 300, 300);
    label.center = CGPointMake(self.view.bounds.size.width/2,
                               60);
//    label.font = [UIFont systemFontOfSize:3000];
//    label.textColor = [UIColor redColor];
//    label.text = @"取得中...";
//    [label setText:@"取得中..."];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor: [UIColor blackColor]];
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
//    label2 = [[UILabel alloc]init];
//    label2.text=@"サイズ";
//    [self.view addSubview:label2];
    
    
    //1. PHCollectionListの取得
    // type: PHCollectionListTypeMomentList
    // subtype: PHCollectionListSubtypeAny
    PHFetchResult *momentLists = [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeMomentList subtype:PHCollectionListSubtypeAny options:nil];
    
    // type: PHCollectionListTypeFolder
    // subtype: PHCollectionListSubtypeAny
    PHFetchResult *folderLists = [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeFolder subtype:PHCollectionListSubtypeAny options:nil];
    
    // type: PHCollectionListTypeSmartFolder
    // subtype: PHCollectionListSubtypeAny
    PHFetchResult *smartFolderList = [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeSmartFolder subtype:PHCollectionListSubtypeAny options:nil];
    
    
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
                
                NSLog(@"arrAssets.count = %d", (int)arrAssets.count);
                
                
                if(arrAssets.count < 30){
                    
                    [arrAssets addObject:asset];
                    
                    if(!isFirstDisplay &&
                       !(arrAssets.count < 30)){
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
    
    NSLog(@"setAssetToMDCSwipe for asset.count = %d", (int)arrAssets.count);
    
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
    
    MDCSwipeToChooseView *viewSwipe;
    PHAsset *asset;
    for(int i = 0;i < arrAssets.count;i++){
        NSLog(@"asset %d = %@", i, arrAssets[i]);
        viewSwipe =
        [[MDCSwipeToChooseView alloc]
         initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/1.3f,
                                  self.view.bounds.size.height/1.3f)
         options:options];
        viewSwipe.center = self.view.center;
        viewSwipe.tag = 0;
        
        asset = (PHAsset *)arrAssets[i];
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
                 
                 [self.view addSubview:viewSwipe];
             }
         }];

    }
}

//-(void)displayimage{
//    NSLog(@"num of factor = %d", (int)arrImage.count);
//    
//    
//    options = [MDCSwipeToChooseViewOptions new];
//    options.delegate = self;
//    options.likedText = @"Like";
//    options.likedColor = [UIColor blueColor];
//    options.nopeText = @"Dis";
//    options.onPan = ^(MDCPanState *state){
//        if(state.thresholdRatio == 1.f &&
//           state.direction == MDCSwipeDirectionLeft){
//            NSLog(@"Let go now to delete the photo!");
//        }
//    };
//    
//    
//    MDCSwipeToChooseView *viewSwipe;
//    
//    for(int i = 0;i < arrImage.count;i++){
//        viewSwipe =
//        [[MDCSwipeToChooseView alloc]
//         initWithFrame:self.view.bounds//CGRectMake(0, 0, 300, 300)
//         options:options];
//        viewSwipe.center = self.view.center;
//        viewSwipe.tag = 0;
////        view.imageView.image = [UIImage imageNamed:@"photo"];
//        
//        //画像データ取得
////        NSString *strUrl =
////        arrHibitaImageUrl[0];
//        //        arrHibitaImageUrl[i % arrHibitaImageUrl.count][@"img1_500"];
////        NSLog(@"strUrl = %@", strUrl);
//        
////        (NSString *)arrTmpImageUrl[i % arrTmpImageUrl.count];
//
////        NSLog(@"noOfImage = %d : %@", noOfImage, strUrl);
//        
//        viewSwipe.imageView.image = (UIImage *)arrImage[i];
////        [viewSwipe.imageView
////         setImageWithURL:[NSURL URLWithString:strUrl]
////         placeholderImage:nil
////         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){
////             [viewSwipe.imageView
////              setImageWithURL:[NSURL URLWithString:strUrl]
////              placeholderImage:image];
////             
////             [SVProgressHUD dismiss];
////         }];
//        [self.view addSubview:viewSwipe];
//    }
//
//}


#pragma delegate method of mdcswipe
// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        NSLog(@"Photo saved! %d", (int)view.tag);
        
        
//        ItemData *itemd = [[ItemData alloc]init];
//        itemd.strCategories = arrHibitaCategories[view.tag];
//        itemd.strImageUrl = arrHibitaImageUrl[view.tag];
//        itemd.strItemId = arrHibitaItemId[view.tag];
//        
//        [arrSavedItem addObject:itemd];
        
    }
}

@end
