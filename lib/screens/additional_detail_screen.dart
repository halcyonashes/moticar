import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moticar/bloc/additional_detail_bloc.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  DateTime? _selectedDOB;
  String? _selectedGender;
  String? _selectedCurrency;

  final List<String> _genders = ["Male", "Female", "Other"];
  final List<String> _currencies = ["USD", "EUR", "GBP", "INR"];

  void _pickDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDOB = picked;
      });
      if(context.mounted) {
        context.read<UserDetailsBloc>().add(DOBChanged(picked));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailsBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Enter Your Details")),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 Date of Birth Picker
              ListTile(
                title: Text(
                  _selectedDOB == null
                      ? "Select Date of Birth"
                      : "DOB: ${_selectedDOB!.toLocal()}".split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _pickDOB(context),
              ),

              const SizedBox(height: 20),

              // 🔹 Gender Dropdown
              DropdownButtonFormField<String>(
                value: _selectedGender,
                hint: const Text("Select Gender"),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                  context.read<UserDetailsBloc>().add(GenderChanged(value!));
                },
                items: _genders.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // 🔹 Currency Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCurrency,
                hint: const Text("Select Currency"),
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value;
                  });
                  context.read<UserDetailsBloc>().add(CurrencyChanged(value!));
                },
                items: _currencies.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),

              // 🔹 Submit Button
              BlocBuilder<UserDetailsBloc, UserDetailsState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: (_selectedDOB != null &&
                        _selectedGender != null &&
                        _selectedCurrency != null)
                        ? () {
                      context
                          .read<UserDetailsBloc>()
                          .add(SubmitUserDetails());
                    }
                        : null,
                    child: const Text("Continue"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
