package hilotcg.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import hilotcg.entities.User;
import hilotcg.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private UserRepository userRepo;
	@Autowired
	private PasswordEncoder encoder;
	
	@Override
	public User register(User user) {
		String encryptedPassword = encoder.encode(user.getPassword());
		user.setPassword(encryptedPassword);
		return userRepo.saveAndFlush(user);
	}

	@Override
	public User getUserByUsername(String username) {
		return userRepo.findByUsername(username);
	}

}
