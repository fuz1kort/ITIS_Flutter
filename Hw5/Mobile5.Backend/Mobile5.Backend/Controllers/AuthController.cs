﻿using MassTransit;
using Microsoft.AspNetCore.Mvc;
using Mobile5.Backend.DTO;
using Mobile5.Backend.Models;
using Mobile5.Backend.Services;

namespace Mobile5.Backend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthController(IPublishEndpoint publishEndpoint) : ControllerBase
{
    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginRequest request)
    {
        var username = request.Username;
        var sessionId = Guid.NewGuid().ToString();

        if (SessionManager.Has(username))
        {
            var oldSessionId = SessionManager.GetSessionId(username);
            if (oldSessionId != null)
            {
                await publishEndpoint.Publish(new LogoutMessage(username, oldSessionId));
                Console.WriteLine("User {0} logged out", username);
                SessionManager.Remove(username);
            }
        }

        SessionManager.Add(username, sessionId);
        Console.WriteLine("User {0} logged in", request.Username);
        return Ok(new { sessionId });
    }
}