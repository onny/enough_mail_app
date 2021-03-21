import 'package:flutter/material.dart';
import 'package:enough_mail_app/models/settings.dart';
import 'package:enough_mail_app/services/alert_service.dart';
import 'package:enough_mail_app/services/navigation_service.dart';
import 'package:enough_mail_app/services/settings_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../locator.dart';
import '../routes.dart';
import 'base.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings settings;
  bool blockExternalImages;

  @override
  void initState() {
    settings = locator<SettingsService>().settings;
    blockExternalImages = settings.blockExternalImages;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Base.buildAppChrome(
      context,
      title: localizations.settingsTitle,
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: blockExternalImages,
                    onChanged: (value) async {
                      setState(() {
                        blockExternalImages = value;
                      });
                      settings.blockExternalImages = value;
                      await locator<SettingsService>().save();
                    },
                  ),
                  Text(localizations.settingsSecurityBlockExternalImages),
                ],
              ),
              Divider(),
              ListTile(
                title: Text(localizations.settingsActionAccounts),
                onTap: () {
                  locator<NavigationService>().push(Routes.settingsAccounts);
                },
              ),
              ListTile(
                title: Text(localizations.settingsActionDesign),
                onTap: () {
                  locator<NavigationService>().push(Routes.settingsDesign);
                },
              ),
              Divider(),
              ListTile(
                title: Text(localizations.settingsActionFeedback),
                onTap: () {
                  locator<NavigationService>().push(Routes.settingsFeedback);
                },
              ),
              ListTile(
                onTap: () {
                  locator<AlertService>().showAbout(context);
                },
                title: Text(localizations.drawerEntryAbout),
              ),
              ListTile(
                onTap: () {
                  locator<NavigationService>().push(Routes.welcome);
                },
                title: Text(localizations.settingsActionWelcome),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
