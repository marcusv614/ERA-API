package br.com.era.eraapi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import br.com.era.eraapi.model.Localizacao;
import br.com.era.eraapi.repository.LocalizacaoRepository;

@Service
public class LocalizacaoService {
    private final LocalizacaoRepository localizacaoRepository;

    public LocalizacaoService(LocalizacaoRepository localizacaoRepository) { this.localizacaoRepository = localizacaoRepository; }

    public List<Localizacao> listAll() { return localizacaoRepository.findAll(); }
    public Localizacao create(Localizacao l) { return localizacaoRepository.save(l); }
    public Localizacao get(Long id) { return localizacaoRepository.findById(id).orElse(null); }
    public void delete(Long id) { localizacaoRepository.deleteById(id); }
}
