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
import br.com.era.eraapi.model.Retirada;
import br.com.era.eraapi.service.RetiradaService;

@RestController
@RequestMapping("/api/retiradas")
public class RetiradaController {
    private final RetiradaService retiradaService;
    public RetiradaController(RetiradaService retiradaService) { this.retiradaService = retiradaService; }

    @GetMapping
    public ResponseEntity<List<Retirada>> list() { return ResponseEntity.ok(retiradaService.listAll()); }

    @PostMapping
    public ResponseEntity<Retirada> create(@RequestBody Retirada r) { return ResponseEntity.ok(retiradaService.create(r)); }

    @GetMapping("/{id}")
    public ResponseEntity<Retirada> get(@PathVariable Long id) { Retirada r = retiradaService.get(id); if (r==null) return ResponseEntity.notFound().build(); return ResponseEntity.ok(r); }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) { retiradaService.delete(id); return ResponseEntity.noContent().build(); }
}
