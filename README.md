# awesome-occupation-standard

本仓库收集并整理了中国职业分类标准及社会调查数据中的职业编码，便于社会学和其他学科的学术研究和数据分析。

## 数据说明

### CFPS职业编码

[CFPS](https://www.isss.pku.edu.cn/sjsj/cfpsxm/index.htm?CSRFT=J96T-7QLE-F6CY-ZYE8-Q7BA-RV5P-A170-RIWU)（中国家庭追踪调查，China Family Panel Studies）是北京大学主持的全国性、综合性长期追踪调查。基线调查始于2010年，每两年追访一次，目前最新数据为2022年。

CFPS职业编码以GB/T 6565-2015为基础，结合实际调查需求做了自定义调整，并部分与ISCO国际标准接轨。职业编码体系由公开dta文件中提取。

- [中国家庭动态追踪调查2010年职业行业编码.pdf](CFPS/中国家庭动态追踪调查2010年职业行业编码.pdf)：CFPS官方职业编码体系文档
- [cfps_10-22_raw.csv](CFPS/cfps_10-22_raw.csv)：合并自CFPS 2010-2022年各年度的职业编码及名称，含冲突标记
- [cfps_10-22_clean.csv](CFPS/cfps_10-22_clean.csv)：对冲突项人工修订后的标准职业编码表

### GBT6565标准

[国家标准全文公开系统](https://openstd.samr.gov.cn/bzgk/gb/index) 提供的中国标准职业分类代码（GB/T 6565），目前最新为2015年版。

- [GBT6565-1999_职业分类与代码.pdf](GBT6565/GBT6565-1999_职业分类与代码.pdf)
- [GBT6565-2009_职业分类与代码.pdf](GBT6565/GBT6565-2009_职业分类与代码.pdf)
- [GBT6565-2015_职业分类与代码.pdf](GBT6565/GBT6565-2015_职业分类与代码.pdf)

## 脚本说明

- [get_cfps_code.R](scripts/get_cfps_code.R)：用于提取和清洗CFPS各年度职业编码，检测并标记多年度编码冲突，生成标准化职业编码表。

## 贡献说明

欢迎提交PR补充其他社会调查职业编码、标准文档或相关脚本。

## To-do

- ISCO
- SOC
- CLDS