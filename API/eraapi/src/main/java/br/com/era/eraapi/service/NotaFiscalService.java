package br.com.era.eraapi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import br.com.era.eraapi.model.NotaFiscal;
import br.com.era.eraapi.repository.NotaFiscalRepository;

@Service
public class NotaFiscalService {
    private final NotaFiscalRepository repo;
    public NotaFiscalService(NotaFiscalRepository repo) { this.repo = repo; }

    public List<NotaFiscal> listAll() { return repo.findAll(); }
    public NotaFiscal create(NotaFiscal n) { return repo.save(n); }
    public NotaFiscal get(Long id) { return repo.findById(id).orElse(null); }
    public void delete(Long id) { repo.deleteById(id); }
}
