<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${msg("loginTitle",(realm.displayName!''))}</title>
  <link rel="stylesheet" href="${url.resourcesPath}/css/sakura-theme.css">
</head>
<body>

<div id="sakura-branding">
  <span class="brand-main">miyazakitakara</span>
  <span class="brand-sub">技術ノート</span>
</div>

<div id="side-label">技術ノート</div>

<canvas id="sakura-canvas" aria-hidden="true"></canvas>
<img id="fuji-bg" src="${url.resourcesPath}/img/fuji.svg" alt="" aria-hidden="true">

<div id="page-wrap">

  <div id="login-card">
    <h1 id="login-title" aria-hidden="true">${msg("loginAccountTitle")}</h1>

    <#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
      <div class="alert alert-${message.type}">${kcSanitize(message.summary)?no_esc}</div>
    </#if>

    <#if realm.password>
    <form id="kc-form-login" action="${url.loginAction}" method="post"
          onsubmit="document.getElementById('kc-login').disabled=true;return true;">

      <#if !usernameHidden??>
      <div class="field">
        <label for="username" aria-hidden="true">
          <#if !realm.loginWithEmailAllowed>${msg("username")}
          <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}
          <#else>${msg("email")}</#if>
        </label>
        <input id="username" name="username" type="text"
               value="${(login.username!'')}"
               placeholder="${msg('username')}"
               autofocus autocomplete="off">
      </div>
      </#if>

      <div class="field">
        <label for="password" aria-hidden="true">${msg("password")}</label>
        <input id="password" name="password" type="password"
               placeholder="${msg('password')}"
               autocomplete="current-password">
      </div>

      <#if messagesPerField.existsError('username','password')>
        <div class="alert alert-error">${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}</div>
      </#if>

      <div class="form-row">
        <#if realm.rememberMe && !usernameHidden??>
          <label class="checkbox-label">
            <input type="checkbox" id="rememberMe" name="rememberMe"
              <#if login.rememberMe??>checked</#if>>
            ${msg("rememberMe")}
          </label>
        </#if>
        <#if realm.resetPasswordAllowed>
          <a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
        </#if>
      </div>

      <input type="hidden" name="credentialId"
        <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>>

      <input type="submit" id="kc-login" value="${msg('doLogIn')}">
    </form>
    </#if>

    <#if realm.password && social.providers??>
      <div class="social-divider"><span>${msg("identity-provider-login-label")}</span></div>
      <div id="kc-social-providers">
        <#list social.providers as p>
          <a href="${p.loginUrl}" class="social-btn" id="social-${p.alias}">
            <span>${p.displayName}</span>
          </a>
        </#list>
      </div>
    </#if>

    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
      <div class="register-row">
        ${msg("noAccount")} <a href="${url.registrationUrl}">${msg("doRegister")}</a>
      </div>
    </#if>
  </div>

  <div id="quote-card" aria-hidden="true">
    <div class="quote-content">
      <p class="quote-jp"></p>
      <p class="quote-en"></p>
      <p class="quote-author"></p>
      <a class="quote-source" target="_blank" rel="noopener">Wikipedia ↗</a>
    </div>
  </div>

</div>

<script>
var QUOTES = [
  {
    jp: "願わくは花の下にて春死なむその如月の望月のころ",
    en: "\u201cWould that I might die beneath the cherry blossoms in spring, around that full moon of February.\u201d",
    author: "\u897f行法師 / Saig\u014d H\u014dshi (1118\u20131190)",
    url: "https://en.wikipedia.org/wiki/Saigyo"
  },
  {
    jp: "花の雲鐘は上野か浅草か",
    en: "\u201cA cloud of cherry blossoms \u2014 the temple bell, is it Ueno, is it Asakusa?\u201d",
    author: "\u677e尾芭蕉 / Matsuo Bash\u014d (1644\u20131694)",
    url: "https://en.wikipedia.org/wiki/Matsuo_Bash%C5%8D"
  },
  {
    jp: "花の陰 見知らぬ人も なかりけり",
    en: "\u201cIn the cherry blossom\u2019s shade, there is no such thing as a stranger.\u201d",
    author: "\u5c0f林一茹 / Kobayashi Issa (1763\u20131828)",
    url: "https://en.wikipedia.org/wiki/Kobayashi_Issa"
  },
  {
    jp: "不思議やな 生きて桜の 花の下",
    en: "\u201cWhat a strange thing! To be alive beneath cherry blossoms.\u201d",
    author: "\u5c0f林一茹 / Kobayashi Issa (1763\u20131828)",
    url: "https://en.wikipedia.org/wiki/Kobayashi_Issa"
  },
  {
    jp: "花はさかりに、月はくまなきをのみ見るものかは。",
    en: "\u201cAre flowers worth seeing only when in full bloom, and the moon only when it is cloudless?\u201d",
    author: "\u5409田兼好 / Yoshida Kenk\u014d (1283\u20131352)",
    url: "https://en.wikipedia.org/wiki/Yoshida_Kenk%C5%8D"
  }
];
var q = QUOTES[Math.floor(Math.random() * QUOTES.length)];
document.querySelector('.quote-jp').textContent = q.jp;
document.querySelector('.quote-en').textContent = q.en;
document.querySelector('.quote-author').textContent = q.author;
var src = document.querySelector('.quote-source');
src.href = q.url;
</script>
<script src="${url.resourcesPath}/js/sakura.js"></script>
</body>
</html>
