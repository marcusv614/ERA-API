package br.com.era.eraapi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import br.com.era.eraapi.model.Retirada;
import br.com.era.eraapi.repository.RetiradaRepository;

@Service
public class RetiradaService {
    private final RetiradaRepository retiradaRepository;
    public RetiradaService(RetiradaRepository retiradaRepository) { this.retiradaRepository = retiradaRepository; }

    public List<Retirada> listAll() { return retiradaRepository.findAll(); }
    public Retirada create(Retirada r) { return retiradaRepository.save(r); }
    public Retirada get(Long id) { return retiradaRepository.findById(id).orElse(null); }
    public void delete(Long id) { retiradaRepository.deleteById(id); }
}
