Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A956C54F54
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E7B10E7C3;
	Tue, 28 Jul 2026 07:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ugreen.com header.i=@ugreen.com header.b="IBvMuJv/";
	dkim-atps=neutral
X-Greylist: delayed 2311 seconds by postgrey-1.36 at gabe;
 Tue, 28 Jul 2026 06:56:06 UTC
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7B010E532;
 Tue, 28 Jul 2026 06:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1785221727;
 bh=DItCFw3ZM1/6TvIXqKKL/PLAbi+vl6KkZbM1Uo4hj7Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=IBvMuJv/gaZzOPfp0t2MrR6LrSyUGxVM5XB4jxmiw3DDb9aLTF75D+SykawE4k6kQ
 81sOpvPPtAZy5JTuQ+Y5REEvzyZ+Mujtkkj++jmE/pXCQSgnzvnzTn9pU5WwRc4Ut9
 iwqALUkuvxPOenUPe5bjFetKBJuYOIOhHhISv5T0=
X-QQ-mid: esmtpgz16t1785221719tc3b98b08
X-QQ-Originating-IP: 9innfBLIQxQZSvkaPMkFYtB2dnrE+VaVX2kptGcGCk8=
Received: from localhost.localdomain ( [113.90.157.158])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 28 Jul 2026 14:55:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2462819298408965018
From: Neil Zhong <neil.zhong@ugreen.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Date: Tue, 28 Jul 2026 14:55:12 +0800
Message-ID: <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260728065512.59911-1-neil.zhong@ugreen.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OQhZ3T0tjf0aXvfI3wMhvPcgzynO5MSCVEVTMjx2o05qF9QC51noEaNQ
 zZGSBKjQLaJg07Fb8tf1B82+6gNiD6vi3M/uoLRC7AviAoHzbuovY4zfKByEXD4xQ1W7KWc
 0/7dqNSZBkcceg2o8C4Pro3FEM4AvvqYylhjxfQOeLWCaGHyaMexq0TelY6bpZ9b+PRA3dH
 0Vhdx6n7hOd5k3UBpM77mOpIsD7B4jAHyftADknOax0EEWMLP2dAmp+BAI4ssizzVJkyf6R
 TLTCPvLIiZYtjBAdEvX//CC9JDlVSbwCwzPmpQyPBp7jOrkyz8yQ3W4sY1mCLO8L3iyz4gf
 VtX3xiIWxv2MsiZiwhguRFWeqlRj3I5bs6k7pBj+kimi79AevjBJfSeqT3bmTT9olLyIeSK
 PM+yinuvrgyKoSe+O5prq7CXlCujy7a6KXiqF9N7ME0rEtiX5dPRN8UoK6gYpRbrbEdp5N6
 IbSSVE31s/71LLbRS+0AsxvDumCbaVU1MjpIKBsGdIVlGlhJBoX8cPLWDqFpR8ikxquBUXg
 x9dXLgxdfyh2b1xX0BMQ5aheO9cgbbmRHfGMcr8MCIq3nrpJ/fz0vMxG555iUooRLVhvMl7
 LOrVm5evntfamf/D7S26W51M9kVndo4zAsDRYq7YC3OuTUS9Ow46OHRPK3D1m5MJRsDEUd1
 u9vxz+HC2Sci5CLSfH+mUiJGamd31UhfVXUQugevVezHvW68eTMa5zS8ZEL6pl+iZiw+dLj
 sezch/YKnsTWmAs6PrudjJCtbz2uV1tLds0s26qJ7V++i8hfyZ+YmpoZ78oQHIeztzW51KH
 g/5dBaxX5vBar4nnVrk9D4KgwI3govOEoMmowQQVjqYMFR6L6I1Nkt+Y2mIZbJYMUE06jDu
 bJDHB2VRllMvmRE++lu7nmslY/n9Q7ftyJNukPV/faa0/3VWMvvHcUmrEMFgfqDP/1hSOpT
 2Frs6fx8Ou9d9VMj2qk3cD7BxEpIbJ46x2N9ePxemDNVsDftaZSDx3eZzsfOslXDat5cePS
 RjSGz4lypAm2X10g8sHLR5Kf871tTB1dFpNiRIiJww5opcdtmDrz/NVJOPs3N3HZvqXC8e+
 A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

On x86, restoring a backed-up write-combined (WC) buffer object can be
expensive. The restore path allocates WB pages and converts them with
set_pages_array_wc(), which performs synchronous cache and TLB flushes.

Xe currently allows its shrinker to back up the pages of a WC BO while
the BO still has GPUVA mappings created by VM_BIND. A later validation
restores the pages while holding the BO's dma-resv. The cache-attribute
conversion then serializes EXEC, VM_BIND and dma-buf users on that
reservation object.

This was observed as intermittent HDR 4K60 playback stalls on two
Panther Lake systems with 8 GiB of memory. In a pre-change reproducer,
the maximum ioctl latencies were 549 ms for XE_EXEC, 291 ms for
XE_VM_BIND and 343 ms for DMA-BUF IMPORT. ttm_tt_restore reached 80.6 ms.

Keep a non-purgeable WC BO resident while it has at least one GPUVA
mapping. Purgeable BOs are still discarded, and after the last
VM_UNBIND the BO becomes reclaimable again. Add an A/B module parameter
which can restore the old behavior.

With the change, a 21-minute capture had no XE_EXEC, XE_VM_BIND or
DMA-BUF ioctl over the 16.7 ms frame interval. Their respective maxima
were 348 us, 136 us and 20 us. The ttm_tt_restore maximum was 8.33 ms,
and the set_pages_array_wc call rate fell from 14.64/s to 0.179/s.

The change intentionally trades reclaimable memory for latency while a
WC BO remains mapped. It does not take an additional BO reference or
change teardown: VM destruction and process exit remove the GPUVA
mappings and drop their existing references. During testing,
MemAvailable remained near 3 GiB and the dma-buf working set released
five 24 MiB surfaces while playback continued.

Signed-off-by: Neil Zhong <neil.zhong@ugreen.com>
---
Changes in v2:
- Call ttm_bo_shrink_suitable() before the Xe-specific WC predicate, so
  ttm_bo->ttm is known to be non-NULL before checking its cache mode.

 drivers/gpu/drm/xe/xe_defaults.h |  1 +
 drivers/gpu/drm/xe/xe_module.c   |  6 ++++++
 drivers/gpu/drm/xe/xe_module.h   |  2 +-
 drivers/gpu/drm/xe/xe_shrinker.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_defaults.h b/drivers/gpu/drm/xe/xe_defaults.h
index c8ae1d5f..645e289f 100644
--- a/drivers/gpu/drm/xe/xe_defaults.h
+++ b/drivers/gpu/drm/xe/xe_defaults.h
@@ -22,5 +22,6 @@
 #define XE_DEFAULT_WEDGED_MODE			XE_WEDGED_MODE_UPON_CRITICAL_ERROR
 #define XE_DEFAULT_WEDGED_MODE_STR		"upon-critical-error"
 #define XE_DEFAULT_SVM_NOTIFIER_SIZE		512
+#define XE_DEFAULT_ALLOW_BOUND_WC_SHRINK	false
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index 848d6526..67bcaf54 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -22,6 +22,7 @@
 #include "xe_sched_job.h"
 
 struct xe_modparam xe_modparam = {
+	.allow_bound_wc_shrink = XE_DEFAULT_ALLOW_BOUND_WC_SHRINK,
 	.probe_display =	XE_DEFAULT_PROBE_DISPLAY,
 	.guc_log_level =	XE_DEFAULT_GUC_LOG_LEVEL,
 	.force_probe =		XE_DEFAULT_FORCE_PROBE,
@@ -33,6 +34,11 @@ struct xe_modparam xe_modparam = {
 	/* the rest are 0 by default */
 };
 
+module_param_named(allow_bound_wc_shrink, xe_modparam.allow_bound_wc_shrink,
+		   bool, 0600);
+MODULE_PARM_DESC(allow_bound_wc_shrink,
+		 "Permit reclaim of VM-bound write-combined BOs");
+
 module_param_named(svm_notifier_size, xe_modparam.svm_notifier_size, uint, 0600);
 MODULE_PARM_DESC(svm_notifier_size, "Set the svm notifier size in MiB, must be power of 2 "
 		 "[default=" __stringify(XE_DEFAULT_SVM_NOTIFIER_SIZE) "]");
diff --git a/drivers/gpu/drm/xe/xe_module.h b/drivers/gpu/drm/xe/xe_module.h
index a0eb7db0..bf2c49ce 100644
--- a/drivers/gpu/drm/xe/xe_module.h
+++ b/drivers/gpu/drm/xe/xe_module.h
@@ -12,6 +12,7 @@ struct work_struct;
 
 /* Module modprobe variables */
 struct xe_modparam {
+	bool allow_bound_wc_shrink;
 	bool probe_display;
 	int force_vram_bar_size;
 	int guc_log_level;
@@ -32,4 +33,3 @@ bool xe_destroy_wq_queue(struct work_struct *work);
 void xe_destroy_wq_flush(void);
 
 #endif
-
diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index 83374cd5..edbc22b2 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -11,6 +11,7 @@
 #include <drm/ttm/ttm_tt.h>
 
 #include "xe_bo.h"
+#include "xe_module.h"
 #include "xe_pm.h"
 #include "xe_shrinker.h"
 
@@ -54,6 +55,30 @@ xe_shrinker_mod_pages(struct xe_shrinker *shrinker, long shrinkable, long purgea
 	write_unlock(&shrinker->lock);
 }
 
+static bool xe_shrinker_skip_bound_wc(struct ttm_buffer_object *ttm_bo,
+				      const struct xe_bo_shrink_flags flags)
+{
+	struct xe_bo *bo;
+
+	if (flags.purge || xe_modparam.allow_bound_wc_shrink ||
+	    !xe_bo_is_xe_bo(ttm_bo))
+		return false;
+
+	bo = ttm_to_xe_bo(ttm_bo);
+
+	/*
+	 * Restoring a backed-up WC BO changes freshly allocated WB pages to WC.
+	 * On x86 that runs CPA cache/TLB flushes synchronously while validation
+	 * holds this BO's dma-resv. A VM-bound BO is also likely to be reused by
+	 * a following EXEC, so reclaiming it can turn moderate memory pressure
+	 * into a multi-client reservation-lock stall. Keep that working set
+	 * resident; purgeable objects and objects after VM_UNBIND remain
+	 * reclaimable.
+	 */
+	return ttm_bo->ttm->caching == ttm_write_combined &&
+		xe_bo_is_vm_bound(bo);
+}
+
 static s64 __xe_shrinker_walk(struct xe_device *xe,
 			      struct ttm_operation_ctx *ctx,
 			      const struct xe_bo_shrink_flags flags,
@@ -78,6 +103,9 @@ static s64 __xe_shrinker_walk(struct xe_device *xe,
 			if (!ttm_bo_shrink_suitable(ttm_bo, ctx))
 				continue;
 
+			if (xe_shrinker_skip_bound_wc(ttm_bo, flags))
+				continue;
+
 			lret = xe_bo_shrink(ctx, ttm_bo, flags, scanned);
 			if (lret < 0)
 				return lret;
-- 
2.50.1 (Apple Git-155)
