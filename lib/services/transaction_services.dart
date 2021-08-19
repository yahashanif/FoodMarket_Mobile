part of "services.dart";

class TransactionServices {
  static Future<ApiReturnValue<List<Transaction>>> getTransactions(
      {http.Client? client}) async {
    client ??= http.Client();

    String url = baseURL + 'transaction/?limit=1000';

    var response = await client.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${User.token}"
    });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Please Try Again");
    }

    var data = jsonDecode(response.body);

    List<Transaction> transaction = (data['data']['data'] as Iterable)
        .map((e) => Transaction.fromJSon(e))
        .toList();

    return ApiReturnValue(value: transaction);
    // print(data);
    // return ApiReturnValue(message: "");
  }

  static Future<ApiReturnValue<Transaction>> submitTransaction(
      Transaction transaction,
      {http.Client? client}) async {
    client ??= http.Client();

    String url = baseURL + 'checkout';

    var response = await client.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${User.token}"
        },
        body: jsonEncode(<String, dynamic>{
          "food_id": transaction.food!.id!,
          "user_id": transaction.user!.id!,
          "quantity": transaction.quantity!,
          "total": transaction.total!,
          "status": "PENDING"
        }));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Please Try Again");
    }

    var data = jsonDecode(response.body);

    Transaction value = Transaction.fromJSon(data['data']);

    return ApiReturnValue(value: value);
  }
}
