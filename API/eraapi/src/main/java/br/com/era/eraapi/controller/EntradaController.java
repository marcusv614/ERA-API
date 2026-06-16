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

import br.com.era.eraapi.model.Entrada;
import br.com.era.eraapi.service.EntradaService;

@RestController
@RequestMapping("/api/entradas")
public class EntradaController {
    private final EntradaService entradaService;
    public EntradaController(EntradaService entradaService) { this.entradaService = entradaService; }

    @GetMapping
    public ResponseEntity<List<Entrada>> list() { return ResponseEntity.ok(entradaService.listAll()); }

    @PostMapping
    public ResponseEntity<Entrada> create(@RequestBody Entrada e) { return ResponseEntity.ok(entradaService.create(e)); }

    @GetMapping("/{id}")
    public ResponseEntity<Entrada> get(@PathVariable Long id) { Entrada e = entradaService.get(id); if (e==null) return ResponseEntity.notFound().build(); return ResponseEntity.ok(e); }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) { entradaService.delete(id); return ResponseEntity.noContent().build(); }
}
