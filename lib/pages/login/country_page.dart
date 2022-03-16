import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mob_whatsapp/pages/login/widgets/selection_option.dart';
import 'controllers/login_controller.dart';
import 'models/country_model.dart';

class CountryPage extends StatefulWidget {
  final List<CountryModel> countries;

  const CountryPage({
    Key? key,
    required this.countries
  }) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final LoginController _loginController = GetIt.I.get<LoginController>();

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget> [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Select Your Country or Region',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SelectionOption(
            country: _loginController.country,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 36),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'MORE COUNTRIES AND REGIONS',
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.countries.length,
              itemBuilder: (BuildContext context, int index) {
                CountryModel country = widget.countries[index];

                return GestureDetector(
                  onTap: () => {
                    _loginController.updateCountry(country),
                    Navigator.pop(context)
                  },
                  child: SelectionOption(
                    country: country
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}