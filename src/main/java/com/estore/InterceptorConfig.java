package com.estore;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.estore.interceptor.AuthorizeInterceptor;
import com.estore.interceptor.AuthorizeInterceptorAdmin;
import com.estore.interceptor.ShareInterceptor;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {

	@Autowired
	ShareInterceptor share;

	@Autowired
	AuthorizeInterceptor auth;

	@Autowired
	AuthorizeInterceptorAdmin authAdmin;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(share).addPathPatterns("/**");

		registry.addInterceptor(auth).addPathPatterns("/taikhoan/dangxuat", "/taikhoan/suathongtin",
				"/taikhoan/doimatkhau", "/dathang/**");

		registry.addInterceptor(authAdmin).addPathPatterns("/admin/**");

	}
}
