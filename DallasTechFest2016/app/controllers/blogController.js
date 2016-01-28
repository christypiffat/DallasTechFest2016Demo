'use strict';
app.controller('blogController', ['$q', 'additionalFunctions', function ($q, additionalFunctions) {

    /*******************************************************************************
        Properties                                                             
    ********************************************************************************/
    var em = new breeze.EntityManager('breeze/Breeze');
    var blogPost;
    var self = this;

    self.blogs = [];
    self.selectedBlog;
    self.newBlogPost;

    /*******************************************************************************
       Functions                                                             
    ********************************************************************************/

    function getBlogs() {
        // Set up query
        var query = breeze.EntityQuery
                .from('Blogs')
                .expand('BlogPosts');

        // Execute query
        return em.executeQuery(query)
            .then(function (data) {
                self.blogs = data.results;
                if ((!self.selectedBlog) && (self.blogs) && (self.blogs.length > 0)) {
                    self.selectedBlog = getSelectedBlog(self.blogs[0])[0];
                }
            }).catch(function (err) {
                additionalFunctions.addAlert(err.message, 'error');
            });
    }

    function getSelectedBlog(blog) {
        // Set up query
        var query = breeze.EntityQuery
                .from('Blogs')
                .where('BlogId', 'eq', blog.BlogId);

        // Execute query locally
        return em.executeQueryLocally(query);
    }

    getBlogs();

    /*******************************************************************************
        Methods                                                             
    ********************************************************************************/

    self.selectBlog = function (blog) {
        self.selectedBlog = getSelectedBlog(blog)[0];
    };

    self.addBlogPost = function () {
        blogPost = em.createEntity('BlogPost', {
            Title: self.newBlogPost.Title,
            Content: self.newBlogPost.Content,
            BlogId: self.selectedBlog.BlogId
        });
        self.newBlogPost.Title = '';
        self.newBlogPost.Content = '';
    }

    self.saveAll = function () {
        var deferred = $q.defer();
        if (em.hasChanges()) {
            em.saveChanges()
                .then(function (data) {
                    additionalFunctions.addAlert('Blog post(s) added successfully', 'success');
                    deferred.resolve(data);
                })
                .catch(function (err) {
                    additionalFunctions.addAlert('Error saving blog posts: ' + err.message, 'error');
                    deferred.reject(err);
                });
        }
        else {
            deferred.resolve();
        }
        return deferred.promise;
    };

    self.cancelAll = function () {
        for (var i = 0; i < self.blogs.length; i++) {
            for (var j = 0; j < self.blogs[i].BlogPosts.length; j++) {
                self.selectedBlog.BlogPosts[j].entityAspect.rejectChanges();
            }
        }
    }

}]);
