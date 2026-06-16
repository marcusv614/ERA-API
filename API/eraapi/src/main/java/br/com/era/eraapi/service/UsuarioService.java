package br.com.era.eraapi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import br.com.era.eraapi.model.Usuario;
import br.com.era.eraapi.repository.UsuarioRepository;

@Service
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public List<Usuario> listAll() { return usuarioRepository.findAll(); }
    public Usuario create(Usuario u) { return usuarioRepository.save(u); }
    public Usuario get(Long id) { return usuarioRepository.findById(id).orElse(null); }
    public void delete(Long id) { usuarioRepository.deleteById(id); }
}
