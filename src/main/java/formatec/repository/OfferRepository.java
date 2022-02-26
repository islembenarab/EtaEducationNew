package formatec.repository;

import formatec.DAO.Etablissement;
import formatec.DAO.Formation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import formatec.DAO.Offer;

import java.util.List;

@Repository
public interface OfferRepository extends JpaRepository<Offer, Long>{

    List<Offer> findAllByEtablissement(Etablissement etab);
    List<Offer> findAllByFormation(Formation formation);
}
