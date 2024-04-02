import 'package:companymanager/companies/company_create_update_state.dart';
import 'package:companymanager/data.dart';
import 'package:companymanager/routes.dart';
import 'package:companymanager/services/auth.dart';
import 'package:companymanager/services/firestore.dart';
import 'package:companymanager/services/models.dart' hide User;
import 'package:companymanager/shared/progress_bar.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CompanyCreateUpdateScreen extends StatelessWidget {
  final Company? initialState;
  const CompanyCreateUpdateScreen({super.key, this.initialState});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CompanyCreateUpdateState(initialState: initialState),
      builder: (context, _) {
        var state = Provider.of<CompanyCreateUpdateState>(context);
        return Scaffold(
          appBar: AppBar(
            title: AnimatedProgressBar(value: state.progress),
            leading: IconButton(
              icon: const Icon(FontAwesomeIcons.xmark),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: state.controller,
            onPageChanged: (int index) {
              state.progress = (index / (companyFormSteps.length));
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                if (initialState != null) {
                  return CompanyAddFormScreen(stepIndex: index + 1);
                } else {
                  return const StartPageScreen();
                }
              } else if (index == companyFormSteps.length) {
                return const FinishCompanyAddScreen();
              } else {
                return CompanyAddFormScreen(stepIndex: index);
              }
            },
          ),
        );
      },
    );
  }
}

class StartPageScreen extends StatelessWidget {
  const StartPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<CompanyCreateUpdateState>(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(Sizes.formAddScreenContainerPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...companyAddScreenParagraphs.map((paragraph) {
              return Padding(
                padding: const EdgeInsets.all(
                    Sizes.companyAddScreenParagraphPadding),
                child: Text(paragraph),
              );
            }),
            const Divider(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: state.nextPage,
                  icon: const Icon(FontAwesomeIcons.arrowRight),
                  label: const Text(ButtonLabels.start),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CompanyAddFormScreen extends StatelessWidget {
  final int stepIndex;

  const CompanyAddFormScreen({super.key, required this.stepIndex});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<CompanyCreateUpdateState>(context);
    return Form(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.formAddScreenContainerPadding),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    companyAddStepTitles[stepIndex - 1],
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                ],
              ),
              ...companyFormSteps[stepIndex].map((field) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: Sizes.formFieldContainerPadding,
                    bottom: Sizes.formFieldContainerPadding,
                  ),
                  child: TextFormField(
                    initialValue: state.company.getCommonField(field) ?? '',
                    decoration: InputDecoration(
                      labelText: companyAddFieldsTranslationMap[field],
                      filled: true,
                      hintText: companyAddFieldsPlaceholders[field],
                    ),
                    onChanged: (value) {
                      state.setCompanyField(field, value);
                    },
                  ),
                );
              }),
              const Divider(),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: state.previousPage,
                    icon: const Icon(FontAwesomeIcons.arrowLeft),
                    label: const Text(ButtonLabels.previous),
                  ),
                  ElevatedButton.icon(
                    onPressed: state.nextPage,
                    icon: const Icon(FontAwesomeIcons.arrowRight),
                    label: const Text(ButtonLabels.next),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FinishCompanyAddScreen extends StatelessWidget {
  const FinishCompanyAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<CompanyCreateUpdateState>(context);
    var user = AuthService().user;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(Sizes.formAddScreenContainerPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              companyAddFinishTitle,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            const Divider(),
            ...List.from(
              [...companyStepOneFormFields, ...companyStepTwoFormFields],
            ).map((field) {
              if (field == 'image') {
                var image =
                    _parseImage(state.company.getCommonField(field).toString());
                return ListTile(
                  title: Text(companyAddFieldsTranslationMap[field] ?? ''),
                  subtitle: Image.network(image),
                );
              } else {
                return ListTile(
                  title: Text(companyAddFieldsTranslationMap[field] ?? ''),
                  subtitle: Text(state.company.getCommonField(field)),
                );
              }
            }),
            const Divider(),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: state.previousPage,
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                  label: const Text(ButtonLabels.previous),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    FirestoreService().createUpdateCompany(state.company, user);
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutePath.companies, (route) => false);
                  },
                  icon: const Icon(FontAwesomeIcons.check),
                  label: const Text(ButtonLabels.save),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _parseImage(String imageFieldState) {
    final hasCorrectPrefix = ['http://', 'https://']
        .any((prefix) => imageFieldState.startsWith(prefix));
    final hasCorrectSuffix = ['.jpg', '.jpeg', '.png', '.gif']
        .any((suffix) => imageFieldState.endsWith(suffix));

    if (hasCorrectPrefix && hasCorrectSuffix) {
      return imageFieldState;
    } else {
      return UserProfileFields.defaultProfileImage;
    }
  }
}
