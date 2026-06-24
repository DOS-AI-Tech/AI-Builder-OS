# Deployment Pitfall: [Summary]

<!--
TRIGGER:    deployment workflow when something fails
SAVE AS:    .ai/pitfalls/YYYY-MM-DD-[summary]-pitfall.md
UPDATED BY: AI fills immediately when failure occurs; do not wait until after recovery

Record this the moment something goes wrong. The next session — or the next
person — must not rediscover the same failure.

FIELD GUIDE
  [AI]       AI generates from available context
  [USER]     AI asks user, waits for answer
  [AI+USER]  AI drafts, user confirms or edits
-->

---

## 1. Environment

<!-- [USER] Where did this happen? -->

**Environment:** local / staging / production
**Date:** 
**Who was deploying:** 

---

## 2. What Was Being Done

<!-- [USER] What deployment step or command was running when the failure occurred? -->


---

## 3. Failed Command or Action

<!-- [USER] Exact command that failed. Copy-paste from terminal. -->

```bash

```

---

## 4. Error Output

<!-- [USER] Full error message. Copy-paste, do not summarize. -->

```

```

---

## 5. Root Cause

<!-- [AI+USER] AI diagnoses based on error and context. User confirms or corrects. -->


---

## 6. Fix That Worked

<!-- [USER+AI] What actually resolved it? Exact steps. -->

```bash

```

**Explanation of why this worked:** 

---

## 7. Working Deployment Sequence (After Fix)

<!-- [AI+USER] The full correct sequence from this point forward. -->

```bash

```

---

## 8. Documents to Update

<!-- [AI] What should be updated so this doesn't happen again? -->

- [ ] `.ai/deployment-plan.md` — add to Section 8 (Known Pitfalls)
- [ ] `.ai/memory/frozen/deployment.yaml` — [if SOP needs updating; requires human approval]
- [ ] Other: 
