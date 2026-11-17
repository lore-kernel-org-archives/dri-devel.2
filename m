Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81635606A339
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J3LsOa3z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F203710F928;
	Tue, 17 Nov 2026 20:03:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF9D10F922;
 Tue, 17 Nov 2026 20:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794945805; x=1826481805;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=166q+zvK4Gr1JxNb9XgAK4kJnx8iYlPyM7xgbRhNWS4=;
 b=J3LsOa3zz5eaBDbUU51gAEDDKvT+HLEswDISApnaDTZW4HdTH1Cx95jk
 kN6nFq4zGjivB/1ydn0Znn0rA5icUPxNEgFFm+WRdLZJJthLj/znMnO+h
 xA8MjVe1BKrJsB04hbdm4OCb6m8BYKNFWQHx+Wn1FM3maU6bDmQDeUvTr
 MyGg6mkfpjwTms7XqN+L6NSxMEMPMvMrVROGa0kQ3JMTPQPK/iuNTqKXl
 gu711ZOewnz9VvzWcMocZRgri3hjDYtiZl5xxSxo/Ez6FQ19p+4aEg3lH
 Pr74rqxyGlFNnJlxTOPHQ1pu8qSDvvjDI4D5bYRIBya/xATJc4n5jiB0r g==;
X-CSE-ConnectionGUID: udI0nqLpRaaFdTKxeJxAIQ==
X-CSE-MsgGUID: QLP7ldCIRf6MrIDYT9vHCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3724365"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3724365"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:24 -0800
X-CSE-ConnectionGUID: LnLx7qzuQj2qBilqHQ6DxQ==
X-CSE-MsgGUID: Cemhxa3iQtm62UpwxGJp8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10002034"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:03:23 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 5/6] drm/tests: Test the device stored in drm_crtc_commit
Date: Tue, 17 Nov 2026 22:02:52 +0200
Message-ID: <20261117200253.27078-6-ville.syrjala@linux.intel.com>
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

Check that the commits know their device, and that only the one for a
CRTC knows a CRTC, so that the waits can report timeouts for either
the fake commit or a CRTC commit.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 .../gpu/drm/tests/drm_atomic_commit_test.c    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
index a549be9f21eb..593e1842fada 100644
--- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
@@ -423,6 +423,8 @@ static void drm_test_fake_commit_flip_done(struct kunit *test)
 
 	KUNIT_ASSERT_NOT_NULL(test, state->fake_commit);
 	KUNIT_EXPECT_PTR_EQ(test, plane_state->commit, state->fake_commit);
+	KUNIT_EXPECT_PTR_EQ(test, state->fake_commit->dev, &priv->drm);
+	KUNIT_EXPECT_NULL(test, state->fake_commit->crtc);
 	KUNIT_EXPECT_TRUE(test, try_wait_for_completion(&state->fake_commit->flip_done));
 	KUNIT_EXPECT_FALSE(test, try_wait_for_completion(&state->fake_commit->hw_done));
 
@@ -493,9 +495,45 @@ static void drm_test_fake_commit_not_busy(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+/*
+ * Test that the commits know their device, and that only the one for a CRTC
+ * knows a CRTC, so that the waits can report timeouts for either.
+ */
+static void drm_test_commit_dev(struct kunit *test)
+{
+	struct drm_atomic_test_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *state;
+	struct drm_crtc_state *crtc_state;
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
+	crtc_state = drm_atomic_get_crtc_state(state, priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	ret = drm_atomic_helper_setup_commit(state, false);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state->commit);
+	KUNIT_EXPECT_PTR_EQ(test, crtc_state->commit->dev, &priv->drm);
+	KUNIT_EXPECT_PTR_EQ(test, crtc_state->commit->crtc, priv->crtc);
+
+	drm_atomic_commit_clear(state);
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 static struct kunit_case drm_fake_commit_tests[] = {
 	KUNIT_CASE(drm_test_fake_commit_flip_done),
 	KUNIT_CASE(drm_test_fake_commit_not_busy),
+	KUNIT_CASE(drm_test_commit_dev),
 	{}
 };
 
-- 
2.56.0

