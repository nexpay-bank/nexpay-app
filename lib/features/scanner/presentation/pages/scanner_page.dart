import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/card/presentation/cubit/card_cubit.dart';
import 'package:nexpay/features/transfer/presentation/pages/transfer_page.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key, this.page});
  final int? page;
  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  int selectedTab = 0;
  bool _canScan = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.page != null) {
      selectedTab = widget.page ?? 0;
    }
  }

  void _handleScanResult(BuildContext context, String qrData) {
    if (!_canScan) return;
    _canScan = false;
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => TransferPage(qrData: qrData)),
    );
    Future.delayed(const Duration(seconds: 2), () {
      _canScan = true;
    });
  }

  void _showNoCardDialog(BuildContext context, String error) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Failed"),
        content: Text(error),
        actions: [
          CupertinoDialogAction(
            child: const Text("Retry"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CardCubit, CardState>(
          builder: (context, state) {
            if (state is CardSuccess) {
              final cards = state.cards;
              if (cards.isEmpty) {
                Future.microtask(
                  () => _showNoCardDialog(
                    context,
                    'Please create new account first',
                  ),
                );
                return const SizedBox();
              }

              final qrValue = cards.first.accountId;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Iconsax.arrow_left_2_copy),
                          ),
                        ),
                        const TitleWidget(title: 'My QR Code'),
                        // const Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Icon(Iconsax.more_copy),
                        // ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: context.colors.onBackground.withValues(alpha: 0.3),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        spacing: 16,
                        children: [
                          _buildTab(0, 'Scan QR'),
                          _buildTab(1, 'My QR'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Expanded(
                    child: selectedTab == 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.colors.onBackground,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: context.colors.onBackground
                                      .withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: MobileScanner(
                                    onDetect: (capture) {
                                      final barcode = capture.barcodes.first;
                                      if (barcode.rawValue != null) {
                                        _handleScanResult(
                                          context,
                                          barcode.rawValue!,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),

                                child: QrImageView(
                                  data: qrValue.toString(),
                                  eyeStyle: QrEyeStyle(
                                    color: context.colors.onBackground,
                                    eyeShape: QrEyeShape.circle,
                                  ),
                                  foregroundColor: context.colors.onBackground,
                                  version: QrVersions.auto,
                                  size: MediaQuery.of(context).size.width - 32,
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                "Show This Code to The Sender",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Ask your friend to send money by scan this QR",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    // style: ElevatedButton.styleFrom(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     vertical: 16,
                                    //   ),
                                    //   backgroundColor: Colors.yellow.shade600,
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(16),
                                    //   ),
                                    // ),
                                    onPressed: () {
                                      Share.share('My QR: $qrValue');
                                    },
                                    child: const Text(
                                      "Share",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? context.colors.primary
                : context.colors.onBackground,
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
