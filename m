Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2E606A333
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RYVCiPJI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C4310F919;
	Tue, 17 Nov 2026 20:03:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF17910F922;
 Tue, 17 Nov 2026 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794945795; x=1826481795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w4f9rRztSEUh6UoR9+HXvON4CHs/9DGTezgik+/LdSA=;
 b=RYVCiPJI4q3K+xbs5r/W0EoVTPRSpz2yzapHa4PSxm3ka1Vjskl/RD2x
 i8iM0/tVIXZ4++74SuAF0k2M9Iw0Lf3LLW+ScPNcusaivjephEto0B9nt
 aa8W1f5Gcgwabz+LAQZzxqoOBz3jlKS+BMqRkjku1j7lB21xjhvBNB4yh
 FwCtIDKgAK/gyCEoQmTXr5TuHkRfTQWLXad/v1+tLbFYRo+TcLGSB3fBT
 tXGQwf2JuzOII/evjrW/nymXYXs0MiJb1qbWraA7nKoM2HHQlqiW+2NmU
 outLjPdaxKpVegb7WGFRs49QgwqXmVC25emoAckTRMQ42bsHDe0nIFnMh g==;
X-CSE-ConnectionGUID: Jgce26VqQvmYsoBPyke64w==
X-CSE-MsgGUID: Ubw9FIIyRlCy4z4dwxQIQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3656017"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3656017"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:14 -0800
X-CSE-ConnectionGUID: w4xIvxpvSd67HmU6FUBIfw==
X-CSE-MsgGUID: HHO2W6sETviEi4yBBfXeKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10173556"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:13 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 3/6] drm/tests: Test fake_commit->flip_done completion
Date: Tue, 17 Nov 2026 22:02:50 +0200
Message-ID: <20261117200253.27078-4-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117200253.27078-1-ville.syrjala@linux.intel.com>
References: <20261117200253.27078-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Check that the fake commit has flip_done completed by
drm_atomic_helper_setup_commit(), with hw_done left pending, and that a
nonblocking commit touching an unbound plane is not rejected with
-EBUSY because of the previous commit's fake commit.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 .../gpu/drm/tests/drm_atomic_commit_test.c    | 116 +++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
index 6ccb001f6264..a549be9f21eb 100644
--- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
@@ -10,6 +10,7 @@
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_probe_helper.h>
+#include <linux/workqueue.h>
 
 #define DRM_TEST_ENC_0 BIT(0)
 #define DRM_TEST_ENC_1 BIT(1)
@@ -391,6 +392,118 @@ static struct kunit_case drm_in_clone_mode_check_test[] = {
 	{}
 };
 
+/*
+ * Test that the commit used for planes which are not bound to any CRTC has
+ * flip_done completed already by drm_atomic_helper_setup_commit(), since there
+ * is no flip to wait for, while hw_done is left for the commit to complete.
+ */
+static void drm_test_fake_commit_flip_done(struct kunit *test)
+{
+	struct drm_atomic_test_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *state;
+	struct drm_plane_state *plane_state;
+	int ret;
+
+	priv = drm_atomic_test_init_drm_components(test, false);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	plane_state = drm_atomic_get_plane_state(state, priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_state);
+	KUNIT_ASSERT_NULL(test, plane_state->crtc);
+	KUNIT_ASSERT_NULL(test, priv->plane->state->crtc);
+
+	ret = drm_atomic_helper_setup_commit(state, false);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_ASSERT_NOT_NULL(test, state->fake_commit);
+	KUNIT_EXPECT_PTR_EQ(test, plane_state->commit, state->fake_commit);
+	KUNIT_EXPECT_TRUE(test, try_wait_for_completion(&state->fake_commit->flip_done));
+	KUNIT_EXPECT_FALSE(test, try_wait_for_completion(&state->fake_commit->hw_done));
+
+	drm_atomic_commit_clear(state);
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+struct drm_test_hw_done_work {
+	struct delayed_work work;
+	struct drm_crtc_commit *commit;
+};
+
+static void drm_test_hw_done_work_func(struct work_struct *work)
+{
+	struct drm_test_hw_done_work *w =
+		container_of(work, struct drm_test_hw_done_work, work.work);
+
+	complete_all(&w->commit->hw_done);
+}
+
+/*
+ * Test that a nonblocking commit does not fail with -EBUSY just because the
+ * previous commit that touched the same unbound plane is still in flight, ie.
+ * its hw_done is yet to complete. It should instead wait for the hw_done, so
+ * that userspace can not get arbitrarily far ahead of the commit work.
+ */
+static void drm_test_fake_commit_not_busy(struct kunit *test)
+{
+	struct drm_atomic_test_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *state, *prev;
+	struct drm_test_hw_done_work w;
+	int ret;
+
+	priv = drm_atomic_test_init_drm_components(test, false);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	/* The previous commit, which became the plane's current state */
+	prev = drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, prev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm_atomic_get_plane_state(prev, priv->plane));
+	ret = drm_atomic_helper_setup_commit(prev, true);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_NULL(test, prev->fake_commit);
+	priv->plane->state->commit = drm_crtc_commit_get(prev->fake_commit);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm_atomic_get_plane_state(state, priv->plane));
+
+	w.commit = prev->fake_commit;
+	INIT_DELAYED_WORK_ONSTACK(&w.work, drm_test_hw_done_work_func);
+	schedule_delayed_work(&w.work, msecs_to_jiffies(20));
+
+	ret = drm_atomic_helper_setup_commit(state, true);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, try_wait_for_completion(&prev->fake_commit->hw_done));
+
+	flush_delayed_work(&w.work);
+	destroy_delayed_work_on_stack(&w.work);
+
+	drm_atomic_commit_clear(state);
+	drm_atomic_commit_clear(prev);
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+static struct kunit_case drm_fake_commit_tests[] = {
+	KUNIT_CASE(drm_test_fake_commit_flip_done),
+	KUNIT_CASE(drm_test_fake_commit_not_busy),
+	{}
+};
+
+static struct kunit_suite drm_fake_commit_test_suite = {
+	.name = "drm_atomic_fake_commit",
+	.test_cases = drm_fake_commit_tests,
+};
+
 static struct kunit_suite drm_test_check_modeset_test_suite = {
 	.name = "drm_validate_modeset",
 	.test_cases = drm_test_check_modeset_test,
@@ -402,7 +515,8 @@ static struct kunit_suite drm_in_clone_mode_check_test_suite = {
 };
 
 kunit_test_suites(&drm_in_clone_mode_check_test_suite,
-		  &drm_test_check_modeset_test_suite);
+		  &drm_test_check_modeset_test_suite,
+		  &drm_fake_commit_test_suite);
 
 MODULE_AUTHOR("Jessica Zhang <quic_jesszhan@quicinc.com");
 MODULE_DESCRIPTION("Test cases for the drm_atomic_helper functions");
-- 
2.56.0

