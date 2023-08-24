import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/strings.dart';
import '../providers/page.dart';
import '../providers/user.dart';
import '../constants/app_constants.dart';
import 'package:asgardeo_flutter_app/configs/configs.dart' as configs;

class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            IconButton(
              onPressed: () {
                context.read<CurrentPage>().setPageIndex(AppConstants.homePage);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            const Text(Strings.viewProfileTitle, style: TextStyle(fontSize: 30))
          ]),
          const SizedBox(height: 50),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(configs.primaryColor), width: 2.0),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(
                    context.read<User>().photo),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(Strings.firstNameLabel, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(Strings.lastNameLabel, style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(Strings.dOBLabel, style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(Strings.mobileLabel, style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(Strings.countryLabel, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.read<User>().firstName,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          context.read<User>().lastName,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          context.read<User>().dateOfBirth,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          context.read<User>().mobile,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          context.read<User>().country,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Container(
            height: 44.0,
            width: 170.0,
            decoration: BoxDecoration(
                color: const Color(configs.primaryColor),
                borderRadius: BorderRadius.circular(configs.buttonRadius)),
            child: ElevatedButton(
              onPressed: () {
                context.read<CurrentPage>().setPageIndex(AppConstants.editProfilePage);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
              ),
              child: const Text(Strings.editProfileButton, style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 100),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text(Strings.license),
          )
        ],
      ),
    );
  }
}
