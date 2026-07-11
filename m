Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB79AC44511
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C6D10F9E7;
	Sat, 11 Jul 2026 02:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A7nrS0cZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6876610E6F0;
 Sat, 11 Jul 2026 02:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738592; x=1815274592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jmFpHjqNdJa+TqbFOH1B7sfGPu+FdIecupYR3B+0tKY=;
 b=A7nrS0cZ7KeJ3PQhEKQOkpsh6gfLo2qaNGiwpYxzDrSUFUTv9C867E2E
 IinsY2wg3kwSUMJWUCnyZYGTkjCpJ63cUwMV5p8xDA3gKknbDea0iB8gQ
 /OAAxA+t60exBz4KDkJYQzcHFJWdkdO2j0ODTsjQKardPeaCvKVt0osOJ
 qfZjEtzXrlkKM2Lna1ZYok15JmexkGewvZXVsOfMck3GGqgd5C8iTshHX
 V6gu+YfCHu2j6leYUXUM8FA9sgYucZdRhHJ67UGcvAqZWzFgwdrmyZ880
 E26D4zOsWg2wqkiy/qXsmN0wv8MpQ5uOhWp/dc8Rlj+rVdCETwBp86VVt w==;
X-CSE-ConnectionGUID: FdqDWaU3T8iNhJ/E8U+qJA==
X-CSE-MsgGUID: 6S05zHqfTE2VT2ejJkIJ5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986323"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986323"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:31 -0700
X-CSE-ConnectionGUID: DRVvVHk3SHmlo1yazSd+ow==
X-CSE-MsgGUID: bW4vLIekTDyeov1Z3glwEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987768"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v3 22/33] drm/xe: Add Kconfig.profile options for BO defrag
 configuration
Date: Fri, 10 Jul 2026 19:56:08 -0700
Message-Id: <20260711025619.2540575-23-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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
- DRM_XE_BO_DEFRAG_SIZE_LIMIT: Maximum number of bytes to defrag per
  work run
- DRM_XE_BO_DEFRAG_INTERVAL_MS: Default delay before defrag worker runs
- DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS: Upper bound for defrag worker
  interval

Update xe_bo.c to use these Kconfig options as defaults via #ifdef
guards, maintaining backward compatibility with hardcoded values when
not configured.

Additionally, disable defrag completely when XE_BO_DEFRAG_SIZE_LIMIT is
set less than 2M by returning early from xe_bo_defrag_update() (and
xe_bo_defrag_remove()) so BOs are never added to the defrag list or the
worker kicked; xe_bo_defrag_add() and xe_bo_defrag_schedule() assert the
limit is at least 2M.

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
 drivers/gpu/drm/xe/Kconfig.profile | 40 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_bo.c         | 26 +++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/xe/Kconfig.profile b/drivers/gpu/drm/xe/Kconfig.profile
index e07517d120e0..e0aade41f53e 100644
--- a/drivers/gpu/drm/xe/Kconfig.profile
+++ b/drivers/gpu/drm/xe/Kconfig.profile
@@ -74,3 +74,43 @@ config DRM_XE_ENABLE_SCHEDTIMEOUT_LIMIT
 	  to apply to applicable user. For elevated user, all above MIN
 	  and MAX values will apply when this configuration is enable to
 	  apply limitation. By default limitation is applied.
+
+config DRM_XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD
+	int "BO defrag reclaim backoff threshold"
+	default 2
+	range 1 1000
+	help
+	  Once this many BOs are tracked on the device defrag list (i.e. were
+	  backed with a sub-optimal page order), request that the TTM pool backs
+	  off from aggressive reclaim at the beneficial order during populate,
+	  so that allocations make forward progress instead of stalling.
+
+config DRM_XE_BO_DEFRAG_SIZE_LIMIT
+	int "Maximum bytes to defrag per work run"
+	default 33554432
+	range 0 1073741824
+	help
+	  Maximum number of bytes the defrag worker will process in a single run
+	  before yielding and rescheduling itself. Set to less than large page
+	  size (2M) to disable defrag. A defrag move synchronously reallocates
+	  and re-copies a BO's backing store, which is not free. If a large
+	  number of BOs become eligible at once, processing them all in one
+	  worker run would hold things up for a long, unbounded stretch.
+	  Instead, cap the work done per run and requeue, spreading the defrag
+	  effort out over time.
+
+config DRM_XE_BO_DEFRAG_INTERVAL_MS
+	int "Default delay before defrag worker run (ms)"
+	default 25
+	range 1 1000
+	help
+	  Default delay before (re)running the defrag worker, in milliseconds.
+
+config DRM_XE_BO_DEFRAG_INTERVAL_MAX_MS
+	int "Upper bound for defrag worker interval (ms)"
+	default 15000
+	range 100 1000000
+	help
+	  Upper bound for the (exponentially backed off) defrag worker interval,
+	  in milliseconds, so repeated failures don't push the retry arbitrarily
+	  far out. 15000 ms = 15 seconds.
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 073d926ef9ac..0bdd1c920404 100644
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
  * Maximum number of bytes of newly (re)allocated backing the defrag worker will
@@ -65,17 +69,31 @@
  * Only pages a move truly reallocates are charged; pages harvested from the old
  * backing are free, so an object larger than the budget is upgraded in
  * budget-sized slices across runs.
+ *
+ * Set to 0 to disable defrag completely.
  */
+#ifdef CONFIG_DRM_XE_BO_DEFRAG_SIZE_LIMIT
+#define XE_BO_DEFRAG_SIZE_LIMIT			CONFIG_DRM_XE_BO_DEFRAG_SIZE_LIMIT
+#else
 #define XE_BO_DEFRAG_SIZE_LIMIT			SZ_32M
+#endif
 
 /* Default delay before (re)running the defrag worker, in milliseconds. */
+#ifdef CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MS
+#define XE_BO_DEFRAG_INTERVAL_MS		CONFIG_DRM_XE_BO_DEFRAG_INTERVAL_MS
+#else
 #define XE_BO_DEFRAG_INTERVAL_MS		25
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
@@ -1126,6 +1144,7 @@ int xe_bo_defrag_init(struct xe_device *xe)
 
 static void xe_bo_defrag_schedule(struct xe_device *xe)
 {
+	xe_assert(xe, XE_BO_DEFRAG_SIZE_LIMIT >= SZ_2M);
 	schedule_delayed_work(&xe->mem.defrag.worker,
 			      msecs_to_jiffies(xe->mem.defrag.interval_ms));
 }
@@ -1152,6 +1171,7 @@ static void xe_bo_defrag_add(struct xe_bo *bo)
 
 	xe_bo_assert_held(bo);
 	xe_assert(xe, xe_bo_needs_defrag(bo));
+	xe_assert(xe, XE_BO_DEFRAG_SIZE_LIMIT >= SZ_2M);
 
 	scoped_guard(spinlock, &xe->mem.defrag.lock) {
 		if (list_empty(&bo->defrag_link)) {
@@ -1185,6 +1205,9 @@ static void xe_bo_defrag_remove(struct xe_bo *bo)
 {
 	xe_bo_assert_held(bo);
 
+	if (XE_BO_DEFRAG_SIZE_LIMIT < SZ_2M)
+		return;
+
 	if (list_empty(&bo->defrag_link))
 		return;
 
@@ -1204,6 +1227,9 @@ static void xe_bo_defrag_update(struct xe_bo *bo)
 {
 	xe_bo_assert_held(bo);
 
+	if (XE_BO_DEFRAG_SIZE_LIMIT < SZ_2M)
+		return;
+
 	if (xe_bo_needs_defrag(bo))
 		xe_bo_defrag_add(bo);
 	else
-- 
2.34.1

