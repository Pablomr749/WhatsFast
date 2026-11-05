# WhatsApp Lite — Windows 11 x64

Cliente de escritorio **no oficial** que abre `https://web.whatsapp.com` en una ventana Tauri 2 sobre Microsoft Edge WebView2. El núcleo de la aplicación está escrito en Rust.

## Qué incluye esta primera versión

- WebView2 del sistema; no empaqueta Chromium.
- Sesión persistente mediante el perfil de WebView2/Tauri.
- Bandeja del sistema: clic izquierdo o «Abrir WhatsApp Lite» muestra la ventana.
- Cerrar la ventana la oculta; «Salir» en el menú de bandeja termina la aplicación.
- Instalador NSIS x64.
- Sin analítica, publicidad ni servicios propios en segundo plano.

## Alcance y limitaciones

Esta edición está enfocada a **mensajería**. La disponibilidad de funciones como notificaciones web, micrófono, cámara, llamadas, compartir pantalla o descargas depende de WhatsApp Web, de WebView2 y de los permisos de Windows. No se garantiza paridad absoluta con la aplicación oficial de WhatsApp para Windows.

La aplicación no implementa ni simula la API de WhatsApp: carga el sitio oficial. WhatsApp puede cambiar sus requisitos de navegador o bloquear clientes no oficiales.

## Requisitos para compilar en Windows 11

1. Windows 11 x64.
2. Rust estable (instalado mediante `rustup`).
3. Microsoft C++ Build Tools con **Desktop development with C++**.
4. Microsoft Edge WebView2 Runtime (normalmente ya viene con Windows 11).
5. Conexión a Internet para descargar dependencias de Cargo.

Guía oficial de prerrequisitos: https://v2.tauri.app/start/prerequisites/

## Compilar

Abre PowerShell en la carpeta del proyecto:

```powershell
# Instala el subcomando de Tauri CLI (una sola vez)
cargo install tauri-cli --version "^2" --locked

# Comprueba las herramientas
rustc --version
cargo --version

# Compila y genera el instalador NSIS
cargo tauri build
```

El instalador se genera normalmente en:

```text
src-tauri\target\release\bundle\nsis\
```

Para ejecutar en modo desarrollo:

```powershell
cargo tauri dev
```

## Uso

1. Instala el paquete `*-setup.exe`.
2. Abre WhatsApp Lite.
3. Vincula el dispositivo escaneando el QR de WhatsApp Web.
4. Al cerrar la ventana, la aplicación queda en la bandeja del sistema.
5. Usa el menú de bandeja → **Salir** para cerrar completamente.

## Notas de rendimiento

Tauri/Rust reduce el coste del anfitrión frente a un contenedor Electron, pero el consumo principal seguirá dependiendo del propio WhatsApp Web y del motor Chromium de WebView2. Mantener WhatsApp activo en segundo plano puede seguir consumiendo memoria y CPU para recibir mensajes y mantener la sesión. No se fuerza la suspensión de WebView2 porque podría retrasar notificaciones o actividad de la sesión.

## Seguridad y privacidad

- La autenticación se realiza en el dominio oficial `web.whatsapp.com`.
- No se solicitan credenciales por separado.
- No se añade sincronización propia ni telemetría.
- El perfil local de WebView2 contiene datos de sesión; protege tu cuenta de Windows y no compartas ese perfil.
- Este proyecto no está afiliado, respaldado ni certificado por WhatsApp o Meta.

## Estructura

```text
whatsapp-lite/
├── frontend/
│   └── index.html
├── src-tauri/
│   ├── tauri.conf.json
│   ├── icons/
│   │   └── tray.png
│   └── src/
│       ├── lib.rs
│       └── main.rs
└── README.md
```


## Obtener un instalador sin compilar en tu PC

El proyecto incluye `.github/workflows/build-windows.yml`. Si subes esta carpeta a un repositorio de GitHub:

1. Abre la pestaña **Actions**.
2. Selecciona **Build Windows installer**.
3. Pulsa **Run workflow**.
4. Cuando termine, descarga el artefacto `WhatsApp-Lite-Windows-x64-Installer`.

GitHub compila el instalador en una máquina Windows. El usuario final no necesita Rust ni herramientas de desarrollo. El instalador NSIS está configurado para descargar el instalador de WebView2 si falta.

Para publicar una versión etiquetada, crea y sube una etiqueta como `v0.1.0`; el flujo compilará también el instalador.

**Importante:** el artefacto de GitHub Actions todavía no es una publicación firmada. Windows SmartScreen puede mostrar una advertencia para aplicaciones sin certificado de firma de código. No desactives SmartScreen para instalarlo.
