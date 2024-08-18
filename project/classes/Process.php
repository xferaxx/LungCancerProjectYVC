<?php

$filepath = realpath(dirname(__FILE__));
include_once($filepath . '/../lib/Session.php');
include_once($filepath . '/../lib/Database.php');
include_once($filepath . '/../helpers/Format.php');


class Process
{
  private $db;
  private $fm;

  public function __construct()
  {
    $this->db = new Database();
    $this->fm = new Format();
  }

  public function getProcessData($data)
  {
    if (!isset($data['ans'])) {
      header("Location:test.php?q=" . $data['quesnumber'] . "&token=" . $data["token"]);
      exit();
    }

    $selectAns        = $this->fm->validation($data['ans']);
    $quesnumber = $this->fm->validation($data['quesnumber']);
    $selectAns        = mysqli_real_escape_string($this->db->link, $selectAns);
    $quesnumber = mysqli_real_escape_string($this->db->link, $quesnumber);
    $next       = $quesnumber + 1;

    if (!isset($_SESSION['score'])) {
      $_SESSION['score'] = '0';
    }

    $total = $this->getTotal();
    $right = $this->rightAns($quesnumber);
    if ($right == $selectAns) {
      $_SESSION['score']++;
    }

    $this->insertUserExam(
      $quesNo = $quesnumber,
      $rightAns = $right,
      $answer = $selectAns,
      $img_id = $quesnumber,
      $imgLevel = $this->getImageLevel($quesnumber),
      $token = $data["token"],
      $_SESSION["userId"]
    );

    $next = PyAPI::getLevel($_SESSION["userId"], $data["token"]);
    if ($next == "Low" || $next == "Medium" || $next == "High") {
      $_SESSION["level"] = $next;
      $next = $this->getNext($data["token"], $next);
      header("Location:test.php?q=" . $next . "&token=" . $data["token"]);
      exit();
    }

    if ($quesnumber == $total) {
      header("Location:final.php");
      exit();
    } else {
      header("Location:test.php?q=" . $next . "&token=" . $data["token"]);
    }
  }

  private function getNext($token, $level)
  {
    if ($level == "Low") $level = 1;
    else if ($level == "Medium") $level = 2;
    else if ($level == "High") $level = 3;
    $query = "SELECT quesNo, (SELECT COUNT(*) FROM exam WHERE exam.quesNo = tbl_ques.quesNo AND exam.user_id = '" . $_SESSION["userId"] . "' AND token='" . $token . "') as cnt,
    (SELECT ImgLevel FROM images WHERE images.id = tbl_ques.quesNo) as level
    FROM tbl_ques WHERE (SELECT COUNT(*) FROM exam WHERE exam.quesNo = tbl_ques.quesNo AND exam.user_id = '" . $_SESSION["userId"] . "' AND token='" . $token . "') = 0
    
    AND (SELECT ImgLevel FROM images WHERE images.id = tbl_ques.quesNo) = " . $level . "
    ;";
    if ($this->db->select($query)) {
      $result = $this->db->select($query)->fetch_assoc();
      return $result["quesNo"];
    } else {
      header("Location:final.php");
      exit();
    }
  }


  private function getTotal()
  {
    $query = "SELECT * FROM tbl_ques";
    $result = $this->db->select($query);
    $resultData = $result->num_rows;
    return $resultData;
  }

  private function rightAns($quesnumber)
  {
    $query = "SELECT * FROM tbl_ans WHERE quesNo = '$quesnumber' AND rightAns = '1'";
    $result = $this->db->select($query)->fetch_assoc();
    $rightar = $result['id'];
    return $rightar;
  }

  private function getImageLevel($quesnumber)
  {
    $query = "SELECT * FROM images WHERE id = '$quesnumber'";
    $result = $this->db->select($query)->fetch_assoc();
    $rightar = $result['ImgLevel'];
    return $rightar;
  }

  private function insertUserExam(
    $quesNo = "",
    $rightAns = "",
    $answer = "",
    $img_id = "",
    $imgLevel = "",
    $token = "",
    $userId = "",
  ) {
    $query = "
INSERT INTO `exam` (`quesNo`, `rightAns`, `answer`, `img_id`, `imgLevel`, `token`, `user_id`) 
VALUES ('" . $quesNo . "', '" . $rightAns . "', '" . $answer . "', '" . $img_id . "', '" . $imgLevel . "', '" . $token . "', '" . $userId . "')
";
    $insertr = $this->db->insert($query);
  }
}
