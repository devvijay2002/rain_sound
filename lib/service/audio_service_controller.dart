import 'dart:developer';
import 'package:just_audio/just_audio.dart';
import '../model/sound_model.dart';


class AudioServiceController {
  final Map<String, AudioPlayer> _players = {};

  Future<void> initPlayers(List<Sound> sounds) async {
    log('sounds name: ${sounds[0].name}');
    try {
      // Dispose existing players before creating new ones
      for (final player in _players.values) {
        await player.dispose();
      }
      _players.clear();
      for (final sound in sounds) {
        final player = AudioPlayer();
        await player.setAsset(sound.assetPath, preload: true);
        player.setLoopMode(LoopMode.one);
        _players[sound.id] = player;
      }
    } catch (e) {
      log("Error on initPlayers: $e");
    }
  }

  Future<void> playAll(Map<String, double> volumes) async {
    try {
      log("playAll called. Players to play: ${_players.length}");
      final futures = <Future>[];
      for (final entry in _players.entries) {
        final volume = volumes[entry.key] ?? 0.0;
        log("Setting volume for ${entry.key}: $volume");

        futures.add(entry.value.setVolume(volume));

        if (!entry.value.playing) {
          log("Starting player: ${entry.key}");
          // Don't await here — collect futures
          futures.add(entry.value.play());
        } else {
          log("Player already playing: ${entry.key}");
        }
      }
      // Wait for all async tasks to complete
      await Future.wait(futures);
      log("All players started.");
    } catch (e, st) {
      log("Error on playAll: $e\n$st");
    }
  }

  Future<void> playOne(String playerId, double volume) async {
    try {
      final player = _players[playerId];

      if (player == null) {
        log("Player with id $playerId not found.");
        return;
      }

      log("Setting volume for $playerId: $volume");
      await player.setVolume(volume);

      if (!player.playing) {
        log("Starting player: $playerId");
        await player.play();
      } else {
        log("Player already playing: $playerId");
      }

      log("Player $playerId started successfully.");
    } catch (e, st) {
      log("Error on playSingle($playerId): $e\n$st");
    }
  }

  // In AudioServiceController
  Future<void> stopAll() async {
    try {
      log("stopAll called. Players: ${_players.length}");

      final futures = <Future>[];

      for (final entry in _players.entries) {
        final player = entry.value;
        log("Stopping player for: ${entry.key}, playing: ${player.playing}");

        futures.add(player.pause());
        futures.add(player.stop());
        futures.add(player.seek(Duration.zero));
        futures.add(player.setVolume(0.0));
      }

      await Future.wait(futures);

      log("All players stopped: ${_players.length}");
    } catch (e, st) {
      log("Error on stopAll: $e\n$st");
    }
  }

  Future<void> stopOne(String playerId) async {
    try {
      final player = _players[playerId];

      if (player == null) {
        log("Player with id $playerId not found.");
        return;
      }

      log("Stopping player: $playerId, playing: ${player.playing}");

      await player.pause();
      await player.stop();
      await player.seek(Duration.zero);
      // await player.setVolume(0.0);

      log("Player $playerId stopped successfully.");
    } catch (e, st) {
      log("Error on stopSingle($playerId): $e\n$st");
    }
  }

  Future<void> setVolume(String soundId, double volume) async {
    try {
      final player = _players[soundId];
      if (player != null) {
        await player.setVolume(volume);
      }
    } catch (e) {
      log("Error on setVolume: $e");
    }
  }

  Future<void> dispose() async {
    try {
      for (final player in _players.values) {
        await player.dispose();
      }
      _players.clear();
    } catch (e) {
      log("Error on dispose: $e");
    }
  }
}
