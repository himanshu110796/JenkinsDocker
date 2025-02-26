package com.JenDock.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class JenDockController {
	
	@GetMapping("/test")  
    public ResponseEntity<String> testing() {
        return ResponseEntity.ok("Test");
    }

}
