content = string(
    GenDoc.generate_front_matter(;
        title = "Simple and binary regression",
        date = "2020-03-05",
        tags = "['simulating data']"
    ),
raw"""

One of the most famous scientific discoveries was Newton's laws of motion.
The laws allowed people to make predictions.
For example, the acceleration for an object can be predicted given the applied force and the mass of the object.
Making predictions remains a popular endeavour.
This post explains the simplest way to predict an outcome for a new value, given a set of points.

To explain the concepts, data on apples and pears is generated.
Underlying relations for the generated data are known.
The known relations can be compared to the results from the regression.
This post is accompanied by code which can be found in the [R Markdown file](/notebooks/regression.html).

## Generating data
The goal is to predict whether a fruit is an apple or a pear.
Say we have a sample of size $n$.
Say the sample consist of two properties for each fruit, namely

- height, and
- width.

The properties for the fruit at index $i$ are respectively denoted by $h_i$ and $w_i$.
Prediction will be done for the fruit type, which is denoted by $y_i$.
The sample indices can be visualised as follows.

I | H | W | Y
--- | --- | --- | ---
1 | $h_1$ | $w_1$ | $y_1$
2 | $h_2$ | $w_2$ | $y_2$
... | ... | ... | ...
$n$ | $h_n$ | $w_n$ | $y_n$

Let half of the elements be apples and half of the elements be pears.
So, $n$ is even.
Let

$$
y_{i} =
\begin{cases}
\text{apple} & \text{if $i$ is odd}, \: \text{and} \\
\text{pear} & \text{if $i$ is even}.
\end{cases}
$$

Let the height and fruit type be correlated.
To this end define

$$
h_{i} =
\begin{cases}
\text{one sample of size 1 drawn from } N(10, 1) & \text{if $Y_i$ is apple}, \: \text{and} \\
\text{one sample of size 1 drawn from } N(12, 1) & \text{if $Y_i$ is pear}.
\end{cases}
$$

Let the height and width also be correlated.
Define the width to be 0.6 times the height.
Specifically,

$$ w_i = 0.6 H_i. $$

## Simple linear regression
A *simple linear regression* fits a line through points in two dimensions.
It should be able to infer the relation between $H$ and $W$.

{{< center >}}
*Height and width*
![](/images/regression/w-h.svg)
{{< /center >}}

The algorithmic way to fit a line is via the *method of least squares*.
Any straight line can be described by a linear equation of the form $y = p_1 x + p_0$, where the first parameter $p_0$ is the intercept with $y$ and the second parameter $p_1$ is the slope.
Adding an error $e$, and rewriting yields

$$
\begin{aligned}
y_i & = p_0 + p_1 x_i + e_i \\
e_i & = y_i - p_0 - p_1 x_i. \\
\end{aligned}
$$

An algorithm could now be defined to naively minimize the sum of all the errors

$$ S'(p_0, p_1) = \sum_{i=1}^n e_i $$

with respect to the choice of $p_0$ and $p_1$.
This would not always result in a well fitted line, since errors might cancel each other out.
For example, when $e_1 = 10$ and $e_2 = -10$, then $e_1 + e_2 = 0$.
This is solved by squaring the errors.
The method of least squares minimizes

$$ S(p_0, p_1) = \sum_{i=1}^n e_i^2 = \sum_{i=1}^n (y_i - p_0 - p_1 x_i)^2 $$

with respect to the choice of $p_0$ and $p_1$ (Rice, [2006](#rice2006mathematical)).
The simplest estimator for the points is the mean.

{{< center >}}
*Errors for the simplest estimator*
![](/images/regression/w-h-mean.svg)
{{< /center >}}

Let $\overline{h}$ be the mean of $H$.
The squared sum of the errors for $p_0 = \overline{h}$ and $p_1 = 0$ is

$$ S(\overline{h}, 0) = \sum_{i=1}^n e_i^2 \approx 33.2. $$

This error cannot be compared to other errors, since it is not standardized.
A standardized metric is the Pearson correlation coefficient $r$.
(See the blog post on [correlations](/posts/correlations) for more information.)
The fit according to the correlation coefficient is undefined, since the variance of $H$ is zero.

Minimizing the least squares error with R finds $p_0 \approx 0.01$ and $p_1 \approx 1.66$.
The difference with our definition for $W$ and the fitted model is likely due to rounding errors.

{{< center >}}
*Fitted line*
![](/images/regression/w-h-fit.svg)
{{< /center >}}

For the fitted line, $S(p_0, p_1) \approx 0.02$ and $r \approx 1.00$.

## Binary logistic regression
Next up is inference on the relation between $Y$ and $W$.
The method of least squares is unable to calculate an error for "apple" and "pear".
A work-around is to encode "apple" as 0 and "pear" as 1.
A line can now be fitted.

{{< center >}}
*Fitted line through fruit type and width*
![](/images/regression/w-y-fit.svg)
{{< /center >}}

As can be observed from the image for the binary regression, the model does not take into account that $Y$ is a binary variable.
The model even predicts values outside the expected range, that is, values outside the range 0 to 1.
A better fit is the logistic function.

{{< center >}}
Fitted logistic model through fruit type and width
![](/images/regression/w-y-logit-fit.svg)
{{< /center >}}

The correlation coefficient $r$ should not be used to compare the models, since $Y$ is not linear.
Classification *accuracy* is a better metric:

$$ \text{accuracy} = \frac{\text{number of correct predictions}}{\text{total number of predictions}} . $$

The threshold is set to 0.5 to get a binary prediction from both models.
More precisely: let $m(d)$ denote the prediction for $y_i$, and $y_i'$ denote the binary prediction for $y_i$.
For each prediction

$$
y_i' =
\begin{cases}
0 & \text{if $m(y_i) \leq 0.5$}, \: \text{and} \\
1 & \text{if $0.5 < m(y_i).$}
\end{cases}
$$

The least squares error and accuracy for both models are as follows.

model | $\boldsymbol{S(p_0, p_1)}$ | accuracy
--- | --- | ---
Linear regression | 2.39 | 0.83
Logistic regression | 2.02 | 0.89

So, both metrics improve when switching to the logistic function.

## References
{{< id rice2006mathematical >}}
Rice, J. A. (2006).
Mathematical statistics and data analysis.
Cengage Learning.

"""
)
