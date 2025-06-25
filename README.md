# Preguntas y Respuestas

6. Explique el ciclo de vida de un UIViewController

Apple provee una lista de métodos para manejar el ciclo de vida de un controlador:
	•	init: Inicializador.
	•	loadView: Crea la vista desde el controlador (si no se usa un storyboard).
	•	viewDidLoad: Se llama al momento en que la vista ya se encuentra en memoria.
	•	viewWillAppear: Antes de que la vista se muestre.
	•	viewDidAppear: Después de que la vista se muestre.
	•	viewWillDisappear: Antes de que la vista deje de ser visible.
	•	viewDidDisappear: Después de que la vista haya desaparecido.
	•	deinit: El controlador se ha liberado de la memoria.


7. Explique el ciclo de vida de una aplicación
	•	Al igual que el ciclo de vida de un controlador, el AppDelegate o el SceneDelegate proveen métodos donde se pueden manejar diferentes estados de la app.
	•	didFinishLaunchingWithOptions: La app se ha inicializado.
	•	applicationDidBecomeActive: Lista para recibir eventos.
	•	applicationWillResignActive: Última interacción antes de que pase a estar inactiva.
	•	applicationDidEnterBackground: La app ha entrado en segundo plano.
	•	applicationWillEnterForeground: La app ha regresado a un estado activo.
	•	applicationWillTerminate: Última interacción antes de que se cierre la app.

8. ¿En qué casos se usa un weak, un strong y un unowned?
	•	strong: Referencia por defecto, mantiene una referencia fuerte con el objeto. Se usa cuando necesitas que la referencia siga viva hasta que el dueño desaparezca.
	•	weak: Se usa para evitar retain cycles y cuando el objeto A depende de B pero no viceversa. El ejemplo más común es un delegate.
	•	unowned: Similar al weak, pero se usa cuando sabes que el objeto nunca será nulo. Se usa en procesos donde la eficiencia es clave (no lo tiendo a usar).

9. ¿Qué es el ARC?

Es el memory garbage collector de Swift. Cuando se crea un objeto strong, el contador aumenta en uno. Cuando este se desinicializa, el contador resta uno. (weak y unowned no se ven reflejados en el contador).

10. Análisis

El color final es amarillo, porque al momento de crear la instancia se le asigna en el viewDidLoad el color rojo, pero después, en el AppDelegate, que fue quien lo instanció, se le asigna el color amarillo y el viewDidLoad ya había pasado.
