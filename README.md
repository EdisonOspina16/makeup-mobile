# Makeup – Taller Integrador 2 + 3

Catálogo de maquillaje (HTTP/JSON) con prioridad y nota personal guardadas en
Drift, patrón Repository y sincronización offline-first con Firestore.

---
# **Integrantes:** 
### Edison Ospina Arroyave
### Ana Sofia Londoño Ortega
---

## Cómo ejecutarlo

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

- Catálogo: `https://dummyjson.com/c/7718-7cf9-46ba-9f1c`
- Firebase: proyecto `makeup-e5058` (Android, `com.example.movies`),
  colección `makeup_notes`, documento = `productId`.
- La regla de guardado exige prioridad >= 2.
- El botón de sincronizar (icono en la barra superior) envía solo los
  registros con `pendingSync == true`.

## Preguntas

1. **¿Para qué sirve pendingSync?** Es una marca guardada en Drift que indica
   si el registro de un producto ya llegó a Firestore (`false`) o si todavía
   falta enviarlo (`true`). Con ella la app sabe qué mostrar en el detalle
   ("Sincronizado" o "Pendiente") y qué registros reenviar con el botón de
   sincronizar, sin tener que enviar todo otra vez.
2. **¿Por qué se guarda primero en Drift?** Porque el guardado no puede
   depender de internet ni de Firebase. Si se guardara primero en la nube y
   fallara la conexión, el usuario perdería su prioridad y su nota. En Drift el
   dato queda seguro en el dispositivo, sigue ahí al cerrar la app, y después se
   intenta subir.
3. **¿Qué función cumple el Repository?** Es la capa intermedia entre la
   interfaz y los datos. Concentra en un solo lugar la consulta local, el
   guardado (primero Drift, luego Firestore) y la sincronización de pendientes.
   Así las pantallas solo le piden cosas al Repository y no saben nada de Drift
   ni de Firebase.
4. **¿Qué ocurre si Firebase falla?** No se pierde nada: el registro ya está en
   Drift y se queda con `pendingSync = true`. La app avisa que se guardó
   localmente y que está pendiente. Cuando vuelva la conexión, el botón
   "Sincronizar pendientes" lo envía y lo marca como sincronizado.
