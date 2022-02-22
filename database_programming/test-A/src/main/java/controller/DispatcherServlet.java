package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

//@WebServlet(name = "userSevlet", urlPatterns = "/", loadOnStartup = 1)
public class DispatcherServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = LoggerFactory.getLogger(DispatcherServlet.class);
    
    private RequestMapping rm;

    @Override
    public void init() throws ServletException {
        rm = new RequestMapping();
        rm.initMapping();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) 
    	throws ServletException, IOException {
    	logger.debug("Method : {}, Request URI : {}, ServletPath : {}", 
    			request.getMethod(), request.getRequestURI(), request.getServletPath());
    	String contextPath = request.getContextPath();
    	String servletPath = request.getServletPath();
    	
        Controller controller = rm.findController(servletPath);
        logger.debug("controller : {}", controller);
        
        try {
            String uri = controller.execute(request, response);
            
            logger.debug("URI : {}", uri);
            
            if (uri == null) return;
            
            if (uri.startsWith("redirect:")) {	
            	// redirection 
            	String targetUri = contextPath + uri.substring("redirect:".length());
            	response.sendRedirect(targetUri);           
            }
            else {
            	String targetUri = "/WEB-INF" + uri;
            	logger.debug("targetURI : {}", targetUri);
            	RequestDispatcher rd = request.getRequestDispatcher(targetUri);
                rd.forward(request, response);		// forward to the view page
            }                   
        } catch (Exception e) {
            logger.error("Exception : {}", e);
            throw new ServletException(e.getMessage());
        }
    }
}

