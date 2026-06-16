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

import br.com.era.eraapi.model.Localizacao;
import br.com.era.eraapi.service.LocalizacaoService;

@RestController
@RequestMapping("/api/localizacoes")
public class LocalizacaoController {
    private final LocalizacaoService localizacaoService;
    public LocalizacaoController(LocalizacaoService localizacaoService) { this.localizacaoService = localizacaoService; }

    @GetMapping
    public ResponseEntity<List<Localizacao>> list() { return ResponseEntity.ok(localizacaoService.listAll()); }

    @PostMapping
    public ResponseEntity<Localizacao> create(@RequestBody Localizacao l) { return ResponseEntity.ok(localizacaoService.create(l)); }

    @GetMapping("/{id}")
    public ResponseEntity<Localizacao> get(@PathVariable Long id) { Localizacao l = localizacaoService.get(id); if (l==null) return ResponseEntity.notFound().build(); return ResponseEntity.ok(l); }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) { localizacaoService.delete(id); return ResponseEntity.noContent().build(); }
}
