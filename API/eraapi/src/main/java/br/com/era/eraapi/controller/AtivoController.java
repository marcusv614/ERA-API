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
import br.com.era.eraapi.model.Ativo;
import br.com.era.eraapi.service.AtivoService;

@RestController
@RequestMapping("/api/ativos")
public class AtivoController {
    private final AtivoService ativoService;
    public AtivoController(AtivoService ativoService) { this.ativoService = ativoService; }

    @GetMapping
    public ResponseEntity<List<Ativo>> list() { return ResponseEntity.ok(ativoService.listAll()); }

    @PostMapping
    public ResponseEntity<Ativo> create(@RequestBody Ativo a) { return ResponseEntity.ok(ativoService.create(a)); }

    @GetMapping("/{id}")
    public ResponseEntity<Ativo> get(@PathVariable Long id) { Ativo a = ativoService.get(id); if (a==null) return ResponseEntity.notFound().build(); return ResponseEntity.ok(a); }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) { ativoService.delete(id); return ResponseEntity.noContent().build(); }
}
