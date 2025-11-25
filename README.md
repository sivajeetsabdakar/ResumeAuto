# Resume Tailoring Workflow

This repository helps us turn a single base resume (stored as modular LaTeX files under `custom/src/`) into highly targeted variants for different job descriptions. The steps below capture the playbook we follow to deliver ATS-ready resumes quickly and consistently.

## 1. Intake & Gap Analysis
1. Collect the target job description plus any recruiter instructions and store them in `prompt.txt` (or keep them handy in the IDE).
2. Skim the JD to extract the must-have hard skills, domain keywords, and role expectations (e.g., “computer vision”, “PyTorch”, “model deployment”). Keep a short checklist so nothing is missed later.
3. Compare those requirements with the current content of the base resume (open `custom/src/*.tex` files) and note the gaps: sections that need rewording, skills missing from the stack, or projects that are irrelevant to the JD.

## 2. Section-Driven Editing
All resume content lives in LaTeX snippets under `custom/src/`. We only modify the sections that need tailoring:

| Section | File | Typical Edits |
| --- | --- | --- |
| Summary | `custom/src/summary.tex` | Rephrase to name the target role, insert JD keywords immediately, keep it to 2–3 sentences. |
| Experience | `custom/src/experience.tex` | Update bullet verbs/metrics, weave in JD terminology, never delete past roles. |
| Projects | `custom/src/projects.tex` | Keep 3–4 most relevant projects; rewrite bullets to emphasize required tech. |
| Skills | `custom/src/skills.tex` | Reorder so JD tech appears first; add/remove tools only when truthful. |
| Education & Achievements | `custom/src/education.tex`, `custom/src/achievements.tex` | Usually unchanged per instructions. |

Tips:
- Use consistent LaTeX macros (e.g., `\resumeItem{...}`) so formatting stays intact.
- Prefer small, surgical edits via `apply_patch` or the editor—avoid regenerating entire files.
- Keep language precise (verbs like “Architected”, “Engineered”) and avoid buzzwords.

## 3. ATS & Consistency Checks
1. Ensure section headers remain in the expected order: SUMMARY → EXPERIENCE → EDUCATION → PROJECTS → TECHNICAL SKILLS → ACHIEVEMENTS.
2. Verify that every JD keyword we highlighted during gap analysis appears somewhere meaningful (Summary, Experience, Projects, or Skills). If something is missing, adjust bullets rather than stuffing at the end.
3. Run linting for LaTeX syntax if available; at minimum, re-open each edited file to catch typos.

## 4. Build & Validate
1. Navigate to `custom/` and run the build script:
   ```cmd
   build-clean.bat
   ```
   (or `build.bat` for a quicker iteration). This generates `custom/resume.pdf`.
2. Open the PDF to confirm layout, bullet alignment, and that no sections overflow onto a blank page.
3. Archive the tailored PDF with a descriptive name if needed (e.g., `resume_Entrupy.pdf`).

## 5. Handoff
- Summarize the edits in the chat (sections touched + rationale).
- Point out anything the requester should double-check (e.g., metrics they may want to verify).

Following this workflow lets us go from JD intake to a polished, ATS-friendly PDF in minutes while keeping the process repeatable for future roles.

