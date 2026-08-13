Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77107C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3461610F249;
	Thu, 13 Aug 2026 09:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JpAbSSRG";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7324C10E4B3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:30:43 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so2911285ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786588243; x=1787193043; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=raTfuzuuiidiLk5Kwgy9KWW2V5Ai0ZEgvTmOdH7+rH4=;
 b=JpAbSSRG60NzlDn9pJkyfcBh4vQ8F4tBVNnTqAVM7bG72jNhFHIo7C7h1jKJrKiO9O
 ByBTiv3A6L/awO5zdEFkfA49o3xASIjbv1+T+I1kgFOr3/WhkHcNwghxO/JRpr8jzbXZ
 C0bJN/JnCRMEbzNCAHYFFUU5W3vouFPmEuBiEX+JTaw0R4nS00VodQPJto+/21ymaHp5
 tTgozy5C+h/7IxQJFddPYpdiOr2aQ8taJVuSO6+s7JrWfejWfP7lk3gLWcjheRvWkUHW
 Skvf8O9oE2/h6ENq5iLE5uABE6W+ANgXtx+Q5D86ZXJKfOQ9OwemBfC9mEtIOxw63nWG
 yNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786588243; x=1787193043;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=raTfuzuuiidiLk5Kwgy9KWW2V5Ai0ZEgvTmOdH7+rH4=;
 b=bKmCcSj7nQutrUo6shWotsEG/9/P+dChrAkmTFpSnw0AgeKqoh0737SGpHOlRLagAu
 rwWTDlYB0U/hyWzsQwwmJoaQVANcwj7X102MvS7hkL1BYRl2e1QeAwlRqbN6BYYbILh6
 400nMLkWDN+cYYfH/N7chKcKU3ghqMw/gIY8uMLcvNavjVeJewKIZlJE1SpBuvFpco0s
 Pref+J1i2X/Q1y1RifW04pisq3POOAwzZKaINZ6ZN840rcF9bqeoCbMtedpB7N5wwPDR
 /Z4+mY4WVsE0RZN7UMcs+IPt3Do5wtd07M5aV2C1ttNFzlI0AreDIhnyTSsKz/iABnU3
 ii5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMfbaQnSaFVCwiie2Bl3bXPtI59yo/PPYmb68caOnSbtjpI/hd3tJ3XDOCPH42LuoshHVdVXKSFX0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGS2Pn8ITMQ2yvtqL4Z9b9EHZhISho4keDP4+RDSD3ZilH0lHT
 aKHpqN1btpCBs8MuninqENiTby7tawQhILY9I3ywqRLJtscWfKOqxGu1UcTnVg==
X-Gm-Gg: AR+sD10DF3LcJmoew2ikwQ++Bh3Ahx1Qa36YftS10z+Bbgg1msNLwg91rlv5gypmaHs
 uKLdepw5Q48XmjRvnCOBAStQLKk8zSdJ73NcsMqjo9AYIklmJsVXfYKYvpe+bClkfqXAdm9b3K4
 nxni8pmb+xAZuYGWLXts+D34XLPksVYsxOf0iG2J/862+7lgynCPzd3qJchIYktu6kLGyR7oNDh
 oJiOw5aXX4HbZ07ziTSGyAOR1L7snM6zmWdet5jE5ShD8LTmgFcqyT79BPnmz55RQcaS6v0eWws
 vZK2VykUoOmyxmPGfSOY7W8vPd+UIhIRidZuRufjOcNs31Ofe0B+lzEjKqp6N3cr87yRt53xomG
 qZOhyfuzSNFmDMEFC5a/eWhX8yBoA/qNKtKx0K0FBgCXKZtdoBvTYNHkyT/HSzZVlgC4HzRaUH4
 RWohU9Lg6KgLSECT3bFSe0VKSaGKuRrW0qCUBdmrkBrPG7WNRRzdIy0F8mnn1D77Dd6i2FuDMvE
 b2Ycs2WkhjF66mACjD0LKkMpB/SQNzeYWwJCF1/tRIM/QPE6SHkautM
X-Received: by 2002:a05:6a21:2983:b0:3bf:5539:f93 with SMTP id
 adf61e73a8af0-3cc5550649dmr3282407637.38.1786588242797; 
 Wed, 12 Aug 2026 19:30:42 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.208.200])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf731f95sm1950053eec.15.2026.08.12.19.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 19:30:42 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v2 3/3] drm/xe: Implement Wa_22016122933
Date: Wed, 12 Aug 2026 23:30:16 -0300
Message-ID: <20260813023016.805573-4-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813023016.805573-1-talesam@gmail.com>
References: <20260813023016.805573-1-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

Add the OOB workaround scoped like i915 (media version 13.00, media GT
only - MEDIA_VERSION() OOB rules only match the media GT on standalone
media platforms) and apply XE_BO_FLAG_NEEDS_UC to the GuC-shared
allocations the CPU reads from: the CTBs, the GuC log, ADS and the SLPC
shared data. hwconfig and the G2G buffer are allocated on the primary
GT only, where the workaround does not apply.

Validation on two ARL machines (7d51 and 7dd1): before, 20-60 TLB
invalidation ack stalls per day, every day, for weeks, on every kernel
and on two GuC firmware versions (70.53.0 and 70.72.1). After: zero
stalls across 6+ days of combined runtime and >5M TLB invalidations
processed under the same workloads. The second machine, which could not
survive a day of media workloads on xe without a platform freeze, ran
34h+ continuously including video transcoding with zero incidents.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
---
 drivers/gpu/drm/xe/xe_guc.c        | 16 ++++++++++++++++
 drivers/gpu/drm/xe/xe_guc.h        |  2 ++
 drivers/gpu/drm/xe/xe_guc_ads.c    |  3 ++-
 drivers/gpu/drm/xe/xe_guc_ct.c     |  6 ++++--
 drivers/gpu/drm/xe/xe_guc_log.c    |  7 +++++--
 drivers/gpu/drm/xe/xe_guc_pc.c     |  3 ++-
 drivers/gpu/drm/xe/xe_wa_oob.rules |  1 +
 7 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 4286bd05c68..c988a2a3b7b 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -1468,6 +1468,22 @@ int xe_guc_suspend(struct xe_guc *guc)
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
index f02ac9bf742..6e0942f5643 100644
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

