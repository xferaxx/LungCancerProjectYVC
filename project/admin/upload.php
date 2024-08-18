<?php
// Include the database configuration file  
require_once 'dbConfig.php';

// If file upload form is submitted 
$status = $statusMsg = '';


$target_dir = "uploads/";
$target_file = $target_dir . basename($_FILES["img"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

// Check if image file is a actual image or fake image
if (isset($_POST["submit"])) {
    $check = getimagesize($_FILES["img"]["tmp_name"]);
    if ($check !== false) {
        $statusMsg = "File is an image - " . $check["mime"] . ".";
        $uploadOk = 1;
    } else {
        $statusMsg = "File is not an image.";
        $uploadOk = 0;
    }
}

// Allow certain file formats
if (
    $imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
    && $imageFileType != "gif"
) {
    $statusMsg = "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
    $uploadOk = 0;
}

// Check if $uploadOk is set to 0 by an error
if ($uploadOk == 0) {
    $statusMsg = "Sorry, your file was not uploaded.";
    // if everything is ok, try to upload file
} else {
    if (move_uploaded_file($_FILES["img"]["tmp_name"], $target_file)) {
        $status = 'success';

        $ImgName = "admin/uploads/" . basename($_FILES["img"]["name"]);
        $ImgTyp = $_POST["ImgTyp"];
        $priority = filter_input(INPUT_POST, "priority", FILTER_VALIDATE_INT);

        $insert = $db->query("INSERT INTO images (ImgName,ImgType,ImgLevel) VALUES ('$ImgName','$ImgTyp','$priority')");
        if ($insert) {
            $status = 'success';
            $statusMsg = "File uploaded successfully.";
    } else {
        $statusMsg = "Sorry, there was an error uploading your file.";
    }
}

exit();

if (isset($_POST["upload"])) {
    $status = 'error';
    if (!empty($_FILES["img"]["name"])) {
        // Get file info 
        $fileName = basename($_FILES["img"]["name"]);
        $fileType = pathinfo($fileName, PATHINFO_EXTENSION);

        // Allow certain file formats 
        $allowTypes = array('jpg', 'png', 'jpeg', 'gif');
        if (in_array($fileType, $allowTypes)) {
            $image = $_FILES['img']['tmp_name'];
            $imgContent = file_get_contents($image);
            $base64 = 'data:image/' . $fileType . ';base64,' . base64_encode($imgContent);
            $ImgTyp = $_POST["ImgTyp"];
            $priority = filter_input(INPUT_POST, "priority", FILTER_VALIDATE_INT);
            $insert = $db->query("INSERT INTO images (ImgName,ImgType,ImgLevel) VALUES ('$base64','$ImgTyp','$priority')");

            if ($insert) {
                $status = 'success';
                $statusMsg = "File uploaded successfully.";
            } else {
                $statusMsg = "File upload failed, please try again.";
            }
        } else {
            $statusMsg = 'Sorry, only JPG, JPEG, PNG, & GIF files are allowed to upload.';
        }
    } else {
        $statusMsg = 'Please select an image file to upload.';
    }
}

// Display status message 
echo $statusMsg;
}