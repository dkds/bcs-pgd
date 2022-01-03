/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.util;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author neo
 */
public class NumberConverter {

    private final String[] firstDecimals = {"", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};
    private final String[] secondDecimals = {"", "", "twenty", "thirty", "fourty", "fifty", "sixty", "seventy", "eighty", "ninety"};
    private final String[] numberNames = {"", "", "", "hundred", "thousand", "thousand", "hundred thousand", "million", "million", "billion", "billion", "billion"};
    private String points = "";
    private final String BASE_CURRENCY = "Rupees";
    private final String SUB_CURRENCY = "Cents";
    private final boolean useLacks = false;
    private final boolean currency = false;
    private final int maxDecimals = 11;
    private final boolean addWordONLY = false;
    private final boolean lowerCase = true;
    private final boolean upperCase = false;
    private final boolean wordCase = false;

    public String convertValue(String text) {
        String converted = "";
        String decimalText = formatToInt(text);
        int length = decimalText.length();
        if (length > 0) {
            if (length > 8 && length < 10) {
                converted += " " + convertNinthTenthAndEleventhDecimals(Integer.parseInt(decimalText.substring(
                        length - 9, length - 8))).trim();
            } else if (length > 8 && length < 11) {
                converted += " " + convertNinthTenthAndEleventhDecimals(Integer.parseInt(decimalText.substring(
                        length - 10, length - 8))).trim();
            } else if (length > 8 && length < 12) {
                converted += " " + convertNinthTenthAndEleventhDecimals(Integer.parseInt(decimalText.substring(
                        length - 11, length - 8))).trim();
            }
            if (length > 6 && length < 8) {
                converted += " " + convertSeventhAndEighthDecimals(Integer.parseInt(decimalText.substring(length - 7,
                                                                                                          length - 6))).trim();
            } else if (length > 6) {
                converted += " " + convertSeventhAndEighthDecimals(Integer.parseInt(decimalText.substring(length - 8,
                                                                                                          length - 6))).trim();
            }
            if (length > 5) {
                converted += " " + convertSixthDecimal(Integer.parseInt(decimalText.substring(length - 6, length - 5))).trim();
            }
            if (length > 3 && length < 5) {
                converted += " " + convertFourthAndFifthDecimals(Integer.parseInt(decimalText.substring(length - 4,
                                                                                                        length - 3))).trim();
            } else if (length > 3) {
                converted += " " + convertFourthAndFifthDecimals(Integer.parseInt(decimalText.substring(length - 5,
                                                                                                        length - 3))).trim();
            }
            if (length > 2) {
                if (length > 5 && converted.trim().endsWith(numberNames[3])) {
                    converted += " " + numberNames[4];
                }
                converted += " " + convertThirdDecimal(Integer.parseInt(decimalText.substring(length - 3, length - 2))).trim();
            }
            if (length > 0 && length < 2) {
                converted += " " + convertFirstTwoDecimals(Integer.parseInt(decimalText.substring(length - 1))).trim();
            } else if (length > 0) {
                converted += " " + convertFirstTwoDecimals(Integer.parseInt(decimalText.substring(length - 2, length))).trim();
            }
            converted += " " + convertPoints();
        }
        return format(converted, text).trim();
    }

    private float formatToFloat(String text) {
        String string = text;
        while (string.contains(",")) {
            string = string.substring(0, string.indexOf(',')) + string.substring(string.indexOf(',') + 1,
                                                                                 string.length());
        }
        return Float.parseFloat(string);
    }

    private boolean isValidNumber(String text) {
        boolean isValid = false;
        for (int i = 0; i < text.length(); i++) {
            try {
                Double.parseDouble(text);
            } catch (NumberFormatException e) {
                isValid = false;
                break;
            }
            if (Character.isDigit(text.charAt(i)) || text.charAt(i) == '.') {
                isValid = true;
            } else {
                isValid = false;
                break;
            }
        }
        return isValid;
    }

    private String convertFirstDecimal(int value) {
        if (value < 10) {
            return firstDecimals[value];
        } else {
            return "";
        }
    }

    private String convertSecondDecimal(int value) {
        if (value > 1 && value < 10) {
            return secondDecimals[value];
        } else {
            return "";
        }
    }

    private String convertThirdDecimal(int value) {
        if (value > 0 && value < 10) {
            return convertFirstDecimal(value) + " " + numberNames[3] + " and ";
        } else {
            return "";
        }
    }

    private String convertFourthAndFifthDecimals(int value) {
        if (value > 0 && value < 100) {
            return convertFirstTwoDecimals(value) + " " + numberNames[4];
        } else {
            return "";
        }
    }

    private String convertSixthDecimal(int value) {
        if (value > 0 && value < 10) {
            return convertFirstTwoDecimals(value) + " " + numberNames[6];
        } else {
            return "";
        }
    }

    private String convertSeventhAndEighthDecimals(int value) {
        if (value > 0 && value < 100) {
            return convertFirstTwoDecimals(value) + " " + numberNames[7];
        } else {
            return "";
        }
    }

    private String convertNinthTenthAndEleventhDecimals(int value) {
        String converted = "";
        if (value < 100) {
            converted = convertFirstTwoDecimals(value);
        } else if (value > 99 && value < 1000) {
            converted += " " + convertThirdDecimal(Integer.parseInt(String.valueOf(value).substring(0, 1))).trim();
            converted += " " + convertFirstTwoDecimals(Integer.parseInt(String.valueOf(value).substring(1))).trim();
        }
        return converted + " " + numberNames[10];
    }

    private String convertFirstTwoDecimals(int value) {
        String converted = "";
        if (value < 10) {
            converted = convertFirstDecimal(value);
        } else if (value > 9) {
            converted = convertSpecialSecondDecimals(value);
            if (converted.isEmpty()) {
                String splitted = String.valueOf(value).substring(0, 1);
                converted = convertSecondDecimal(Integer.parseInt(splitted));
                splitted = String.valueOf(value).substring(1);
                converted += " " + convertFirstDecimal(Integer.parseInt(splitted));
            }
        }
        return converted;
    }

    private String convertPoints() {
        String converted = "";
        if (!points.isEmpty() && points.startsWith(".")) {
            if (currency && formatToFloat(points) != 0) {
                converted += " " + BASE_CURRENCY + " and ";
                converted += convertFirstTwoDecimals(Integer.parseInt(String.format("%.2f", Float.parseFloat(
                                                                                    "0" + points)).substring(
                                String.format("%.2f", Float.parseFloat("0" + points)).indexOf('.') + 1)));
                if (converted.endsWith(" and ")) {
                    converted += " zero";
                }
                converted += " " + SUB_CURRENCY;
            } else if (!currency) {
                points = points.substring(1);
                converted = "point";
                for (int i = 0; i < points.length(); i++) {
                    converted += " " + convertFirstDecimal(Integer.parseInt(String.valueOf(points.charAt(i))));
                    if (Integer.parseInt(String.valueOf(points.charAt(i))) == 0) {
                        converted += " zero";
                    }
                }
            }
        }
        return converted;
    }

    private String convertSpecialSecondDecimals(int value) {
        Map<Integer, String> specialDecimals = new HashMap<>(0);
        specialDecimals.put(10, "ten");
        specialDecimals.put(11, "elevan");
        specialDecimals.put(12, "twelve");
        specialDecimals.put(13, "thirteen");
        specialDecimals.put(14, "fourteen");
        specialDecimals.put(15, "fifteen");
        specialDecimals.put(16, "sixteen");
        specialDecimals.put(17, "seventeen");
        specialDecimals.put(18, "eighteen");
        specialDecimals.put(19, "nineteen");
        if (specialDecimals.containsKey(value)) {
            return specialDecimals.get(value);
        } else {
            return "";
        }
    }

    private String trim(String text) {
        String[] trimedParts = text.split(" ");
        String trimed = "";
        for (String trimedPart : trimedParts) {
            if (!trimedPart.trim().isEmpty()) {
                if (lowerCase) {
                    trimed += trimedPart.trim().toLowerCase() + " ";
                } else if (upperCase) {
                    trimed += trimedPart.trim().toUpperCase() + " ";
                } else if (wordCase) {
                    trimed += (trimedPart.trim().substring(0, 1).toUpperCase() + trimedPart.trim().substring(1).toLowerCase()) + " ";
                }
            }
        }
        return trimed;
    }

    private long countOf(String text, String value) {
        if (text.contains(value)) {
            return text.split(value).length - 1;
        } else {
            return 0;
        }
    }

    private String format(String text, String textInField) {
        String string = text;
        try {
            if (Float.parseFloat(textInField) == 0 && string.trim().isEmpty()) {
                string = "zero";
            }
        } catch (NumberFormatException e) {
        }
        if (string.trim().startsWith("point")) {
            string = "zero " + string;
        }
        if (string.trim().startsWith(BASE_CURRENCY)) {
            string = string.replaceFirst(BASE_CURRENCY, "");
        }
        if (string.trim().startsWith(" and")) {
            string = string.replaceFirst(" and", "");
        }
        if (countOf(string.toUpperCase(), " AND") > 1) {
            string = string.replaceFirst(" and", "");
        }
        if (string.trim().endsWith(" and")) {
            string = string.substring(0, string.lastIndexOf(" and")) + string.substring(string.lastIndexOf(" and"),
                                                                                        string.length() - 1).replaceFirst(
                            " and",
                            "");
        }
        if (currency) {
            if (!string.trim().endsWith(SUB_CURRENCY) && !string.trim().endsWith(BASE_CURRENCY)) {
                string += " " + BASE_CURRENCY;
            }
        }
        if (useLacks) {
            if (string.contains(numberNames[6])) {
                string = string.replace(numberNames[6], "lacks");
            }
            if (countOf(string, numberNames[3]) == 2) {
                string = string.replaceFirst(numberNames[3], "lacks");
            }
            if (countOf(string, numberNames[3]) == 3) {
                string = string.replaceFirst(numberNames[3], "lacks");
                string = string.replaceFirst(numberNames[3], "lacks");
                string = string.replaceFirst("lacks", numberNames[3]);
            }
        }
        if (addWordONLY && !string.trim().toUpperCase().endsWith("ONLY")) {
            string += " only";
        }
        return trim(string);
    }

    private String formatToInt(String text) {
        String string = text;
        while (string.contains(",")) {
            string = string.substring(0, string.indexOf(',')) + string.substring(string.indexOf(',') + 1,
                                                                                 string.length());
        }
        if (string.contains(".")) {
            points = string.substring(string.indexOf('.'));
            string = string.substring(0, string.indexOf('.'));
        } else {
            points = "";
        }
        try {
            string = String.valueOf(Long.parseLong(string));
        } catch (NumberFormatException e) {
        }
        return (string);
    }

}
