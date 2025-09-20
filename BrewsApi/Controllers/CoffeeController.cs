using BrewsCore.Services;
using Microsoft.AspNetCore.Mvc;

namespace BrewsApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CoffeeController(ICoffeeService coffeeService) : ControllerBase
    {
        private readonly ICoffeeService coffeeService = coffeeService ?? throw new ArgumentNullException(nameof(coffeeService));

        [HttpGet]
        public IActionResult GetAllCoffees()
        {
            return Ok(coffeeService.GetAllCoffees());
        }
    }
}
