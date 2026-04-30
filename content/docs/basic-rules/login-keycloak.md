---
title: Acceso Seguro con Keycloak
category: Documentation
star: 9
sticky: 9
article: false
author: Jesús Albujas
---

Keycloak es una plataforma de código abierto que proporciona servicios de gestión de identidades y accesos, facilitando la autenticación y autorización en aplicaciones y servicios. Su propósito es garantizar un acceso seguro y controlado a recursos digitales, ofreciendo una solución integral para la gestión de identidades, single sign-on (SSO) y la federación de identidades.

**ERP Consultores y Asociados** ha decidido implementar Keycloak como parte de su infraestructura tecnológica para aprovechar los beneficios significativos que esta herramienta aporta a la gestión de identidades y accesos.

Si tu servicio tiene habilitado autenticación en dos pasos haz [clic aquí](/docs/basic-rules/login-2fa/)

---

Ingrese al servicio de ADempiere. En la zona inferior verá **Acceder con Keycloak**

![ADempiere](/docs-assets/291b156c-b169-474a-b444-c120619c2711.png)

## Acceder a tu cuenta

Lo redireccionará a la siguiente página. Donde debe ingresar:

- **Usuario o  Email** suminsitrado por el **Agente de Atención al Cliente**.

- **Contraseña** suminsitrada por el **Agente de Atención al Cliente**.

![image](/docs-assets/36baa53f-3b7a-4a05-9fc9-9e0fcccb87ae.png)

## Configuración de tu aplicación de identificación móvil

Posteriormente de haber ingresado los datos suminstrados, será redirigido al siguiente apartado.

![Configuración](/docs-assets/8fc5bd3f-49c2-4397-9d57-af64c5d4279f.png)

Donde usted debe descargar una de las aplicaciones sugeridas en su teléfono móvil para realizar el escaneo al código QR. Puede instalarlas haciendo click en uno de ellos:

- [**Google Authenticator**](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=es_VE&gl=US)

- [**Microsoft Authenticator**](https://play.google.com/store/search?q=microsoft+authenticator&c=apps&hl=es_VE&gl=US)

- [**FreeOTP**](https://play.google.com/store/search?q=Freeotp&c=apps&hl=es_VE&gl=US)

---

Una vez instalada la aplicación, escanee el código QR.

Luego de haber escaneado este le dejará un código de 6 cifras. **Importante**: debe ingresar el código antes de que caduque, si observa en la aplicación instalada en su teléfono móvil para obtener el código o si usted instaló el complemento [**Authenticator**](/docs/basic-rules/login-2fa/) en su navegador , tiene temporizador, debe ingresar el código antes de que este caduque.

Copie el código donde le indica **Keycloak**.

![Código](/docs-assets/6605b6fc-994c-49f3-a845-d8fb8430ec79.jpg)

## Modificar la contraseña

Ahora deberá modificar su contraseña inicial.

![Modificar](/docs-assets/63efef69-7d87-4e68-93cb-5fdbdd7fc70a.png)

Por otro lado, te solicitará que verifiques el correo electrónico.

![verificar-email](/docs-assets/1f21226f-c5aa-4519-9815-100db9fe888a.png)

Deberas ir a tu correo electrónico y seguir el enlace.

![gmail](/docs-assets/64f1d259-c5ff-4f88-a048-b33088c06b42.png)

El enlace te llevará a Keycloak, donde te estará confirmando la dirección de correo electrónico, haces **click para seguir**.

![confirmar](/docs-assets/f583bfd6-c026-4767-baaa-effb36eedd27.png)

Posteriormente, tu correo ya habrá sido confirmado.

![confirmado](/docs-assets/1644800e-b6b1-49a9-88dd-54df1bc98481.png)

Ahora bien, luego de haber realizado este proceso usted deberá actualizar la página y será redirigido hasta ADempiere, donde ingresará normalmente.
