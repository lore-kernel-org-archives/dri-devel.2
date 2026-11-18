Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEC0606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I/XTxJqA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0777110EC76;
	Wed, 18 Nov 2026 18:33:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF1810EC72;
 Wed, 18 Nov 2026 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795026811; x=1826562811;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KuWcVTgoALigCcL2c9q2ALKD4jtV6NXHdhvwOD8QAVw=;
 b=I/XTxJqAZsaI3cD0pn8NTpJAhf1l1Y60hvi8DCKKdwU7dNKBLRlJ7DcA
 8Gv8gq4HzaRHAVrdSGuB/l/LnvXoBw7w8GbldpX2/zu87DBFAUAguwEr+
 mfyGI6u7aiN8XyhQMLZKxIUX9Udu9qr9rcLKP7DskruXwFwYoj7LE8uQ4
 YaBpjtsDi3o/m9GPcmjVqW/6jTCNFer777bbsmT11+kZ5dLtTHlxUQufA
 5m/m+4cMcoEsiHrsYRwrMwrNalIIzaLmb9oQea7AwFBhI6UsoSVCI7oIW
 +f/Mn5fWx9U5pXLrchvlVt5ONfk0jandGvfYkhQbEVMSCPTKqN0D1y5JO A==;
X-CSE-ConnectionGUID: Uru+ziOYR7maMzPGQsrUpQ==
X-CSE-MsgGUID: GOPCm2+yQkOzhFKheT0t2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3745581"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3745581"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:33:30 -0800
X-CSE-ConnectionGUID: WgbRup8YTGiaC3uaVxaNKg==
X-CSE-MsgGUID: TWP4fmOQR0CX0Md3yQJpYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10486963"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:33:28 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v2 6/6] drm/tests: Test limiting the run-ahead of fake commit
 only commits
Date: Wed, 18 Nov 2026 20:33:25 +0200
Message-ID: <20261118183325.3328-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117200253.27078-7-ville.syrjala@linux.intel.com>
References: <20261117200253.27078-7-ville.syrjala@linux.intel.com>
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
plane with swap_state(stall=false), and checks that a new commit never
gets past drm_atomic_helper_setup_commit() before the previous one has
reached hw_done. Check that directly rather than by counting the
commits in flight, which would depend on how quickly the commit work
items get to run.

The commit work items are always drained before the test returns, also
when it bails out early, so that none of them can touch the device
after it has been torn down.

v2: Make sure everything is torn down before we bail (sashiko)
    Don't count the in flight commits as that is non-deterministic (sashiko)

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 .../gpu/drm/tests/drm_atomic_commit_test.c    | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
index 593e1842fada..7c51ea84718f 100644
--- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
@@ -10,6 +10,7 @@
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_probe_helper.h>
+#include <linux/delay.h>
 #include <linux/workqueue.h>
 
 #define DRM_TEST_ENC_0 BIT(0)
@@ -36,6 +37,11 @@ struct drm_atomic_test_priv {
 	struct drm_crtc *crtc;
 	struct drm_encoder encoders[3];
 	struct drm_connector connectors[2];
+
+	/* for drm_test_fake_commit_flood() */
+	atomic_t flood_inflight;
+	struct completion flood_drained;
+	bool flood_released;
 };
 
 static int modeset_counter;
@@ -495,6 +501,134 @@ static void drm_test_fake_commit_not_busy(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+static void drm_test_flood_commit_work(struct work_struct *work)
+{
+	struct drm_atomic_commit *state =
+		container_of(work, struct drm_atomic_commit, commit_work);
+	struct drm_atomic_test_priv *priv =
+		container_of(state->dev, struct drm_atomic_test_priv, drm);
+
+	drm_atomic_helper_wait_for_dependencies(state);
+
+	/* Pretend to do some work */
+	msleep(2);
+
+	drm_atomic_helper_commit_hw_done(state);
+	drm_atomic_helper_commit_cleanup_done(state);
+
+	/* The commit must be gone before the test can tear down the device */
+	drm_atomic_commit_put(state);
+
+	if (atomic_dec_and_test(&priv->flood_inflight))
+		complete_all(&priv->flood_drained);
+}
+
+/*
+ * Wait for all the commit work items to finish. The submitter holds one
+ * reference to flood_inflight until it is done submitting, so that the
+ * completion can not fire early. Also used as a cleanup action, to make sure
+ * no work item outlives the test if it bails out.
+ */
+static void drm_test_flood_drain(void *data)
+{
+	struct drm_atomic_test_priv *priv = data;
+
+	if (!xchg(&priv->flood_released, true) &&
+	    atomic_dec_and_test(&priv->flood_inflight))
+		complete_all(&priv->flood_drained);
+
+	wait_for_completion(&priv->flood_drained);
+}
+
+static int drm_test_flood_submit(struct kunit *test,
+				 struct drm_atomic_test_priv *priv)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *state;
+	struct drm_plane_state *plane_state;
+	struct drm_crtc_commit *prev;
+	int ret;
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	state = drm_atomic_commit_alloc(&priv->drm);
+	if (!state) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	state->acquire_ctx = &ctx;
+
+	plane_state = drm_atomic_get_plane_state(state, priv->plane);
+	if (IS_ERR(plane_state)) {
+		ret = PTR_ERR(plane_state);
+		goto err_put;
+	}
+
+	/* Stable, the plane is locked */
+	prev = priv->plane->state->commit;
+
+	ret = drm_atomic_helper_setup_commit(state, true);
+	if (ret)
+		goto err_put;
+
+	/*
+	 * Userspace must not get ahead of the previous commit's hw_done,
+	 * whatever the commit work is up to.
+	 */
+	if (prev)
+		KUNIT_EXPECT_TRUE(test, try_wait_for_completion(&prev->hw_done));
+
+	ret = drm_atomic_helper_swap_state(state, false);
+	if (ret)
+		goto err_put;
+
+	/* The ctx goes away, but the state lives on in the work item */
+	state->acquire_ctx = NULL;
+
+	atomic_inc(&priv->flood_inflight);
+	INIT_WORK(&state->commit_work, drm_test_flood_commit_work);
+	queue_work(system_dfl_wq, &state->commit_work);
+
+	ret = 0;
+	goto out;
+
+err_put:
+	drm_atomic_commit_put(state);
+out:
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	return ret;
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
+	int i, ret;
+
+	priv = drm_atomic_test_init_drm_components(test, false);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	atomic_set(&priv->flood_inflight, 1);
+	init_completion(&priv->flood_drained);
+
+	ret = kunit_add_action_or_reset(test, drm_test_flood_drain, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	for (i = 0; i < 100; i++) {
+		ret = drm_test_flood_submit(test, priv);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+	}
+
+	drm_test_flood_drain(priv);
+}
+
 /*
  * Test that the commits know their device, and that only the one for a CRTC
  * knows a CRTC, so that the waits can report timeouts for either.
@@ -533,6 +667,7 @@ static void drm_test_commit_dev(struct kunit *test)
 static struct kunit_case drm_fake_commit_tests[] = {
 	KUNIT_CASE(drm_test_fake_commit_flip_done),
 	KUNIT_CASE(drm_test_fake_commit_not_busy),
+	KUNIT_CASE(drm_test_fake_commit_flood),
 	KUNIT_CASE(drm_test_commit_dev),
 	{}
 };
-- 
2.56.0

