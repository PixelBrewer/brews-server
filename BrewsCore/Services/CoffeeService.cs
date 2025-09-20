using System;
using BrewsCore.Models;

namespace BrewsCore.Services;

public interface ICoffeeService
{
	public IEnumerable<Coffee> GetAllCoffees();
}
public class CoffeeService : ICoffeeService
{
	public IEnumerable<Coffee> GetAllCoffees()
	{
		var jsonPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "..", "..", "..", "Data", "DummyData.json");
		if (!File.Exists(jsonPath))
			return [];

		var json = File.ReadAllText(jsonPath);
		var coffees = System.Text.Json.JsonSerializer.Deserialize<List<Coffee>>(json, new System.Text.Json.JsonSerializerOptions
		{
			PropertyNameCaseInsensitive = true
		});
		return coffees ?? Enumerable.Empty<Coffee>();
	}
}
