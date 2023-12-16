#!/bin/bash

# 定义可执行文件和测试文件的路径
ASSIGNMENT3_EXECUTABLE="/root/assign3/build/assignment3"
TEST_DIR="/root/assign3/bc"

# 测试用例的正则表达式
declare -A regex_map
regex_map["test00"]="^14: ((plus, minus)|(minus, plus))"
regex_map["test01"]="^22: ((plus, minus)|(minus, plus))"
regex_map["test02"]="^28: ((plus, minus)|(minus, plus))"
regex_map["test03"]="^27: ((plus, minus)|(minus, plus))"
regex_map["test04"]="^10: ((plus, minus)|(minus, plus))"
regex_map["test05"]="^33: ((plus, minus)|(minus, plus))"
regex_map["test06"]="^11: malloc\n15 : plus\n21 : minus"
regex_map["test07"]="^19: plus\n25 : minus"
regex_map["test08"]="^25: plus\n31 : minus"
regex_map["test09"]="^21: malloc\n27 : plus\n33 : minus"
regex_map["test10"]="^25: malloc\n31 : minus\n37 : plus"
regex_map["test11"]="^11: ((plus, minus)|(minus, plus))\n18 : malloc\n27 : clever"
regex_map["test12"]="^11: ((plus, minus)|(minus, plus))\n21 : malloc\n30 : clever"
regex_map["test13"]="^15: ((plus, minus)|(minus, plus))\n31 : clever"
regex_map["test14"]="^10: ((plus, minus)|(minus, plus))\n14 : foo\n30 : clever"
regex_map["test15"]="^15: ((plus, minus)|(minus, plus))\n19 : foo\n35 : clever"
regex_map["test16"]="^16: foo\n17 : plus\n24 : malloc\n32 : clever"
regex_map["test17"]="^20: foo\n21 : ((plus, minus)|(minus, plus))\n37 : clever"
regex_map["test18"]="^30: ((foo, clever)|(clever, foo))\n31 : ((plus, minus)|(minus, plus))"
regex_map["test19"]="^24: foo\n28 : clever\n30 : plus"
regex_map["test20"]="^47: ((foo, clever)|(clever, foo))\n48 : ((plus, minus)|(minus, plus))"
regex_map["test21"]="^15: ((plus, minus)|(minus, plus))\n31 : clever"
regex_map["test22"]="^17: plus\n31 : make_simple_alias\n32 : foo"
regex_map["test23"]="^14: ((plus, minus)|(minus, plus))\n25 : malloc\n26 : malloc\n30 : foo\n31 : make_simple_alias\n33 : foo"
regex_map["test24"]="^17: minus\n29 : make_no_alias\n30 : foo"
regex_map["test25"]="^21: plus\n37 : make_alias\n38 : foo"
regex_map["test26"]="^31: malloc\n39 : plus\n40 : make_alias\n45 : minus"
regex_map["test27"]="^22: plus\n27 : foo\n44 : clever"
regex_map["test28"]="^22: plus\n29 : foo\n34 : malloc\n36 : malloc\n38 : malloc\n47 : clever"
regex_map["test29"]="^21: ((plus, minus)|(minus, plus))\n26 : clever\n27 : ((plus, minus)|(minus, plus))\n41 : malloc\n46 : foo\n51 : foo"

# 用于存储测试结果
declare -a passed_tests
declare -a failed_tests

# 循环运行 30 个测试用例
for i in {00..29}
do
    # 生成测试用例的名称和文件名
    test_name="test${i}"
    TEST_FILE="${TEST_DIR}/${test_name}.bc"

    # 执行测试并获取输出
    echo "Running test case $i"
    output=$($ASSIGNMENT3_EXECUTABLE $TEST_FILE)

    # 获取与测试用例相关联的正则表达式，并将 \n 替换为实际的换行符
    regex=$(echo ${regex_map[$test_name]} | sed 's/\\n/\'$'\n/g')

    # 使用 awk 进行多行匹配
    result=$(echo "$output" | awk -v pat="$regex" '
    {
        buffer=(NR==1)?$0:buffer ORS $0
    }
    END{
        if (buffer ~ pat) {
            print "passed"
        } else {
            print "failed"
        }
    }')

    if [[ $result == "passed" ]]; then
        echo "Test $test_name passed."
        passed_tests+=("$test_name")
    else
        echo "Test $test_name failed."
        echo "Expected pattern: $regex"
        echo "Actual output: $output"
        failed_tests+=("$test_name")
    fi
done

# 打印总结
echo "Testing Summary:"
echo "----------------"
echo "Passed Tests: ${passed_tests[@]}"
echo "Failed Tests: ${failed_tests[@]}"
