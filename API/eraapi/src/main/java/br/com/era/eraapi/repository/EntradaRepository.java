package br.com.era.eraapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.era.eraapi.model.Entrada;

@Repository
public interface EntradaRepository extends JpaRepository<Entrada, Long> {
}
