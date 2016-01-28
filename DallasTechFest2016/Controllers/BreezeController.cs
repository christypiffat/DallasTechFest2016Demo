using Breeze.ContextProvider;
using Breeze.ContextProvider.EF6;
using Breeze.WebApi2;
using DallasTechFest2016.Models;
using Newtonsoft.Json.Linq;
using System.Linq;
using System.Web.Http;

namespace DallasTechFest2016.Controllers
{
    [BreezeController]
    public class BreezeController : ApiController
    {
        // EFContextProvider
        readonly EFContextProvider<BlogEntities> _db = new EFContextProvider<BlogEntities>();

        // ~/breeze/Breeze/Metadata
        [HttpGet]
        public string Metadata()
        {
            return _db.Metadata();
        }

        // ~/breeze/Breeze/SaveChanges
        [HttpPost]
        public SaveResult SaveChanges(JObject saveBundle)
        {
            return _db.SaveChanges(saveBundle);
        }

        // ~/breeze/Breeze/Blogs
        // ~/breeze/Breeze/Blogs?$filter=substringof(Url,'msdn')
        // ~/breeze/Breeze/Blogs?$filter=BlogId lt 3
        // ~/breeze/Breeze/Blogs?$expand=BlogPosts
        [HttpGet]
        public IQueryable<Blog> Blogs()
        {
            return _db.Context.Blogs;
        }

        // ~/breeze/Breeze/BlogsFromMSDN
        [HttpGet]
        public IQueryable<Blog> BlogsFromMSDN()
        {
            return _db.Context.Blogs.Where(b => b.Url.Contains("msdn"));
        }
        
        // ~/breeze/Breeze/Comments
        // ~/breeze/Breeze/Comments?$filter=BlogPostId eq 3
        [HttpGet]
        public IQueryable<Comment> Comments()
        {
            return _db.Context.Comments;
        }
    }
}
