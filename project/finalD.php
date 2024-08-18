<?php include 'inc/header.php'; ?>
<?php
Session::checkSession();
?>

<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center">
            <h1 class="mt-5">Congratulations <span class="sr-only">(current)</span><strong><?php echo Session::get("name"); ?></strong> You completed the Draw Test.</h1>
            <p class="lead">see you next time , Study Well good luck</p>
            </a>

            <a class="btn btn-outline-info btn-lg" href="Drawing.php"><span class="fa fa-arrow-right"></span> Start Draw Test again</a>
        </div>

    </div>
</div>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<?php include 'inc/footer.php'; ?>