#!/bin/bash
# cn-stock-intel: 安装每3小时一次的邮件摘要任务
# 依赖：OpenClaw 已安装并运行，nodemailer 已安装
# 用法：bash scripts/setup-cron-3h.sh

set -e

echo "[cn-stock-intel] 安装 A股财经摘要 | 每3小时 任务..."

openclaw cron add \
  --name "A股财经摘要 | 每3小时" \
  --cron "0 */3 * * *" \
  --session isolated \
  --timeout-seconds 180 \
  --no-deliver \
  --message "你是一个财经事实记录员。任务是搜索过去3小时内 A股（沪深）相关财经新闻，重点关注四个板块：新能源（锂电池/光伏/新能源车）、消费（白酒/乳业/零售/快递/内需政策）、AI人工智能（AI硬件/应用/大模型/机器人）、电网电力设备（电力板块/特高压/储能）。筛选标准：有具体数据或具体事件的要闻公告；排除纯分析/纯荐股/纯K线判断内容。输出格式：段落式摘要，以【板块名】开头标注具体事实（数据+事件），以【待核实】标注存疑内容。如果过去3小时无实质新增，回复「本时段无新增实质财经要闻」。今日日期自行获取。只输出事实，不输出分析判断。搜索完成后，调用 nodemailer 发送邮件：收件人 yishuziyu@gmail.com，标题「【A股财经摘要】3小时滚动摘要」，SMTP配置：smtp.gmail.com:587，账号从环境变量读取（smtp-user/ smtp-pass）。先搜索整理内容，再发送邮件，两个步骤都要完成。"

echo "[cn-stock-intel] 安装完成！查看任务：openclaw cron list"
