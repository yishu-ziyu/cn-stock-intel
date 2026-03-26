# cn-stock-intel | A股情报

A股投研定时复盘系统。基于 [OpenClaw](https://github.com/openclaw/openclaw) + Gmail 构建，每30分钟推送一次事实要闻，每3小时邮件汇总，覆盖新能源、消费、AI、电网四大板块。

---

## 核心特性

- **30分钟一次**：盘中实时追踪，直接推送至 OpenClaw 聊天窗口
- **3小时一次**：邮件摘要，发送至你的 Gmail
- **事实优先**：只记录可核实的数据和具体事件，排除纯分析/荐股/K线判断
- **四板块覆盖**：新能源、消费、AI人工智能、电网电力设备

---

## 快速开始

### 前置需求

- [OpenClaw](https://github.com/openclaw/openclaw)（支持 cron + agent）
- Gmail 账号（需要 App Password）

### 1. 克隆项目

```bash
git clone https://github.com/yishu-ziyu/cn-stock-intel.git
cd cn-stock-intel
```

### 2. 配置凭证

复制配置文件模板：

```bash
cp .env.example .env
```

编辑 `.env`，填入你的信息：

```bash
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password    # 不是登录密码，是 App Password
SMTP_FROM=your-email@gmail.com
RECIPIENT_EMAIL=your-email@gmail.com
```

#### Gmail App Password 获取方法

1. 前往 [Google Account Security](https://myaccount.google.com/security)
2. 开启**两步验证**（必须）
3. 在**应用密码**页面生成一个 16 位密码
4. 将生成的密码填入 `SMTP_PASS`

### 3. 安装 cron 任务

安装邮件工具依赖：

```bash
cd scripts
npm install nodemailer
cd ..
```

安装定时任务：

```bash
# 30分钟推送任务（直接推送到 OpenClaw）
bash scripts/setup-cron-30m.sh

# 3小时邮件任务
bash scripts/setup-cron-3h.sh
```

### 4. 验证

检查任务是否安装成功：

```bash
openclaw cron list
```

两个任务都出现即表示安装完成。

---

## 目录结构

```
cn-stock-intel/
├── README.md
├── .env.example          # 凭证模板（用户填自己的）
├── .gitignore
├── scripts/
│   ├── setup-cron-30m.sh # 安装 30 分钟任务
│   ├── setup-cron-3h.sh  # 安装 3 小时任务
│   └── smtp-helper.js    # 邮件发送辅助脚本
└── prompts/
    ├── 30min-prompt.md    # 30 分钟任务的事实记录员指令
    └── 3h-prompt.md       # 3 小时任务的指令（含邮件发送）
```

---

## 自定义板块

编辑 `prompts/` 下的 prompt 文件，修改搜索关键词部分即可：

```
- 新能源（锂电池/光伏/新能源车）
- 消费（白酒/乳业/零售/快递/内需政策）
- AI人工智能（AI硬件/应用/大模型/机器人）
- 电网电力设备（电力板块/特高压/储能）
```

---

## 卸载

```bash
openclaw cron rm <job-id>
```

job-id 可通过 `openclaw cron list` 查看。

---

## 技术栈

- **调度层**：OpenClaw cron（isolated agent session）
- **搜索层**：新浪财经 + 浏览器自动化
- **邮件层**：nodemailer + Gmail SMTP
- **推送层**：OpenClaw 直接消息

---

## License

MIT
