<?php

class PyAPI
{
    public static function get($image, $id, $strr, $Sol)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "http://127.0.0.1:5000/my-link/?image=" . $image . "&id=" . $id . "&strr=" . $strr . "&Cimage" . $Sol . "&Sol");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($ch);
        curl_close($ch);

        $output = json_decode($output);
        return $output; //[0]=img, [1]=percent
    }

    public static function getLevel($user_id, $token)
    {
        if (isset($_SESSION["level"])) return $_SESSION["level"];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "http://127.0.0.1:5000/my-level/?user_id=" . $user_id . "&token=" . $token);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($ch);
        curl_close($ch);

        if ($output == "Low" || $output == "Medium" || $output == "High") {
            return $output;
        }

        $output = json_decode($output);
        return $output;
    }
}
