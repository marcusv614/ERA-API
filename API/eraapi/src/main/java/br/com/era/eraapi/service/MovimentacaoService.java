package br.com.era.eraapi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import br.com.era.eraapi.model.Movimentacao;
import br.com.era.eraapi.repository.MovimentacaoRepository;

@Service
public class MovimentacaoService {
    private final MovimentacaoRepository movimentacaoRepository;
    public MovimentacaoService(MovimentacaoRepository movimentacaoRepository) { this.movimentacaoRepository = movimentacaoRepository; }

    public List<Movimentacao> listAll() { return movimentacaoRepository.findAll(); }
    public Movimentacao create(Movimentacao m) { return movimentacaoRepository.save(m); }
    public Movimentacao get(Long id) { return movimentacaoRepository.findById(id).orElse(null); }
    public void delete(Long id) { movimentacaoRepository.deleteById(id); }
}
