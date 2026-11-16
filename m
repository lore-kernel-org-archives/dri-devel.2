Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA83606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D/zyN+Hk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A72E510F126;
	Mon, 16 Nov 2026 12:57:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCA910F106;
 Mon, 16 Nov 2026 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794833836; x=1826369836;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kx80+iVT0K/rR5znwIn6S+ycgVAvrV4U7MbNwpiJeJs=;
 b=D/zyN+HkePsYOMBA5aICEBAVd1ETtbfnTwf+kvwWdNjxAJjyh7eYK+Kf
 /e22cupRgB5L7pS6k9PlWk/+COZchv/jlq5RXnIbnSkDCo2ujOqL18kaU
 T7LkyJI2yTHRrzs21Z/fqVbTDSTHoCnzjWcNTOhKI+7YM/esjJJZ35SLH
 oQDAfgWjLk08VpRSEH9ea5CIpcMN9U1eip9GuwZ02fGQC236Ty2Q2WTjV
 FU6oUxNSl4HI2QaZC/rsnuwmQIipLpjLNHlAfrXt15VYXflV8YINJvf7k
 Es6QxWDADgEwE6Za62vw5PBxgxvo6grZrKBB8st2ymtg4fzYNyIsjzq1F Q==;
X-CSE-ConnectionGUID: D6lQT6qfSlCOntrvZAKh5Q==
X-CSE-MsgGUID: u5Npc8HHTBS3jgYFWbmQyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3557851"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3557851"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 04:57:16 -0800
X-CSE-ConnectionGUID: U67JIv9WRKmiVuPdA/N14w==
X-CSE-MsgGUID: 9sCZ22HbTmOmt1KoJTflCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9439994"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 04:57:14 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 4/4] drm/tests: Test event ownership in atomic states
Date: Mon, 16 Nov 2026 14:56:49 +0200
Message-ID: <20261116125649.15742-5-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116125649.15742-1-ville.syrjala@linux.intel.com>
References: <20261116125649.15742-1-ville.syrjala@linux.intel.com>
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

Add KUnit tests for what happens to the event of a CRTC state that went
through drm_atomic_helper_setup_commit(): an internally allocated event
and an event provided by the caller must both be thrown away, releasing
their reference on the commit, if the state is destroyed without the
event having been consumed, while a consumed and sent event completes
flip_done and is left alone.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 .../gpu/drm/tests/drm_atomic_commit_test.c    | 201 +++++++++++++++++-
 1 file changed, 200 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
index 6ccb001f6264..80b3f6fd872a 100644
--- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
@@ -5,9 +5,13 @@
  * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/dma-fence.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_file.h>
+#include <drm/drm_vblank.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_probe_helper.h>
 
@@ -378,6 +382,187 @@ KUNIT_ARRAY_PARAM(drm_check_in_clone_mode, drm_clone_mode_tests,
 KUNIT_ARRAY_PARAM(drm_check_valid_clones, drm_valid_clone_mode_tests,
 		  drm_check_valid_clones_desc);
 
+struct drm_event_test_ctx {
+	struct drm_atomic_test_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc_commit *commit;
+};
+
+/*
+ * Set up a state with an enabled CRTC and run drm_atomic_helper_setup_commit()
+ * on it. Takes an extra reference on the CRTC commit, which the caller has to
+ * drop, so that the references held by the state and its event can be counted.
+ */
+static void drm_event_test_setup_commit(struct kunit *test,
+					struct drm_event_test_ctx *c,
+					struct drm_pending_vblank_event *event,
+					bool active)
+{
+	int ret;
+
+	c->priv = drm_atomic_test_init_drm_components(test, false);
+	KUNIT_ASSERT_NOT_NULL(test, c->priv);
+
+	drm_modeset_acquire_init(&c->ctx, 0);
+
+	c->state = drm_kunit_helper_atomic_state_alloc(test, &c->priv->drm,
+						       &c->ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, c->state);
+
+	c->crtc_state = drm_atomic_get_crtc_state(c->state, c->priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, c->crtc_state);
+
+	c->crtc_state->enable = active;
+	c->crtc_state->active = active;
+	c->crtc_state->event = event;
+
+	ret = drm_atomic_helper_setup_commit(c->state, false);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	c->commit = c->crtc_state->commit;
+	KUNIT_ASSERT_NOT_NULL(test, c->commit);
+	if (active) {
+		KUNIT_ASSERT_NOT_NULL(test, c->crtc_state->event);
+		KUNIT_EXPECT_PTR_EQ(test, c->crtc_state->event->base.completion,
+				    &c->commit->flip_done);
+	}
+
+	drm_crtc_commit_get(c->commit);
+}
+
+static void drm_event_test_finish(struct drm_event_test_ctx *c)
+{
+	drm_crtc_commit_put(c->commit);
+	drm_modeset_drop_locks(&c->ctx);
+	drm_modeset_acquire_fini(&c->ctx);
+}
+
+/*
+ * Test that destroying a state whose commit was never queued throws away the
+ * event allocated by drm_atomic_helper_setup_commit(), and gives up the
+ * reference the event held on the commit.
+ */
+static void drm_test_event_abort_internal(struct kunit *test)
+{
+	struct drm_event_test_ctx c;
+
+	drm_event_test_setup_commit(test, &c, NULL, true);
+
+	/* state, crtcs[].commit and the event, plus the one taken above */
+	KUNIT_EXPECT_EQ(test, kref_read(&c.commit->ref), 4);
+
+	drm_atomic_commit_clear(c.state);
+
+	KUNIT_EXPECT_EQ(test, kref_read(&c.commit->ref), 1);
+	KUNIT_EXPECT_FALSE(test, try_wait_for_completion(&c.commit->flip_done));
+
+	drm_event_test_finish(&c);
+}
+
+/*
+ * Same as above, but with an event provided by the caller, like the atomic
+ * uapi does.
+ */
+static void drm_test_event_abort_user(struct kunit *test)
+{
+	struct drm_pending_vblank_event *event;
+	struct drm_event_test_ctx c;
+
+	event = kzalloc_obj(*event);
+	KUNIT_ASSERT_NOT_NULL(test, event);
+
+	drm_event_test_setup_commit(test, &c, event, true);
+	KUNIT_EXPECT_PTR_EQ(test, c.crtc_state->event, event);
+	KUNIT_EXPECT_EQ(test, kref_read(&c.commit->ref), 4);
+
+	/* the event is freed here */
+	drm_atomic_commit_clear(c.state);
+
+	KUNIT_EXPECT_EQ(test, kref_read(&c.commit->ref), 1);
+
+	drm_event_test_finish(&c);
+}
+
+static const char *drm_event_test_fence_name(struct dma_fence *fence)
+{
+	return "drm-event-test";
+}
+
+static const struct dma_fence_ops drm_event_test_fence_ops = {
+	.get_driver_name = drm_event_test_fence_name,
+	.get_timeline_name = drm_event_test_fence_name,
+};
+
+/*
+ * Test that an event from the atomic uapi (here with an out-fence) is thrown
+ * away with the state when the CRTC stays off. drm_atomic_helper_setup_commit()
+ * skips such CRTCs, so no driver is required to consume the event and nothing
+ * but the state destructor is left to free it. The fence reference tells
+ * whether the event got freed.
+ */
+static void drm_test_event_stays_off(struct kunit *test)
+{
+	struct drm_pending_vblank_event *event;
+	struct drm_event_test_ctx c;
+	struct dma_fence fence;
+	spinlock_t lock;
+
+	event = kzalloc_obj(*event);
+	KUNIT_ASSERT_NOT_NULL(test, event);
+
+	spin_lock_init(&lock);
+	dma_fence_init(&fence, &drm_event_test_fence_ops, &lock, 0, 0);
+	/* the event's reference; the one from dma_fence_init() stays ours */
+	event->base.fence = dma_fence_get(&fence);
+
+	drm_event_test_setup_commit(test, &c, event, false);
+
+	KUNIT_EXPECT_PTR_EQ(test, c.crtc_state->event, event);
+	KUNIT_EXPECT_NULL(test, event->base.completion);
+	KUNIT_EXPECT_TRUE(test, try_wait_for_completion(&c.commit->flip_done));
+	KUNIT_EXPECT_EQ(test, kref_read(&fence.refcount), 2);
+
+	/* the event is freed here */
+	drm_atomic_commit_clear(c.state);
+
+	KUNIT_EXPECT_EQ(test, kref_read(&fence.refcount), 1);
+	KUNIT_EXPECT_EQ(test, kref_read(&c.commit->ref), 1);
+
+	/* the last reference is not dropped, @fence is on the stack */
+	drm_event_test_finish(&c);
+}
+
+/*
+ * Test that an event which the driver consumed is not touched when the state
+ * is destroyed, and that sending it completes flip_done.
+ */
+static void drm_test_event_consumed(struct kunit *test)
+{
+	struct drm_pending_vblank_event *event;
+	struct drm_event_test_ctx c;
+
+	drm_event_test_setup_commit(test, &c, NULL, true);
+
+	event = c.crtc_state->event;
+	c.crtc_state->event = NULL;
+
+	spin_lock_irq(&c.priv->drm.event_lock);
+	drm_send_event_locked(&c.priv->drm, &event->base);
+	spin_unlock_irq(&c.priv->drm.event_lock);
+
+	KUNIT_EXPECT_TRUE(test, try_wait_for_completion(&c.commit->flip_done));
+	/* the event gave up its reference when it was sent */
+	KUNIT_EXPECT_EQ(test, kref_read(&c.commit->ref), 3);
+
+	drm_atomic_commit_clear(c.state);
+
+	KUNIT_EXPECT_EQ(test, kref_read(&c.commit->ref), 1);
+
+	drm_event_test_finish(&c);
+}
+
 static struct kunit_case drm_test_check_modeset_test[] = {
 	KUNIT_CASE(drm_test_check_connector_changed_modeset),
 	{}
@@ -391,6 +576,19 @@ static struct kunit_case drm_in_clone_mode_check_test[] = {
 	{}
 };
 
+static struct kunit_case drm_event_ownership_tests[] = {
+	KUNIT_CASE(drm_test_event_abort_internal),
+	KUNIT_CASE(drm_test_event_abort_user),
+	KUNIT_CASE(drm_test_event_stays_off),
+	KUNIT_CASE(drm_test_event_consumed),
+	{}
+};
+
+static struct kunit_suite drm_event_ownership_test_suite = {
+	.name = "drm_atomic_event_ownership",
+	.test_cases = drm_event_ownership_tests,
+};
+
 static struct kunit_suite drm_test_check_modeset_test_suite = {
 	.name = "drm_validate_modeset",
 	.test_cases = drm_test_check_modeset_test,
@@ -402,7 +600,8 @@ static struct kunit_suite drm_in_clone_mode_check_test_suite = {
 };
 
 kunit_test_suites(&drm_in_clone_mode_check_test_suite,
-		  &drm_test_check_modeset_test_suite);
+		  &drm_test_check_modeset_test_suite,
+		  &drm_event_ownership_test_suite);
 
 MODULE_AUTHOR("Jessica Zhang <quic_jesszhan@quicinc.com");
 MODULE_DESCRIPTION("Test cases for the drm_atomic_helper functions");
-- 
2.56.0

