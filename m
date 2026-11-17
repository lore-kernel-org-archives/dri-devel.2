Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462D606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MOiQpRVN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A0410F925;
	Tue, 17 Nov 2026 20:03:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B53A10F930;
 Tue, 17 Nov 2026 20:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794945810; x=1826481810;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=39q7XbTMSpBI6vYPuVqUFugJqN1MWcJbIiBkY7/Xs9w=;
 b=MOiQpRVN26ypEWEpeL0FHHSI23/mx6KMf4nH8aaYdsxgegaQn0wzp64B
 Xgy50EFipwWQBCbDvlHcjMjQGU1nf0QFUHNLw234i7bXVNeuX9qdd6u7p
 aeKDI+nKJAWVMImbafOsXNhOY70xQ0IV87c61ltm7fLOshONiJdL+efrc
 uKowDpbeLRP36QC3nyXkjbDU/h8HSbqcldp5OtxUzugRnK54HVAonyHkX
 esswLotm2LIKPLEikKbepJnbzYl8a3dfn4xFPiornntdJqXv+BCb4OZ6u
 QvaMa5vO0PrQmMqz7hlJSdbJuDWxCv+DrQALVvXEQaqtHFP+4dZn+lJPN Q==;
X-CSE-ConnectionGUID: AXHN9VxpQGevPbEMs6AJYw==
X-CSE-MsgGUID: ogjtrinXQb6jCPM70XWhqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3724369"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3724369"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:29 -0800
X-CSE-ConnectionGUID: mZA0jlBrQMC+meMvWTub4g==
X-CSE-MsgGUID: vHzyd4+xQCCaT3hCgy6a+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10002070"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:28 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 6/6] drm/tests: Test limiting the run-ahead of fake commit
 only commits
Date: Tue, 17 Nov 2026 22:02:53 +0200
Message-ID: <20261117200253.27078-7-ville.syrjala@linux.intel.com>
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

Add a test that floods nonblocking commits touching only an unbound
plane with swap_state(stall=false), and checks that the number of
commits in flight stays bounded and that no hw_done wait times out.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 .../gpu/drm/tests/drm_atomic_commit_test.c    | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
index 593e1842fada..247b5a916b58 100644
--- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
@@ -10,6 +10,7 @@
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_probe_helper.h>
+#include <linux/delay.h>
 #include <linux/workqueue.h>
 
 #define DRM_TEST_ENC_0 BIT(0)
@@ -495,6 +496,88 @@ static void drm_test_fake_commit_not_busy(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+static atomic_t drm_test_flood_inflight, drm_test_flood_max, drm_test_flood_timeouts;
+
+static void drm_test_flood_commit_work(struct work_struct *work)
+{
+	struct drm_atomic_commit *state =
+		container_of(work, struct drm_atomic_commit, commit_work);
+	struct drm_plane *plane;
+	struct drm_plane_state *old_plane_state;
+	int i;
+
+	for_each_old_plane_in_state(state, plane, old_plane_state, i)
+		if (drm_crtc_commit_wait(old_plane_state->commit))
+			atomic_inc(&drm_test_flood_timeouts);
+
+	/* Pretend to do some work */
+	msleep(2);
+
+	drm_atomic_helper_commit_hw_done(state);
+	drm_atomic_helper_commit_cleanup_done(state);
+	atomic_dec(&drm_test_flood_inflight);
+	drm_atomic_commit_put(state);
+}
+
+/*
+ * Test that a flood of nonblocking commits that only touch an unbound plane
+ * can not queue up an unbounded number of commits, even if the driver does not
+ * ask swap_state() to stall. Otherwise the work items would all wait for the
+ * hw_done of their predecessor, and the waits would add up.
+ */
+static void drm_test_fake_commit_flood(struct kunit *test)
+{
+	struct drm_atomic_test_priv *priv;
+	int i;
+
+	priv = drm_atomic_test_init_drm_components(test, false);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	atomic_set(&drm_test_flood_inflight, 0);
+	atomic_set(&drm_test_flood_max, 0);
+	atomic_set(&drm_test_flood_timeouts, 0);
+
+	for (i = 0; i < 100; i++) {
+		struct drm_modeset_acquire_ctx ctx;
+		struct drm_atomic_commit *state;
+		int cur, ret;
+
+		drm_modeset_acquire_init(&ctx, 0);
+
+		state = drm_atomic_commit_alloc(&priv->drm);
+		KUNIT_ASSERT_NOT_NULL(test, state);
+		state->acquire_ctx = &ctx;
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test,
+					     drm_atomic_get_plane_state(state, priv->plane));
+
+		ret = drm_atomic_helper_setup_commit(state, true);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		ret = drm_atomic_helper_swap_state(state, false);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		cur = atomic_inc_return(&drm_test_flood_inflight);
+		if (cur > atomic_read(&drm_test_flood_max))
+			atomic_set(&drm_test_flood_max, cur);
+
+		INIT_WORK(&state->commit_work, drm_test_flood_commit_work);
+		queue_work(system_dfl_wq, &state->commit_work);
+
+		drm_modeset_drop_locks(&ctx);
+		drm_modeset_acquire_fini(&ctx);
+	}
+
+	while (atomic_read(&drm_test_flood_inflight))
+		msleep(10);
+
+	/*
+	 * The previous commit may still be doing its cleanup when the next
+	 * one is submitted, hence 2 rather than 1.
+	 */
+	KUNIT_EXPECT_LE(test, atomic_read(&drm_test_flood_max), 2);
+	KUNIT_EXPECT_EQ(test, atomic_read(&drm_test_flood_timeouts), 0);
+}
+
 /*
  * Test that the commits know their device, and that only the one for a CRTC
  * knows a CRTC, so that the waits can report timeouts for either.
@@ -533,6 +616,7 @@ static void drm_test_commit_dev(struct kunit *test)
 static struct kunit_case drm_fake_commit_tests[] = {
 	KUNIT_CASE(drm_test_fake_commit_flip_done),
 	KUNIT_CASE(drm_test_fake_commit_not_busy),
+	KUNIT_CASE(drm_test_fake_commit_flood),
 	KUNIT_CASE(drm_test_commit_dev),
 	{}
 };
-- 
2.56.0

