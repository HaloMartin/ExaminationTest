# ExaminationTest
方舟行笔试内容

运行环境：Xcode 9.1（9B55），macOS High Sierra 10.13.1

# 题目1，给定两个由0-9数字组成的最长可达30个字符的字符串，请计算他们对应的整数的和
> 允许使用字符串转最大不超过32bit整型的系统函数，比如123，100，结果为：223

这个比较简单，就是模仿加法运算的过程：

1. **反转输入的加数、被加数字符串**；
2. **以较长的字符串长度为准，在末尾加0，补齐较短字符串长度，方便计算**；
3. **逐位相加**，因为已经反转，所以个位的位置在第0位，十位百位千位分别在1、2、3位；
4. **检查进位标志**，如果进位标志为YES，则表示更高位要加1，如个位相加是6+7=13，则进位标志为YES，十位在计算的时候就需要加上这个进位；
5. **若还没有全部计算完，继续步骤3；否则继续步骤6**；
6. **检查进位标志看是否发生溢出**，如果溢出，则需要进一位，如999+1，到步骤6时，检查到发生溢出，则进1，结果为1000；
7. **去掉计算结果中末尾的0后，反转回来**；
8. **输出结果**。

相关代码在工具类MCUtil中的additionWithSummand:andAddend:里

# 题目2，给定一个数字，请返回其对应的字符串
> 数字和字符串对应的关系如下：
1->Z, 2->Y, 3->X, ... ,25->B, 26->A,
27-ZZ, 28->ZY, ...

咋一看，这东西就是一个找规律的题目，规律很简单，基础就是1到26对应大写字母Z到A的映射，然后用大写字母的组合来组合出其他的数字，本质上还是一个进制转换的问题。

需求可以直接理解成十进制转26进制的问题，注意，这边的十进制数不包含数字0，代码中也需要处理这种特殊情况；

我在工具类MCUtil中写了一个common方法，convertDecimal:toMFormat:，作用是把十进制转成指定的任意进制的值，这个方法是模拟进制转换的计算过程，所以结果是反的，实际在使用的时候需要反转一下。

接下来是具体过程了：
1. **需要把基础的映射关系保存下来**，我选择使用是OC中的NSDictionary来保存，C/C++中可以使用map替代，以数字为key，以对应的大写字母作为value
2. **把输入的十进制数转成指定的26进制数**
3. **根据步骤1中得到的映射关系得到转换后的字符串**
4. **反转字符串以得到正确的结果**

# 题目3，计算网约车司机的服务分
>其计算规则如下：
> 1. ***取最近的不多于50单（多于50单则取最近的50单）***
> 2. ***对于每一单，乘客好评权重是1，差评是-1，投诉是-3***
> 3. ***服务分 = 总权重 * 100 / 总单数***

请设计相应的数据结构和接口，其中接口定义要求如下：
1. **输入**：最近的一单的评分情况：好评/差评/投诉
2. **输出**：服务分
举例：
司机已经接了9单，都是好评。现在又接1单，但是得到差评，其服务分是：（9 * 1 - 1 * 1）* 100 / 10 = 80

定义个订单信息**MCClientOrder**，包含订单和评价信息，实际中应该限制一下访问权限，外部不能修改的订单信息，只能读，可以在扩展（Extension）中定义属性，然后添加对应的访问和设置方法；

评价信息是固定的，可以使用枚举**MCClientComment**定义对应的三种；

司机对象是**MCDriver**，这边可以暴露给外部常用的信息，如已完成订单数量，订单信息等；

定义了两个协议，来模仿接口:
1. ***MCDriverService***，协议中包含的方法*calculateScoreWithOrder:*就是题目中要求的接口，传入一个订单信息即可计算出对应的服务分；
2. ***MCDriverCommentRules***，这个是额外的协议接口，是用来让实现多态，因为不同司机的评分规则可能不一样，这样做可以更好，根据题目，有三个不同的规则：
* 规则1，取最近的不多于X单（多于X单则取最近的X单），返回X；对应方法*numberOfCommentsFromDriver*:
* 规则2，对于每一单，返回评分规则，好评差评投诉对应的奖惩规则,返回结果中要求key为**MCClientComment**，value为对应的奖惩分数，元素都是**NSNumber**；对应方法：*rewardAndPunishRulesOfCommentsFromDriver:*
* 规则3，服务分计算规则；对应方法：*scoreOfCommentsFromDriver:*

另外**MCDriverTest**是测试类，用来模仿调用司机对象，在这需要实现***MCDriverCommentRules***协议，这里我使用了delegate的方式，让**MCDriverTest**来决定规则，如果不需要的话，也可以直接在**MCDriver**中加上这个协议，就想***MCDriverService***一样。

此外在MCDriver的init方法中，我模拟了100个数据，方便测试，另外也打印了一些信息，如果不需要的话可以注释掉。

其他可以参考代码，main中已经写好了相关测试代码，取消相关注释即可运行。
