//
//  SK.h
//  danmitsutype
//
//  Created by yu kawase on 13/01/17.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef void (^sk_connect_fail_t)();
typedef void (^sk_product_success_t)(SKProductsRequest* request, SKProductsResponse* response);
typedef void (^sk_product_fail_t)();
typedef void (^sk_request_success_t)(SKRequest* request);
typedef void (^sk_request_fail_t)(SKRequest* request, NSError* error);
typedef void (^sk_purchase_success_t)(/*SKPaymentTransaction* transaction*/);
typedef void (^sk_purchase_fail_t)(/*SKPaymentTransaction* transaction*/);
typedef void (^sk_restore_success_t)(/*SKPaymentTransaction* transaction*/);
typedef void (^sk_restore_fail_t)(/*SKPaymentTransaction* transaction*/);

typedef enum CURRENT_REQUEST_TYPE{
    PRODUCT_REQUEST,
    PURCHASE_REQUEST,
    RESTORE_REQUEST
} CurrentRequestType;

@interface SK : NSObject<
SKProductsRequestDelegate
, SKPaymentTransactionObserver
>{
    CurrentRequestType currentRequestType;
    
    // よくわからんけどエラー
    sk_connect_fail_t onFailConnect;
    
    // 情報取得コールバック
    sk_product_success_t onProductSuccess;
    sk_product_fail_t onProductFail;
    
    // リクエストコールバック
    sk_request_success_t onRequestSuccess;
    sk_request_fail_t onRequestFail;
    
    // 課金処理コールバック
    sk_purchase_success_t onPurchaseSuccess;
    sk_purchase_fail_t onPurchaseFail;
    
    // リストアコールバック
    sk_restore_success_t onRestoreSuccess;
    sk_restore_fail_t onRestoreFail;
    
    // product
    SKProduct* specialStageProduct;
    
    NSSet* productIds;
    
    dispatch_queue_t dq;
}

// TODO 強参照指定でなにか処理がひつようになるのかな
@property (strong) sk_connect_fail_t onFailConnect;
@property (strong) sk_product_success_t onProductSuccess;
@property (strong) sk_product_fail_t onProductFail;
@property (strong) sk_request_success_t onRequestSuccess;
@property (strong) sk_request_fail_t onRequestFail;
@property (strong) sk_purchase_success_t onPurchaseSuccess;
@property (strong) sk_purchase_fail_t onPurchaseFail;
@property (strong) sk_restore_success_t onRestoreSuccess;
@property (strong) sk_restore_fail_t onRestoreFail;


// ▼パラメータセッター
-(void) setProductIds:(NSSet*)productIds_;

// ▼処理リクエスト
-(void) startParches;
-(void) startRestore;

-(BOOL) hasProductInfo;

+(SK*) getInstance;
-(BOOL) checkSk;
-(void) productRequest;

@end
