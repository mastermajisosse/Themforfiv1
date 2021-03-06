import 'dart:async';

import 'package:flutterbuyandsell/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutterbuyandsell/api/common/ps_resource.dart';
import 'package:flutterbuyandsell/api/common/ps_status.dart';
import 'package:flutterbuyandsell/provider/common/ps_provider.dart';
import 'package:flutterbuyandsell/repository/product_repository.dart';
import 'package:flutterbuyandsell/viewobject/holder/product_parameter_holder.dart';
import 'package:flutterbuyandsell/viewobject/product.dart';

class PopularProductProvider extends PsProvider {
  PopularProductProvider({@required ProductRepository repo, int limit = 0})
      : super(repo, limit) {
    if (limit != 0) {
      super.limit = limit;
    }
    _repo = repo;
    print('PopularProductProvider : $hashCode');
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
    });

    productListStream = StreamController<PsResource<List<Product>>>.broadcast();
    subscription =
        productListStream.stream.listen((PsResource<List<Product>> resource) {
      updateOffset(resource.data.length);

      _productList = resource;
      _productList.data = Product().checkDuplicate(resource.data);

      if (resource.status != PsStatus.BLOCK_LOADING &&
          resource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }
  ProductRepository _repo;
  PsResource<List<Product>> _productList =
      PsResource<List<Product>>(PsStatus.NOACTION, '', <Product>[]);
  final ProductParameterHolder productPopularParameterHolder =
      ProductParameterHolder().getPopularParameterHolder();
  PsResource<List<Product>> get productList => _productList;
  StreamSubscription<PsResource<List<Product>>> subscription;
  StreamController<PsResource<List<Product>>> productListStream;
  @override
  void dispose() {
    subscription.cancel();
    isDispose = true;
    print('Trending Product Provider Dispose: $hashCode');
    super.dispose();
  }

  Future<dynamic> loadProductList(
      ProductParameterHolder productParameterHolder) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    await _repo.getProductList(productListStream, isConnectedToInternet, limit,
        offset, PsStatus.PROGRESS_LOADING, productParameterHolder);
  }

  Future<dynamic> resetProductList(
      ProductParameterHolder productParameterHolder) async {
    isLoading = true;

    updateOffset(0);
    isConnectedToInternet = await Utils.checkInternetConnectivity();

    await _repo.getProductList(productListStream, isConnectedToInternet, limit,
        offset, PsStatus.PROGRESS_LOADING, productParameterHolder);

    isLoading = false;
  }

  Future<dynamic> nextProductList(
      ProductParameterHolder productParameterHolder) async {
    isConnectedToInternet = await Utils.checkInternetConnectivity();

    if (!isLoading && !isReachMaxData) {
      super.isLoading = true;

      await _repo.getProductList(productListStream, isConnectedToInternet,
          limit, offset, PsStatus.PROGRESS_LOADING, productParameterHolder);
    }
  }
}
