package com.apr.interceptor;

import java.util.Map;

import com.apr.model.User;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginInterceptor extends AbstractInterceptor {
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		Map<String, Object> session = invocation.getInvocationContext().getSession();

		User user = (User) session.get("user");

		if (user==null) 
			return "login";
		else 
			return invocation.invoke();
		
	}
}
