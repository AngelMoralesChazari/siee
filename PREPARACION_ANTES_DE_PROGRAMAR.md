# Guía de preparación antes de programar – App formulario (Flutter + Firebase)

Esta guía contiene **todo lo que debes tener listo** antes de empezar a escribir código. Sigue los pasos en orden.

---

## 1. Instalar Flutter

### 1.1 Descargar e instalar Flutter SDK

1. Ve a: **https://docs.flutter.dev/get-started/install/windows**
2. Descarga el **Flutter SDK** (archivo .zip).
3. Descomprime en una ruta **sin espacios** ni caracteres especiales, por ejemplo:  
   `C:\flutter` o `C:\dev\flutter`
4. **No** lo pongas en `C:\Program Files`.

### 1.2 Añadir Flutter al PATH de Windows

1. Busca en Windows: **“Variables de entorno”**.
2. Abre **“Editar las variables de entorno del sistema”**.
3. En **Variables del sistema**, selecciona **Path** → **Editar**.
4. **Nuevo** → escribe la ruta de la carpeta `flutter\bin`, por ejemplo:  
   `C:\flutter\bin`
5. Acepta en todas las ventanas.

### 1.3 Comprobar la instalación

Abre una **nueva** terminal (PowerShell o CMD) y ejecuta:

```bash
flutter doctor
```

Revisa que no haya errores críticos. Es normal que pida aceptar licencias de Android:

```bash
flutter doctor --android-licenses
```

Responde `y` donde pregunte. Cuando termines, vuelve a ejecutar:

```bash
flutter doctor
```

Debe mostrar al menos:

- ✓ Flutter
- ✓ Windows Version
- ✓ Android toolchain (si vas a probar en Android)
- ✓ Chrome (opcional, para web)

---

## 2. Configurar el entorno para desarrollo Android (recomendado para app móvil)

### 2.1 Android Studio

1. Descarga: **https://developer.android.com/studio**
2. Instala Android Studio.
3. Abre Android Studio → **More Actions** → **SDK Manager**.
4. En **SDK Platforms**: marca la última versión estable de **Android** (por ejemplo Android 14).
5. En **SDK Tools**: asegúrate de tener:
   - Android SDK Build-Tools
   - Android SDK Command-line Tools
   - Android SDK Platform-Tools
   - Android Emulator
   - (Opcional) Intel/AMD HAXM o Hyper-V si quieres emulador rápido.

### 2.2 Aceptar licencias y verificar

En terminal:

```bash
flutter doctor --android-licenses
flutter doctor
```

Si usas **emulador**:

1. En Android Studio: **Device Manager** (o Tools → Device Manager).
2. Crea un dispositivo virtual (AVD) con una imagen del sistema.
3. Inícialo y luego en terminal: `flutter devices` (debe aparecer el emulador).

Si vas a usar **tu teléfono físico**:

1. Activa **Opciones de desarrollador** y **Depuración USB** en el móvil.
2. Conéctalo por USB.
3. `flutter devices` debe listar el dispositivo.

---

## 3. Crear y configurar el proyecto en Firebase

### 3.1 Cuenta de Google / Firebase

1. Entra en **https://console.firebase.google.com**
2. Inicia sesión con tu cuenta de Google.
3. Si es la primera vez, acepta los términos de Firebase.

### 3.2 Crear un proyecto Firebase

1. **“Agregar proyecto”** (o “Create a project”).
2. Nombre del proyecto, por ejemplo: **siee-formulario** (o el que prefieras).
3. Si te pregunta por Google Analytics, puedes activarlo o desactivarlo.
4. Espera a que se cree el proyecto.

### 3.3 Añadir una app Android al proyecto

1. En la página principal del proyecto Firebase, haz clic en el icono **Android**.
2. **Nombre del paquete Android**: debe ser único. Ejemplo:  
   `com.tudominio.siee` o `com.siee.formulario`
   - Este mismo valor lo usarás al crear el proyecto Flutter (y en `android/app/build.gradle`).
3. (Opcional) Apodo de la app y SHA-1 si más adelante usas login con Google.
4. **Registrar app**.
5. Descarga el archivo **google-services.json** y **guárdalo**; lo colocarás en la carpeta `android/app/` del proyecto Flutter cuando lo creemos.

### 3.4 Activar Firebase Realtime Database

1. En el menú lateral de Firebase Console: **Build** → **Realtime Database**.
2. **Crear base de datos**.
3. Elige la ubicación (por ejemplo `us-central1` o la más cercana).
4. En **Reglas de seguridad**:
   - Para **empezar en desarrollo** puedes usar reglas que permitan lectura/escritura solo si el usuario está autenticado, o temporalmente “solo para pruebas” (luego las endurecerás):

   **Solo desarrollo/pruebas (no producción):**
   ```json
   {
     "rules": {
       ".read": true,
       ".write": true
     }
   }
   ```
   - Para **producción** deberás restringir `.read` y `.write` (por ejemplo con `auth != null` y estructura de datos).

5. Guarda las reglas. Anota la **URL de la base de datos** (algo como `https://tu-proyecto-default-rtdb.firebaseio.com`); la usarás en Flutter.

---

## 4. Herramientas recomendadas en tu PC

- **Editor**: Visual Studio Code o Android Studio (o Cursor, que ya usas).
- **Extensiones en VS Code/Cursor**:
  - **Flutter**
  - **Dart**
  - (Opcional) **Firebase** si hay extensión disponible para tu editor.

---

## 5. Resumen de comprobaciones antes de decir “ya tengo todo”

Marca cada punto cuando lo tengas:

- [ ] **Flutter instalado** y `flutter doctor` sin errores críticos.
- [ ] **Android Studio** instalado (o al menos SDK + herramientas de línea de comandos).
- [ ] **Emulador Android** creado y probado, **o** teléfono físico con depuración USB listo.
- [ ] **Cuenta Firebase** y **proyecto** creados.
- [ ] **App Android** registrada en Firebase y **google-services.json** descargado (lo pondremos en el proyecto cuando lo creemos).
- [ ] **Realtime Database** creada y **URL** anotada.
- [ ] **Reglas de Realtime Database** configuradas (aunque sea temporales para desarrollo).

---

## 6. Sobre el formulario (PDF)

Los apartados y campos de la app serán **exactamente los del documento PDF** que está en la carpeta del proyecto. Como no se puede leer el PDF desde aquí, cuando estés listo para programar:

- Abre el PDF y **lista todos los apartados y campos** (por ejemplo: “Nombre del inmueble”, “Calle y número”, etc.), o
- Copia/pega aquí el texto de las secciones del formulario.

Con esa lista se creará la estructura de pantallas y campos en Flutter y el modelo de datos para Firebase Realtime Database.

---

## 7. Próximo paso

Cuando hayas completado todos los puntos de la sección 5 y tengas a mano:

1. El archivo **google-services.json**.
2. La **URL** de tu Realtime Database.
3. El **nombre del paquete Android** que registraste (ej. `com.tudominio.siee`).

Escribe algo como: **“Ya tengo todo”** (o “listo para empezar”) y, si puedes, pega también la lista de apartados y campos del PDF. A partir de ahí se te dará la estructura del proyecto y el código inicial de la app (Flutter + Firebase Realtime Database).
