package br.com.era.eraapi.model;

import java.time.LocalDateTime;
import java.util.List;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "devolucao")
public class Devolucao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "retirada_id")
    private Retirada retirada;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    @Column(name = "data_devolucao")
    private LocalDateTime dataDevolucao;

    @Column(columnDefinition = "text")
    private String observacao;

    @OneToMany(mappedBy = "devolucao", cascade = CascadeType.ALL)
    private List<DevolucaoItem> items;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Retirada getRetirada() { return retirada; }
    public void setRetirada(Retirada retirada) { this.retirada = retirada; }
    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }
    public LocalDateTime getDataDevolucao() { return dataDevolucao; }
    public void setDataDevolucao(LocalDateTime dataDevolucao) { this.dataDevolucao = dataDevolucao; }
    public String getObservacao() { return observacao; }
    public void setObservacao(String observacao) { this.observacao = observacao; }
    public List<DevolucaoItem> getItems() { return items; }
    public void setItems(List<DevolucaoItem> items) { this.items = items; }
}
