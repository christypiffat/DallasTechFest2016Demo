namespace DallasTechFest2016.Models
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("Blog")]
    public partial class Blog
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Blog()
        {
            BlogPosts = new HashSet<BlogPost>();
        }

        public int BlogId { get; set; }

        [Required]
        [MaxLength(50, ErrorMessage = "Please restrict your blog name to 50 characters")]
        public string Name { get; set; }

        [Required]
        [MaxLength(200, ErrorMessage = "Please restrict your URL to 200 characters")]
        [DataType(DataType.Url)]
        public string Url { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BlogPost> BlogPosts { get; set; }
    }
}
