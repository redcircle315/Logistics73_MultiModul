package kr.co.seoulit.logistics;

import java.nio.charset.Charset;

import javax.servlet.http.HttpSessionListener;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.filter.CharacterEncodingFilter;

import kr.co.seoulit.logistics.sys.interceptor.SessionListener;
import kr.co.seoulit.logistics.sys.interceptor.SiteMeshFilter;

@SpringBootApplication
@EnableAspectJAutoProxy(proxyTargetClass = true)
public class Logistics73SpringBootApplication extends SpringBootServletInitializer{

	public static void main(String[] args) {
		SpringApplication.run(Logistics73SpringBootApplication.class, args);
	}
	@Override
protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
	
	return application.sources(Logistics73SpringBootApplication.class);
}

	//SiteMeshFilter web.xml 에 적용해주는거랑 같음
	@Bean
	public FilterRegistrationBean<SiteMeshFilter> siteMeshFilter() {
		FilterRegistrationBean<SiteMeshFilter> filter = new FilterRegistrationBean<SiteMeshFilter>();
		filter.setFilter(new SiteMeshFilter());
		return filter;
	}
	
	//SessionListener web.xml 에서 같은역할 하는 bean 
	@Bean
	public ServletListenerRegistrationBean<HttpSessionListener> sessionListener() {
		return new ServletListenerRegistrationBean<HttpSessionListener>(new SessionListener());
	}
	
	@Bean 
	public HttpMessageConverter<String> responseBodyConverter() {
		return new StringHttpMessageConverter(Charset.forName("UTF-8")); 
	} 
	
	@Bean 
	public CharacterEncodingFilter characterEncodingFilter() {
		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
		characterEncodingFilter.setEncoding("UTF-8");
	    characterEncodingFilter.setForceEncoding(true);
	    return characterEncodingFilter; 
    } 

}
