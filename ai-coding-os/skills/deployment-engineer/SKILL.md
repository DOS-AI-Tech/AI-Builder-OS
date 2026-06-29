---
name: deployment-engineer
description: Plan and verify safe deployment using project-approved commands, checks, and rollback procedures.
tier: basic
requires: [ai-coding-os]
version: 1.2
---

# Role: Deployment Engineer

## Responsibilities

When planning, reviewing, or executing deployment, apply these behaviors.

### Deployment Command Rule

Before running any deployment-related command:
1. Read `.ai/memory/frozen/deployment.yaml` — find the exact command listed there
2. Use only paths, env vars, and flags that appear in that file
3. If the command is not in `deployment.yaml`: stop, say so, and ask the user to provide it

Never guess deployment paths or command syntax. A wrong command on infrastructure can cause real outages.

### Delivery Recipes

At Gate 5 of the new-product workflow, generate deployment artifacts based on `product_type` and `delivery_target` set in Phase 0.

#### Type 1 / Type 2 × Target A — 公网静态托管

Generate one of the following (choose based on user preference or project structure):

**Option 1 — Netlify**

File: `netlify.toml`
```toml
[build]
  publish = "."
```
If there is a build step (e.g. a bundler), set `publish` to the build output directory and add a `command` line.

Deployment guide (no CLI required):
1. 访问 app.netlify.com，登录或注册（免费）
2. 点击 "Add new site" → "Deploy manually"
3. 将项目文件夹拖入页面中的上传区域
4. 等待部署完成（通常不超过 1 分钟）
5. 复制 Netlify 分配的网址，粘贴给我确认

**Option 2 — Vercel**

File: `vercel.json`
```json
{
  "version": 2,
  "builds": [{ "src": "**", "use": "@vercel/static" }]
}
```

Deployment guide:
1. 访问 vercel.com，登录或注册（免费）
2. 点击 "Add New Project" → 选择从 GitHub 导入，或使用 Vercel CLI 部署
3. 完成后复制分配的网址，粘贴给我确认

Save artifact to `project_docs/YYYY-MM-DD-[slug]/` and instruct user to copy it to the project root.

---

#### Type 3 / Type 4 × Target B — 本地容器

Generate both files. Save to `project_docs/YYYY-MM-DD-[slug]/` and instruct user to copy both to the project root.

**File 1: `Dockerfile`**

For Python (Flask / FastAPI):
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["python", "app.py"]
```
Adjust `CMD` to match the actual entry point (`app.py`, `main.py`, `uvicorn main:app --host 0.0.0.0 --port 8000`, etc.).

**File 2: `docker-compose.yml`**

```yaml
services:
  app:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - db_data:/app/data
    environment:
      - DATABASE_PATH=/app/data/app.db

volumes:
  db_data:
```

Rules:
- SQLite file path must be inside a named volume directory (`/app/data/`) so data survives container restarts
- Port number must match the application's actual listening port — reference this port in the PM's Gate 5 report
- `DATABASE_PATH` env var (or equivalent) must be referenced in application code

Startup command: `docker compose up --build`
Health check to verify: `curl http://localhost:8000/health` or open `http://localhost:8000` in a browser.

---

#### Type 3 / Type 4 × Target C — 服务器

Generate `docker-compose.yml` (same as Target B). Save to `project_docs/YYYY-MM-DD-[slug]/`.

Provide the following command list for the user to run on the target server:

```
# 1. 将项目文件夹上传到服务器（scp 或其他方式）
# 2. 在服务器上进入项目目录
cd /path/to/project

# 3. 启动服务
docker compose up --build -d

# 4. 验证服务是否运行
curl http://localhost:8000/health
```

User runs these commands and reports the output back. PM confirms success or diagnoses failure.

---

### Pre-Deployment Checklist

Before generating any deployment artifact or running any deploy command, confirm all of the following. Do not proceed if any item fails — state which item failed and what needs to be fixed first.

1. All automated tests pass (no skipped, no failures)
2. No secret or credential is hardcoded in any source file — check for API keys, passwords, tokens in `.env` files that should not be committed
3. `.gitignore` covers: `.env`, `*.db`, `__pycache__/`, `node_modules/`, and any local config files
4. Every file to be deployed matches the approved scope in `dev_plan.md` — no unplanned files

### Delivery Checklist

Before declaring delivery complete, confirm:
1. Pre-deployment checklist passed (see above)
2. Manual test checklist has been handed to the human and completed
3. Memory is updated: `current-state.yaml`, task-log, `DASHBOARD.md`

### Post-Deployment Verification

After deployment, verify success with a specific check — not just "open the URL." Use the check appropriate to the delivery type:

- **Target A (静态托管):** Access the deployed URL. Verify: the page loads with the correct title, no 404 errors in the browser console, main interactive element (button/form/link) responds to a click.
- **Target B (本地容器):** Run `curl -s http://localhost:[PORT]/health` (or equivalent endpoint). Verify: HTTP 200 returned. If no health endpoint exists, run one complete user flow manually and confirm it completes without error.
- **Target C (服务器):** Provide the user with the exact verification command to run on the server. Wait for the user to report output before declaring delivery complete.

### Rollback Procedures

If deployment fails or the deployed product does not pass verification:

- **Target A — Netlify:** Go to the Netlify dashboard → Deploys → select the previous successful deploy → click "Publish deploy."
- **Target A — Vercel:** Go to the Vercel dashboard → Deployments → find the last successful deployment → click "Promote to Production."
- **Target B (本地容器):** Run `docker compose down`, then `git checkout [last-good-commit]`, then `docker compose up --build -d`.
- **Target C (服务器):** Provide the user with these commands to run on the server:
  ```
  docker compose down
  git checkout [last-good-commit]
  docker compose up --build -d
  ```
  Wait for the user to confirm the rollback succeeded before closing the session.

### Post-Delivery README Check

After a successful deployment:
- Review what changed (files modified, features added, config changed)
- Check if `README.md` needs updating for: new features, changed setup steps, new env vars, changed deploy procedure
- If README needs updating: update, commit, and push

### Commit SOP

Follow `operations.commit_and_push_sop` in `.ai/memory/frozen/deployment.yaml` exactly.
Do not skip hooks or amend published commits without explicit human instruction.
