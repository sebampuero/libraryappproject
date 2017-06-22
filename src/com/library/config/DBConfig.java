package com.library.config;

import java.io.IOException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.hibernate.SessionFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
public class DBConfig {
	
	@Bean
	public SessionFactory sessionFactory() {
	      LocalSessionFactoryBean lsfb = new LocalSessionFactoryBean();
	      lsfb.setDataSource(getDataSource());
	      lsfb.setPackagesToScan("com.library.entity");
	      lsfb.setHibernateProperties(hibernateProperties());
	      try {
		     lsfb.afterPropertiesSet();
	      } catch (IOException e) {
		     e.printStackTrace();
	      }
	      return lsfb.getObject();
	}
	@Bean
	public DataSource getDataSource() {
	     BasicDataSource dataSource = new BasicDataSource();
	     dataSource.setDriverClassName("com.mysql.jdbc.Driver");
	     dataSource.setUrl("jdbc:mysql://localhost:3306/library?useSSL=false");
	     dataSource.setUsername("springstudent");
	     dataSource.setPassword("springstudent");
	     return dataSource;
	}
	
	@Bean
	  public PlatformTransactionManager annotationDrivenTransactionManager() {
	    return new HibernateTransactionManager(sessionFactory());
	  }
	private Properties hibernateProperties() {
        Properties properties = new Properties();
        properties.put("hibernate.dialect","org.hibernate.dialect.MySQLDialect");
        properties.put("hibernate.show_sql", true);
        properties.put("hibernate.format_sql", true);
        properties.put("hibernate.enable_lazy_load_no_trans", true);
        return properties;        
   }	
	
}
