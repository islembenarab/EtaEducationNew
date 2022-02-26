package formatec.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import formatec.DAO.payment;
@Repository
public interface paymentRepository extends JpaRepository<payment,Long> {

}
