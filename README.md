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
- Firebase: proyecto `udem-movil-2026-pro` (Android, `com.example.movies`),
  colección `makeup_notes`, documento = `productId`.
- La regla de guardado exige prioridad >= 2.
- El botón de sincronizar (icono en la barra superior) envía solo los
  registros con `pendingSync == true`.

## Preguntas

1. **¿Para qué sirve pendingSync?** Marca si un registro local ya llegó a
   Firestore (`false`) o si todavía falta enviarlo (`true`).
2. **¿Por qué se guarda primero en Drift?** Para que el guardado no dependa de
   internet ni de Firebase: el dato queda seguro en el dispositivo y luego se
   intenta subir.
3. **¿Qué función cumple el Repository?** Centraliza la consulta local, el
   guardado y la sincronización, así la interfaz no coordina Drift y Firebase.
4. **¿Qué ocurre si Firebase falla?** Se conserva el registro local con
   `pendingSync = true` y se puede reenviar después con "Sincronizar pendientes".
