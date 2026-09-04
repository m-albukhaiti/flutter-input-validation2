# Flutter Input Validation

هذا المشروع مجهز للعمل من الهاتف فقط.

بعد رفعه إلى GitHub:
1. افتح Settings → Actions → General.
2. تأكد أن GitHub Actions مسموح له بالعمل.
3. افتح Settings → Pages واختر GitHub Actions.
4. افتح Actions وشغل `Prepare Flutter Platforms and Deploy Web`.

الـ workflow يستخدم Flutter الرسمي على خادم GitHub لإنشاء ملفات المنصات داخل المستودع، ثم يبني نسخة Web وينشرها على GitHub Pages.

ملاحظة: إذا كان المستودع يحتوي أصلًا على تغييرات غير متوقعة، راجع التغييرات التي سيضيفها GitHub Actions قبل اعتمادها.
