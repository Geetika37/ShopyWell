import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopywell/app/core/utils/toasts.dart';

class StripePaymentService extends GetxService {
  // Payment status tracking
  final paymentStatus = ''.obs;
  final paymentMessage = ''.obs;
  RxBool isPaymentProcessing = false.obs;
  late Completer<bool> _paymentCompleter;

  // Payment details
  String? paymentId;
  String? paymentIntentId;
  int? createdTimestamp;
  Map<String, dynamic>? paymentIntent;

  @override
  void onInit() {
    super.onInit();
    log("Stripe payment service initialized");
  }

  /// Creates a payment intent on the Stripe server.
  ///
  /// The method takes [amount] (in the currency's smallest unit),
  /// [currency] code (e.g., 'USD', 'GBP'), and an optional [description].
  ///
  /// Returns a map containing the payment intent details from Stripe.
  Future<Map<String, dynamic>> _createPaymentIntent(
    String secretKey,
    String amount,
    String currency, {
    String? description,
  }) async {
    try {
      // Prepare the request body
      Map<String, dynamic> body = {'amount': amount, 'currency': currency};

      // Add description if provided
      if (description != null && description.isNotEmpty) {
        body['description'] = description;
      }

      // Make the API call to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      // Parse and return the response
      return json.decode(response.body);
    } catch (e) {
      log('Error creating payment intent: $e');
      throw Exception('Failed to create payment intent: $e');
    }
  }

  /// Converts a human-readable amount to the smallest currency unit (cents/pence).
  ///
  /// For example, converts '10.99' to '1099' for Stripe processing.
  String _calculateAmount(String amount) {
    final double parsedAmount = double.parse(amount);
    final int amountInCents = (parsedAmount * 100).round();
    return amountInCents.toString();
  }

  /// Starts a Stripe payment process with the given amount and currency.
  ///
  /// Returns a Future that completes with `true` if the payment is successful,
  /// and `false` otherwise.
  ///
  /// The method creates a payment intent, initializes and displays the Stripe payment sheet,
  /// and handles the payment result.
  ///
  /// If there is an error during the payment process, it logs the error,
  /// shows an error toast, and returns `false`.
  Future<bool> startPayment({
    required String amount,
    required String currency,
    required String stripePublishableKey,
    required String stripeSecretKey,
    String? description,
    String? customerName,
  }) async {
    log("Starting Stripe payment for amount: $amount $currency");

    isPaymentProcessing.value = true;
    _paymentCompleter = Completer<bool>();

    try {
      // Initialize Stripe
      Stripe.publishableKey = stripePublishableKey;
      await Stripe.instance.applySettings();

      // Create payment intent
      paymentIntent = await _createPaymentIntent(
        stripeSecretKey,
        _calculateAmount(amount),
        currency,
        description: description,
      );

      paymentIntentId = paymentIntent!['id'];
      createdTimestamp = paymentIntent!['created'];

      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: customerName ?? 'Spice Glen',
          style: ThemeMode.light,
        ),
      );

      // Display the payment sheet
      await _displayPaymentSheet();

      // Wait for the payment process to complete
      return await _paymentCompleter.future;
    } catch (e) {
      log('Error in Stripe payment process: $e');
      Toasts.showError('Payment failed: $e');
      isPaymentProcessing.value = false;
      if (!_paymentCompleter.isCompleted) {
        _paymentCompleter.complete(false);
      }
      return false;
    }
  }

  /// Displays the Stripe payment sheet and handles the payment result.
  Future<void> _displayPaymentSheet() async {
    try {
      // Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      // Payment successful
      paymentStatus.value = 'success';
      paymentMessage.value = 'Payment successful';
      paymentId = paymentIntentId;

      isPaymentProcessing.value = false;
      _paymentCompleter.complete(true);
    } on StripeException catch (e) {
      // Handle Stripe-specific exceptions
      log('Stripe error: ${e.error.localizedMessage}');
      paymentStatus.value = 'error';
      paymentMessage.value = 'Payment failed: ${e.error.localizedMessage}';
      Toasts.showError(paymentMessage.value);

      isPaymentProcessing.value = false;
      _paymentCompleter.complete(false);
    } catch (e) {
      // Handle other exceptions
      log('Error in payment sheet: $e');
      paymentStatus.value = 'error';
      paymentMessage.value = 'Payment failed: $e';
      Toasts.showError(paymentMessage.value);

      isPaymentProcessing.value = false;
      _paymentCompleter.complete(false);
    }
  }

  /// Sends payment status to your backend server.
  ///
  /// This method can be used to update your backend about the payment status
  /// after the payment process is complete.
  Future<bool> updatePaymentStatus({
    required String transactionId,
    required String status,
    String? additionalData,
  }) async {
    try {
      // Implement your API call to update payment status on your server
      // This is just a placeholder - replace with your actual implementation
      log('Updating payment status: ID=$paymentIntentId, Status=$status');

      // Return true if the update was successful
      return true;
    } catch (e) {
      log('Error updating payment status: $e');
      return false;
    }
  }

  @override
  void onClose() {
    log("Cleaning up Stripe payment service");
    super.onClose();
  }
}
