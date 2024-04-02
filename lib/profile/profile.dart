import 'package:companymanager/data.dart';
import 'package:companymanager/routes.dart';
import 'package:companymanager/services/auth.dart';
import 'package:companymanager/services/models.dart';
import 'package:companymanager/shared/loading.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userContextData = Provider.of<User>(context);

    var sessionUser = AuthService().user;
    if (sessionUser == null) {
      return const LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppRouteLabel.profile),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            width: Sizes.profileImageSize,
            height: Sizes.profileImageSize,
            margin: const EdgeInsets.only(top: Sizes.profileTopMargin),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  sessionUser.photoURL ?? UserProfileFields.defaultProfileImage,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text(UserProfileFields.name),
            subtitle:
                Text(sessionUser.displayName ?? UserProfileFields.anonymous),
          ),
          ListTile(
            title: const Text(UserProfileFields.email),
            subtitle: Text(sessionUser.email ?? UserProfileFields.anonymous),
          ),
          ListTile(
            title: const Text(UserProfileFields.withUsSince),
            subtitle: Text(
              sessionUser.metadata.creationTime?.toLocal().toString() ??
                  UserProfileFields.anonymous,
            ),
          ),
          ListTile(
            title: const Text(UserProfileFields.companiesOwned),
            subtitle: Text(
              userContextData.companies.isNotEmpty == true
                  ? userContextData.companies.length.toString()
                  : FeedbackMessage.userNoCompaniesOwned,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: Sizes.profileTopMargin / 2),
            child: ElevatedButton.icon(
              onPressed: () async {
                await AuthService().signOut();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutePath.home,
                    (route) => false,
                  );
                }
              },
              icon: const Icon(
                FontAwesomeIcons.rightFromBracket,
                size: Sizes.buttonIconSize,
              ),
              label: const Text(ButtonLabels.signOut),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(
                  top: Sizes.buttonPadding,
                  bottom: Sizes.buttonPadding,
                  left: Sizes.buttonPaddingAlternate,
                  right: Sizes.buttonPaddingAlternate,
                ),
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
