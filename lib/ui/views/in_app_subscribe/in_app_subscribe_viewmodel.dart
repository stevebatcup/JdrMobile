import 'dart:async';
import 'package:jdr/app/locator.dart';
import 'package:jdr/app/router.gr.dart';
import 'package:jdr/services/auth_service.dart';
import 'package:jdr/services/jdr_networking_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppSubscribeViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final JdrNetworkingService _networkService = JdrNetworkingService();

  final Set<String> _kProductIds = {'1month_sub'};

  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  InAppPurchaseConnection get connection => _connection;

  StreamSubscription<List<PurchaseDetails>> _subscription;

  List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;

  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;

  bool _purchasePending = false;
  bool get purchasePending => _purchasePending;

  bool _loading = true;
  bool get loading => _loading;

  void initInAppPurchases() {
    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
  }

  Future<void> initStoreInfo() async {
    final bool isConnAvailable = await _connection.isAvailable();
    if (!isConnAvailable) {
      _isAvailable = isConnAvailable;
      _products = [];
      _purchasePending = false;
      _loading = false;
      notifyListeners();
      return;
    }

    ProductDetailsResponse productDetailResponse =
        await _connection.queryProductDetails(_kProductIds);
    if (productDetailResponse.error != null) {
      _isAvailable = isConnAvailable;
      _products = productDetailResponse.productDetails;
      _purchasePending = false;
      _loading = false;
      notifyListeners();
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      _isAvailable = isConnAvailable;
      _products = productDetailResponse.productDetails;
      _purchasePending = false;
      _loading = false;
      notifyListeners();
      return;
    }

    _isAvailable = isConnAvailable;
    _products = productDetailResponse.productDetails;
    _purchasePending = false;
    _loading = false;
    notifyListeners();
  }

  void buySubscription() {
    PurchaseParam purchaseParam = PurchaseParam(
      productDetails: _products.first,
      applicationUserName: null,
      sandboxTesting: true,
    );
    _connection.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void showPendingUI() {
    _purchasePending = true;
    notifyListeners();
  }

  void handleError(IAPError error) {
    _purchasePending = false;
    notifyListeners();
  }

  Future<bool> setupJDRSubscription(PurchaseDetails purchaseDetails) async {
    JdrNetworkingResponse result = await _networkService.postData(
      "/in-app-subscribe",
      postData: {'purchase_id': purchaseDetails.purchaseID},
      sessionCookie: _authService.sessionCookie,
    );

    if (result.jsonData['status'] == 'error') {
      print(result.jsonData['message']);
      return false;
    } else if (result.jsonData['status'] == 'success') {
      return true;
    }
    return null;
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    bool purchaseSuccess = false;
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          purchaseSuccess = await setupJDRSubscription(purchaseDetails);
          _purchasePending = false;
          notifyListeners();
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
          if (purchaseSuccess) _navigationService.replaceWith(Routes.homeView);
        }
      }
    });
  }

  void signOut() async {
    await _authService.signOut();
    _navigationService.replaceWith(Routes.loginView);
  }
}
