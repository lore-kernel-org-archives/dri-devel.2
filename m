Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2438606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=PaGH1kiP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C6B10E565;
	Sat, 24 Oct 2026 22:59:08 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CA410E44E
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 16:54:02 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jBmF36P73z8swm;
 Sat, 24 Oct 2026 18:53:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792860839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osqF12FQP0/kntpgKX9h0/xfSvnP7niCFFFU4/uizMw=;
 b=PaGH1kiPCMVHZ9FOEhthFStWgxp8xZTSdrFVcSO5AuDdD/TEqD5HDAf8F++y8u7NEOcLcy
 j4Cnhd9+grQf7w/NNY4L/N+hQ8eIpBViRj46Qj5MDJw0FDm0EVZo1c5cMTiTDGFZARqc/O
 c8zX2ZXG3pP80hzyq3kDvadcPOko1eyDnPfutcF00BJXZDKiA3vTsQbMTcrYjUqH56BtUW
 /oEtWzPeiBfv+G5BFK5w+yKw7pJhBbSZ+C/9nc+qMx9IoPPlYNyO1Z2IiT8L565vU0UeIu
 GdfCLf2y22MpLZ61ndrCWcORJieq/XY5N/agsUKCO8CzbDJsSOy0aQFE24rM1A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, ville.syrjala@linux.intel.com, jfalempe@redhat.com,
 javierm@redhat.com
Subject: [PATCH v2 2/2] drm/tests: Add KUnit tests for the client mode size
 limits
Date: Sat, 24 Oct 2026 17:53:55 +0100
Message-ID: <20261024165355.2782145-3-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024165355.2782145-1-hugo@hsal.es>
References: <20261024165355.2782145-1-hugo@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jBmF36P73z8swm
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test that the first-mode, cmdline, tiled and clone pickers skip modes
larger than the client's size, and that drm_client_modeset_probe() keeps
the preferred mode in connector->modes when the client is smaller than
it

Also test that drm_client_firmware_config() rejects the firmware config
for a tiled connector with missing tiles when no non-tiled mode fits,
and uses the non-tiled mode when one does

Test that it takes the CRTC's current mode when no probed mode fits,
and rejects the config if the current mode doesn't fit either. When
the firmware lit a connector with no mode that fits, the probe must
light another connector on the same CRTC instead

The probe tests call drm_client_modeset_create() directly, because
drm_client_init() needs a dumb_create callback the test driver doesn't
have. The firmware config tests set the connector's CRTC and encoder in
their state by hand, as if the firmware had lit it

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../gpu/drm/tests/drm_client_modeset_test.c   | 494 +++++++++++++++++-
 1 file changed, 493 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
index 00f43fca97954..da8abedbf9d3b 100644
--- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
+++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
@@ -18,6 +18,9 @@ struct drm_client_modeset_test_priv {
 	struct drm_device *drm;
 	struct device *dev;
 	struct drm_connector connector;
+	struct drm_connector second_connector;
+	struct drm_encoder encoder;
+	const struct drm_display_mode *modes[2];
 };
 
 static int drm_client_modeset_connector_get_modes(struct drm_connector *connector)
@@ -48,9 +51,41 @@ static const struct drm_connector_helper_funcs drm_client_modeset_connector_help
 	.get_modes = drm_client_modeset_connector_get_modes,
 };
 
+static int drm_client_modeset_connector_get_modes_preferred(struct drm_connector *connector)
+{
+	int count = drm_add_modes_noedid(connector, 1920, 1080);
+
+	drm_set_preferred_mode(connector, 1920, 1080);
+
+	return count;
+}
+
+static const struct drm_connector_helper_funcs drm_client_modeset_preferred_helper_funcs = {
+	.get_modes = drm_client_modeset_connector_get_modes_preferred,
+};
+
+static int drm_client_modeset_connector_get_modes_small(struct drm_connector *connector)
+{
+	struct drm_display_mode *mode = drm_cvt_mode(connector->dev, 320, 240, 60,
+						     false, false, false);
+
+	if (!mode)
+		return 0;
+
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_connector_helper_funcs drm_client_modeset_small_helper_funcs = {
+	.get_modes = drm_client_modeset_connector_get_modes_small,
+};
+
 static const struct drm_connector_funcs drm_client_modeset_connector_funcs = {
 	.atomic_destroy_state   = drm_atomic_helper_connector_destroy_state,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.fill_modes             = drm_helper_probe_single_connector_modes,
+	.reset                  = drm_atomic_helper_connector_reset,
 };
 
 static int drm_client_modeset_test_init(struct kunit *test)
@@ -197,6 +232,463 @@ static struct kunit_suite drm_test_pick_cmdline_test_suite = {
 
 kunit_test_suite(drm_test_pick_cmdline_test_suite);
 
+static void drm_test_pick_first_mode_within_limits(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connector = &priv->connector;
+	const struct drm_display_mode *full, *smaller, *none, *preferred;
+	int ret;
+
+	drm_connector_helper_add(connector, &drm_client_modeset_preferred_helper_funcs);
+
+	mutex_lock(&drm->mode_config.mutex);
+	ret = drm_helper_probe_single_connector_modes(connector, 1920, 1080);
+	full = drm_connector_first_mode(connector, 1920, 1080);
+	smaller = drm_connector_first_mode(connector, 1024, 768);
+	none = drm_connector_first_mode(connector, 320, 240);
+	preferred = drm_connector_preferred_mode(connector, 1024, 768);
+	mutex_unlock(&drm->mode_config.mutex);
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	KUNIT_ASSERT_NOT_NULL(test, full);
+	KUNIT_EXPECT_EQ(test, full->hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, full->vdisplay, 1080);
+
+	KUNIT_ASSERT_NULL(test, preferred);
+
+	KUNIT_ASSERT_NOT_NULL(test, smaller);
+	KUNIT_EXPECT_EQ(test, smaller->hdisplay, 1024);
+	KUNIT_EXPECT_EQ(test, smaller->vdisplay, 768);
+
+	KUNIT_EXPECT_NULL(test, none);
+}
+
+static void drm_test_pick_cmdline_mode_within_limits(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connector = &priv->connector;
+	struct drm_cmdline_mode *cmdline_mode = &connector->cmdline_mode;
+	const struct drm_display_mode *full, *smaller;
+	int ret;
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector("1920x1080", connector,
+									  cmdline_mode));
+
+	mutex_lock(&drm->mode_config.mutex);
+	ret = drm_helper_probe_single_connector_modes(connector, 1920, 1080);
+	full = drm_connector_pick_cmdline_mode(connector, 1920, 1080);
+	smaller = drm_connector_pick_cmdline_mode(connector, 1024, 768);
+	mutex_unlock(&drm->mode_config.mutex);
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	KUNIT_ASSERT_NOT_NULL(test, full);
+	KUNIT_EXPECT_EQ(test, full->hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, full->vdisplay, 1080);
+
+	KUNIT_EXPECT_NULL(test, smaller);
+}
+
+static void drm_test_pick_tiled_mode_within_limits(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connector = &priv->connector;
+	const struct drm_display_mode *tiled, *smaller_tiled, *non_tiled;
+	int ret;
+
+	drm_connector_helper_add(connector, &drm_client_modeset_preferred_helper_funcs);
+	connector->tile_h_size = 1920;
+	connector->tile_v_size = 1080;
+
+	mutex_lock(&drm->mode_config.mutex);
+	ret = drm_helper_probe_single_connector_modes(connector, 1920, 1080);
+	tiled = drm_connector_get_tiled_mode(connector, 1920, 1080);
+	smaller_tiled = drm_connector_get_tiled_mode(connector, 1024, 768);
+	non_tiled = drm_connector_fallback_non_tiled_mode(connector, 1024, 768);
+	mutex_unlock(&drm->mode_config.mutex);
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	KUNIT_ASSERT_NOT_NULL(test, tiled);
+	KUNIT_EXPECT_EQ(test, tiled->hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, tiled->vdisplay, 1080);
+
+	KUNIT_EXPECT_NULL(test, smaller_tiled);
+
+	KUNIT_ASSERT_NOT_NULL(test, non_tiled);
+	KUNIT_EXPECT_EQ(test, non_tiled->hdisplay, 1024);
+	KUNIT_EXPECT_EQ(test, non_tiled->vdisplay, 768);
+}
+
+static void drm_client_modeset_test_destroy_modes(void *ptr)
+{
+	struct drm_client_modeset_test_priv *priv = ptr;
+
+	modes_destroy(priv->drm, priv->modes, ARRAY_SIZE(priv->modes));
+}
+
+static void drm_test_pick_clone_mode_within_limits(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connectors[] = { &priv->connector, &priv->second_connector };
+	const struct drm_display_mode **modes = priv->modes;
+	struct drm_client_offset offsets[ARRAY_SIZE(connectors)] = {};
+	bool enabled[ARRAY_SIZE(connectors)] = { true, true };
+	bool cloned_fits, cloned_too_small;
+	unsigned int i;
+	int ret;
+
+	ret = drmm_connector_init(drm, &priv->second_connector,
+				  &drm_client_modeset_connector_funcs,
+				  DRM_MODE_CONNECTOR_Unknown,
+				  NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_connector_helper_add(&priv->second_connector,
+				 &drm_client_modeset_connector_helper_funcs);
+
+	ret = kunit_add_action_or_reset(test, drm_client_modeset_test_destroy_modes, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	mutex_lock(&drm->mode_config.mutex);
+	for (i = 0; i < ARRAY_SIZE(connectors); i++) {
+		ret = drm_helper_probe_single_connector_modes(connectors[i], 1920, 1080);
+		KUNIT_EXPECT_GT(test, ret, 0);
+	}
+
+	cloned_too_small = drm_client_target_cloned(drm, connectors, ARRAY_SIZE(connectors),
+						    modes, offsets, enabled, 800, 600);
+	modes_destroy(drm, modes, ARRAY_SIZE(connectors));
+
+	cloned_fits = drm_client_target_cloned(drm, connectors, ARRAY_SIZE(connectors),
+					       modes, offsets, enabled, 1024, 768);
+	mutex_unlock(&drm->mode_config.mutex);
+
+	KUNIT_EXPECT_FALSE(test, cloned_too_small);
+	KUNIT_EXPECT_TRUE(test, cloned_fits);
+	for (i = 0; i < ARRAY_SIZE(connectors); i++) {
+		KUNIT_ASSERT_NOT_NULL(test, modes[i]);
+		KUNIT_EXPECT_EQ(test, modes[i]->hdisplay, 1024);
+		KUNIT_EXPECT_EQ(test, modes[i]->vdisplay, 768);
+	}
+}
+
+static struct drm_crtc *drm_client_modeset_test_add_crtc(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_encoder *encoder = &priv->encoder;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	int ret;
+
+	plane = drm_kunit_helper_create_primary_plane(test, drm, NULL, NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
+
+	crtc = drm_kunit_helper_create_crtc(test, drm, plane, NULL, NULL, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+
+	ret = drmm_encoder_init(drm, encoder, NULL, DRM_MODE_ENCODER_NONE, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	ret = drm_connector_attach_encoder(&priv->connector, encoder);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return crtc;
+}
+
+static void drm_test_firmware_config_tiled_fallback(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connector = &priv->connector;
+	struct drm_connector *connectors[] = { connector };
+	struct drm_crtc *crtcs[ARRAY_SIZE(connectors)] = {};
+	struct drm_client_offset offsets[ARRAY_SIZE(connectors)] = {};
+	bool enabled[ARRAY_SIZE(connectors)] = { true };
+	struct drm_client_dev client = { .dev = drm };
+	const struct drm_display_mode *too_small_mode;
+	bool config_fits, config_too_small;
+	struct drm_crtc *too_small_crtc;
+	struct drm_crtc *crtc;
+	int ret;
+
+	crtc = drm_client_modeset_test_add_crtc(test);
+
+	drm_mode_config_reset(drm);
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	connector->state->best_encoder = &priv->encoder;
+	connector->state->crtc = crtc;
+	drm_connector_get(connector);
+
+	drm_connector_helper_add(connector, &drm_client_modeset_preferred_helper_funcs);
+	connector->has_tile = true;
+	connector->num_h_tile = 2;
+	connector->num_v_tile = 1;
+	connector->tile_h_size = 1920;
+	connector->tile_v_size = 1080;
+
+	ret = kunit_add_action_or_reset(test, drm_client_modeset_test_destroy_modes, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	mutex_lock(&drm->mode_config.mutex);
+	ret = drm_helper_probe_single_connector_modes(connector, 4096, 4096);
+
+	/*
+	 * The zeroed current mode fits 320x240, so only the non-tiled fallback
+	 * leaves the connector without a mode
+	 */
+	config_too_small = drm_client_firmware_config(&client, connectors, ARRAY_SIZE(connectors),
+						      crtcs, priv->modes, offsets, enabled,
+						      320, 240);
+	too_small_mode = priv->modes[0];
+	too_small_crtc = crtcs[0];
+	modes_destroy(drm, priv->modes, ARRAY_SIZE(connectors));
+	memset(crtcs, 0, sizeof(crtcs));
+
+	/* The tile size fits, so the non-tiled fallback must skip it */
+	config_fits = drm_client_firmware_config(&client, connectors, ARRAY_SIZE(connectors),
+						 crtcs, priv->modes, offsets, enabled,
+						 1920, 1080);
+	mutex_unlock(&drm->mode_config.mutex);
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, config_too_small);
+	KUNIT_EXPECT_NULL(test, too_small_mode);
+	KUNIT_EXPECT_NULL(test, too_small_crtc);
+
+	KUNIT_EXPECT_TRUE(test, config_fits);
+	KUNIT_EXPECT_PTR_EQ(test, crtcs[0], crtc);
+	KUNIT_ASSERT_NOT_NULL(test, priv->modes[0]);
+	KUNIT_EXPECT_EQ(test, priv->modes[0]->hdisplay, 1680);
+	KUNIT_EXPECT_EQ(test, priv->modes[0]->vdisplay, 1050);
+}
+
+static void drm_client_modeset_test_take_mode(struct kunit *test, struct drm_device *drm,
+					      struct drm_display_mode *dst,
+					      struct drm_display_mode *mode)
+{
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	drm_mode_init(dst, mode);
+	drm_mode_destroy(drm, mode);
+}
+
+static void drm_test_firmware_config_current_mode(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connector = &priv->connector;
+	struct drm_connector *connectors[] = { connector };
+	struct drm_crtc *crtcs[ARRAY_SIZE(connectors)] = {};
+	struct drm_client_offset offsets[ARRAY_SIZE(connectors)] = {};
+	bool enabled[ARRAY_SIZE(connectors)] = { true };
+	struct drm_client_dev client = { .dev = drm };
+	const struct drm_display_mode *too_large_mode;
+	struct drm_display_mode current_too_large;
+	struct drm_display_mode current_fits;
+	bool config_fits, config_too_large;
+	struct drm_crtc *too_large_crtc;
+	struct drm_crtc *crtc;
+	int ret;
+
+	crtc = drm_client_modeset_test_add_crtc(test);
+
+	drm_mode_config_reset(drm);
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc->state);
+	connector->state->best_encoder = &priv->encoder;
+	connector->state->crtc = crtc;
+	drm_connector_get(connector);
+
+	/*
+	 * drm_client_firmware_config() only configures connectors that aren't
+	 * tiled once a tiled one is configured, so use a single 1x1 tile.
+	 */
+	drm_connector_helper_add(connector, &drm_client_modeset_preferred_helper_funcs);
+	connector->has_tile = true;
+	connector->num_h_tile = 1;
+	connector->num_v_tile = 1;
+	connector->tile_h_size = 1920;
+	connector->tile_v_size = 1080;
+
+	ret = kunit_add_action_or_reset(test, drm_client_modeset_test_destroy_modes, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_client_modeset_test_take_mode(test, drm, &current_too_large,
+					  drm_mode_find_dmt(drm, 1920, 1080, 60, false));
+	drm_client_modeset_test_take_mode(test, drm, &current_fits,
+					  drm_cvt_mode(drm, 320, 240, 60, false, false, false));
+
+	/* Every probed mode is larger than 320x240, so only "current" is left */
+	mutex_lock(&drm->mode_config.mutex);
+	ret = drm_helper_probe_single_connector_modes(connector, 4096, 4096);
+
+	drm_mode_copy(&crtc->state->mode, &current_too_large);
+	config_too_large = drm_client_firmware_config(&client, connectors, ARRAY_SIZE(connectors),
+						      crtcs, priv->modes, offsets, enabled,
+						      320, 240);
+	too_large_mode = priv->modes[0];
+	too_large_crtc = crtcs[0];
+	modes_destroy(drm, priv->modes, ARRAY_SIZE(connectors));
+	memset(crtcs, 0, sizeof(crtcs));
+
+	drm_mode_copy(&crtc->state->mode, &current_fits);
+	config_fits = drm_client_firmware_config(&client, connectors, ARRAY_SIZE(connectors),
+						 crtcs, priv->modes, offsets, enabled,
+						 320, 240);
+	mutex_unlock(&drm->mode_config.mutex);
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, config_too_large);
+	KUNIT_EXPECT_NULL(test, too_large_mode);
+	KUNIT_EXPECT_NULL(test, too_large_crtc);
+
+	KUNIT_EXPECT_TRUE(test, config_fits);
+	KUNIT_EXPECT_PTR_EQ(test, crtcs[0], crtc);
+	KUNIT_ASSERT_NOT_NULL(test, priv->modes[0]);
+	KUNIT_EXPECT_EQ(test, priv->modes[0]->hdisplay, 320);
+	KUNIT_EXPECT_EQ(test, priv->modes[0]->vdisplay, 240);
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(drm_client_modeset_free_wrapper, drm_client_modeset_free,
+			    struct drm_client_dev *);
+
+static void drm_test_probe_keeps_modes_above_limits(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connector = &priv->connector;
+	const struct drm_display_mode *mode;
+	struct drm_client_dev *client;
+	int ret;
+
+	drm->mode_config.max_width = 4096;
+	drm->mode_config.max_height = 4096;
+
+	drm_client_modeset_test_add_crtc(test);
+
+	drm_connector_helper_add(connector, &drm_client_modeset_preferred_helper_funcs);
+
+	client = kunit_kzalloc(test, sizeof(*client), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, client);
+	client->dev = drm;
+
+	ret = drm_client_modeset_create(client);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_add_action_or_reset(test, drm_client_modeset_free_wrapper, client);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_client_modeset_probe(client, 1024, 768);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	mode = client->modesets[0].mode;
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	KUNIT_EXPECT_EQ(test, mode->hdisplay, 1024);
+	KUNIT_EXPECT_EQ(test, mode->vdisplay, 768);
+
+	mutex_lock(&drm->mode_config.mutex);
+	mode = drm_connector_preferred_mode(connector, 1920, 1080);
+	mutex_unlock(&drm->mode_config.mutex);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	KUNIT_EXPECT_EQ(test, mode->hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, mode->vdisplay, 1080);
+}
+
+/*
+ * The firmware lit a connector with a mode larger than the client, and a second
+ * connector on the same CRTC has a mode that fits. Probing must not keep the
+ * firmware config, so the fallback drives the second connector
+ */
+static void drm_test_probe_lights_other_connector(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connector = &priv->connector;
+	struct drm_connector *second = &priv->second_connector;
+	struct drm_display_mode *current_mode;
+	struct drm_client_dev *client;
+	struct drm_mode_set *modeset;
+	struct drm_crtc *crtc;
+	int ret;
+
+	drm->mode_config.max_width = 4096;
+	drm->mode_config.max_height = 4096;
+
+	ret = drmm_connector_init(drm, second, &drm_client_modeset_connector_funcs,
+				  DRM_MODE_CONNECTOR_Unknown, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_connector_helper_add(second, &drm_client_modeset_small_helper_funcs);
+
+	crtc = drm_client_modeset_test_add_crtc(test);
+	ret = drm_connector_attach_encoder(second, &priv->encoder);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_mode_config_reset(drm);
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc->state);
+
+	/* A single 1x1 tile, so drm_client_firmware_config() looks at it first */
+	drm_connector_helper_add(connector, &drm_client_modeset_preferred_helper_funcs);
+	connector->has_tile = true;
+	connector->num_h_tile = 1;
+	connector->num_v_tile = 1;
+	connector->tile_h_size = 1920;
+	connector->tile_v_size = 1080;
+	connector->state->best_encoder = &priv->encoder;
+	connector->state->crtc = crtc;
+	drm_connector_get(connector);
+
+	current_mode = drm_mode_find_dmt(drm, 1920, 1080, 60, false);
+	KUNIT_ASSERT_NOT_NULL(test, current_mode);
+	drm_mode_copy(&crtc->state->mode, current_mode);
+	drm_mode_destroy(drm, current_mode);
+
+	client = kunit_kzalloc(test, sizeof(*client), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, client);
+	client->dev = drm;
+
+	ret = drm_client_modeset_create(client);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_add_action_or_reset(test, drm_client_modeset_free_wrapper, client);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_client_modeset_probe(client, 320, 240);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	modeset = &client->modesets[0];
+	KUNIT_EXPECT_PTR_EQ(test, modeset->crtc, crtc);
+	KUNIT_ASSERT_EQ(test, modeset->num_connectors, 1);
+	KUNIT_EXPECT_PTR_EQ(test, modeset->connectors[0], second);
+	KUNIT_ASSERT_NOT_NULL(test, modeset->mode);
+	KUNIT_EXPECT_EQ(test, modeset->mode->hdisplay, 320);
+	KUNIT_EXPECT_EQ(test, modeset->mode->vdisplay, 240);
+}
+
+static struct kunit_case drm_test_pick_mode_limits_tests[] = {
+	KUNIT_CASE(drm_test_pick_first_mode_within_limits),
+	KUNIT_CASE(drm_test_pick_cmdline_mode_within_limits),
+	KUNIT_CASE(drm_test_pick_tiled_mode_within_limits),
+	KUNIT_CASE(drm_test_pick_clone_mode_within_limits),
+	KUNIT_CASE(drm_test_firmware_config_tiled_fallback),
+	KUNIT_CASE(drm_test_firmware_config_current_mode),
+	KUNIT_CASE(drm_test_probe_keeps_modes_above_limits),
+	KUNIT_CASE(drm_test_probe_lights_other_connector),
+	{}
+};
+
+static struct kunit_suite drm_test_pick_mode_limits_test_suite = {
+	.name = "drm_test_pick_mode_limits",
+	.init = drm_client_modeset_test_init,
+	.test_cases = drm_test_pick_mode_limits_tests
+};
+
+kunit_test_suite(drm_test_pick_mode_limits_test_suite);
+
 /*
  * This file is included directly by drm_client_modeset.c so we can't
  * use any MODULE_* macro here.
-- 
2.55.0

