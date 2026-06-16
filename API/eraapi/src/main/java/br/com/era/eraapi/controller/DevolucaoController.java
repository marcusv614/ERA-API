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
import br.com.era.eraapi.model.Devolucao;
import br.com.era.eraapi.service.DevolucaoService;

@RestController
@RequestMapping("/api/devolucoes")
public class DevolucaoController {
    private final DevolucaoService devolucaoService;
    public DevolucaoController(DevolucaoService devolucaoService) { this.devolucaoService = devolucaoService; }

    @GetMapping
    public ResponseEntity<List<Devolucao>> list() { return ResponseEntity.ok(devolucaoService.listAll()); }

    @PostMapping
    public ResponseEntity<Devolucao> create(@RequestBody Devolucao d) { return ResponseEntity.ok(devolucaoService.create(d)); }

    @GetMapping("/{id}")
    public ResponseEntity<Devolucao> get(@PathVariable Long id) { Devolucao d = devolucaoService.get(id); if (d==null) return ResponseEntity.notFound().build(); return ResponseEntity.ok(d); }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) { devolucaoService.delete(id); return ResponseEntity.noContent().build(); }
}
