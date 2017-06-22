package com.library.config;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

public class WebInitiliazer implements WebApplicationInitializer {

	
	@Override
	public void onStartup(ServletContext ctx) throws ServletException {
		AnnotationConfigWebApplicationContext rootctx = new AnnotationConfigWebApplicationContext();
		ctx.addListener(new SessionListener());
		rootctx.register(AppConfig.class);
		rootctx.setServletContext(ctx);
		ServletRegistration.Dynamic servlet = ctx.addServlet("dispatcher", new DispatcherServlet(rootctx));
		servlet.setLoadOnStartup(1);
		servlet.addMapping("/");
	}
}
