using System;

namespace BrewsCore.Models;

public class Coffee
{
	public Guid Id { get; set; }
	public string Name { get; set; } = string.Empty;
	public string Origin { get; set; } = string.Empty;
	public string RoastLevel { get; set; } = string.Empty;
	public DateTime ObtainedOn { get; set; }
	public decimal Price { get; set; }
	public string Notes { get; set; } = string.Empty;
	public int Rating { get; set; }
	public string ObtainedAtLocation { get; set; } = string.Empty;
}
