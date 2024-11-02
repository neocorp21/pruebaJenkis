package com.example.demojenkis;

import com.example.demojenkis.metodo.Suma;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertEquals;


@SpringBootTest
class DemoJenkisApplicationTests {

	Suma suma = new Suma();
	@Test
	void sumar() {
	assertEquals(5, suma.sumar(2, 3));
	}





}
