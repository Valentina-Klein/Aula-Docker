package br.com.meucontainer.novocontainer;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class MeuController {

    @GetMapping("/demo")
    public String mensagem() {
        return "<h1>Demonstração do curso</h1><p>API funcionando corretamente!</p><strong>Status: ONLINE</strong>";
    }
}
