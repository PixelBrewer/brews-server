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
		// This is just a placeholder implementation.
		return new List<Coffee>
		{
			new Coffee { Id = Guid.NewGuid(), Name = "Espresso", RoastLevel = "Dark" },
			new Coffee { Id = Guid.NewGuid(), Name = "Latte", RoastLevel = "Medium" },
			new Coffee { Id = Guid.NewGuid(), Name = "Cappuccino", RoastLevel = "Light" }
		};
	}
}
