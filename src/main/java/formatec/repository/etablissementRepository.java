package formatec.repository;




import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import formatec.DAO.Etablissement;


@Repository
public interface etablissementRepository extends JpaRepository<Etablissement,Long> {
	Etablissement findByEmail(String email);
	boolean existsByEmail(String email);
	List<Etablissement> findAllByEtat(boolean etat);
	
}