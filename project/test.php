<?php include 'inc/header.php'; ?>

<?php
Session::checkSession();

if (isset($_GET['q'])) {
    $quesnumber = (int) $_GET['q'];
} else {
    header("Location:exam.php");
}
$total    = $exam->getTotalRows();
$question = $exam->getQuestionNumber($quesnumber);


?>

<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $process = $pro->getProcessData($_POST);
}

?>

<div class="container">
    <div class="row">

        <?php if (isset($_SESSION["level"])) { ?>
            <div class="col-xl-4 text-center">
            </div>
            <div class="col-xl-4 text-center">
                <h1 class="mt-5"><?php echo  "The System Entered You To Level:  ", $_SESSION["level"]; ?></h1>
            </div>
            <div class="col-xl-4 text-center">
            </div>
        <?php } else { ?>
            <div class="col-xl-4">
            </div>
        <?php } ?>

        <div class="col-xl-4 text-left">
            <h1 class="mt-5">Question <?php echo $question['quesNo'] . " of " . $total; ?></h1>
        </div>
        <div class="col-xl-4">

        </div>
        <div class="col-xl-4">

        </div>

        <div class="col-xl-4">
            <form method="post" action="">
                <table>
                    <tr>
                        <td colspan="2">
                            <h3>Question <?php echo $question['quesNo'] . " : " . $question['ques']; ?></h3>
                        </td>
                    </tr>
                    <?php
                    $answer = $exam->getAnswer($quesnumber);
                    if ($answer) {
                        while ($result = $answer->fetch_assoc()) {
                    ?>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input type="radio" name="ans" class="form-check-input" value="<?php echo $result['id']; ?>" /><?php echo $result['ans']; ?>
                                        </label>
                                    </div>

                                    <!--                                        <input type="radio" name="ans" value="--><?php //echo $result['id']; 
                                                                                                                            ?>
                                    <!--" />--><?php //echo $result['ans']; 
                                                ?>
                                </td>
                            </tr>
                    <?php }
                    } ?>
                    <tr>
                        <td>
                            <br />
                            <input type="submit" name="submit" class="btn btn-primary" value="Continue" />
                            <input type="hidden" name="quesnumber" value="<?php echo $quesnumber; ?>" />

                            <?php if (isset($_GET["token"])) { ?>
                                <input type="hidden" name="token" value="<?php echo $_GET["token"]; ?>" />
                            <?php } else { ?>
                                <input type="hidden" name="token" value="<?php
                                                                            unset($_SESSION["level"]);
                                                                            echo time() ?>" />
                            <?php } ?>
                        </td>
                    </tr>

                </table>
            </form>
            <br />
            <br />
        </div>

        <div class="col-xl-4">
            <img class="img-fluid" src="<?php echo $exam->getImage($quesnumber)["ImgName"]; ?>" alt="" />
        </div>
    </div>
</div>