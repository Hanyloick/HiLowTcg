package hilotcg.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import hilotcg.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findById(int id);
	User findByUsername(String username);
}
