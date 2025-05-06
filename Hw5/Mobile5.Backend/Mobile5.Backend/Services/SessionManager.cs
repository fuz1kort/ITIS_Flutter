using System.Collections.Concurrent;

namespace Mobile5.Backend.Services;

public static class SessionManager
{
    private static readonly ConcurrentDictionary<string, string> Sessions = new();

    public static bool Has(string username) => Sessions.ContainsKey(username);
    public static void Add(string username, string sessionId) => Sessions[username] = sessionId;
    public static void Remove(string username) => Sessions.TryRemove(username, out _);
    public static string? GetSessionId(string username) => Sessions.GetValueOrDefault(username);
}