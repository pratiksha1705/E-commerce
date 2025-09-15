package com.ecommerce.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false); // Do not create a new session if one doesn't exist

        String requestURI = httpRequest.getRequestURI();
        
        // Check if an admin is logged in
        boolean isAdminLoggedIn = (session != null && session.getAttribute("adminUser") != null);
        
        // Allow access to login page and related resources without being logged in
        boolean isLoginRequest = requestURI.endsWith("login.jsp") || requestURI.endsWith("/admin/login");

        if (isAdminLoggedIn || isLoginRequest) {
            // If logged in or it's a login request, let the request through
            chain.doFilter(request, response);
        } else {
            // If not logged in and not a login request, redirect to the admin login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login.jsp");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if needed
    }

    @Override
    public void destroy() {
        // Cleanup code, if needed
    }
}