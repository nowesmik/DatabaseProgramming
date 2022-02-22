package model.service;

@SuppressWarnings("serial")
public class AppException extends Exception{
	public AppException() {
		super();
	}

	public AppException(String message) {
		super(message);
	}

	public AppException(String message, Throwable cause) {
		super(message, cause);
	}
}
