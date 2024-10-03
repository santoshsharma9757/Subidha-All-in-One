import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/constant/app_string.dart';
import 'package:hamro_smart_life/constant/app_text_style.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_appbar.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_textformfield.dart';
import 'package:hamro_smart_life/view_model/compound_interest_notifier.dart';
import 'package:provider/provider.dart';

class CompoundInterestScreen extends StatefulWidget {
  const CompoundInterestScreen({super.key});

  @override
  State<CompoundInterestScreen> createState() => _CompoundInterestScreenState();
}

class _CompoundInterestScreenState extends State<CompoundInterestScreen> {
  final _formKey = GlobalKey<FormState>();

  late CompoundInterestNotifier compoundInterestNotifier;
  @override
  void initState() {
    compoundInterestNotifier =
        Provider.of<CompoundInterestNotifier>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    compoundInterestNotifier.clearSelectedValue();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compoundInterestProvider =
        Provider.of<CompoundInterestNotifier>(context, listen: false);
    return Scaffold(
      appBar: const ReusableAppBar(
        title: CIString.chakriyaByaj,
        centerTitle: true,
      ),
      body: Consumer<CompoundInterestNotifier>(
        builder: (context, compoundInterestvalue, child) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ReusableTextFormField(
                  labelText: CIString.principleAmount,
                  backgroundColor: AppColors.lightBlue,
                  controller: compoundInterestProvider.principalController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return CIString.principleAmountValidation;
                    }
                    if (double.tryParse(value) == null) {
                      return CIString.principleAmountValidation2;
                    }
                    return null;
                  },
                ),
                AppSpacing.verticalMedium,
                ReusableTextFormField(
                  labelText: CIString.rateMonthly,
                  backgroundColor: AppColors.lightBlue,
                  controller: compoundInterestProvider.rateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return CIString.rateValidation;
                    }
                    if (double.tryParse(value) == null) {
                      return CIString.rateValidation2;
                    }
                    return null;
                  },
                ),
                AppSpacing.verticalMedium,
                GestureDetector(
                  onTap: () => compoundInterestProvider.selectDate(context,
                      isLoanDate: true),
                  child: AbsorbPointer(
                    child: ReusableTextFormField(
                      labelText: CIString.loanLiyekoMiti,
                      controller: TextEditingController(
                        text: compoundInterestvalue.loanTakenDateUI != null
                            ? compoundInterestvalue.loanTakenDateUI
                                .toString() // Raw date string
                            : '',
                      ),
                      backgroundColor: AppColors.lightBlue,
                      suffixIcon: const Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                AppSpacing.verticalMedium,
                GestureDetector(
                  onTap: () => compoundInterestProvider
                    ..selectDate(context, isLoanDate: false),
                  child: AbsorbPointer(
                    child: ReusableTextFormField(
                      labelText: CIString.bhuktaniMiti,
                      controller: TextEditingController(
                        text: compoundInterestvalue.paymentDateUI != null
                            ? compoundInterestvalue.paymentDateUI
                                .toString() // Raw date string
                            : '',
                      ),
                      backgroundColor: AppColors.lightBlue,
                      suffixIcon: const Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                AppSpacing.verticalMedium,
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      compoundInterestProvider
                          .calculateCompoundInterest(context);
                      setState(() {});
                    }
                  },
                  child: Text(CIString.calculate.toString()),
                ),
                AppSpacing.verticalMedium,
                if (compoundInterestvalue.totalAmount != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${CIString.smayAwadhi} ${compoundInterestvalue.timePeriod}',
                        style: AppTextStyles.heading1,
                      ),
                      AppSpacing.verticalExtraSmall,
                      Text(
                        '${CIString.kulByaj} ${compoundInterestvalue.interest}',
                        style: AppTextStyles.heading1,
                      ),
                      AppSpacing.verticalExtraSmall,
                      Text(
                        '${CIString.kulRakam} ${compoundInterestvalue.totalAmount}',
                        style: AppTextStyles.heading1,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
