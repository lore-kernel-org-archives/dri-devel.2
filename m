Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032F606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXBJwqoB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B687710FD80;
	Fri,  6 Nov 2026 15:12:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1999C10FA9A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:12:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 807D66020F;
 Fri,  6 Nov 2026 15:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18941F008A1;
 Fri,  6 Nov 2026 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793977928;
 bh=bdQjWvaV3tK0YMLtqvKmF2zujMpuQLU9tux2ZMPjZ9M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BXBJwqoBbL1az5sN4B0mN0KILTXQzVzb21aSsdDFnpP5nhy3CDVacopNAS9qMtAWK
 Nhcx20A2rA+DSPhymRjlQ6lwzAcpti0zAfF+cHOLvkg4AvB27zgKRVMIw1KncOo6+c
 1bcmYqzYup8/vZZfN06gqQJWY8YCJgByTOmAdpG8MiXaXGrJI53yRoF2QPPNw2bKlf
 Xh/9aOhssRbXV/TZCQsTo3XnHPtWNMiYLgAJC2kryFEpSV5SXANsgPKFGjMofbsfdd
 9sLsKoZtf7YmeKzh0eZlijhHrmNdo6NWw3KwuMW4xSZ5y3yxUOhJseZBdbChbK+NFC
 uUXcghKOrOY5w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 16:11:43 +0100
Subject: [PATCH v8 5/7] drm/tests: atomic: Add tests for
 drm_atomic_commit_fill_with_defaults()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-reset-state-flag-v8-5-50fd046b705f@kernel.org>
References: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
In-Reply-To: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Daniel Stone <daniel@fooishbar.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11915; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kHbezj/o3ICp+MByq0mQaMM3hkY76FHH1DrGLBz5s8I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlv3xm6Tzsl/rasdfFWzrDoR31CWt6aplwGc8/XT4jOD
 e+a6SnXMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACby9Ttjwzymi98E5kk5ZDj/
 Nw5Y6HRikobM3MZD9coCS756fXrCyqI762/bz+ebfdYWvWvcKBC7krG+qm+C5TefP3GzBDOfxP5
 mMzuzZemn9aEZivVnX7SK/z3kVLdsJ9NNpt/eMzJ+3r37PeQuAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_atomic_commit_fill_with_defaults() is used by the
DRM_MODE_ATOMIC_RESET flag to bring all objects back to their pristine
state. However, it has no dedicated test coverage.

Add two tests that verify the reset cycle. The first enables a CRTC,
plane, and connector, then calls drm_atomic_commit_fill_with_defaults()
and verifies all objects return to their disabled state: CRTC inactive,
plane disabled with no framebuffer, and connector unbound. The second
goes further and commits the default-filled state to verify the
init -> enable -> reset -> commit sequence completes without errors.

Suggested-by: Daniel Stone <daniel@fooishbar.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_atomic_test.c | 322 +++++++++++++++++++++++++++++++-
 1 file changed, 320 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_test.c b/drivers/gpu/drm/tests/drm_atomic_test.c
index 5e156d09e56f..f30b4c6f4259 100644
--- a/drivers/gpu/drm/tests/drm_atomic_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_test.c
@@ -9,4 +9,5 @@
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_property.h>
 
 #include <kunit/test.h>
@@ -143,5 +144,4 @@ static struct kunit_case drm_atomic_get_connector_for_encoder_tests[] = {
 };
 
-
 static struct kunit_suite drm_atomic_get_connector_for_encoder_test_suite = {
 	.name = "drm_test_atomic_get_connector_for_encoder",
@@ -149,5 +149,323 @@ static struct kunit_suite drm_atomic_get_connector_for_encoder_test_suite = {
 };
 
-kunit_test_suite(drm_atomic_get_connector_for_encoder_test_suite);
+/*
+ * Test that after enabling a CRTC and connector, filling with defaults
+ * produces a state where all objects are disabled: CRTC is inactive,
+ * plane is disabled, and connector is unbound.
+ *
+ * This is done without any lease, so all objects are expected to be
+ * reset.
+ *
+ * The plane is not explicitly enabled with a framebuffer here, so
+ * this validates that fill_with_defaults produces a consistent
+ * disabled state rather than testing an active plane teardown.
+ */
+static void drm_test_check_fill_with_defaults(struct kunit *test)
+{
+	struct drm_atomic_test_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *new_conn_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_plane_state *new_plane_state;
+	struct drm_atomic_commit *state;
+	struct drm_display_mode *mode;
+	struct drm_device *drm;
+	int ret;
+
+	priv = create_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	drm = &priv->drm;
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     priv->crtc,
+						     &priv->connector,
+						     mode, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_fill:
+	ret = drm_atomic_commit_fill_with_defaults(NULL, state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_fill;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(state, priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_crtc_state);
+	KUNIT_EXPECT_FALSE(test, new_crtc_state->enable);
+	KUNIT_EXPECT_FALSE(test, new_crtc_state->active);
+
+	new_plane_state = drm_atomic_get_new_plane_state(state, priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_plane_state);
+	KUNIT_EXPECT_NULL(test, new_plane_state->crtc);
+	KUNIT_EXPECT_NULL(test, new_plane_state->fb);
+
+	new_conn_state = drm_atomic_get_new_connector_state(state, &priv->connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
+	KUNIT_EXPECT_NULL(test, new_conn_state->crtc);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that after enabling a CRTC and connector, fill_with_defaults
+ * produces a state that can be successfully committed.
+ *
+ * This is done without any lease, so all objects are reset.
+ *
+ * The plane is not explicitly enabled with a framebuffer, so this
+ * validates that fill_with_defaults produces a consistent disabled
+ * state rather than testing an active plane teardown.
+ */
+static void drm_test_check_fill_with_defaults_commit(struct kunit *test)
+{
+	struct drm_atomic_test_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *state;
+	struct drm_display_mode *mode;
+	struct drm_device *drm;
+	int ret;
+
+	priv = create_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	drm = &priv->drm;
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     priv->crtc,
+						     &priv->connector,
+						     mode, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_fill:
+	ret = drm_atomic_commit_fill_with_defaults(NULL, state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_fill;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state->allow_modeset = true;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_fill;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that filling with defaults reports the color management changes
+ * on the new states through color_mgmt_changed, so that drivers
+ * reprogram the color management hardware when a LUT is being cleared
+ * by the reset.
+ */
+static void drm_test_check_fill_with_defaults_color_mgmt(struct kunit *test)
+{
+	struct drm_atomic_test_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_plane_state *new_plane_state;
+	struct drm_atomic_commit *state;
+	struct drm_property_blob *gamma_lut;
+	struct drm_device *drm;
+	u32 lut = 0;
+	int ret;
+
+	priv = create_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	drm = &priv->drm;
+
+	gamma_lut = drm_property_create_blob(drm, sizeof(lut), &lut);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, gamma_lut);
+
+	/*
+	 * Attach a gamma LUT to the current CRTC state, like userspace
+	 * setting the GAMMA_LUT property would. The state takes ownership
+	 * of the blob reference.
+	 */
+	priv->crtc->state->gamma_lut = gamma_lut;
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_fill:
+	ret = drm_atomic_commit_fill_with_defaults(NULL, state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_fill;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(state, priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_crtc_state);
+	KUNIT_EXPECT_NULL(test, new_crtc_state->gamma_lut);
+	KUNIT_EXPECT_TRUE(test, new_crtc_state->color_mgmt_changed);
+
+	new_plane_state = drm_atomic_get_new_plane_state(state, priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_plane_state);
+	KUNIT_EXPECT_FALSE(test, new_plane_state->color_mgmt_changed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that a reset on which userspace re-applies the exact same
+ * configuration doesn't need a modeset, and thus doesn't require the
+ * DRM_MODE_ATOMIC_ALLOW_MODESET flag.
+ */
+static void drm_test_check_fill_with_defaults_no_modeset(struct kunit *test)
+{
+	struct drm_atomic_test_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_atomic_commit *state;
+	struct drm_display_mode *mode;
+	struct drm_device *drm;
+	int ret;
+
+	priv = create_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	drm = &priv->drm;
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     priv->crtc,
+						     &priv->connector,
+						     mode, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry:
+	ret = drm_atomic_commit_fill_with_defaults(NULL, state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* Re-apply the exact same configuration on top of the reset */
+	new_conn_state = drm_atomic_get_new_connector_state(state, &priv->connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
+
+	ret = drm_atomic_set_crtc_for_connector(new_conn_state, priv->crtc);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(state, priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_crtc_state);
+
+	ret = drm_atomic_set_mode_for_crtc(new_crtc_state, mode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	new_crtc_state->enable = true;
+	new_crtc_state->active = true;
+
+	/* Modesets aren't allowed and shouldn't be needed */
+	state->allow_modeset = false;
+
+	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, new_crtc_state->active_changed);
+	KUNIT_EXPECT_FALSE(test, new_crtc_state->connectors_changed);
+	KUNIT_EXPECT_FALSE(test, new_crtc_state->mode_changed);
+	KUNIT_EXPECT_FALSE(test, drm_atomic_crtc_needs_modeset(new_crtc_state));
+
+	/*
+	 * mode_fixup() only derives adjusted_mode when the mode or the
+	 * connectors changed, so a CRTC that stays enabled across the
+	 * commit must have kept the timings it was already running
+	 * instead of the zeroed mode a pristine state comes with.
+	 */
+	KUNIT_EXPECT_TRUE(test, drm_mode_equal(&new_crtc_state->adjusted_mode,
+					       &new_crtc_state->mode));
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+static struct kunit_case drm_atomic_fill_with_defaults_tests[] = {
+	KUNIT_CASE(drm_test_check_fill_with_defaults),
+	KUNIT_CASE(drm_test_check_fill_with_defaults_commit),
+	KUNIT_CASE(drm_test_check_fill_with_defaults_color_mgmt),
+	KUNIT_CASE(drm_test_check_fill_with_defaults_no_modeset),
+	{ }
+};
+
+static struct kunit_suite drm_atomic_fill_with_defaults_test_suite = {
+	.name = "drm_atomic_commit_fill_with_defaults",
+	.test_cases = drm_atomic_fill_with_defaults_tests,
+};
+
+kunit_test_suites(&drm_atomic_get_connector_for_encoder_test_suite,
+		  &drm_atomic_fill_with_defaults_test_suite);
 
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");

-- 
2.55.0

