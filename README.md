# Rain Sound: Better Sleep (Flutter, GetX)

A Flutter app for mixing and playing calming rain and nature sounds for better sleep.

## Features

- Sound Library: Rain, Frogs, Wind, Thunder, Stream (easily add more).
- Simultaneous Mixing: Play and mix any/all sounds at once.
- Per-Sound Volume: Each sound has its own slider.
- Master Power: One-tap on/off for all sounds (starts with default mix).
- Master Volume: Optional global volume control.
- Background Playback: Works when app is in background or screen is off.
- State Persistence: Remembers last mix and power state.
- Clean UI: Modern, production-ready structure.

## How to Add Real Audio Files

1. Put your audio files (e.g., `rain.mp3`, `frogs.mp3`) in `assets/sounds/`.
2. Register them in `pubspec.yaml` under `assets:`.
3. Add sound info in `lib/services/sound_library.dart`.
4. Use seamless, loop-friendly files for best results.

## iOS/Android Setup Notes

### iOS

- In `ios/Runner/Info.plist`:
  ```
  <key>UIBackgroundModes</key>
  <array>
    <string>audio</string>
  </array>
  ```
- In Xcode, set "Audio, AirPlay, and Picture in Picture" background mode.

### Android

- No special manifest changes needed for background audio with just_audio.
- Your audio files go in `assets/sounds/`.

## Packages Used

- just_audio
- audio_session
- audio_service
- get
- get_storage

## Replace Assets

- Place actual `.mp3` or `.wav` files in `assets/sounds/` and update `pubspec.yaml`.

---

**This is a complete, production-quality Flutter app structure using GetX.**