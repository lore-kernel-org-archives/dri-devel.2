Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1D5CDB47C
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6587F10ECDF;
	Tue, 23 Jun 2026 22:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XT6+/xJP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870BA10ECE7;
 Tue, 23 Jun 2026 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253660; x=1813789660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Bge7msPG+gcVGWJrjYkp2rl2GsHEw9b2i3xjWrikY5w=;
 b=XT6+/xJPPrBxOWNq/36p5iQCHeP17AEQXLrQXBXgki/Yu6e1gHRldLr2
 sH2nRGD/ylReisjjExWF8e76zAah8tidjOPIohBzqHOqJfEBaMnDp1YL+
 JXqVFXiz7WBcuGDBC1wSJkuHdftPO0yegGlXL/HKIJqVE4TAqy1uw751p
 c7MESOG27iLR637yCHNoh13GKDMsXsIU5k9C3ltrv1+cmnZZ2/wK6YgGM
 Hhm2jsc9/0ZXTjSFZ/IvfyVgN/mLg0mfG39PZgrhUWiNJFdyl2cwux880
 ZvAaAsdJAYDOnQfAI/tR1JIwrCNq1iQ/+fXr2YRtjGbWrjlW0WtmZjrQ9 w==;
X-CSE-ConnectionGUID: /MVvx0hHTzajIP2X4CE8Ag==
X-CSE-MsgGUID: MeD7mOvsRgWV6ygrXVKpyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048832"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048832"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:40 -0700
X-CSE-ConnectionGUID: hc0NDCeyS3O5F8iyY70yBw==
X-CSE-MsgGUID: gRIoWvBhR2y8GIttuhlgAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335813"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:40 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 12/12] drm/xe: Add Kconfig.profile options for BO defrag
 configuration
Date: Tue, 23 Jun 2026 15:27:32 -0700
Message-Id: <20260623222732.360872-13-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623222732.360872-1-matthew.brost@intel.com>
References: <20260623222732.360872-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Add Kconfig.profile options to make XE_BO_DEFRAG_* defines configurable:
- DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD: Threshold for TTM reclaim
  backoff
- DRM_XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK: Maximum BOs to defrag per work
  run
- DRM_XE_BO_DEFRAG_INTERVAL_MS: Default delay before defrag worker runs
- DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS: Upper bound for defrag worker
  interval

Update xe_bo.c to use these Kconfig options as defaults via #ifdef
guards, maintaining backward compatibility with hardcoded values when
not configured.

Additionally, disable defrag completely when
XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK is set to 0 by returning early from
xe_bo_defrag_add() without adding to the defrag list or kicking the
worker.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-haiku-4.5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/Kconfig.profile | 35 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_bo.c         | 22 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/xe/Kconfig.profile b/drivers/gpu/drm/xe/Kconfig.profile
index e07517d120e0..4de501b3af64 100644
--- a/drivers/gpu/drm/xe/Kconfig.profile
+++ b/drivers/gpu/drm/xe/Kconfig.profile
@@ -74,3 +74,38 @@ config DRM_XE_ENABLE_SCHEDTIMEOUT_LIMIT
 	  to apply to applicable user. For elevated user, all above MIN
 	  and MAX values will apply when this configuration is enable to
 	  apply limitation. By default limitation is applied.
+
+config DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD
+	int "BO defrag reclaim backoff threshold"
+	default 2
+	help
+	  Once this many BOs are tracked on the device defrag list (i.e. were
+	  backed with a sub-optimal page order), request that the TTM pool backs
+	  off from aggressive reclaim at the beneficial order during populate,
+	  so that allocations make forward progress instead of stalling.
+
+config DRM_XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK
+	int "Maximum BOs to defrag per work run"
+	default 2
+	help
+	  Maximum number of BOs the defrag worker will process in a single run
+	  before yielding and rescheduling itself. Set to 0 to disable defrag.
+	  A defrag move synchronously reallocates and re-copies a BO's backing
+	  store, which is not free. If a large number of BOs become eligible at
+	  once, processing them all in one worker run would hold things up for a
+	  long, unbounded stretch. Instead, cap the work done per run and requeue,
+	  spreading the defrag effort out over time.
+
+config DRM_XE_BO_DEFRAG_INTERVAL_MS
+	int "Default delay before defrag worker run (ms)"
+	default 50
+	help
+	  Default delay before (re)running the defrag worker, in milliseconds.
+
+config DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS
+	int "Upper bound for defrag worker interval (ms)"
+	default 15000
+	help
+	  Upper bound for the (exponentially backed off) defrag worker interval,
+	  in milliseconds, so repeated failures don't push the retry arbitrarily
+	  far out. 15000 ms = 15 seconds.
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index f74fd6f5504a..b8935850f399 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -49,7 +49,11 @@
  * aggressive reclaim at the beneficial order during populate, so that
  * allocations make forward progress instead of stalling.
  */
+#ifdef CONFIG_DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD
+#define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	CONFIG_DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD
+#else
 #define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
+#endif
 
 /*
  * Maximum number of BOs the defrag worker will process in a single run before
@@ -62,17 +66,31 @@
  * concurrent active work (e.g. a large FPS drop). Instead, cap the work done
  * per run and requeue, spreading the defrag effort out over time so it stays
  * in the background and yields to userspace progress.
+ *
+ * Set to 0 to disable defrag completely.
  */
+#ifdef CONFIG_DRM_XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK
+#define XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK	CONFIG_DRM_XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK
+#else
 #define XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK	2
+#endif
 
 /* Default delay before (re)running the defrag worker, in milliseconds. */
+#ifdef CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MS
+#define XE_BO_DEFRAG_INTERVAL_MS		CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MS
+#else
 #define XE_BO_DEFRAG_INTERVAL_MS		50
+#endif
 
 /*
  * Upper bound for the (exponentially backed off) defrag worker interval, in
  * milliseconds, so repeated failures don't push the retry arbitrarily far out.
  */
+#ifdef CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS
+#define XE_BO_DEFRAG_INTERVAL_MAX_MS		CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS
+#else
 #define XE_BO_DEFRAG_INTERVAL_MAX_MS		15000	/* 15 seconds */
+#endif
 
 static void xe_bo_defrag_worker(struct work_struct *w);
 static void xe_place_from_ttm_type(u32 mem_type, struct ttm_place *place);
@@ -1036,6 +1054,10 @@ static void xe_bo_defrag_add(struct xe_bo *bo)
 	struct xe_device *xe = xe_bo_device(bo);
 	bool kick = false;
 
+	/* Defrag disabled when limit is 0 */
+	if (!XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK)
+		return;
+
 	scoped_guard(spinlock, &xe->mem.defrag.lock) {
 		if (list_empty(&bo->defrag_link)) {
 			/* Kick the worker when the list transitions to non-empty. */
-- 
2.34.1

