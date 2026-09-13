            // MapWhen allows you to split the middleware pipeline into two completely separate branches by specifying a predicate
            // If the request path start with '/api' then middleware will execute. Otherwise, following middleware will execute
            // With this configuration, there is no way for both this middleware and the following middleware to execute for a single request.
            // this is an either or case
            // use MapWhen to restrict the for example StaticFiles middleware from running for all requests if you specify a certain path:
            // app.MapWhen(context => context.Request.Path.Value.StartsWithSegments("/assets"), appBuilder => appBuilder.UseStaticFiles());
            // This would result in the static files middleware only running for request paths starting with '/assets' (where we store our static files). Any request with a path not matching this criteria would not run the StaticFiles middleware and the next registered middleware would run directly instead (perhaps saving valuable nano-seconds!).
            //app.MapWhen(context => context.Request.Path.StartsWithSegments("/api"), appBuilder =>
            //{
            //    appBuilder.UseMiddlewareTwo();
            //});


            // As with MapWhen, all middleware registered before the UseWhen call will apply to all requests.
            // The primary difference between UseWhen and MapWhen is how later (i.e. registered below) middleware is executed. Unlike MapWhen, UseWhen continues to execute later middleware regardless of whether the UseWhen predicate was true or false.
            // UseWhen is very powerful and incredibly useful. Rather than the middleware itself deciding on if it should execute (perhaps via configuration), we can control middleware ourselves by choosing how we register it.
            // Here are a few examples:   Restrict output caching to anonymous users. Add diagnostic headers for a certain IP subnet. Handle errors differently for API and MVC actions. Restrict certain requests from analytics.
            //app.UseWhen(context => context.Request.Path.StartsWithSegments("/api"), appBuilder =>
            //{
            //    appBuilder.UseStatusCodePagesWithReExecute("/apierror/{0}");

            //    appBuilder.UseExceptionHandler("/apierror/500");
            //});