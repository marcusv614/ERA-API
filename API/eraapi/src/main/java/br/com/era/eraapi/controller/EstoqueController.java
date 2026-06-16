package br.com.era.eraapi.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.era.eraapi.model.Estoque;
import br.com.era.eraapi.service.EstoqueService;

@RestController
@RequestMapping("/api/estoque")
public class EstoqueController {

    private final EstoqueService estoqueService;

    public EstoqueController(EstoqueService estoqueService) {
        this.estoqueService = estoqueService;
    }

    @GetMapping("/produto/{produtoId}")
    public ResponseEntity<List<Estoque>> byProduto(@PathVariable Long produtoId) {
        return ResponseEntity.ok(estoqueService.findByProdutoId(produtoId));
    }
}
