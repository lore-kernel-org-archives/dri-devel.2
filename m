Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEEAC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2403B10E6EE;
	Tue, 28 Jul 2026 07:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ugreen.com header.i=@ugreen.com header.b="JGc2T21h";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A788610E52A;
 Tue, 28 Jul 2026 06:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1785219454;
 bh=IKr/xBiap9QPDPCSVpn98P0/Z/fzgZ4/NfU/RLKVtCc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=JGc2T21hWsZTe9sKmr9UTziWlturj7SmsB8oM2o0f5XJZo2CRlvhsjgkAyzFMPiQY
 6wcTB7dCgJI4TemJh18pQ02x8k41FsrWEv7lPsZ9xafrOuVsSrhLP7WQ+AmyquimDE
 5ETZ5D0mpc//WoduIuDbCH0wZ9NCHMah5dVXj3AE=
X-QQ-mid: zesmtpsz7t1785219446t70fee9d6
X-QQ-Originating-IP: p8L3zlY7hvQavcP/y5EST1VwZSbwTEWUR43h+3UjyqY=
Received: from localhost.localdomain ( [113.90.157.158])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 28 Jul 2026 14:16:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11062680780444015281
From: Neil Zhong <neil.zhong@ugreen.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] drm/xe: keep VM-bound WC BOs resident during reclaim
Date: Tue, 28 Jul 2026 14:14:43 +0800
Message-ID: <4BF27CE161436C73+20260728061443.33616-2-neil.zhong@ugreen.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260728061443.33616-1-neil.zhong@ugreen.com>
References: <20260728061443.33616-1-neil.zhong@ugreen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NuZvjORXcxgLG6wmvnSq4ukANbhuoLEMKgwd/q4ObQNKuxEqYD7Xntvh
 b0Lw3nQFGCwYjr1cWl3/CgFERbzZq/gYQ3wtDOLj/k9Ph1nkXkMvp5iqwC4lnyqkl7AtXIr
 cwI57xkMUoHt8mtU/iwW6S+8TPZ+RYbhfTpMJ0I4hJj6gV1bOZzJVKpqqSncde1ocZLzkxj
 dw2Ny0VpkvpkWkbgUvhWkMcTsP320WfkGHiu4D6Rzj7itkZp7htBc/BuuOa7/+laL751CtN
 zskPXM2ztazK185J6i27TUVWrInMXqhAggTKY9QDQcj4yq+8yp4HfvSkY3+8m08IhR9izjM
 CMg9M7hoPXK55ESoWsS+tCaKNgx5X8v4CVDg/CkATxg5gwYfmWfIm0Oi33gKKZZCPseXD8c
 dz9feZAztBt2EMhv8Sz9u2lnmgy2huppzeipp4hIAMKOXRadbsumPL74wBzYAlOn8fHhrU1
 cbwCoxt60/6OMQRqaqZRKquvx+iI2BlwQa8+nYP2StZaCqmVHHZZZ6Yhzckpez1dYV9EoZm
 uDUqG6XZOzS6zcV0rbUyH1EPR+5TwF2i1LI87X6lcHEo78Pf9n7xkSfmYHfOYg2IE5rav+d
 1dEwQ3ifwQLAVs1tef7QX3DivNslrMQ4HfD5Jxwk7ni4bBubJlWGwmE5uPJiycBs4qYPXxZ
 c/zZCdjoI7glPlJUUYBgZVX5G02MbS+4pMrEnBCE0A3S94pYVgqKaRlcdyJqXu1Fi1gJkVn
 H5A4nOnalksOyYF4KJhXA7VPEc4k+MbwRQKz4g/XhsC4LalDySrJ7fgVUHOrsuVHo1MhaWJ
 QmR7U8+n+ERFrN1l5iid1jqq159ixB1q5B8HA9fsMSE/H3KCoJGdUTnZYHYQGE75RRz1SI/
 YY74brpGkgb0UnXSobNHijN/pG9MNX70syye0DEUod0C1f4qns4jMnEM+jKjnTl4M5Du+sK
 uUyUT4Gu6Z6r4MRKZcwRDvbT2nAMLpHwZSJqK+T/FuIgVt3zknCrbxuGKXJb7DrYLRQ4NSs
 RgozFbT/KFgnbitYwr
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
index 83374cd5..caa39f39 100644
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
@@ -75,6 +100,9 @@ static s64 __xe_shrinker_walk(struct xe_device *xe,
 			continue;
 
 		ttm_bo_lru_for_each_reserved_guarded(&curs, man, &arg, ttm_bo) {
+			if (xe_shrinker_skip_bound_wc(ttm_bo, flags))
+				continue;
+
 			if (!ttm_bo_shrink_suitable(ttm_bo, ctx))
 				continue;
 
-- 
2.50.1 (Apple Git-155)

