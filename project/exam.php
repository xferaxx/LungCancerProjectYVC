<?php include 'inc/header.php'; ?>
<?php
Session::checkSession();
?>

<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center">
            <h1 class="mt-5">You can start your exam</h1>
            <p class="lead">Take your time. Click Start Exam when you are ready.</p>
            <img src="img/okkk.png" height="200" width="200" />
        </div>
        <div class="col-lg-6 text-center">
            <a href="starttest.php" class="btn btn-success btn-lg">
                <span class="fa fa-arrow-right"></span> Start Exam Now!
            </a>
        </div>
        <div class="col-lg-6 text-center">
            <a href="Drawing.php" class="btn btn-success btn-lg">
                <span class="fa fa-arrow-right"></span> Start Drawing
            </a>
        </div>


    </div>
</div>