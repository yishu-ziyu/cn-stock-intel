#!/usr/bin/env node
// smtp-helper.js
// 邮件发送辅助脚本，读取环境变量发送邮件
// 用法：node smtp-helper.js --to <email> --subject <text> --body <text>

const nodemailer = require('nodemailer');
const { env } = process;

const transporter = nodemailer.createTransport({
  host: env.SMTP_HOST || 'smtp.gmail.com',
  port: parseInt(env.SMTP_PORT || '587'),
  secure: env.SMTP_SECURE === 'true',
  auth: {
    user: env.SMTP_USER,
    pass: env.SMTP_PASS,
  },
});

async function send({ to, subject, body }) {
  try {
    const info = await transporter.sendMail({
      from: env.SMTP_FROM || env.SMTP_USER,
      to,
      subject,
      text: body,
    });
    console.log('Sent:', info.messageId);
    return { success: true, messageId: info.messageId };
  } catch (err) {
    console.error('Send failed:', err.message);
    return { success: false, error: err.message };
  }
}

// CLI 入口
const args = process.argv.slice(2);
const get = (k) => {
  const i = args.indexOf(k);
  return i >= 0 ? args[i + 1] : null;
};

const to = get('--to');
const subject = get('--subject');
const body = get('--body');

if (!to || !subject || !body) {
  console.error('Usage: node smtp-helper.js --to <email> --subject <text> --body <text>');
  process.exit(1);
}

send({ to, subject, body }).then((r) => {
  process.exit(r.success ? 0 : 1);
});
