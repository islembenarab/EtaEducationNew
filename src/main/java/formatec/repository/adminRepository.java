package formatec.repository;




import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import formatec.DAO.Admin;


@Repository
public interface adminRepository extends JpaRepository<Admin,Long> {
	Admin findByEmail(String email);
	boolean existsByEmail(String email);


}