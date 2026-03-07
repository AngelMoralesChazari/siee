# Configuración de Firebase para SIEE Formulario

## 1. Archivo `google-services.json`

- Descárgalo desde la consola de Firebase (tu proyecto → Configuración del proyecto → Tus apps → Android).
- **Cópialo** en: `android/app/google-services.json`

Si el paquete de tu app en Firebase es distinto a `com.siee.siee_formulario`, regístra la app Android en Firebase con ese applicationId o cambia `applicationId` en `android/app/build.gradle.kts` para que coincida con el que tienes en Firebase.

## 2. Opciones de Firebase en Flutter (`firebase_options.dart`)

Tienes dos opciones:

### Opción A – FlutterFire CLI (recomendado)

En la raíz del proyecto:

```bash
dart run flutterfire_cli:flutterfire configure
```

Inicia sesión en Firebase si lo pide y selecciona tu proyecto. Se generará `lib/firebase_options.dart` con los valores correctos.

### Opción B – Manual

Abre `lib/firebase_options.dart` y sustituye los placeholders por los datos de tu proyecto Firebase (API Key, App ID, Project ID, Database URL, etc.) desde la consola de Firebase.

## 3. Realtime Database

En Firebase Console → Realtime Database, crea la base de datos si no existe. La URL (por ejemplo `https://tu-proyecto-default-rtdb.firebaseio.com`) debe coincidir con la que uses en `firebase_options.dart` (campo `databaseURL`).

## 4. Probar la app

```bash
flutter pub get
flutter run
```

Elige un dispositivo Android (emulador o teléfono por USB).
