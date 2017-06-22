package com.library.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled=true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private UserDetailsService myUserDetailsService;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')").
			antMatchers("/").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')").
			antMatchers("/library/**").access("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')");
		
		http.authorizeRequests().and().formLogin().loginPage("/login").failureUrl("/login?error").
			usernameParameter("username").passwordParameter("password").and().logout().logoutUrl("/logout").
			logoutSuccessUrl("/login?logout=true").and().csrf().disable().
			exceptionHandling().accessDeniedPage("/access_denied");

	}
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
                auth.userDetailsService(myUserDetailsService);
                auth.authenticationProvider(authenticationProvider());
	}
	@Bean
    public PasswordEncoder passwordEncoder(){
    	return new BCryptPasswordEncoder();
    }
    
	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
        	DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        	authenticationProvider.setUserDetailsService(myUserDetailsService);
        	authenticationProvider.setPasswordEncoder(passwordEncoder());
        	return authenticationProvider;
	}
	
}
