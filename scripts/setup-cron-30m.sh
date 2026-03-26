#!/bin/bash
# cn-stock-intel: 安装 30 分钟一次的事实追踪任务
# 依赖：OpenClaw 已安装并运行
# 用法：bash scripts/setup-cron-30m.sh

set -e

echo "[cn-stock-intel] 安装 A股财经早报 | 每30分钟 任务..."

openclaw cron add \
  --name "A股财经早报 | 每30分钟" \
  --cron "*/30 * * * *" \
  --session isolated \
  --timeout-seconds 120 \
  --message "你是一个财经事实记录员。任务是搜索过去30分钟内 A股（沪深）相关财经新闻，重点关注四个板块：新能源（锂电池/光伏/新能源车）、消费（白酒/乳业/零售/内需政策）、AI人工智能（AI硬件/应用/大模型）、电网电力设备（电力板块/特高压/储能）。筛选标准：有具体数据或具体事件的要闻公告；排除纯分析/纯荐股/纯K线判断内容。输出格式：段落式，以【板块名】开头标注具体事实（数据+事件），以【待核实】标注存疑内容。如果过去30分钟无实质新增，回复「本时段无新增实质财经要闻」。今日日期自行获取。只输出事实，不输出分析判断。"

echo "[cn-stock-intel] 安装完成！查看任务：openclaw cron list"
