<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=false; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div class="custom-login-wrapper">
            <!-- Left Column: Sign In Form -->
            <div class="login-left-col">
                <h1 class="col-title">Inicia Sesión</h1>
                
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        
                        <div class="form-group">
                            <input tabindex="1" id="username" class="form-control" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="off" placeholder="Correo Electrónico" />
                        </div>
                        
                        <div class="form-group">
                            <input tabindex="2" id="password" class="form-control" name="password" type="password" autocomplete="off" placeholder="Contraseña" />
                        </div>
                        
                        <div class="form-bottom-row">
                            <div id="kc-form-buttons">
                                <button tabindex="4" class="btn-custom" name="login" id="kc-login" type="submit">
                                    Ingresar <span class="arrow">&rarr;</span>
                                </button>
                            </div>
                            
                            <div id="kc-form-options">
                                <#if realm.resetPasswordAllowed>
                                    <span class="reset-password"><a tabindex="5" href="${url.loginResetCredentialsUrl}">Forgot your password?</a></span>
                                </#if>
                            </div>
                        </div>

                    </form>
                </#if>
            </div>


        </div>
    </#if>
</@layout.registrationLayout>
