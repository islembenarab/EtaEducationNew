package formatec.repository;




import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import formatec.DAO.Apprenant;


@Repository
public interface aprenantRepository extends JpaRepository<Apprenant,Long> {
	Apprenant findByEmail(String email);
	boolean existsByEmail(String email);
	List<Apprenant> findAllByEtat(boolean etat);

}