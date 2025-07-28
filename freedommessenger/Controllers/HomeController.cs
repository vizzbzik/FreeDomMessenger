
using Microsoft.AspNetCore.Mvc;

namespace freedommessenger.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index() => View();
    }
}
