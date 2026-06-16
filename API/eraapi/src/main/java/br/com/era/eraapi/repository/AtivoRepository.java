package br.com.era.eraapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.era.eraapi.model.Ativo;

@Repository
public interface AtivoRepository extends JpaRepository<Ativo, Long> {
}
