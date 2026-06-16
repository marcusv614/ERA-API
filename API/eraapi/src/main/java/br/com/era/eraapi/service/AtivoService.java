package br.com.era.eraapi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import br.com.era.eraapi.model.Ativo;
import br.com.era.eraapi.repository.AtivoRepository;

@Service
public class AtivoService {
    private final AtivoRepository repo;
    public AtivoService(AtivoRepository repo) { this.repo = repo; }

    public List<Ativo> listAll() { return repo.findAll(); }
    public Ativo create(Ativo a) { return repo.save(a); }
    public Ativo get(Long id) { return repo.findById(id).orElse(null); }
    public void delete(Long id) { repo.deleteById(id); }
}
