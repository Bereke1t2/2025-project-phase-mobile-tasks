import 'package:ecommerce_app/futures/product/data/data_sources/remote/product_remote_data_sources.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    ProductRemoteDataSources,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient, onMissingStub: OnMissingStub.returnDefault)
  ]
)
void main() {}