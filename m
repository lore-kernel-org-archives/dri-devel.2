Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD0606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q6/LTXJ3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F1B10FEE6;
	Thu, 29 Oct 2026 01:42:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C440110FEE6;
 Thu, 29 Oct 2026 01:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793238161; x=1824774161;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9qNyHWL22Ko5t0TRxtdZgXTLhashvzBZr8Ycy6FNRGQ=;
 b=Q6/LTXJ3boiThQsy1aWySeB8IolpI/NFBM3uhWa37Tx+LVhBwxPIasEo
 wS44edCHS/RpHE4qSQO7FfT0ySMZXJ295as2aQrI2C5aM4xg62JonlW31
 fVUrROvpZvoKFD+hv1RD8HqFR8vnG0uGEp52+WEV91S7uARHy0kpprDBt
 4MeptsEqJ0XQqb0H+W7431hfA4hV3PvC4MhXwwc50GLKQKwFwhAVPYFPH
 jC7qVIh863AnbD7QGdNdMLNBYNHhZ3T1JATDCtNK3GrGLlEzTRGqc/VM7
 UDqaO1RPqVVmJ+KL7wCSF6QZOk/VtLxhCL/PAotr+7bC/qaJqwh6S/MC5 w==;
X-CSE-ConnectionGUID: 3Z2g6aGUQiWam+otBghV6A==
X-CSE-MsgGUID: 6qSUCbpARryqA+Av9TW0TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1990000"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1990000"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:40 -0700
X-CSE-ConnectionGUID: 1c9OX9oVQA6teBvS+bXjrw==
X-CSE-MsgGUID: 2yMLZGOSTYWjuRy/GpVMng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5522386"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.30])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:38 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [RFC 5/5] drm/i915/selftests: Port selftests that access ggtt to work
 with multi-gt
Date: Thu, 29 Oct 2026 02:41:55 +0100
Message-ID: <20261029014155.55865-6-krzysztof.niemiec@intel.com>
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

Some of the selftests reference a GGTT via to_gt(i915)->ggtt. This is
only incidentally correct on single-gt platforms and on MTL and ARL,
which have two GTs sharing the same GGTT. In principle, however,
different GTs could have different GGTTs associated with them. Have the
tests reflect that scenario by switching to a specific gt instead of
using the to_gt() macro when appropriate.

Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---

Same separate-GGTT assumption as in patch 3, however, this entire change
pertains only to this, so if that assumption can be relaxed, the entire
patch can be probably be dropped from the series (maybe save for the
engine->gt == gt check, but that can be squashed into another patch then)

 .../i915/gem/selftests/i915_gem_client_blt.c  | 29 +++++--
 drivers/gpu/drm/i915/selftests/i915_gem.c     | 79 +++++++++++--------
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 16 +++-
 3 files changed, 80 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c
index 1d4d7cfb3f9c..938185274e29 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_client_blt.c
@@ -688,11 +688,11 @@ static bool has_bit17_swizzle(int sw)
 		sw == I915_BIT_6_SWIZZLE_9_17);
 }
 
-static bool bad_swizzling(struct drm_i915_private *i915)
+static bool bad_swizzling(struct intel_gt *gt)
 {
-	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
+	struct i915_ggtt *ggtt = gt->ggtt;
 
-	if (i915->gem_quirks & GEM_QUIRK_PIN_SWIZZLED_PAGES)
+	if (gt->i915->gem_quirks & GEM_QUIRK_PIN_SWIZZLED_PAGES)
 		return true;
 
 	if (has_bit17_swizzle(ggtt->bit_6_swizzle_x) ||
@@ -704,7 +704,8 @@ static bool bad_swizzling(struct drm_i915_private *i915)
 
 static int igt_client_tiled_blits(void *arg)
 {
-	struct drm_i915_private *i915 = arg;
+	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	I915_RND_STATE(prng);
 	int inst = 0;
 
@@ -712,7 +713,7 @@ static int igt_client_tiled_blits(void *arg)
 	if (GRAPHICS_VER(i915) < 4)
 		return 0;
 
-	if (bad_swizzling(i915)) /* Requires sane (sub-page) swizzling */
+	if (bad_swizzling(gt)) /* Requires sane (sub-page) swizzling */
 		return 0;
 
 	do {
@@ -725,6 +726,9 @@ static int igt_client_tiled_blits(void *arg)
 		if (!engine)
 			return 0;
 
+		if (engine->gt != gt)
+			continue;
+
 		err = __igt_client_tiled_blits(engine, &prng);
 		if (err == -ENODEV)
 			err = 0;
@@ -738,9 +742,18 @@ int i915_gem_client_blt_live_selftests(struct drm_i915_private *i915)
 	static const struct i915_subtest tests[] = {
 		SUBTEST(igt_client_tiled_blits),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			return 0;
 
-	return i915_live_subtests(tests, i915);
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem.c b/drivers/gpu/drm/i915/selftests/i915_gem.c
index ad650f67114a..8f72fd1af8d6 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem.c
@@ -40,9 +40,10 @@ static int switch_to_context(struct i915_gem_context *ctx)
 	return err;
 }
 
-static void trash_stolen(struct drm_i915_private *i915)
+static void trash_stolen(struct intel_gt *gt)
 {
-	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
+	struct drm_i915_private *i915 = gt->i915;
+	struct i915_ggtt *ggtt = gt->ggtt;
 	const u64 slot = ggtt->error_capture.start;
 	const resource_size_t size = resource_size(&i915->dsm.stolen);
 	struct rnd_state prng;
@@ -74,11 +75,11 @@ static void trash_stolen(struct drm_i915_private *i915)
 	ggtt->vm.clear_range(&ggtt->vm, slot, PAGE_SIZE);
 }
 
-static void simulate_hibernate(struct drm_i915_private *i915)
+static void simulate_hibernate(struct intel_gt *gt)
 {
 	intel_wakeref_t wakeref;
 
-	wakeref = intel_runtime_pm_get(&i915->runtime_pm);
+	wakeref = intel_runtime_pm_get(&gt->i915->runtime_pm);
 
 	/*
 	 * As a final string in the tail, invalidate stolen. Under a real S4,
@@ -87,9 +88,9 @@ static void simulate_hibernate(struct drm_i915_private *i915)
 	 * for automated testing across a cluster), so to simulate the effect
 	 * of stolen being trashed across S4, we trash it ourselves.
 	 */
-	trash_stolen(i915);
+	trash_stolen(gt);
 
-	intel_runtime_pm_put(&i915->runtime_pm, wakeref);
+	intel_runtime_pm_put(&gt->i915->runtime_pm, wakeref);
 }
 
 static int igt_pm_prepare(struct drm_i915_private *i915)
@@ -99,29 +100,29 @@ static int igt_pm_prepare(struct drm_i915_private *i915)
 	return 0;
 }
 
-static void igt_pm_suspend(struct drm_i915_private *i915)
+static void igt_pm_suspend(struct intel_gt *gt)
 {
 	intel_wakeref_t wakeref;
 
-	with_intel_runtime_pm(&i915->runtime_pm, wakeref) {
-		i915_ggtt_suspend(to_gt(i915)->ggtt);
-		i915_gem_suspend_late(i915);
+	with_intel_runtime_pm(&gt->i915->runtime_pm, wakeref) {
+		i915_ggtt_suspend(gt->ggtt);
+		i915_gem_suspend_late(gt->i915);
 	}
 }
 
-static void igt_pm_hibernate(struct drm_i915_private *i915)
+static void igt_pm_hibernate(struct intel_gt *gt)
 {
 	intel_wakeref_t wakeref;
 
-	with_intel_runtime_pm(&i915->runtime_pm, wakeref) {
-		i915_ggtt_suspend(to_gt(i915)->ggtt);
+	with_intel_runtime_pm(&gt->i915->runtime_pm, wakeref) {
+		i915_ggtt_suspend(gt->ggtt);
 
-		i915_gem_freeze(i915);
-		i915_gem_freeze_late(i915);
+		i915_gem_freeze(gt->i915);
+		i915_gem_freeze_late(gt->i915);
 	}
 }
 
-static void igt_pm_resume(struct drm_i915_private *i915)
+static void igt_pm_resume(struct intel_gt *gt)
 {
 	intel_wakeref_t wakeref;
 
@@ -129,17 +130,18 @@ static void igt_pm_resume(struct drm_i915_private *i915)
 	 * Both suspend and hibernate follow the same wakeup path and assume
 	 * that runtime-pm just works.
 	 */
-	with_intel_runtime_pm(&i915->runtime_pm, wakeref) {
-		i915_ggtt_resume(to_gt(i915)->ggtt);
-		if (GRAPHICS_VER(i915) >= 8)
-			setup_private_pat(to_gt(i915));
-		i915_gem_resume(i915);
+	with_intel_runtime_pm(&gt->i915->runtime_pm, wakeref) {
+		i915_ggtt_resume(gt->ggtt);
+		if (GRAPHICS_VER(gt->i915) >= 8)
+			setup_private_pat(gt);
+		i915_gem_resume(gt->i915);
 	}
 }
 
 static int igt_gem_suspend(void *arg)
 {
-	struct drm_i915_private *i915 = arg;
+	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct i915_gem_context *ctx;
 	struct file *file;
 	int err;
@@ -159,12 +161,12 @@ static int igt_gem_suspend(void *arg)
 	if (err)
 		goto out;
 
-	igt_pm_suspend(i915);
+	igt_pm_suspend(gt);
 
 	/* Here be dragons! Note that with S3RST any S3 may become S4! */
-	simulate_hibernate(i915);
+	simulate_hibernate(gt);
 
-	igt_pm_resume(i915);
+	igt_pm_resume(gt);
 
 	err = switch_to_context(ctx);
 out:
@@ -174,7 +176,8 @@ static int igt_gem_suspend(void *arg)
 
 static int igt_gem_hibernate(void *arg)
 {
-	struct drm_i915_private *i915 = arg;
+	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct i915_gem_context *ctx;
 	struct file *file;
 	int err;
@@ -194,12 +197,12 @@ static int igt_gem_hibernate(void *arg)
 	if (err)
 		goto out;
 
-	igt_pm_hibernate(i915);
+	igt_pm_hibernate(gt);
 
 	/* Here be dragons! */
-	simulate_hibernate(i915);
+	simulate_hibernate(gt);
 
-	igt_pm_resume(i915);
+	igt_pm_resume(gt);
 
 	err = switch_to_context(ctx);
 out:
@@ -209,7 +212,8 @@ static int igt_gem_hibernate(void *arg)
 
 static int igt_gem_ww_ctx(void *arg)
 {
-	struct drm_i915_private *i915 = arg;
+	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	struct drm_i915_gem_object *obj, *obj2;
 	struct i915_gem_ww_ctx ww;
 	int err = 0;
@@ -254,9 +258,18 @@ int i915_gem_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_gem_hibernate),
 		SUBTEST(igt_gem_ww_ctx),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
+
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			return 0;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
 
-	return i915_live_subtests(tests, i915);
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
index fc068dab27f4..3231025a7b7f 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -957,7 +957,8 @@ int i915_vma_mock_selftests(void)
 
 static int igt_vma_remapped_gtt(void *arg)
 {
-	struct drm_i915_private *i915 = arg;
+	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
 	const struct intel_remapped_plane_info planes[] = {
 		{ .width = 1, .height = 1, .src_stride = 1 },
 		{ .width = 2, .height = 2, .src_stride = 2 },
@@ -990,7 +991,7 @@ static int igt_vma_remapped_gtt(void *arg)
 	intel_wakeref_t wakeref;
 	int err = 0;
 
-	if (!i915_ggtt_has_aperture(to_gt(i915)->ggtt))
+	if (!i915_ggtt_has_aperture(gt->ggtt))
 		return 0;
 
 	obj = i915_gem_object_create_internal(i915, 10 * 10 * PAGE_SIZE);
@@ -1107,6 +1108,15 @@ int i915_vma_live_selftests(struct drm_i915_private *i915)
 	static const struct i915_subtest tests[] = {
 		SUBTEST(igt_vma_remapped_gtt),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
+	int err;
+
+	for_each_gt(gt, i915, id) {
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
 
-	return i915_live_subtests(tests, i915);
+	return 0;
 }
-- 
2.55.0

