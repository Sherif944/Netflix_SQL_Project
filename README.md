# 🎬 Netflix Movies and TV Shows Data Analysis

Welcome to my Netflix Data Analysis project! In this project, I performed a comprehensive analysis of the Netflix dataset to uncover trends, analyze content distribution, and solve 15+ specific business questions using **Advanced SQL (T-SQL)**.

---

## 📌 Project Overview

The objective of this project was to explore the Netflix dataset and extract meaningful insights. The analysis covers everything from basic content counting to complex string manipulation and statistical breakdowns (like percentage growth in specific regions).

🚀 **Key Highlights of the Analysis:**
* **Content Segmentation:** Categorizing movies based on description keywords.
* **Geographical Insights:** Specialized analysis for production in India and other top countries.
* **Data Normalization:** Handling multi-valued attributes (Cast, Country, Genre) using `CROSS APPLY`.
* **Advanced Aggregations:** Using Window Functions and CTEs for ranking and filtering.

---

## 🛠️ Technical Implementation
<img width="940" height="529" alt="BrandAssets_Logos_01-Wordmark" src="https://github.com/user-attachments/assets/091761ba-d6e2-4a15-8324-9af02befb09e" />


### Key SQL Techniques Used:
1. **String Manipulation:** Using `STRING_SPLIT`, `TRIM`, `REPLACE`, and `LEFT` to clean and normalize data.
2. **Window Functions:** Leveraging `RANK()` and `PARTITION BY` to find top ratings and durations.
3. **Complex Logic:** Using `CASE` statements for content labeling (Bad vs. Good segmentation).
4. **Subqueries & CTEs:** Organizing complex logic for multi-step calculations.
5. **Date Functions:** Using `DATEDIFF`, `GETDATE`, and `YEAR()` for time-based analysis.

---

## 🚀 Business Questions Solved

Here are some of the key insights extracted from the data:

* **Content Distribution:** Comparison between Movies and TV Shows.
* **Top Performers:** Identifying the most common ratings and the top 5 countries producing content.
* **Normalization Challenges:** Splitting comma-separated lists for Directors, Cast, and Countries to get accurate counts.
* **Deep Dives:** Finding the longest movies, specific director filmographies, and actor appearances (e.g., Salman Khan) over the last 10 years.
* **Regional Focus:** A detailed look at Indian content and its percentage contribution per year.
* **Safety Categorization:** Labeling content based on "violence" and "kill" keywords in the description.

---

## 📂 Featured SQL Snippets

### 1. Handling Multi-Valued Attributes (Normalizing Cast)
```sql
SELECT TOP 10
    new_cast,
    COUNT(*) total_number
FROM (
    SELECT TRIM(value) AS new_cast
    FROM netflix_titles
    CROSS APPLY STRING_SPLIT(cast, ',')
    WHERE country LIKE '%India%') t
GROUP BY new_cast
ORDER BY total_number DESC;
```

### 2. Content Segmentation Logic
```sql
SELECT
    movie_segmentation,
    COUNT(*) total_number
FROM (
    SELECT *,
        CASE
            WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END movie_segmentation
    FROM netflix_titles) t
GROUP BY movie_segmentation;
```

### 3. Percentage Analysis (India Content)
```sql
SELECT TOP 5
    release_year,
    COUNT(*) total_number,
    ROUND(CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM netflix_titles WHERE country LIKE '%India%') * 100, 2) AS Percentage_per_year
FROM netflix_titles
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY total_number DESC;
```
---

# 📜Project Conclusion

This analysis provides a clear picture of Netflix's content strategy, from global production hubs to content safety and genre popularity. The use of SQL allowed for efficient processing of thousands of records to answer specific business-driven questions.

---

# 🌟 About Me

Hi! I'm Sherif Mohammed, a professional pharmacist and data enthusiast. I specialize in turning complex datasets into clear, actionable insights through advanced SQL and data automation.

Let's connect!

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=for-the-badge&logo=linkedin)]([https://www.linkedin.com/in/your-profile-url](https://www.linkedin.com/in/sherif-mohammed-8a0aa3162/))
