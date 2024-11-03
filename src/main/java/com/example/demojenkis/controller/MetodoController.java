package com.example.demojenkis.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/metodo")
public class MetodoController {
    @GetMapping("/hola")
    public String metodo(){
        return "Hola Mundo";
    }
}
