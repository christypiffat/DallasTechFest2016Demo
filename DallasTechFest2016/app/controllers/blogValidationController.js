'use strict';
app.controller('blogValidationController', ['$q', 'additionalFunctions', function ($q, additionalFunctions) {

    /*****************************************************************************************************
      Validators
    *****************************************************************************************************/
    //// Add custom validator for Name
    //blogUrl.validators.push(lengthValidatorFactory({ maxValue: 200, minValue: 15 }));
    //// now register in breeze
    //breeze.Validator.registerFactory(lengthValidatorFactory, "lengthValidator");

    function isValidLength(value, context) {
        return value.length >= context.minValue && value.length <= context.maxValue;
    }

    function lengthValidatorFactory(context) {
        return new breeze.Validator(
            "lengthValidator",
            isValidLength,
            {
                minValue: context.minValue,
                maxValue: context.maxValue,
                messageTemplate: breeze.core.formatString("%displayName% length '%value%' must be between %1 and %2 characters", context.minValue, context.maxValue)
            }
        );
    }

	function initValidation(em) {
		// get entity store
		var store = em.metadataStore;

		// get Blog and its Url property
		var blogType = store.getEntityType('Blog');
		var blogUrl = blogType.getProperty('Url');

	    // Add URL validator
		blogUrl.validators.push(breeze.Validator.url());
	    // Add custom validator for Name
		blogUrl.validators.push(lengthValidatorFactory({ maxValue: 200, minValue: 15 }));
	    // now register in breeze
		breeze.Validator.registerFactory(lengthValidatorFactory, "lengthValidator");

		getBlogs();
	};

    /*******************************************************************************
        Properties                                                             
    ********************************************************************************/
    var em = new breeze.EntityManager('breeze/Breeze');
	// set validators
	em.fetchMetadata().then(function () { initValidation(em); });

	var blogName = null;
    var blogPost = null;
    var token = null;
    var self = this;

    self.blogs = [];
    self.selectedBlog;
    self.newBlogPost;
    self.newBlog;
    self.addingNewBlog = false;
    self.addingNewPost = false;

    self.errorList = [];

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

    /*******************************************************************************
        Methods                                                             
    ********************************************************************************/

    self.addBlog = function () {
        self.newBlog = em.createEntity('Blog');
        token = self.newBlog.entityAspect.validationErrorsChanged.subscribe(function (args) {
            if ((args.added) || (args.removed)) {
                self.validateBlog();
            }
        });
        self.validateBlog();
        self.addingNewBlog = true;
    }

    self.validateBlog = function () {
        // Null out error list
        self.blogNameErrors = null;
        self.blogUrlErrors = null;

        if (!self.newBlog.entityAspect.validateEntity()) {
            var errors = self.newBlog.entityAspect.getValidationErrors();
            var nameErrors = '';
            var urlErrors = '';

            for (var i = 0; i < errors.length; i++) {
                if (errors[i].propertyName == 'Name') {
                    if (nameErrors.length > 0) nameErrors += ", ";
                    nameErrors += errors[i].errorMessage;
                }
                else if (errors[i].propertyName == 'Url') {
                    if (urlErrors.length > 0) urlErrors += ", ";
                    urlErrors += errors[i].errorMessage;
                }
            }
            if (nameErrors !== '') self.blogNameErrors = nameErrors;
            if (urlErrors !== '') self.blogUrlErrors = urlErrors;
            return false;
        }
        else {
            return true;
        }
    }
    self.selectBlog = function (blog) {
        self.selectedBlog = getSelectedBlog(blog)[0];
    };

    self.addPost = function () {
        self.addingNewPost = true;
    }

    self.addBlogPost = function () {
        blogPost = em.createEntity('BlogPost', {
            Title: self.newBlogPost.Title,
            Content: self.newBlogPost.Content,
            BlogId: self.selectedBlog.BlogId
        });
        self.newBlogPost.Title = '';
        self.newBlogPost.Content = '';
    };

    self.saveAll = function () {
        var deferred = $q.defer();
        if (self.validateBlog()) {
            if (em.hasChanges()) {
                em.saveChanges()
                    .then(function (data) {
                        additionalFunctions.addAlert('Blog post(s) added successfully', 'success');
                        self.newBlog.entityAspect.validationErrorsChanged.unsubscribe(token);
                        self.addingNewBlog = false;
                        self.addingNewPost = false;
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
        self.addingNewBlog = false;
        self.addingNewPost = false;
    }

}]);
