package formatec.repository;

import java.util.List;

import formatec.DAO.*;
import org.springframework.data.jpa.repository.JpaRepository;

public interface condidatureRepository extends JpaRepository<Condidature, Long> {

    void deleteByEtab(Etablissement etab);

    void deleteByForm(Formation formation);

    void deleteByForma(Formateur formateur);

    boolean existsByEtab(Etablissement etab);

    boolean existsByForm(Formation formation);

    boolean existsByForma(Formateur formateur);

    List<Condidature> findAllByForma(Formateur Formateur);
    List<Condidature> findAllByForm(Formation Formateur);
    List<Condidature> findAllByEtab(Etablissement Formateur);
    List<Condidature> findAllByetat(boolean etat);

    List<Condidature> findAllByetatAndEtabAndDemandeur(boolean etat, Etablissement etab, String type);

    List<Condidature> findAllByetatAndFormaAndDemandeur(boolean etat, Formateur etab, String type);

    List<Condidature> findAllByetatAndEtab(boolean etat, Etablissement etab);

    List<Condidature> findAllByetatAndForma(boolean etat, Formateur etab);
}
