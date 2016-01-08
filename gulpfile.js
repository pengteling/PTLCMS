var gulp = require('gulp');

/*自动地从package.json中加载任意Gulp插件*/
var gulpLoadPlugins = require('gulp-load-plugins'),
    plugins = gulpLoadPlugins();



//压缩js
//var uglify = require('gulp-uglify');
gulp.task('uglify', function() {
    gulp.src('js/*.js')
        .pipe(plugins.uglify())
        .pipe(gulp.dest('build'));
});

//压缩CSS
gulp.task('minifycss', function() {
    gulp.src('css/*.css')
        .pipe(plugins.minifyCss())
        .pipe(gulp.dest('build'));
});

/*实时监测 浏览器实时变化*/
var browserSync = require('browser-sync');
gulp.task('browser-sync', function() {
    var files = [
        '**/*.html',
        'css/**/*.css',
        '/js/**/*.js'
    ];
    browserSync.init(files, {
        server: {
            baseDir: './web/'
        }
    });
});

//合并所有js
gulp.task('alljs', function() {
    gulp.src('bower_components/**/dist/**/*.min.js', {
        base: 'bower_components'
    })
        .pipe(plugins.uglify())
        .pipe(plugins.concat("base.js"))
        .pipe(gulp.dest('web/js'));
})

//合并所有CSS
gulp.task('allcss', function() {
    gulp.src('bower_components/**/dist/**/*.min.css', {
        base: 'bower_components'
    })
        .pipe(plugins.minifyCss())
        .pipe(plugins.concat("base.css"))
        .pipe(gulp.dest('web/css'));
})

gulp.task('start', ['alljs', 'allcss'])