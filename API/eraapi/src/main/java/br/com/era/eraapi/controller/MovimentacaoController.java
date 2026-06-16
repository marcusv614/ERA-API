package br.com.era.eraapi.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.era.eraapi.model.Movimentacao;
import br.com.era.eraapi.service.MovimentacaoService;

@RestController
@RequestMapping("/api/movimentacoes")
public class MovimentacaoController {
    private final MovimentacaoService movimentacaoService;
    public MovimentacaoController(MovimentacaoService movimentacaoService) { this.movimentacaoService = movimentacaoService; }

    @GetMapping
    public ResponseEntity<List<Movimentacao>> list() { return ResponseEntity.ok(movimentacaoService.listAll()); }

    @PostMapping
    public ResponseEntity<Movimentacao> create(@RequestBody Movimentacao m) { return ResponseEntity.ok(movimentacaoService.create(m)); }

    @GetMapping("/{id}")
    public ResponseEntity<Movimentacao> get(@PathVariable Long id) { Movimentacao m = movimentacaoService.get(id); if (m==null) return ResponseEntity.notFound().build(); return ResponseEntity.ok(m); }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) { movimentacaoService.delete(id); return ResponseEntity.noContent().build(); }
}
