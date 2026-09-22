Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590D9C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4BF10EF50;
	Wed, 23 Sep 2026 07:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYV53zX6";
	dkim-atps=neutral
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com
 [74.125.227.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1E710ED3E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:46:57 +0000 (UTC)
Received: by mail-vs2-f42.google.com with SMTP id
 71dfb90a1353d-5c98e194227so1721257e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790088416; x=1790693216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N13BXdlokto4sCHjiM5WwsUbk/PLZ0LoYy+RU/kDB3A=;
 b=AYV53zX6IIxPubSx7WFJ+h3A1FiS4ERTPVbU4tYIPEczWbGQ4B6EzrwXFwk3Yd3xcW
 hPAn0YTMv5S5FFAViy24abyHbRzRw87zTxJsPrxs87HVIZPsg8i0gBWbN1DQM+/gur7n
 tMo0QpnW8QE96yiclHbXeWVZS99LPt9vYuRcA+ZzZwWQmWNzz3iwksUhBaDQdASW2ToY
 OMDKvgwGd73Ff3BWejAPvsX8x2MfALivXD1yxxPd+VP9TT0orqxjopRHwUvQFgsz/pHc
 gz5uuEAth7WgHMg/PIKyBywwgkBRQVkrl34SS8ihavh8G9MH7mzldHP6I4nYn4lBb7+3
 ThMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790088416; x=1790693216;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N13BXdlokto4sCHjiM5WwsUbk/PLZ0LoYy+RU/kDB3A=;
 b=AdXctUNiek5quoslKmQH7vgbQtKMjhTuGvLWfmV7p1KQ5oSQZgMYMly0a4SubXUE8M
 BDMdpc4/j00q2UkIGcC2P1zHELTDYlGg54zdtV3O4qtpIPF2SviDZZPavyeS4RKUOd69
 Nx7z7OBr3G09wiN4nH3L7ZKF5WIU3/LP+bLXE696J+uykqBy100UCtsnIS7tK9LyUAW2
 Tv5eSMp+eba/xxbvAIzL2oMoIBvM/DhNiMgzO5vA4YsxpT9uGoGR9YKSzd1DHPjD2jCk
 6DcLqBuCRmR0dkVo7pOlycUomxInaDkh7NsiA/CIsoeg8KWl0lajvyedcUcfqC+cECjL
 PnZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAz561+btRjMkcV6HmIDyEhmcqyjM2uwpZc1ykZ7173vyHB8UkesixaZvKbOxlQijCYNPbPjgSHqc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nxcm77gTs6PWgEijRRI95VFOeMVj0HgpQfhfrvnD6hDWLV87hx
 65oKmouR3EXNC48uZt08V0dVFfcMFIfntXRJFeBLx2LZw8xxiqfVGQQC
X-Gm-Gg: AYBFou0FwQF8ghNh+VWJCLEKcUdVEdvU3uAPx/j2jN8a85fr//sIQjGoipWsQqBrwFh
 I+pXyyJMNxcSdhPaFrjXEj59XjqRda3ZDe5YMZCTswG46zFCnu8PiXUAp0JdrasoJQDS2XRfzsj
 lRnq/9XJByxdI0WeOAnOC/N1gmQLaaTwj7FFYh288jxPkAAcsAqz6hWZpWzMCX6jBp600oBDPKs
 aYuzc1WqZI2OLctxCQQRl6LaASJ5pCdIzKCBgGH3AmU01KDhdBW2R1vgmXRY5lylhWX6/o4uuug
 70BN8/8lOvLCjzwM8adho/YSWor5xl3X8IAkgx9QaJLk3/M6YLZ+75GoBf08fpopqKU5CG6JTnY
 GuANgLIYGHS8HwVc9XD86BXirvI0at4QN0nNniMBhKlNDyBrtF/C6tT34n+WGk/l+u6Lf2QzaYf
 ZDvgfITXOnUS5/sOCdXQ/AUDLMdFoyJ8+uXxFJJfxkLwwq2whmCWYDrhr2LYbm8a6+cE9a31Obg
 d3R8ywgHFKKCI0IHssPuoASd4bAzUwKTysm2wku51jDN3FV+0uXniM+hrf0rfs=
X-Received: by 2002:a05:6122:c82:b0:5bf:889f:e7da with SMTP id
 71dfb90a1353d-5c9e34499a4mr3051349e0c.2.1790088416138; 
 Tue, 22 Sep 2026 07:46:56 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.210.5])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9850d661d77sm2017067241.7.2026.09.22.07.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:46:55 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 jani.nikula@intel.com, navonjohnlukose@gmail.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v6 3/3] drm/xe: Implement Wa_22016122933
Date: Tue, 22 Sep 2026 11:46:34 -0300
Message-ID: <20260922144634.55130-4-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922144634.55130-1-talesam@gmail.com>
References: <20260922144634.55130-1-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On platforms with a standalone media GT and media version 13.00
(MTL/ARL), memory shared between the CPU and the media GT's GuC must
not be mapped cached on the CPU side: the CPU can otherwise read stale
cache lines for data the GuC has already written.

i915 implements this as Wa_22016122933 (see
intel_gt_needs_wa_22016122933(), used by intel_guc_allocate_vma() and
intel_gt_coherent_map_type()); xe never inherited it.

The visible symptom on ARL is TLB invalidation acks stalling for a
near-constant ~2.3s: the GuC writes the G2H ack in time, but the CPU
keeps reading a stale (empty) view of the G2H CTB until the line is
naturally evicted, so the fence timeout at 2.25s fires first. GuC log
decode confirmed all invalidations were handled promptly by the
firmware, and only the media GT was affected. See Link for the full
investigation (three machines affected: 7d51, 7dd1, Arc Pro 130T).

Making the mapping coherent instead of uncached does not help: with a
GGTT PAT entry repurposed to WB|COH_2WAY the driver comes up and the
media GT GuC runs, but the stalls remain (request-to-ack 2290ms).
Uncached really is required here. Note that 2-way coherency is not
normally reachable from a GGTT PTE (only 2 PAT bits), so that
experiment needed a modified PAT table and may not reflect a supported
configuration.

Add the OOB workaround scoped like i915 (media version 13.00, media GT
only - MEDIA_VERSION() OOB rules only match the media GT on standalone
media platforms) and apply XE_BO_FLAG_NEEDS_UC to the GuC-shared
allocations the CPU reads from: the CTBs, the GuC log, ADS, the SLPC
shared data and the engine activity buffers. hwconfig and the G2G
buffer are allocated on the primary GT only, where the workaround does
not apply.

Note that XE_BO_FLAG_NEEDS_UC drives both the CPU mapping (uncached)
and the GGTT cache mode (XE_CACHE_NONE instead of XE_CACHE_WB), which is
stricter than i915: i915 documents the workaround as WC on the CPU side
and UC on the GPU side. A CPU-WC variant with the GGTT side kept at
XE_CACHE_NONE was measured to be equally effective, but expressing it
would require either a new BO flag or decoupling the GGTT cache-mode
selection from XE_BO_FLAG_NEEDS_UC - simply swapping in
XE_BO_FLAG_FORCE_WC silently relaxes the GPU side back to WB and the
stalls return. The stricter mapping is kept here since it is the tested
configuration and no throughput difference between the two was
measurable; the extra plumbing can be added later if parity with i915 is
preferred.

Scope is limited to the GuC-shared allocations, which is where the
failures were observed. i915 additionally covers media-GT LRC/ring
state; extending xe to match can be done as a follow-up if wanted.

Validation on two ARL machines (7d51 and 7dd1): before, 20-60 TLB
invalidation ack stalls per day, every day, for weeks, on every kernel
and on two GuC firmware versions (70.53.0 and 70.72.1). After: zero
stalls in six weeks of combined runtime, over 10M TLB invalidations
processed under the same workloads, across kernels 7.1.6, 7.1.8 and
7.2. The 7dd1 machine, which could not survive a day of media
workloads on xe without a platform freeze, has been running xe full
time since 11 August, including days with heavy video transcoding,
with zero stalls and zero freezes.

The coherency experiment, the CPU-WC measurements and the engine
activity coverage gap were found by Navon John Lukose while A/B
testing v2 on an ARL 7d51.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
Suggested-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
Tested-by: Navon John Lukose <navonjohnlukose@gmail.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_guc.c                 | 16 ++++++++++++++++
 drivers/gpu/drm/xe/xe_guc.h                 |  2 ++
 drivers/gpu/drm/xe/xe_guc_ads.c             |  3 ++-
 drivers/gpu/drm/xe/xe_guc_ct.c              |  6 ++++--
 drivers/gpu/drm/xe/xe_guc_engine_activity.c |  6 ++++--
 drivers/gpu/drm/xe/xe_guc_log.c             |  7 +++++--
 drivers/gpu/drm/xe/xe_guc_pc.c              |  3 ++-
 drivers/gpu/drm/xe/xe_wa_oob.rules          |  1 +
 8 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index c7f8bbd4cb9..3ab4cb9e496 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -1469,6 +1469,22 @@ int xe_guc_suspend(struct xe_guc *guc)
 	return 0;
 }
 
+/**
+ * xe_guc_bo_wa_flags - Extra BO flags for memory shared with the GuC
+ * @gt: the &xe_gt whose GuC the buffer will be shared with
+ *
+ * Wa_22016122933: on the standalone media GT, memory shared between the
+ * CPU and the GuC must not be mapped cached on the CPU side, otherwise
+ * the CPU can read stale data written by the GuC (e.g. G2H CTB writes)
+ * for multiple seconds.
+ *
+ * Return: additional XE_BO_FLAG_* to use when allocating GuC-shared memory
+ */
+u32 xe_guc_bo_wa_flags(struct xe_gt *gt)
+{
+	return XE_GT_WA(gt, 22016122933) ? XE_BO_FLAG_NEEDS_UC : 0;
+}
+
 void xe_guc_notify(struct xe_guc *guc)
 {
 	struct xe_gt *gt = guc_to_gt(guc);
diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
index 61e3ee19a59..c4eca40d69c 100644
--- a/drivers/gpu/drm/xe/xe_guc.h
+++ b/drivers/gpu/drm/xe/xe_guc.h
@@ -30,6 +30,7 @@
 	xe_guc_fw_version_at_least((guc), MAKE_GUC_VER_ARGS(ver))
 
 struct drm_printer;
+struct xe_gt;
 
 void xe_guc_comm_init_early(struct xe_guc *guc);
 int xe_guc_init_noalloc(struct xe_guc *guc);
@@ -45,6 +46,7 @@ void xe_guc_runtime_suspend(struct xe_guc *guc);
 void xe_guc_runtime_resume(struct xe_guc *guc);
 int xe_guc_suspend(struct xe_guc *guc);
 int xe_guc_softreset(struct xe_guc *guc);
+u32 xe_guc_bo_wa_flags(struct xe_gt *gt);
 void xe_guc_notify(struct xe_guc *guc);
 int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
 int xe_guc_mmio_send(struct xe_guc *guc, const u32 *request, u32 len);
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index ff8eee3831a..abc7266fc6f 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -435,7 +435,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 					  XE_BO_FLAG_SYSTEM |
 					  XE_BO_FLAG_GGTT |
 					  XE_BO_FLAG_GGTT_INVALIDATE |
-					  XE_BO_FLAG_PINNED_NORESTORE);
+					  XE_BO_FLAG_PINNED_NORESTORE |
+					  xe_guc_bo_wa_flags(gt));
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 5c4733da385..5c393aa29de 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -376,7 +376,8 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
 					  XE_BO_FLAG_SYSTEM |
 					  XE_BO_FLAG_GGTT |
 					  XE_BO_FLAG_GGTT_INVALIDATE |
-					  XE_BO_FLAG_PINNED_NORESTORE);
+					  XE_BO_FLAG_PINNED_NORESTORE |
+					  xe_guc_bo_wa_flags(gt));
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
@@ -386,7 +387,8 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
 					  XE_BO_FLAG_SYSTEM |
 					  XE_BO_FLAG_GGTT |
 					  XE_BO_FLAG_GGTT_INVALIDATE |
-					  XE_BO_FLAG_PINNED_NORESTORE);
+					  XE_BO_FLAG_PINNED_NORESTORE |
+					  xe_guc_bo_wa_flags(gt));
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
diff --git a/drivers/gpu/drm/xe/xe_guc_engine_activity.c b/drivers/gpu/drm/xe/xe_guc_engine_activity.c
index a782be57caa..729ce8ac140 100644
--- a/drivers/gpu/drm/xe/xe_guc_engine_activity.c
+++ b/drivers/gpu/drm/xe/xe_guc_engine_activity.c
@@ -97,7 +97,8 @@ static int allocate_engine_activity_buffers(struct xe_guc *guc,
 
 	metadata_bo = xe_bo_create_pin_map_novm(gt_to_xe(gt), tile, PAGE_ALIGN(metadata_size),
 						ttm_bo_type_kernel, XE_BO_FLAG_SYSTEM |
-						XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE,
+						XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE |
+						xe_guc_bo_wa_flags(gt),
 						false);
 
 	if (IS_ERR(metadata_bo))
@@ -105,7 +106,8 @@ static int allocate_engine_activity_buffers(struct xe_guc *guc,
 
 	bo = xe_bo_create_pin_map_novm(gt_to_xe(gt), tile, PAGE_ALIGN(size),
 				       ttm_bo_type_kernel, XE_BO_FLAG_VRAM_IF_DGFX(tile) |
-				       XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE, false);
+				       XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_INVALIDATE |
+				       xe_guc_bo_wa_flags(gt), false);
 
 	if (IS_ERR(bo)) {
 		xe_bo_unpin_map_no_vm(metadata_bo);
diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
index 538d4df0f7a..7d006268ce9 100644
--- a/drivers/gpu/drm/xe/xe_guc_log.c
+++ b/drivers/gpu/drm/xe/xe_guc_log.c
@@ -17,6 +17,7 @@
 #include "xe_force_wake.h"
 #include "xe_gt_printk.h"
 #include "xe_gt_types.h"
+#include "xe_guc.h"
 #include "xe_map.h"
 #include "xe_mmio.h"
 #include "xe_module.h"
@@ -624,14 +625,16 @@ void xe_guc_log_print_lfd(struct xe_guc_log *log, struct drm_printer *p)
 int xe_guc_log_init(struct xe_guc_log *log)
 {
 	struct xe_device *xe = log_to_xe(log);
-	struct xe_tile *tile = gt_to_tile(log_to_gt(log));
+	struct xe_gt *gt = log_to_gt(log);
+	struct xe_tile *tile = gt_to_tile(gt);
 	struct xe_bo *bo;
 
 	bo = xe_managed_bo_create_pin_map(xe, tile, GUC_LOG_SIZE,
 					  XE_BO_FLAG_SYSTEM |
 					  XE_BO_FLAG_GGTT |
 					  XE_BO_FLAG_GGTT_INVALIDATE |
-					  XE_BO_FLAG_PINNED_NORESTORE);
+					  XE_BO_FLAG_PINNED_NORESTORE |
+					  xe_guc_bo_wa_flags(gt));
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index 097b075bd89..e0105222a2c 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -1391,7 +1391,8 @@ int xe_guc_pc_init(struct xe_guc_pc *pc)
 					  XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 					  XE_BO_FLAG_GGTT |
 					  XE_BO_FLAG_GGTT_INVALIDATE |
-					  XE_BO_FLAG_PINNED_NORESTORE);
+					  XE_BO_FLAG_PINNED_NORESTORE |
+					  xe_guc_bo_wa_flags(gt));
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index dd69ad07f7a..30958b26a1d 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -14,6 +14,7 @@
 16017236439	PLATFORM(PVC)
 14019821291	MEDIA_VERSION_RANGE(1300, 2000)
 14015076503	MEDIA_VERSION(1300)
+22016122933	MEDIA_VERSION(1300)
 14018913170	GRAPHICS_VERSION_RANGE(1270, 1274)
 		MEDIA_VERSION(1300)
 		PLATFORM(DG2)
-- 
2.55.0

