//
//  SK.m
//  danmitsutype
//
//  Created by yu kawase on 13/01/17.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "SK.h"

@implementation SK

@synthesize onFailConnect;
@synthesize onProductSuccess;
@synthesize onProductFail;
@synthesize onRequestSuccess;
@synthesize onRequestFail;
@synthesize onPurchaseSuccess;
@synthesize onPurchaseFail;
@synthesize onRestoreSuccess;
@synthesize onRestoreFail;

static SK* instance;

+(SK*) getInstance{
    if(instance == nil){
        instance = [[SK alloc] init];
    }
    
    return instance;
}

-(id) init{
    self = [super init];
    if(self){
        [self initialize];
    }
    
    return self;
}

-(void) initialize{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

-(BOOL) checkSk{
    return [SKPaymentQueue canMakePayments];
}

-(void) productRequest{
    currentRequestType = PRODUCT_REQUEST;
    [self productRequestImple];
}

-(void) productRequestImple{
    if(![self checkSk]){
        NSString* message = @"端末の機能制限でApp内での購入が不可になっています\n\n設定 > 一般 > 機能制限\nで[App内での購入]をONにしてください";
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        if(currentRequestType == PURCHASE_REQUEST){
            onPurchaseFail();
        }else if(currentRequestType == RESTORE_REQUEST){
            onRestoreFail();
        }else{
            onProductFail();
        }
        return;
    }
    SKProductsRequest* productRequest;
    productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIds];
    productRequest.delegate = self;
    [productRequest start];
}

// ▼ public =========================================

-(void) setProductIds:(NSSet *)productIds_{
    productIds = productIds_;
}

-(void) startParches{
    currentRequestType = PURCHASE_REQUEST;
    if(specialStageProduct != nil){
        SKPayment* payment = [SKPayment paymentWithProduct:specialStageProduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        return ;
    }
    
    // プロダクト情報がなければとりにいってから課金処理
    [self productRequestImple];
}

-(void) startRestore{
    currentRequestType = RESTORE_REQUEST;
    if(specialStageProduct != nil){
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
        return ;
    }

    // プロダクト情報がなければとりにいってからリストア
    [self productRequestImple];
}

-(BOOL) hasProductInfo{
    return (specialStageProduct != nil);
}

// ▼ SKProductsRequestDelegate =======================

-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
//    NSLog(@"didReceiveResponse");
    NSArray* productList = response.products;
    NSArray* invalidProductList = response.invalidProductIdentifiers;
    if([invalidProductList count] != 0 || [productList count] == 0){
        // TODO エラー
        NSLog(@"error");
        if(currentRequestType == PURCHASE_REQUEST){
            onPurchaseFail();
        }else if(currentRequestType == RESTORE_REQUEST){
            onRestoreFail();
        }else{
            onProductFail();
        }
        return;
    }
    
    // TODO ちゃんとやる
    specialStageProduct = [productList objectAtIndex:0];
//        for(int i=0,max=[productList count];i<max;i++){
//            SKProduct* product = [productList objectAtIndex:i];
//            [[SK getInstance] startParches:product];
//            NSLog(@"productName:%@, %@", product.localizedTitle, product.priceLocale);
//        }
    if(currentRequestType == PURCHASE_REQUEST){
        [self startParches];
    }else if(currentRequestType == RESTORE_REQUEST){
        [self startRestore];
    }else{
        onProductSuccess(request, response);
    }
}

-(void) requestDidFinish:(SKRequest *)request{
//    NSLog(@"requestDidFinish");
    onRequestSuccess(request);
}

-(void) request:(SKRequest *)request didFailWithError:(NSError *)error{
//    NSLog(@"didFailWithError");
    if(currentRequestType == PURCHASE_REQUEST){
        onPurchaseFail();
    }else if(currentRequestType == RESTORE_REQUEST){
        onRestoreFail();
    }else{
        onRequestFail(request, error);
    }
}

// ▼ SKPaymentTransactionObserver =========================

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    // TODO 処理はmediatorに戻す
    
    // TODO ちゃんとやる.一個なんでこれでちょろまかす
    for(SKPaymentTransaction* transaction in transactions){
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"SKPaymentTransactionStatePurchasing");
                break;
            case SKPaymentTransactionStatePurchased:
                NSLog(@"SKPaymentTransactionStatePurchased");
                onPurchaseSuccess();
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"SKPaymentTransactionStateFailed");
                onPurchaseFail();
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"SKPaymentTransactionStateRestored");
                NSLog(@"restored:%@", transaction.payment.productIdentifier);
                // 気になるのでここだけちゃんと見る
                if([transaction.payment.productIdentifier isEqualToString:specialStageProduct.productIdentifier] ){
                    onPurchaseSuccess();
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    NSLog(@"restoreCompletedTransactionsFailedWithError");
    NSLog(@"error:%@", error.description);
    NSLog(@"%d", error.code);
    if(error.code == SKErrorPaymentCancelled){
        onFailConnect();
    }else{
        onRestoreFail();
    }
//    if(error.code == SKErrorDomain)
    
}

// Sent when all transactions from the user's purchase history have successfully been added back to the queue.
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    NSLog(@"paymentQueueRestoreCompletedTransactionsFinished");
    onRestoreSuccess();
}

// Sent when the download state has changed.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray *)downloads __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0){
    
}

@end
