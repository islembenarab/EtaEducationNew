package formatec.repository;




import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


import formatec.DAO.Formateur;


@Repository
public interface formateurRepository extends JpaRepository<Formateur,Long> {
	Formateur findByEmail(String email);
	boolean existsByEmail(String email);
	List<Formateur> findAllByEtat(boolean etat);


}