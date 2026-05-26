<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <div class="custom-login-wrapper register-wrapper">
            <div class="register-col">
                <h1 class="col-title">Crear una Cuenta</h1>
                
                <form id="kc-register-form" class="form register-form" action="${url.registrationAction}" method="post">
                    
                    <#if message?has_content && message.type == 'error' && !messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm')>
                        <div class="form-group" style="color: #ffb4ab; font-size: 0.875rem; margin-top: 0; margin-bottom: 1rem;">
                            <span class="error-text" aria-live="polite">
                                ${kcSanitize(message.summary)?no_esc}
                            </span>
                        </div>
                    </#if>

                    <div class="form-row">
                        <div class="form-group half-width">
                            <input type="text" id="firstName" class="form-control" name="firstName" value="${(register.formData.firstName!'')}" autocomplete="given-name" placeholder="Nombre" />
                            <#if messagesPerField.existsError('firstName')>
                                <span style="color: #ffb4ab; font-size: 0.75rem;">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</span>
                            </#if>
                        </div>
                        <div class="form-group half-width">
                            <input type="text" id="lastName" class="form-control" name="lastName" value="${(register.formData.lastName!'')}" autocomplete="family-name" placeholder="Apellido" />
                            <#if messagesPerField.existsError('lastName')>
                                <span style="color: #ffb4ab; font-size: 0.75rem;">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</span>
                            </#if>
                        </div>
                    </div>

                    <div class="form-group">
                        <input type="text" id="email" class="form-control" name="email" value="${(register.formData.email!'')}" autocomplete="email" placeholder="Correo Electrónico" />
                        <#if messagesPerField.existsError('email')>
                            <span style="color: #ffb4ab; font-size: 0.75rem;">${kcSanitize(messagesPerField.get('email'))?no_esc}</span>
                        </#if>
                    </div>

                    <#if !realm.registrationEmailAsUsername>
                        <div class="form-group">
                            <input type="text" id="username" class="form-control" name="username" value="${(register.formData.username!'')}" autocomplete="username" placeholder="Nombre de Usuario" />
                            <#if messagesPerField.existsError('username')>
                                <span style="color: #ffb4ab; font-size: 0.75rem;">${kcSanitize(messagesPerField.get('username'))?no_esc}</span>
                            </#if>
                        </div>
                    </#if>

                    <#if passwordRequired??>
                        <div class="form-group">
                            <input type="password" id="password" class="form-control" name="password" autocomplete="new-password" placeholder="Contraseña" />
                            <#if messagesPerField.existsError('password')>
                                <span style="color: #ffb4ab; font-size: 0.75rem;">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
                            </#if>
                        </div>

                        <div class="form-group">
                            <input type="password" id="password-confirm" class="form-control" name="password-confirm" autocomplete="new-password" placeholder="Confirmar Contraseña" />
                            <#if messagesPerField.existsError('password-confirm')>
                                <span style="color: #ffb4ab; font-size: 0.75rem;">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
                            </#if>
                        </div>
                    </#if>

                    <#if recaptchaRequired??>
                        <div class="form-group">
                            <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                        </div>
                    </#if>

                    <div class="form-bottom-row register-bottom-row">
                        <div id="kc-form-options">
                            <span class="reset-password"><a href="${url.loginUrl}">&larr; Volver al Login</a></span>
                        </div>
                        <div id="kc-form-buttons">
                            <button class="btn-custom" type="submit" name="register" id="kc-register">
                                Registrarse <span class="arrow">&rarr;</span>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
