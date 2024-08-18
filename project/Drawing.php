<?php include 'inc/header.php'; ?>

<?php



if (isset($_POST["nextImage"])) {
    $_GET["nextImage"] = $_POST["nextImage"];
}

if (isset($_POST["mahdeCanvas"]) && $_POST["mahdeCanvas"] != "") {
    $data = $_POST["mahdeCanvas"];
    list($type, $data) = explode(';', $data);
    list(, $data)      = explode(',', $data);
    $data = base64_decode($data);

    $fileName = 'admin/uploads/' . time() . '.png';
    $strr = "";
    $data1 = "";

    $openModal = false;
    if (isset($_GET["nextImage"])) {
        $nextImage = intval($_GET["nextImage"]);
        file_put_contents($fileName, $data);
        $results = PyAPI::get($fileName, $nextImage, $strr, $data1);
        $openModal = true;
    }
}

$nextImage = 1;
if (isset($_GET["nextImage"])) {
    $nextImage = intval($_GET["nextImage"]);
}
$query = "SELECT * FROM img_drawing WHERE id_d = '$nextImage'";
if ($db->select($query)) {
    $result = $db->select($query);
    $resultData = $result->fetch_assoc();
} else {
    header("Location:finalD.php");
    exit();
}

// $query = "SELECT * FROM img_drawing WHERE id_d = '$nextImage'";
// $result = $db->select($query);
// $resultData = $result->fetch_assoc();





?>



<input type="hidden" value="<?php echo $resultData["image"] ?>" id="newMahdeCanvas" />

<main class="main1" style="margin-top: 120px">
    <div class="left-block">
        <div class="colors">
            <button type="button" value="#0000ff"></button>
            <button type="button" value="#009fff"></button>
        </div>
        <div class="brushes">
            <button type="button" value="6"></button>
            <button type="button" value="7"></button>
            <button type="button" value="8"></button>
            <button type="button" value="9"></button>
            <button type="button" value="10"></button>
        </div>
        <div class="buttons">
            <button id="clear" type="button">Clear</button>
            <button id="save" type="button"></button>
        </div>
    </div>
    <div class="right-block">
        <canvas id="paint-canvas" width="640" height="400"></canvas>
    </div>

</main>
<form id="myForm" method="POST">
    <input name="mahdeCanvas" type="hidden" id="mahdeCanvas" value="" />
    <input name="nextImage" type="hidden" value="<?php if (isset($_GET["nextImage"])) echo intval($_GET["nextImage"]);
                                                    else echo 1;  ?>" />
    <button type="submit" class="submitBtn">Submit</button>
</form>
<form id="nextForm" method="GET">
    <input name="nextImage" type="hidden" value="<?php if (isset($_GET["nextImage"])) echo intval($_GET["nextImage"]) + 1;
                                                    else echo 2;  ?>" />
    <button type="submit" class="submitBtn">Next</button>
</form>

<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">Your Score <?php echo $results[1], $results[2]; ?></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center ">
                <img class="img-fluid" src=" data:image/png;charset=utf-8;base64,<?php echo $results[0]; ?>" />
            </div>
            <div class="modal-body text-center ">
                <img class="img-fluid" src=" data:image/png;charset=utf-8;base64,<?php echo $results[3]; ?>" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<?php include 'inc/footer.php'; ?>