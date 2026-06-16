package br.com.era.eraapi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import br.com.era.eraapi.model.Entrada;
import br.com.era.eraapi.repository.EntradaRepository;

@Service
public class EntradaService {
    private final EntradaRepository entradaRepository;
    public EntradaService(EntradaRepository entradaRepository) { this.entradaRepository = entradaRepository; }

    public List<Entrada> listAll() { return entradaRepository.findAll(); }
    public Entrada create(Entrada e) { return entradaRepository.save(e); }
    public Entrada get(Long id) { return entradaRepository.findById(id).orElse(null); }
    public void delete(Long id) { entradaRepository.deleteById(id); }
}
