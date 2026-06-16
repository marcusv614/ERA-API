package br.com.era.eraapi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import br.com.era.eraapi.model.Produto;
import br.com.era.eraapi.repository.ProdutoRepository;

@Service
public class ProdutoService {

    private final ProdutoRepository produtoRepository;

    public ProdutoService(ProdutoRepository produtoRepository) {
        this.produtoRepository = produtoRepository;
    }

    public List<Produto> listAll() { return produtoRepository.findAll(); }

    public Produto create(Produto p) { return produtoRepository.save(p); }

    public Produto getById(Long id) { return produtoRepository.findById(id).orElse(null); }

    public void delete(Long id) { produtoRepository.deleteById(id); }
}
