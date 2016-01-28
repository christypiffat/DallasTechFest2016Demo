namespace DallasTechFest2016.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class BlogEntities : DbContext
    {
        public BlogEntities()
            : base("name=BlogEntities")
        {
        }

        public virtual DbSet<Blog> Blogs { get; set; }
        public virtual DbSet<BlogPost> BlogPosts { get; set; }
        public virtual DbSet<Comment> Comments { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BlogPost>()
                .HasMany(e => e.Comments)
                .WithRequired(e => e.BlogPost)
                .WillCascadeOnDelete(false);
        }
    }
}
