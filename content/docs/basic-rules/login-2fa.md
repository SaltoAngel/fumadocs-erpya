---
title: Keycloak con Autenticación 2FA
role: public
category: Documentation
star: 9
sticky: 9
article: false
author: Jesús Albujas
---

## ¿Experimentas dificultades al intentar iniciar sesión? ¿No dispones de un dispositivo móvil?

¡No te preocupes! En ERP, fomentamos un proceso seguro para iniciar sesión. Puedes instalar una variedad de aplicaciones en tu teléfono móvil ya sea **Google Authenticator**, **FreeOTP** o **Microsoft Authenticator** o una extensión en tu navegador **Google Chrome** para facilitar este proceso.

1. Abre Google Chrome y dirígete a la **Chrome Web Store**.

![Buscar](/docs-assets/e79da902-dbec-4d53-bea0-d035bcf2f4a9.png)

2. En la barra de búsqueda, introduce **Authenticator**.

![Chrome Web Store](/docs-assets/b3e6b52e-cc3f-49d5-8518-0b94824895ea.png)

En caso de no encontrar dicha extensión, debes buscar específicamente la siguiente:

![Authenticator](/docs-assets/9f109193-379c-48e1-bba9-81b700e5d48f.png)

Posteriormente, haz clic en **Añadir a Chrome** para instalar la extensión.

![Añadir a Chrome](/docs-assets/44a2e996-f066-4833-8e9b-ed18b3740f1a.png)

Te solicitará permisos para agregar la extensión a Chrome. Selecciona **Add extension** (Agregar extensión).

![Agregar Extensión](/docs-assets/2d51b163-1299-4567-944b-fbabb0129c57.png)

En tu navegador, encontrarás un icono de rompecabezas. Allí se encuentran las extensiones instaladas.

![Extensiones](/docs-assets/a76639a1-db00-49c3-9953-f3e8a9a04701.png)

Ahora, en lugar de escanear con un dispositivo móvil, se usará la extensión.

![Configuración](/docs-assets/8fc5bd3f-49c2-4397-9d57-af64c5d4279f.png)

Para ello, dirigete a tus extensiones > **Selecciona Authenticator**

![Extensión](/docs-assets/8ddbd759-b4e9-4b74-a79a-cac06f779ca4.png)

Selecciona el icono de escáner.

![Escanear](/docs-assets/a4817b58-984c-4beb-98d7-7ddd33b90218.png)

Con el mouse dibuja la zona del **QR**

![QR](/docs-assets/2d4f33f9-ea4d-4086-be29-0bafe0cd8576.png)

Te mostrará una ventana indicando, que ha sido agregado satisfactoriamente.

![Mensaje](/docs-assets/fa1927ce-b470-471d-b48f-7ab386f7aa4e.png)

Vuelve a buscar la extensión.

![Seleccionar Extensión](/docs-assets/8ddbd759-b4e9-4b74-a79a-cac06f779ca4.png)

Copia el código en Keycloak y realiza el paso de [Modificar contraseña](http://docs.erpya.com/docs/basic-rules/login-keycloak.html#modificar-la-contrasena)

![image](/docs-assets/c45577eb-dba2-496e-8224-b262750dd468.png)
