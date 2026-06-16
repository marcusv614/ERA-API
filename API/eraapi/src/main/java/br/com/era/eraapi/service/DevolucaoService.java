package br.com.era.eraapi.service;

import java.util.List;
import org.springframework.stereotype.Service;
import br.com.era.eraapi.model.Devolucao;
import br.com.era.eraapi.repository.DevolucaoRepository;

@Service
public class DevolucaoService {
    private final DevolucaoRepository devolucaoRepository;
    public DevolucaoService(DevolucaoRepository devolucaoRepository) { this.devolucaoRepository = devolucaoRepository; }

    public List<Devolucao> listAll() { return devolucaoRepository.findAll(); }
    public Devolucao create(Devolucao d) { return devolucaoRepository.save(d); }
    public Devolucao get(Long id) { return devolucaoRepository.findById(id).orElse(null); }
    public void delete(Long id) { devolucaoRepository.deleteById(id); }
}
