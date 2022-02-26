package formatec.repository;

import java.util.List;


import formatec.DAO.*;
import org.springframework.data.jpa.repository.JpaRepository;

public interface inscriptionsRepository extends JpaRepository<Inscriptions,Long>{

List<Inscriptions> findAllByapp (Apprenant app);
List<Inscriptions> findAllByEtab (Etablissement app);
List<Inscriptions> findAllByForm (Formation app);
List<Inscriptions> findAllByForma (Formateur app);
}
