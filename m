Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3EF606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XhDckxaX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64EF10E173;
	Thu, 29 Oct 2026 01:42:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 168A810E173;
 Thu, 29 Oct 2026 01:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793238136; x=1824774136;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eNYuH9AQl8yTvhInewVbZNRp0DAeeg6oZEyrn9tR30Q=;
 b=XhDckxaXlF0vx5wGanfYktHwCpTRKznaxFtXyohhN+IEBIIu4Y5coRSD
 jI9Xmefw+3GY2GMMXtujs3WiPhqZHpUkRuWXLEaG78YyOmbd5j2k0ZBiN
 StJR8HWOr1IWQIKR88QZrWkIOg0R+ty+t8hRbDt/itjCVVEGAIdhDo6/w
 49Gsho/aYrSH3m/TDh725Z3/gvHjShSxJxjj4+pDt7J0jZQGX9ZgG2BHr
 rA85ax3nZt5hu5rIEe9L0q4CPSwVK+WkPUOQ6Cxkz21VKS3v2PxBy9JZC
 YFW0QhfcacgB4hfEaRkiQzH/VhbdS5K+fIGCc53PDcEZ1UgcZ7uXfK7zQ Q==;
X-CSE-ConnectionGUID: VMEN9qtGRa6dmzToW5taSw==
X-CSE-MsgGUID: n/v//3U9RhC540PlD/6o3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2006005"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="2006005"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:16 -0700
X-CSE-ConnectionGUID: A7Gxc6b1Sd2/cTvOdUD7wQ==
X-CSE-MsgGUID: JfYJ3m9GRAic7C5tNNEwig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6823182"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.30])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:13 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [RFC 1/5] drm/i915/selftests: Port GT-dependent selftests to work
 with multi-GT (low-hanging fruits part 1)
Date: Thu, 29 Oct 2026 02:41:51 +0100
Message-ID: <20261029014155.55865-2-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029014155.55865-1-krzysztof.niemiec@intel.com>
References: <20261029014155.55865-1-krzysztof.niemiec@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Port tests that take GT as argument or otherwise depend on a specific GT
to work to correctly check every GT on system.

This patch addresses the test suites that only really needed to have the
test calls wrapped inside for_each_gt with little to no other intervention.

Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---

Note that the mock device related tests haven't been touched. This is
because the mock device is hard-coded to have a single GT, so to_gt()
will always be correct. At this moment the single GT assumption is
reasonable to make from the perspective of the test developer, and
changing those to handle multi-gt mock devices is IMO out of scope and
should be done if/when mock devices are expanded to have multiple GTs.

Maybe it's worth it to annotate the places where the single GT
assumption is made for mock devices?

 .../drm/i915/gem/selftests/i915_gem_migrate.c | 11 +++++-
 drivers/gpu/drm/i915/gt/selftest_context.c    | 16 ++++++--
 drivers/gpu/drm/i915/gt/selftest_engine.c     | 15 +++++---
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  | 15 ++++++--
 .../drm/i915/gt/selftest_engine_heartbeat.c   | 22 +++++++----
 drivers/gpu/drm/i915/gt/selftest_execlists.c  | 19 +++++++---
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      | 15 ++++++--
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c  | 24 +++++++-----
 drivers/gpu/drm/i915/gt/selftest_lrc.c        | 11 +++++-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    | 38 +++++++++++++------
 drivers/gpu/drm/i915/gt/selftest_mocs.c       | 11 +++++-
 drivers/gpu/drm/i915/gt/selftest_reset.c      | 20 +++++++---
 .../drm/i915/gt/selftest_ring_submission.c    | 15 ++++++--
 drivers/gpu/drm/i915/gt/selftest_timeline.c   | 15 ++++++--
 .../gpu/drm/i915/gt/selftest_workarounds.c    | 15 ++++++--
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c     | 20 +++++++---
 .../drm/i915/gt/uc/selftest_guc_hangcheck.c   | 20 +++++++---
 .../drm/i915/gt/uc/selftest_guc_multi_lrc.c   | 20 +++++++---
 .../gpu/drm/i915/selftests/i915_gem_evict.c   | 15 ++++++--
 drivers/gpu/drm/i915/selftests/intel_uncore.c | 11 +++++-
 20 files changed, 260 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
index d8f4a10d71de..3d4ffca8087c 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
@@ -520,9 +520,18 @@ int i915_gem_migrate_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_lmem_pages_failsafe_migrate),
 		SUBTEST(igt_lmem_async_migrate),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
 	if (!HAS_LMEM(i915))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	for_each_gt(gt, i915, id) {
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_context.c b/drivers/gpu/drm/i915/gt/selftest_context.c
index ab76703f6e8b..ae56b410a320 100644
--- a/drivers/gpu/drm/i915/gt/selftest_context.c
+++ b/drivers/gpu/drm/i915/gt/selftest_context.c
@@ -446,10 +446,18 @@ int intel_context_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_active_context),
 		SUBTEST(live_remote_context),
 	};
-	struct intel_gt *gt = to_gt(i915);
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(gt))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
+
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
 
-	return intel_gt_live_subtests(tests, gt);
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine.c b/drivers/gpu/drm/i915/gt/selftest_engine.c
index 57fea9ea1705..bd96db071859 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine.c
@@ -12,15 +12,18 @@ int intel_engine_live_selftests(struct drm_i915_private *i915)
 		live_engine_pm_selftests,
 		NULL,
 	};
-	struct intel_gt *gt = to_gt(i915);
+	struct intel_gt *gt;
 	typeof(*tests) *fn;
+	unsigned int id;
 
-	for (fn = tests; *fn; fn++) {
-		int err;
+	for_each_gt(gt, i915, id) {
+		for (fn = tests; *fn; fn++) {
+			int err;
 
-		err = (*fn)(gt);
-		if (err)
-			return err;
+			err = (*fn)(gt);
+			if (err)
+				return err;
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
index 5ffa5e30f419..99348395b92b 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
@@ -380,11 +380,20 @@ int intel_engine_cs_perf_selftests(struct drm_i915_private *i915)
 		SUBTEST(perf_mi_bb_start),
 		SUBTEST(perf_mi_noop),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int intel_mmio_bases_check(void *arg)
diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
index b893a8fde895..933f30d250c7 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
@@ -266,18 +266,26 @@ int intel_heartbeat_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_heartbeat_off),
 	};
 	int saved_hangcheck;
+	struct intel_gt *gt;
+	unsigned int id;
 	int err;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
 
-	saved_hangcheck = i915->params.enable_hangcheck;
-	i915->params.enable_hangcheck = INT_MAX;
+		saved_hangcheck = i915->params.enable_hangcheck;
+		i915->params.enable_hangcheck = INT_MAX;
 
-	err = intel_gt_live_subtests(tests, to_gt(i915));
+		err = intel_gt_live_subtests(tests, gt);
 
-	i915->params.enable_hangcheck = saved_hangcheck;
-	return err;
+		i915->params.enable_hangcheck = saved_hangcheck;
+
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 void st_engine_heartbeat_disable(struct intel_engine_cs *engine)
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 21e5ed9f72a3..ddf71b3784bf 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -4495,12 +4495,21 @@ int intel_execlists_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_virtual_slice),
 		SUBTEST(live_virtual_reset),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (to_gt(i915)->submission_method != INTEL_SUBMISSION_ELSP)
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (gt->submission_method != INTEL_SUBMISSION_ELSP)
+			continue;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+		if (intel_gt_is_wedged(gt))
+			continue;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
index 07eaf71955c4..09c0c4096665 100644
--- a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
+++ b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
@@ -205,9 +205,18 @@ int intel_gt_pm_late_selftests(struct drm_i915_private *i915)
 		 */
 		SUBTEST(live_rc6_ctx_wa),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
index 53f3ce5c33a4..d67a6d75c56a 100644
--- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
@@ -2016,21 +2016,27 @@ int intel_hangcheck_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_reset_evict_fence),
 		SUBTEST(igt_handle_error),
 	};
-	struct intel_gt *gt = to_gt(i915);
 	intel_wakeref_t wakeref;
+	struct intel_gt *gt;
+	unsigned int id;
 	int err;
 
-	if (!intel_has_gpu_reset(gt))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (!intel_has_gpu_reset(gt))
+			continue;
 
-	if (intel_gt_is_wedged(gt))
-		return -EIO; /* we're long past hope of a successful reset */
+		if (intel_gt_is_wedged(gt))
+			return -EIO; /* we're long past hope of a successful reset */
 
-	wakeref = intel_runtime_pm_get(gt->uncore->rpm);
+		wakeref = intel_runtime_pm_get(gt->uncore->rpm);
 
-	err = intel_gt_live_subtests(tests, gt);
+		err = intel_gt_live_subtests(tests, gt);
 
-	intel_runtime_pm_put(gt->uncore->rpm, wakeref);
+		intel_runtime_pm_put(gt->uncore->rpm, wakeref);
 
-	return err;
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_lrc.c b/drivers/gpu/drm/i915/gt/selftest_lrc.c
index 23f04f6f8fba..ac26c91b1e1f 100644
--- a/drivers/gpu/drm/i915/gt/selftest_lrc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_lrc.c
@@ -1986,9 +1986,18 @@ int intel_lrc_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_lrc_indirect_ctx_bb),
 		SUBTEST(live_lrc_per_ctx_bb),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
 	if (!HAS_LOGICAL_RING_CONTEXTS(i915))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	for_each_gt(gt, i915, id) {
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
index 5b986a7687d9..997fd1ec155c 100644
--- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
+++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
@@ -562,7 +562,7 @@ static int live_emit_pte_full_ring(void *arg)
 	 * nearly full.
 	 */
 
-	if (igt_spinner_init(&st.spin, to_gt(i915)))
+	if (igt_spinner_init(&st.spin, gt))
 		return -ENOMEM;
 
 	obj = i915_gem_object_create_internal(i915, 2 * PAGE_SIZE);
@@ -806,12 +806,20 @@ int intel_migrate_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(thread_global_copy),
 		SUBTEST(thread_global_clear),
 	};
-	struct intel_gt *gt = to_gt(i915);
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (!gt->migrate.context)
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (!gt->migrate.context)
+			continue;
 
-	return intel_gt_live_subtests(tests, gt);
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static struct drm_i915_gem_object *
@@ -1027,13 +1035,21 @@ int intel_migrate_perf_selftests(struct drm_i915_private *i915)
 		SUBTEST(perf_clear_blt),
 		SUBTEST(perf_copy_blt),
 	};
-	struct intel_gt *gt = to_gt(i915);
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(gt))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
 
-	if (!gt->migrate.context)
-		return 0;
+		if (!gt->migrate.context)
+			continue;
 
-	return intel_gt_live_subtests(tests, gt);
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_mocs.c b/drivers/gpu/drm/i915/gt/selftest_mocs.c
index d73e438fb85f..916ceba580da 100644
--- a/drivers/gpu/drm/i915/gt/selftest_mocs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_mocs.c
@@ -445,9 +445,18 @@ int intel_mocs_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_mocs_reset),
 	};
 	struct drm_i915_mocs_table table;
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
 	if (!get_mocs_settings(i915, &table))
 		return 0;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	for_each_gt(gt, i915, id) {
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_reset.c b/drivers/gpu/drm/i915/gt/selftest_reset.c
index 2cfc23c58e90..43f90b0687d7 100644
--- a/drivers/gpu/drm/i915/gt/selftest_reset.c
+++ b/drivers/gpu/drm/i915/gt/selftest_reset.c
@@ -382,13 +382,21 @@ int intel_reset_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_atomic_reset),
 		SUBTEST(igt_atomic_engine_reset),
 	};
-	struct intel_gt *gt = to_gt(i915);
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (!intel_has_gpu_reset(gt))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (!intel_has_gpu_reset(gt))
+			continue;
 
-	if (intel_gt_is_wedged(gt))
-		return -EIO; /* we're long past hope of a successful reset */
+		if (intel_gt_is_wedged(gt))
+			return -EIO; /* we're long past hope of a successful reset */
 
-	return intel_gt_live_subtests(tests, gt);
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
index 600333ae6c8c..6ce7be6e7692 100644
--- a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
@@ -291,9 +291,18 @@ int intel_ring_submission_live_selftests(struct drm_i915_private *i915)
 	static const struct i915_subtest tests[] = {
 		SUBTEST(live_ctx_switch_wa),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (to_gt(i915)->submission_method > INTEL_SUBMISSION_RING)
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (gt->submission_method > INTEL_SUBMISSION_RING)
+			continue;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_timeline.c b/drivers/gpu/drm/i915/gt/selftest_timeline.c
index 29d860a5c9c8..0aad7bd50926 100644
--- a/drivers/gpu/drm/i915/gt/selftest_timeline.c
+++ b/drivers/gpu/drm/i915/gt/selftest_timeline.c
@@ -1421,9 +1421,18 @@ int intel_timeline_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_hwsp_rollover_kernel),
 		SUBTEST(live_hwsp_rollover_user),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_workarounds.c b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
index 4e4c420ae67f..8f9705b25f70 100644
--- a/drivers/gpu/drm/i915/gt/selftest_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
@@ -1374,9 +1374,18 @@ int intel_workarounds_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_gpu_reset_workarounds),
 		SUBTEST(live_engine_reset_workarounds),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
+
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
index 63a75272924f..c8ce82692614 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
@@ -407,13 +407,21 @@ int intel_guc_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(intel_guc_steal_guc_ids),
 		SUBTEST(intel_guc_fast_request),
 	};
-	struct intel_gt *gt = to_gt(i915);
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(gt))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
 
-	if (!intel_uc_uses_guc_submission(&gt->uc))
-		return 0;
+		if (!intel_uc_uses_guc_submission(&gt->uc))
+			continue;
+
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
 
-	return intel_gt_live_subtests(tests, gt);
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
index 83801c992488..91a129e73665 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
@@ -150,13 +150,21 @@ int intel_guc_hang_check(struct drm_i915_private *i915)
 	static const struct i915_subtest tests[] = {
 		SUBTEST(intel_hang_guc),
 	};
-	struct intel_gt *gt = to_gt(i915);
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(gt))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
 
-	if (!intel_uc_uses_guc_submission(&gt->uc))
-		return 0;
+		if (!intel_uc_uses_guc_submission(&gt->uc))
+			continue;
+
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
 
-	return intel_gt_live_subtests(tests, gt);
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
index 18077801b2e6..e4652b1b303d 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
@@ -172,13 +172,21 @@ int intel_guc_multi_lrc_live_selftests(struct drm_i915_private *i915)
 	static const struct i915_subtest tests[] = {
 		SUBTEST(intel_guc_multi_lrc_basic),
 	};
-	struct intel_gt *gt = to_gt(i915);
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(gt))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
 
-	if (!intel_uc_uses_guc_submission(&gt->uc))
-		return 0;
+		if (!intel_uc_uses_guc_submission(&gt->uc))
+			continue;
 
-	return intel_gt_live_subtests(tests, gt);
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
index 718cddde7e73..fd58faf31fe5 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
@@ -563,9 +563,18 @@ int i915_gem_evict_live_selftests(struct drm_i915_private *i915)
 	static const struct i915_subtest tests[] = {
 		SUBTEST(igt_evict_contexts),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			continue;
+
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/drm/i915/selftests/intel_uncore.c
index 514d2200751b..e741dd322537 100644
--- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
+++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
@@ -288,6 +288,15 @@ int intel_uncore_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_fw_table),
 		SUBTEST(live_forcewake_ops),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	return intel_gt_live_subtests(tests, to_gt(i915));
+	for_each_gt(gt, i915, id) {
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
-- 
2.55.0

