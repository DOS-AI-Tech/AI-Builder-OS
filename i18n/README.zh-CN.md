[English](../README.md) · **简体中文** · [使用指南](../user-guide/index.zh-CN.html)

# AI Builder Operating System

一套免费、零依赖的 AI 软件交付操作系统。
只需全局安装一次，即可让 Claude Code、Codex、GitHub Copilot、Cursor 和 Qoder 共享同一套项目记忆、工作流和人工审批 Gate。

## 快速开始

### 1. 全局安装免费框架

```bash
git clone https://github.com/DOS-AI-Tech/AI-Builder-OS.git ~/ai-builder-os
bash ~/ai-builder-os/installer/install.sh
```

```powershell
git clone https://github.com/DOS-AI-Tech/AI-Builder-OS.git "$HOME\ai-builder-os"
& "$HOME\ai-builder-os\installer\install.ps1"
```

选择你使用的 Agent。安装器会把核心框架和五个基础技能安装到对应的全局技能目录，不需要 Node/npm、Python、服务器或数据库。

### 2. 初始化项目

```bash
bash ~/ai-builder-os/installer/init.sh /path/to/project
```

```powershell
& "$HOME\ai-builder-os\installer\init.ps1" "C:\path\to\project"
```

项目中只会创建记忆、领域目录、输出目录和薄适配器，不会重复复制全局技能。

### 3. 开始工作

用任意已选择的 Agent 打开项目并描述任务。AI Builder OS 会读取项目状态、选择工作流、展示必要的人工 Gate，确认后才继续执行。

## 为什么需要它

| 常见问题 | AI Builder OS 的处理方式 |
|---------|--------------------------|
| Agent 没理解需求就开始写代码 | 实施前必须完成需求和计划 Gate |
| 换工具或会话后上下文丢失 | 项目内保存架构、当前状态、工作项和任务日志 |
| 修复一个流程却破坏另一个流程 | 影响分析、可追踪测试和回归检查 |
| 不同 Agent 各用一套方法 | 全局统一框架 + 项目薄适配器 |

目标很简单：让人保持控制，同时不必在每次会话中重新解释项目。

## 免费内容

免费框架包含工作流路由、记忆规范、输出模板、项目初始化，以及五个基础技能：

| 技能 | 职责 |
|------|------|
| `requirements-analyst` | 产品定义、MVP 范围、验收标准、变更影响 |
| `architect` | 技术决策、边界、ADR、适合交付目标的技术栈 |
| `project-manager` | 阶段编排、计划、Gate、工作项、交接 |
| `test-engineer` | 测试计划、追踪、执行和回归验证 |
| `deployment-engineer` | 已批准的部署命令、验证和回滚 |

## 工作方式

```text
为每个选中的 Agent 全局安装一次
└── AI Builder OS 核心 + 免费基础技能
                      │
                      ▼
每个项目初始化一次
├── .ai/memory/       共享项目状态
├── domain/           项目领域知识
├── project_docs/     需求、计划和测试证据
└── 薄适配器           确保 Agent 激活全局框架
```

静态框架能力放在全局；业务上下文和工作历史留在项目内，通过 Git 审查和版本管理。

## 付费技能包

高级技能包与免费框架分开销售、分开交付，用于增加专业领域能力。

```bash
bash ~/ai-builder-os/installer/install-skill.sh <skill-name> /path/to/purchased-pack
```

```powershell
& "$HOME\ai-builder-os\installer\install-skill.ps1" <skill-name> "C:\path\to\purchased-pack"
```

免费框架是强制依赖。如果没有任何 Agent 安装免费框架，付费技能安装会终止。付费技能不会包含或修改免费框架。

## 文档

- [中文使用指南](../user-guide/index.zh-CN.html)
- [English User Guide](../user-guide/index.html)
- [技能格式规范](../ai-builder-os/skills/SKILL-FORMAT.md)
- [工作流参考](../ai-builder-os/workflows/README.md)

升级免费框架：拉取仓库更新后运行 `installer/update.sh` 或 `installer/update.ps1`。项目记忆和付费技能不会被修改。

## 支持的 Agent

支持 Claude Code、OpenAI Codex、GitHub Copilot、Cursor 和 Qoder。全局目录统一定义在 `installer/agents.conf`。

## 许可与贡献

免费框架开源，欢迎提交 Issue 和 Pull Request。付费技能包内容不得进入公共框架仓库。
