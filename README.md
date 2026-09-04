# Flutter Input Validation Assignment

تطبيق Flutter عملي يطبق جميع أدوات الإدخال والتفاعل المطلوبة مع Validation.

## يحتوي على

1. TextField
2. TextFormField للبريد
3. TextFormField للهاتف
4. TextFormField لحقل مطلوب
5. Checkbox
6. Radio
7. Switch
8. Slider
9. RangeSlider
10. DropdownButton
11. PopupMenuButton

ويستخدم `Form` و `GlobalKey<FormState>` للتحقق من جميع البيانات مرة واحدة.

## تشغيل المشروع محلياً

```bash
flutter pub get
flutter run
```

ولتجربة نسخة الويب:

```bash
flutter run -d chrome
```

## نشر التطبيق على GitHub Pages

تمت إضافة GitHub Actions في:

`.github/workflows/deploy-pages.yml`

بعد رفع المشروع إلى مستودع GitHub:

1. اجعل اسم الفرع الرئيسي `main`.
2. ادخل إلى:
   **Settings → Pages**
3. في **Build and deployment** اختر:
   **Source: GitHub Actions**
4. ادخل إلى تبويب **Actions** وانتظر انتهاء عملية `Deploy Flutter Web to GitHub Pages`.
5. بعد نجاحها سيظهر رابط الموقع في:
   **Settings → Pages**

سيكون الرابط بالشكل:

`https://USERNAME.github.io/REPOSITORY-NAME/`

استبدل `USERNAME` باسم حساب GitHub و`REPOSITORY-NAME` باسم المستودع.

> ملاحظة: لا تحتاج إلى تعديل `base-href` يدوياً؛ ملف GitHub Actions يضبطه تلقائياً حسب اسم المستودع.
