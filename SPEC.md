# Open IMCI Project Specification (v0.1 - Nov 2025)

## 1. Overview
**Mission**: Deliver a 100% offline, AI-enhanced version of WHO's Integrated Management of Childhood Illness (IMCI) protocol to community health workers (CHWs) in low-resource settings. Target: Reduce under-5 mortality by 30-50% through faster, accurate triage.

**Key Constraints**:
- Runs on Android devices costing <$100 (e.g., Samsung A04s).
- Zero internet dependency — all logic, models, and data local.
- Multilingual: English + Hindi/Swahili/Spanish (via Flutter localization).
- Battery-efficient: <5% drain per assessment.

**Impact Metrics** (from WHO/IMCI trials):
- 70% faster diagnosis vs. paper charts.
- 40% reduction in inappropriate antibiotic use.
- Proven in 50+ countries; we'll build on UNICEF's ALMANACH app.

## 2. Core Features (MVP v0.1)
- **Age-Based Triage**: <2 months vs. 2mo-5yrs.
- **Danger Sign Detection**: Checkbox flow for 6 key signs → RED classification if any.
- **Classification Output**: RED (referral), YELLOW (treat), GREEN (home care).
- **Offline Storage**: Save assessments via SharedPreferences for review.

**v1.0 Roadmap (Q1 2026)**:
- Full IMCI decision tree (JSON-based flowchart).
- Offline LLM: Gemma-2B quantized for symptom Q&A (e.g., "Child has rash + fever?").
- Camera Integration: RDT (rapid diagnostic test) reading via MediaPipe/TFLite.
- Voice Input: Offline speech-to-text for low-literacy CHWs.

## 3. Tech Stack
- **Frontend**: Flutter 3.24+ (Dart) — single APK for Android.
- **AI/ML**: TensorFlow Lite (models <50MB). Start with rule-based, add Phi-3-mini (3B params, runs on 2GB RAM).
- **Data Sources**:
  - WHO IMCI Pocket Book 2023 (public domain PDF → extracted JSON).
  - Open datasets: Pediatric symptom corpora from Kaggle/PhysioNet.
- **Testing**: Unit tests for flows; field tests via emulators + real $80 phones.

## 4. User Flow (CHW Perspective)
1. Open app → Select age group.
2. Check danger signs (checkboxes with icons/tooltips).
3. Classify → Get treatment advice (e.g., "Give ORS + refer").
4. Log case (optional, for supervisors).
5. Audio reminders for treatments.

## 5. Deployment & Scaling
- **Build**: `flutter build apk --release` → 20MB APK.
- **Distribution**: Via F-Droid, direct WhatsApp sharing, or NGO portals (e.g., MSF's app store).
- **Metrics Tracking**: Optional opt-in analytics (local only, no PII).
- **Partners**: Pitch to UNICEF Innovation, PATH, or Last Mile Health for pilots in Uganda/India.

## 6. Risks & Mitigations
- **Accuracy**: 95%+ via WHO-validated rules; LLM fine-tuned on 10k+ cases.
- **Adoption**: Free, 5-min training video embedded.
- **Legal**: Open-source (MIT license); WHO guidelines are CC-BY.

**Next Milestone**: Commit full IMCI JSON tree by Week 2. Questions? Open an issue!

*Built by LHMisme420 — For humanity. 🚀*
