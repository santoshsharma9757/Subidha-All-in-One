import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/constant/app_string.dart';
import 'package:hamro_smart_life/constant/app_text_style.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_appbar.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_textformfield.dart';
import 'package:hamro_smart_life/view_model/simple_interest_notifier.dart';
import 'package:provider/provider.dart';

class SimpleInterestScreen extends StatefulWidget {
  const SimpleInterestScreen({super.key});

  @override
  State<SimpleInterestScreen> createState() => _SimpleInterestScreenState();
}

class _SimpleInterestScreenState extends State<SimpleInterestScreen> {
  final _formKey = GlobalKey<FormState>();

  late SimpleInterestNotifier simpleInterestNotifier;
  @override
  void initState() {
    simpleInterestNotifier =
        Provider.of<SimpleInterestNotifier>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    simpleInterestNotifier.clearSelectedValue();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(title: SIString.sadharanByaj),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ReusableTextFormField(
                labelText: SIString.principleAmount,
                backgroundColor: AppColors.lightOrange,
                controller: simpleInterestNotifier.principalController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return SIString.principleAmountValidation;
                  }
                  if (double.tryParse(value) == null) {
                    return SIString.principleAmountValidation2;
                  }
                  return null;
                },
              ),
              AppSpacing.verticalMedium,
              ReusableTextFormField(
                labelText: SIString.rate,
                backgroundColor: AppColors.lightOrange,
                controller: simpleInterestNotifier.rateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return SIString.rateValidation;
                  }
                  if (double.tryParse(value) == null) {
                    return SIString.rateValidation2;
                  }
                  return null;
                },
              ),
              AppSpacing.verticalMedium,
              ReusableTextFormField(
                labelText: SIString.time,
                backgroundColor: AppColors.lightOrange,
                controller: simpleInterestNotifier.timeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return SIString.timeValidation;
                  }
                  if (double.tryParse(value) == null) {
                    return SIString.timeValidation2;
                  }
                  return null;
                },
              ),
              AppSpacing.verticalMedium,
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    simpleInterestNotifier.calculateSimpleInterest();
                  }
                },
                child: const Text(SIString.calculate),
              ),
              AppSpacing.verticalMedium,
              Consumer<SimpleInterestNotifier>(
                  builder: (context, provider, child) => provider.result != -1
                      ? Column(
                          children: [
                            Text(
                              '${SIString.kulByaj} ${provider.result}',
                              style: AppTextStyles.heading1,
                            ),
                            Text(
                              '${SIString.kulRakam} ${provider.totalAmount}',
                              style: AppTextStyles.heading1,
                            ),
                          ],
                        )
                      : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
