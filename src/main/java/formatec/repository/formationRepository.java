package formatec.repository;





import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import formatec.DAO.Formation;


@Repository
public interface formationRepository extends JpaRepository<Formation,Long>{
	Formation findBynameFormation(String name);
	List<Formation> findAllByEtat(boolean etat);
}