namespace DallasTechFest2016.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Comment")]
    public partial class Comment
    {
        public int CommentId { get; set; }

        [MaxLength(2000, ErrorMessage = "Please restrict your comment to 2000 characters")]
        public string Content { get; set; }

        public int BlogPostId { get; set; }

        public virtual BlogPost BlogPost { get; set; }
    }
}
