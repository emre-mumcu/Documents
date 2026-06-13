

# Google external login setup in ASP.NET Core

## Create the app in Google

* Navigate to the [Google API & Services](https://console.cloud.google.com/apis) page of the Google Cloud platform.
* If no project exists, create a new project by selecting the Create Project button. To select a different project than an existing project that loads, select the loaded project's button in the top-left corner of the UI, followed by the project. To add a new project, select the loaded project's button in the top-left corner of the UI, followed by the New project button.
* When creating a new project:
	- Enter a Project name.
	- Optionally, select an Organization for the project.
	- Select the Create button.

After creating the project, the Dashboard page of the project loads, where it's possible to configure the project.

Open the Credentials tab to create the OAuth client.

The prerequisite to creating the credentials is to configure the OAuth consent screen. If the consent isn't configured, there's a prompt to configure the consent screen.

* Select Configure consent screen or select OAuth consent screen in the sidebar.
* In the OAuth consent screen, select Get started.
* Set the App name and User support email.
* Set the audience type to External.
* Add Contact information by entering a contact email address.
* Agree to the terms.
* Select Create.

Create the client credentials for the app by opening the Clients sidebar menu item:

* Select the Create client button.
* Select Web application as the Application type.
* Enter a Name for the client.
* Add an Authorized redirect URI. For local testing, use the default address https://localhost:{PORT}/signin-google, where the {PORT} placeholder is the app's port.
* Select the Create button to create the client.
* Save the Client ID and Client secret, which are used later in the ASP.NET app configuration.

**Note**

The URI segment /signin-google is set as the default callback of the Google authentication provider. It's possible to change the default callback URI while configuring the Google authentication middleware via the inherited RemoteAuthenticationOptions.CallbackPath property.

When deploying the app, either:

* Update the app's redirect URI in the Google Console to the app's deployed redirect URI.
* Create a new Google API registration in the Google Console for the production app with its production redirect URI.

## Create a new Web Application

Create a new folder for your application and run the following command:

```bash
dotnet new web
```

Open the newly created application in VS Code: code .

### Store the Google client ID and secret

Store sensitive settings, such as the Google client ID and secret values, with Secret Manager.

1. Initialize the project for secret storage:

	The Secret Manager tool hides implementation details, such as where and how the values are stored. You can use the tool without knowing these implementation details. The values are stored in a JSON file in the local machine's user profile folder:

	%APPDATA%\Microsoft\UserSecrets\<user_secrets_id>\secrets.json

	Enable secret storage:

	dotnet user-secrets init

	The preceding command adds a UserSecretsId element within a PropertyGroup of the project file. By default, the inner text of UserSecretsId is a GUID. The inner text is arbitrary, but is unique to the project.

2. Store the sensitive settings in the local secret store with the secret keys Authentication:Google:ClientId (value: {CLIENT ID} placeholder) and Authentication:Google:ClientSecret (value: {CLIENT SECRET} placeholder):

	dotnet user-secrets set "Authentication:Google:ClientId" "{CLIENT ID}"
	dotnet user-secrets set "Authentication:Google:ClientSecret" "{CLIENT SECRET}"

	NOTE: 

	The Secret Manager tool can be used from other directories too. Use the --project option to supply the file system path at which the project file exists. For example:

	dotnet user-secrets set "Movies:ServiceApiKey" "12345" --project "C:\apps\WebApp1\src\WebApp1"

	IMPORTANT:

	The : separator doesn't work with environment variable hierarchical keys on all platforms. For example, the : separator isn't supported by Bash. The double underscore, __, is supported by all platforms and automatically replaced by a colon, :.


### Configure Application

Add NuGet package:

dotnet add package Microsoft.AspNetCore.Authentication.Google

Program.cs

```cs
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddAuthentication(options =>
{
    options.DefaultScheme = Microsoft.AspNetCore.Authentication.Cookies.CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = Microsoft.AspNetCore.Authentication.Google.GoogleDefaults.AuthenticationScheme;
})
.AddCookie() 
.AddGoogle(googleOptions =>
{
    googleOptions.ClientId = builder.Configuration["Authentication:Google:ClientId"]!;
    googleOptions.ClientSecret = builder.Configuration["Authentication:Google:ClientSecret"]!;
});

builder.Services.AddControllersWithViews();

var app = builder.Build();

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();

app.UseAuthorization();

app.MapRazorPages();

app.Run();
```

#### Alternative [Configure Google authentication with Google.Apis.Auth.AspNetCore3]


```bash
dotnet add package Google.Apis.Auth.AspNetCore3
```

```cs
services.AddAuthentication().AddGoogleOpenIdConnect(googleOptions =>
{
    googleOptions.ClientId = configuration["Authentication:Google:ClientId"];
    googleOptions.ClientSecret = configuration["Authentication:Google:ClientSecret"];
});
```

## AccountController

Create the following directories

Models
Views
Controllers

```cs
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Mvc;

public class AccountController : Controller
{
    public IActionResult Login()
    {
        // Google login ekranına yönlendirir
        var properties = new AuthenticationProperties { RedirectUri = Url.Action("GoogleResponse") };
        return Challenge(properties, GoogleDefaults.AuthenticationScheme);
    }

    public async Task<IActionResult> GoogleResponse()
    {
        // Giriş başarılı olduktan sonra kullanıcı bilgilerini okuyalım
        var result = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        
        var claims = result.Principal.Identities
            .FirstOrDefault().Claims.Select(claim => new
            {
                claim.Issuer,
                claim.OriginalIssuer,
                claim.Type,
                claim.Value
            });

        // Burada kullanıcıyı veritabanına kaydedebilir veya ana sayfaya yönlendirebilirsiniz
        return Json(claims);
    }

    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return RedirectToAction("Index", "Home");
    }
}
```

## Index.cshtml
```html
@if (User.Identity.IsAuthenticated)
{
    <h3>Hoş geldin, @User.Identity.Name!</h3>
    <a href="/Account/Logout" class="btn btn-danger">Çıkış Yap</a>
}
else
{
    <h3>Lütfen giriş yapın</h3>
    <a href="/Account/Login" class="btn btn-primary">Google ile Giriş Yap</a>
}
```




# References

https://learn.microsoft.com/en-us/aspnet/core/security/authentication/social/google-logins?view=aspnetcore-10.0

https://learn.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-10.0&tabs=windows
