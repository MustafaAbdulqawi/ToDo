import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubits/sign_up_cubit/sign_up_cubit.dart';

class MoreOfPhoneNumber extends StatelessWidget {
  final String text;
  final ValueChanged<String> onSelected;

  const MoreOfPhoneNumber({
    super.key,
    required this.text,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            cubit.selectedNumber,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          PopupMenuButton<String>(
            color: Colors.white,
            icon: const Icon(
              Icons.arrow_drop_down_sharp,
            ),
            onSelected: (value) {
              cubit.chooseNumber(value);
              onSelected(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "+93", child: Text("Afghanistan")),
              const PopupMenuItem(value: "+355", child: Text("Albania")),
              const PopupMenuItem(value: "+213", child: Text("Algeria")),
              const PopupMenuItem(
                  value: "+1-268", child: Text("Antigua and Barbuda")),
              const PopupMenuItem(value: "+54", child: Text("Argentina")),
              const PopupMenuItem(value: "+374", child: Text("Armenia")),
              const PopupMenuItem(value: "+61", child: Text("Australia")),
              const PopupMenuItem(value: "+43", child: Text("Austria")),
              const PopupMenuItem(value: "+994", child: Text("Azerbaijan")),
              const PopupMenuItem(value: "+973", child: Text("Bahrain")),
              const PopupMenuItem(value: "+880", child: Text("Bangladesh")),
              const PopupMenuItem(value: "+1-246", child: Text("Barbados")),
              const PopupMenuItem(value: "+375", child: Text("Belarus")),
              const PopupMenuItem(value: "+32", child: Text("Belgium")),
              const PopupMenuItem(value: "+501", child: Text("Belize")),
              const PopupMenuItem(value: "+229", child: Text("Benin")),
              const PopupMenuItem(value: "+975", child: Text("Bhutan")),
              const PopupMenuItem(value: "+591", child: Text("Bolivia")),
              const PopupMenuItem(
                  value: "+387", child: Text("Bosnia and Herzegovina")),
              const PopupMenuItem(value: "+267", child: Text("Botswana")),
              const PopupMenuItem(value: "+55", child: Text("Brazil")),
              const PopupMenuItem(value: "+673", child: Text("Brunei")),
              const PopupMenuItem(value: "+359", child: Text("Bulgaria")),
              const PopupMenuItem(value: "+226", child: Text("Burkina Faso")),
              const PopupMenuItem(value: "+257", child: Text("Burundi")),
              const PopupMenuItem(value: "+855", child: Text("Cambodia")),
              const PopupMenuItem(value: "+237", child: Text("Cameroon")),
              const PopupMenuItem(value: "+1", child: Text("Canada")),
              const PopupMenuItem(value: "+238", child: Text("Cape Verde")),
              const PopupMenuItem(
                  value: "+236", child: Text("Central African Republic")),
              const PopupMenuItem(value: "+235", child: Text("Chad")),
              const PopupMenuItem(value: "+56", child: Text("Chile")),
              const PopupMenuItem(value: "+86", child: Text("China")),
              const PopupMenuItem(value: "+57", child: Text("Colombia")),
              const PopupMenuItem(value: "+269", child: Text("Comoros")),
              const PopupMenuItem(value: "+242", child: Text("Congo")),
              const PopupMenuItem(
                  value: "+243", child: Text("Congo, Democratic Republic")),
              const PopupMenuItem(value: "+506", child: Text("Costa Rica")),
              const PopupMenuItem(value: "+385", child: Text("Croatia")),
              const PopupMenuItem(value: "+53", child: Text("Cuba")),
              const PopupMenuItem(value: "+357", child: Text("Cyprus")),
              const PopupMenuItem(value: "+420", child: Text("Czech Republic")),
              const PopupMenuItem(value: "+45", child: Text("Denmark")),
              const PopupMenuItem(value: "+20", child: Text("Egypt")),
              const PopupMenuItem(value: "+33", child: Text("France")),
              const PopupMenuItem(value: "+49", child: Text("Germany")),
              const PopupMenuItem(value: "+91", child: Text("India")),
              const PopupMenuItem(value: "+62", child: Text("Indonesia")),
              const PopupMenuItem(value: "+98", child: Text("Iran")),
              const PopupMenuItem(value: "+964", child: Text("Iraq")),
              const PopupMenuItem(value: "+972", child: Text("Israel")),
              const PopupMenuItem(value: "+39", child: Text("Italy")),
              const PopupMenuItem(value: "+81", child: Text("Japan")),
              const PopupMenuItem(value: "+962", child: Text("Jordan")),
              const PopupMenuItem(value: "+254", child: Text("Kenya")),
              const PopupMenuItem(value: "+965", child: Text("Kuwait")),
              const PopupMenuItem(value: "+961", child: Text("Lebanon")),
              const PopupMenuItem(value: "+218", child: Text("Libya")),
              const PopupMenuItem(value: "+212", child: Text("Morocco")),
              const PopupMenuItem(value: "+31", child: Text("Netherlands")),
              const PopupMenuItem(value: "+234", child: Text("Nigeria")),
              const PopupMenuItem(value: "+968", child: Text("Oman")),
              const PopupMenuItem(value: "+92", child: Text("Pakistan")),
              const PopupMenuItem(value: "+970", child: Text("Palestine")),
              const PopupMenuItem(value: "+351", child: Text("Portugal")),
              const PopupMenuItem(value: "+974", child: Text("Qatar")),
              const PopupMenuItem(value: "+7", child: Text("Russia")),
              const PopupMenuItem(value: "+966", child: Text("Saudi Arabia")),
              const PopupMenuItem(value: "+27", child: Text("South Africa")),
              const PopupMenuItem(value: "+34", child: Text("Spain")),
              const PopupMenuItem(value: "+90", child: Text("Turkey")),
              const PopupMenuItem(value: "+44", child: Text("United Kingdom")),
              const PopupMenuItem(value: "+1", child: Text("United States")),
              const PopupMenuItem(
                  value: "+971", child: Text("United Arab Emirates")),
            ],
          ),
        ],
      ),
    );
  }
}
