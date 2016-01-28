namespace DallasTechFest2016.Models
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("BlogPost")]
    public partial class BlogPost
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public BlogPost()
        {
            Comments = new HashSet<Comment>();
        }

        public int BlogPostId { get; set; }

        [Required()]
        [MaxLength(50, ErrorMessage = "Please restrict your title to 50 characters")]
        public string Title { get; set; }

        public string Content { get; set; }

        public int BlogId { get; set; }

        public virtual Blog Blog { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Comment> Comments { get; set; }
    }
}
