package formatec.service;

import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import formatec.repository.SseService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Ameya Shetti
 */

@Service
public class SseServiceImpl implements SseService {

    private final List<SseEmitter> emitters = new ArrayList<SseEmitter>();

    @Override
    public boolean add(SseEmitter sseEmitter) {
        return this.emitters.add(sseEmitter);
    }

    @Override
    public boolean remove(SseEmitter sseEmitter) {
        return this.emitters.remove(sseEmitter);
    }

    @Override
    public List<SseEmitter> getSsEmitters() {
        return this.emitters;
    }
    @Async
	@Scheduled(fixedRate = 5000)
	public void doNotify() throws IOException {
		List<SseEmitter> deadEmitters = new ArrayList<>();
		emitters.forEach(emitter -> {
			try {
				emitter.send(SseEmitter.event());
			} catch (Exception e) {
				deadEmitters.add(emitter);
			}
		});
		emitters.removeAll(deadEmitters);
	}

}
