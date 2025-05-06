using MassTransit;
using Mobile5.Backend.Models;

namespace Mobile5.Backend.Services;

public class BroadcastService(IServiceScopeFactory scopeFactory) : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            using var scope = scopeFactory.CreateScope();
            var publishEndpoint = scope.ServiceProvider.GetRequiredService<IPublishEndpoint>();

            var message = $"Got message at {DateTime.UtcNow}";
            await publishEndpoint.Publish(new BroadcastMessage(message), stoppingToken);

            await Task.Delay(3000, stoppingToken);
        }
    }
}