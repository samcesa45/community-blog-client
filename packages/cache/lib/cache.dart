library cache;

class CacheClient {
  final Map<String, Object> _cache;

  CacheClient() : _cache = <String, Object>{};

  //writes the provided [key], [value] pair to the in-memory cache

  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  ///Looks up the value for the provided [key]
  ///defaults to null if no value exists for the provided key

  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}
