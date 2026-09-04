import 'package:flutter/material.dart';

void main() {
  runApp(const ValidationAssignmentApp());
}

class ValidationAssignmentApp extends StatelessWidget {
  const ValidationAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'واجب فلاتر - أدوات الإدخال والتحقق',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
      home: const InputValidationPage(),
    );
  }
}

class InputValidationPage extends StatefulWidget {
  const InputValidationPage({super.key});

  @override
  State<InputValidationPage> createState() => _InputValidationPageState();
}

class _InputValidationPageState extends State<InputValidationPage> {
  final _formKey = GlobalKey<FormState>();

  // 1. TextField - no validation.
  final _normalController = TextEditingController();

  // 2. Email.
  final _emailController = TextEditingController();

  // 3. Phone.
  final _phoneController = TextEditingController();

  // 4. Required field.
  final _requiredController = TextEditingController();

  bool _acceptedTerms = false;
  String? _gender;
  bool _notifications = false;
  double _experience = 5;
  RangeValues _ageRange = const RangeValues(20, 30);
  String? _city;
  String? _language;

  final List<String> _cities = [
    'صنعاء',
    'عدن',
    'تعز',
    'الحديدة',
    'إب',
    'حضرموت',
  ];

  final List<String> _languages = ['العربية', 'الإنجليزية', 'الألمانية'];

  @override
  void dispose() {
    _normalController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _requiredController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      setState(() {});
      return;
    }

    _showSummaryDialog();
  }

  void _reset() {
    _normalController.clear();
    _emailController.clear();
    _phoneController.clear();
    _requiredController.clear();

    setState(() {
      _acceptedTerms = false;
      _gender = null;
      _notifications = false;
      _experience = 5;
      _ageRange = const RangeValues(20, 30);
      _city = null;
      _language = null;
    });

    _formKey.currentState?.reset();
  }

  void _showSummaryDialog() {
    final summary = [
      'الإدخال العادي: ${_normalController.text.isEmpty ? '—' : _normalController.text}',
      'البريد الإلكتروني: ${_emailController.text}',
      'الهاتف: ${_phoneController.text}',
      'الحقل المطلوب: ${_requiredController.text}',
      'الموافقة على الشروط: ${_acceptedTerms ? 'نعم' : 'لا'}',
      'الجنس: $_gender',
      'الإشعارات: ${_notifications ? 'مفعّلة' : 'متوقفة'}',
      'الخبرة: ${_experience.toStringAsFixed(0)} / 10',
      'العمر: ${_ageRange.start.toStringAsFixed(0)} - ${_ageRange.end.toStringAsFixed(0)}',
      'المدينة: $_city',
      'اللغة: $_language',
    ];

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ملخص البيانات'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: summary
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(item),
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 25,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'واجب فلاتر',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: const [
                        Icon(Icons.assignment_turned_in_outlined, size: 48),
                        SizedBox(height: 8),
                        Text(
                          'أدوات الإدخال والتفاعل مع التحقق',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'تطبيق جميع الأدوات المطلوبة باستخدام Form و GlobalKey<FormState>',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                _sectionTitle('1) TextField — إدخال عادي'),
                TextField(
                  controller: _normalController,
                  decoration: _decoration(
                    'الإدخال العادي',
                    Icons.edit_outlined,
                  ),
                ),

                _sectionTitle('2) البريد الإلكتروني'),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _decoration(
                    'البريد الإلكتروني',
                    Icons.email_outlined,
                  ),
                  validator: (value) {
                    return value!.contains('@') ? null : 'بريد غير صحيح';
                  },
                ),

                _sectionTitle('3) الهاتف'),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: _decoration(
                    'رقم الهاتف (10 أرقام)',
                    Icons.phone_outlined,
                  ),
                  validator: (value) {
                    return value!.length == 10 ? null : 'رقم غير صحيح';
                  },
                ),

                _sectionTitle('4) حقل مطلوب'),
                TextFormField(
                  controller: _requiredController,
                  decoration: _decoration(
                    'حقل مطلوب',
                    Icons.star_border_outlined,
                  ),
                  validator: (value) {
                    return value!.isEmpty ? 'مطلوب' : null;
                  },
                ),

                _sectionTitle('5) Checkbox — الموافقة'),
                FormField<bool>(
                  initialValue: _acceptedTerms,
                  validator: (value) {
                    return value == true ? null : 'وافق على الشروط';
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          value: _acceptedTerms,
                          contentPadding: EdgeInsets.zero,
                          title: const Text('أوافق على الشروط والأحكام'),
                          secondary: const Icon(Icons.check_circle_outline),
                          onChanged: (value) {
                            setState(() {
                              _acceptedTerms = value ?? false;
                            });
                            field.didChange(_acceptedTerms);
                          },
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                _sectionTitle('6) Radio — الجنس'),
                FormField<String>(
                  initialValue: _gender,
                  validator: (value) {
                    return value != null ? null : 'اختر الجنس';
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioListTile<String>(
                          title: const Text('ذكر'),
                          value: 'ذكر',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() => _gender = value);
                            field.didChange(value);
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('أنثى'),
                          value: 'أنثى',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() => _gender = value);
                            field.didChange(value);
                          },
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                _sectionTitle('7) Switch — الإشعارات'),
                SwitchListTile(
                  value: _notifications,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('تفعيل الإشعارات'),
                  secondary: const Icon(Icons.notifications_outlined),
                  onChanged: (value) {
                    setState(() => _notifications = value);
                  },
                ),

                _sectionTitle('8) Slider — الخبرة'),
                FormField<double>(
                  initialValue: _experience,
                  validator: (value) {
                    final current = value ?? _experience;
                    return current >= 0 && current <= 10
                        ? null
                        : 'خارج النطاق';
                  },
                  builder: (field) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('سنوات الخبرة'),
                            Text(
                              _experience.toStringAsFixed(0),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: _experience,
                          min: 0,
                          max: 10,
                          divisions: 10,
                          label: _experience.toStringAsFixed(0),
                          onChanged: (value) {
                            setState(() => _experience = value);
                            field.didChange(value);
                          },
                        ),
                        if (field.hasError)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                _sectionTitle('9) RangeSlider — العمر'),
                FormField<RangeValues>(
                  initialValue: _ageRange,
                  validator: (value) {
                    final current = value ?? _ageRange;
                    return current.start < current.end
                        ? null
                        : 'نطاق غير صحيح';
                  },
                  builder: (field) {
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'العمر: ${_ageRange.start.toStringAsFixed(0)} - ${_ageRange.end.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        RangeSlider(
                          values: _ageRange,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          labels: RangeLabels(
                            _ageRange.start.toStringAsFixed(0),
                            _ageRange.end.toStringAsFixed(0),
                          ),
                          onChanged: (values) {
                            setState(() => _ageRange = values);
                            field.didChange(values);
                          },
                        ),
                        if (field.hasError)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                _sectionTitle('10) DropdownButton — المدينة'),
                FormField<String>(
                  initialValue: _city,
                  validator: (value) {
                    return value != null ? null : 'اختر مدينة';
                  },
                  builder: (field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'المدينة',
                        prefixIcon: const Icon(Icons.location_city_outlined),
                        border: const OutlineInputBorder(),
                        errorText: field.errorText,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _city,
                          isExpanded: true,
                          hint: const Text('اختر مدينة'),
                          items: _cities
                              .map(
                                (city) => DropdownMenuItem(
                                  value: city,
                                  child: Text(city),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() => _city = value);
                            field.didChange(value);
                          },
                        ),
                      ),
                    );
                  },
                ),

                _sectionTitle('11) PopupMenuButton — اللغة'),
                FormField<String>(
                  initialValue: _language,
                  validator: (value) {
                    return value != null ? null : 'اختر لغة';
                  },
                  builder: (field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'اللغة',
                        prefixIcon: const Icon(Icons.language_outlined),
                        border: const OutlineInputBorder(),
                        errorText: field.errorText,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _language ?? 'لم يتم اختيار لغة',
                              style: TextStyle(
                                color: _language == null
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant
                                    : null,
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.arrow_drop_down_circle),
                            tooltip: 'اختر اللغة',
                            onSelected: (value) {
                              setState(() => _language = value);
                              field.didChange(value);
                            },
                            itemBuilder: (context) {
                              return _languages
                                  .map(
                                    (language) => PopupMenuItem<String>(
                                      value: language,
                                      child: Text(language),
                                    ),
                                  )
                                  .toList();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _submit,
                        icon: const Icon(Icons.send),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'إرسال',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: _reset,
                        icon: const Icon(Icons.refresh),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'إعادة تعيين',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
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
