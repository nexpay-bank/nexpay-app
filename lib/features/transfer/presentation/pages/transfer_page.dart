import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/card/presentation/cubit/card_cubit.dart';
import 'package:nexpay/features/card/presentation/widgets/card_widget.dart';
import 'package:nexpay/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';

class TransferPage extends StatefulWidget {
  final String? qrData;
  const TransferPage({super.key, this.qrData});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String accountNumber = '';
  String amount = '';
  int selectedCardIndex = 0;
  bool success = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      accountNumber = widget.qrData ?? "";
    });
  }

  void _showNumpad(String title, void Function(String) onValueChanged) {
    String input = '';
    showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.background,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 6,
                    width: 150,
                    decoration: BoxDecoration(
                      color: context.colors.onBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  input,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          // crossAxisSpacing: 12,
                          // mainAxisSpacing: 12,
                          childAspectRatio: 16 / 9,
                        ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      String label;
                      if (index < 9)
                        label = '${index + 1}';
                      else if (index == 9)
                        label = '←';
                      else if (index == 10)
                        label = '0';
                      else
                        label = 'OK';
                      return GestureDetector(
                        onTap: () {
                          if (label == '←') {
                            if (input.isNotEmpty)
                              input = input.substring(0, input.length - 1);
                          } else if (label == 'OK') {
                            onValueChanged(input);
                            Navigator.pop(context);
                          } else {
                            input += label;
                          }
                          setModalState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.grey.shade100,
                            // borderRadius: BorderRadius.circular(12),
                            border: BoxBorder.all(
                              width: 0.5,
                              color: context.colors.onBackground.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            label,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CardCubit, CardState>(
        builder: (context, state) {
          if (state is CardSuccess) {
            final cards = state.cards;
            final selectedCard = cards[selectedCardIndex];
            final balance = selectedCard.balance;

            List<int> suggestedAmounts = [
              (balance * 0.25).round(),
              (balance * 0.5).round(),
              (balance * 0.75).round(),
              (balance).round(),
            ];

            return BlocBuilder<TransferCubit, TransferState>(
              builder: (context, transferState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (transferState is TransferFailure) {
                    context.read<TransferCubit>().resetState();

                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text("Failed"),
                        content: Text(transferState.error),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text("Retry"),
                            onPressed: () {
                              Navigator.pop(context); // tutup dialog
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (transferState is TransferSuccess && success) {
                    context.read<TransferCubit>().resetState();

                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text("Success"),
                        content: Text("Transfer Success"),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                });
                return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Positioned(
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                    Iconsax.arrow_left_2_copy,
                                    color: context.colors.onBackground,
                                  ),
                                ),
                              ),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: TitleWidget(title: 'Transfer'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 0.5,
                          color: context.colors.onBackground.withValues(
                            alpha: 0.3,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CardWidget(
                          cardHolder: state.holder,
                          balance: selectedCard.balance,
                          id: selectedCard.accountId,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor:
                                          context.colors.background,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                      ),
                                      builder: (_) {
                                        return StatefulBuilder(
                                          builder: (context, setModalState) {
                                            return SizedBox(
                                              height: 300,
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                            8,
                                                          ),
                                                      height: 6,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        color: context
                                                            .colors
                                                            .onBackground,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          ...cards.asMap().entries.map((
                                                            entry,
                                                          ) {
                                                            final index =
                                                                entry.key;
                                                            final card =
                                                                entry.value;

                                                            return GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                                setState(() {
                                                                  selectedCardIndex =
                                                                      index;
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                      16,
                                                                    ),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          '${state.holder} - \$ ${card.balance}',
                                                                          style: context
                                                                              .textTheme
                                                                              .bodyLarge,
                                                                        ),
                                                                        Text(
                                                                          "Account ID: ${card.accountId}",
                                                                          style: context
                                                                              .textTheme
                                                                              .bodyMedium,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Text("Change Card"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: Icon(Iconsax.direct_down_copy)),
                              ListTile(
                                title: Text(
                                  "Recipient ID",
                                  style: context.textTheme.bodyLarge,
                                ),
                                subtitle: Text(
                                  accountNumber.isEmpty
                                      ? "None"
                                      : accountNumber,
                                  style: context.textTheme.bodySmall,
                                ),
                                trailing: Icon(
                                  Iconsax.card_copy,
                                  color: context.colors.primary,
                                ),
                                onTap: () =>
                                    _showNumpad("Input Account Number", (val) {
                                      setState(() => accountNumber = val);
                                    }),
                              ),
                              ListTile(
                                title: Text(
                                  "Enter Amount",
                                  style: context.textTheme.bodyLarge,
                                ),
                                subtitle: Text(
                                  amount.isEmpty ? "None" : "\$$amount",
                                  style: context.textTheme.bodySmall,
                                ),
                                trailing: Icon(
                                  Iconsax.money_copy,
                                  color: context.colors.primary,
                                ),
                                onTap: () =>
                                    _showNumpad("Insert Amount", (val) {
                                      setState(() => amount = val);
                                    }),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                spacing: 8,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: suggestedAmounts.map((a) {
                                  return Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        backgroundColor: a.toString() == amount
                                            ? context.colors.primary
                                            : context.colors.surface,
                                      ),
                                      onPressed: () =>
                                          setState(() => amount = a.toString()),
                                      child: Text(
                                        '\$$a',
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                              color: a.toString() == amount
                                                  ? context.colors.background
                                                  : context.colors.onBackground,
                                            ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            // vertical: 64,
                            horizontal: 16,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    final enteredAmount =
                                        double.tryParse(amount) ?? 0;
                                    if (enteredAmount > balance) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Insufficient balance!",
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    if (accountNumber.isEmpty ||
                                        amount.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Make sure all fields are filled",
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    setState(() {
                                      success = true;
                                    });
                                    context.read<TransferCubit>().transfer(
                                      fromAccountId: selectedCard.accountId,
                                      toAccountId: int.parse(accountNumber),
                                      amount: double.parse(amount),
                                    );
                                  },
                                  child: Text("Transfer"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                      ],
                    ),
                    transferState is TransferLoading
                        ? Positioned.fill(
                            child: Expanded(
                              child: Container(
                                color: context.colors.background.withValues(
                                  alpha: 0.3,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                );
              },
            );
          }
          if (state is CardLoading) {
            return Expanded(child: Center(child: CircularProgressIndicator()));
          }
          if (state is CardFailure) {
            return Center(child: Text("Failed to fetch"));
          }
          return Container();
        },
      ),
    );
  }
}
