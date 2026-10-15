Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF3ECCA48B
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA17F112669;
	Fri, 16 Oct 2026 07:35:42 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81A21124C0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:25:54 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j5Lhx0DTMzKnCy;
 Thu, 15 Oct 2026 23:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792099553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mcgoV3INGnoJVrXhx5IiQEBNo5YI0Bqb7zeSJExZ80=;
 b=gLrVtBBEPfKVeqiy+wHhR5f3z3mJ70qrvmnfoVnPFJOklj/qPgT7MeXQTslHy5XvFRtBLR
 6cqJO8oBgHkLAiq4VqYMhWKcTQNUmI2HVkPxsg7IEIFVVGvzToGbOpMrlMOg8Q9N3y5rp6
 16PVhQ6hW+YmAKiajquvc3JF06VKof/uiZn6/P8wfoOwAU3SbdU91bK0VR/FJDZrnyPsBN
 B0gzwGr5uK5g+owbB5nKqgoOB609jlPA6q+sg9AoG7VkyRVN6I6V2oavFiw8G9D5Ys9Pgi
 7LBYH4Y5I1zANV4AimquqlCGrXab1XS2AD41/ZXQm3foyEKkyz7MN6LjIJ+0ww==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, ville.syrjala@linux.intel.com, jfalempe@redhat.com,
 javierm@redhat.com, Hugo Sales <hugo@hsal.es>
Subject: [PATCH 2/2] drm/tests: Add KUnit tests for the client mode size limits
Date: Thu, 15 Oct 2026 22:25:45 +0100
Message-ID: <20261015212545.1989962-3-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015212545.1989962-1-hugo@hsal.es>
References: <20261015212545.1989962-1-hugo@hsal.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j5Lhx0DTMzKnCy
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

Test that the first-mode, cmdline, tiled and clone pickers skip modes
larger than the client's size, and that drm_client_modeset_probe() keeps
the preferred mode in connector->modes when the client is smaller than
it

The probe test calls drm_client_modeset_create() directly, because
drm_client_init() needs a dumb_create callback the test driver doesn't
have

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../gpu/drm/tests/drm_client_modeset_test.c   | 218 +++++++++++++++++-
 1 file changed, 217 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
index 00f43fca9795..93aa919d4f31 100644
--- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
+++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
@@ -18,6 +18,8 @@ struct drm_client_modeset_test_priv {
 	struct drm_device *drm;
 	struct device *dev;
 	struct drm_connector connector;
+	struct drm_connector second_connector;
+	struct drm_encoder encoder;
 };
 
 static int drm_client_modeset_connector_get_modes(struct drm_connector *connector)
@@ -48,9 +50,23 @@ static const struct drm_connector_helper_funcs drm_client_modeset_connector_help
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
 static const struct drm_connector_funcs drm_client_modeset_connector_funcs = {
 	.atomic_destroy_state   = drm_atomic_helper_connector_destroy_state,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.fill_modes             = drm_helper_probe_single_connector_modes,
 };
 
 static int drm_client_modeset_test_init(struct kunit *test)
@@ -197,6 +213,206 @@ static struct kunit_suite drm_test_pick_cmdline_test_suite = {
 
 kunit_test_suite(drm_test_pick_cmdline_test_suite);
 
+static void drm_test_pick_first_mode_within_limits(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connector = &priv->connector;
+	const struct drm_display_mode *mode;
+	int ret;
+
+	drm_connector_helper_add(connector, &drm_client_modeset_preferred_helper_funcs);
+
+	mutex_lock(&drm->mode_config.mutex);
+	ret = drm_helper_probe_single_connector_modes(connector, 1920, 1080);
+	mutex_unlock(&drm->mode_config.mutex);
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	mode = drm_connector_first_mode(connector, 1920, 1080);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	KUNIT_EXPECT_EQ(test, mode->hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, mode->vdisplay, 1080);
+
+	KUNIT_ASSERT_NULL(test, drm_connector_preferred_mode(connector, 1024, 768));
+
+	mode = drm_connector_first_mode(connector, 1024, 768);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	KUNIT_EXPECT_EQ(test, mode->hdisplay, 1024);
+	KUNIT_EXPECT_EQ(test, mode->vdisplay, 768);
+
+	KUNIT_EXPECT_NULL(test, drm_connector_first_mode(connector, 320, 240));
+}
+
+static void drm_test_pick_cmdline_mode_within_limits(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connector = &priv->connector;
+	struct drm_cmdline_mode *cmdline_mode = &connector->cmdline_mode;
+	const struct drm_display_mode *mode;
+	int ret;
+
+	KUNIT_ASSERT_TRUE(test, drm_mode_parse_command_line_for_connector("1920x1080", connector,
+									  cmdline_mode));
+
+	mutex_lock(&drm->mode_config.mutex);
+	ret = drm_helper_probe_single_connector_modes(connector, 1920, 1080);
+	mutex_unlock(&drm->mode_config.mutex);
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	mode = drm_connector_pick_cmdline_mode(connector, 1920, 1080);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	KUNIT_EXPECT_EQ(test, mode->hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, mode->vdisplay, 1080);
+
+	KUNIT_EXPECT_NULL(test, drm_connector_pick_cmdline_mode(connector, 1024, 768));
+}
+
+static void drm_test_pick_tiled_mode_within_limits(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connector = &priv->connector;
+	const struct drm_display_mode *mode;
+	int ret;
+
+	drm_connector_helper_add(connector, &drm_client_modeset_preferred_helper_funcs);
+	connector->tile_h_size = 1920;
+	connector->tile_v_size = 1080;
+
+	mutex_lock(&drm->mode_config.mutex);
+	ret = drm_helper_probe_single_connector_modes(connector, 1920, 1080);
+	mutex_unlock(&drm->mode_config.mutex);
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	mode = drm_connector_get_tiled_mode(connector, 1920, 1080);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	KUNIT_EXPECT_EQ(test, mode->hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, mode->vdisplay, 1080);
+
+	KUNIT_EXPECT_NULL(test, drm_connector_get_tiled_mode(connector, 1024, 768));
+
+	mode = drm_connector_fallback_non_tiled_mode(connector, 1024, 768);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	KUNIT_EXPECT_EQ(test, mode->hdisplay, 1024);
+	KUNIT_EXPECT_EQ(test, mode->vdisplay, 768);
+}
+
+static void drm_test_pick_clone_mode_within_limits(struct kunit *test)
+{
+	struct drm_client_modeset_test_priv *priv = test->priv;
+	struct drm_device *drm = priv->drm;
+	struct drm_connector *connectors[] = { &priv->connector, &priv->second_connector };
+	const struct drm_display_mode *modes[ARRAY_SIZE(connectors)] = {};
+	struct drm_client_offset offsets[ARRAY_SIZE(connectors)] = {};
+	bool enabled[ARRAY_SIZE(connectors)] = { true, true };
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
+	mutex_lock(&drm->mode_config.mutex);
+	for (i = 0; i < ARRAY_SIZE(connectors); i++) {
+		ret = drm_helper_probe_single_connector_modes(connectors[i], 1920, 1080);
+		KUNIT_EXPECT_GT(test, ret, 0);
+	}
+	mutex_unlock(&drm->mode_config.mutex);
+
+	KUNIT_EXPECT_TRUE(test, drm_client_target_cloned(drm, connectors, ARRAY_SIZE(connectors),
+							 modes, offsets, enabled, 1024, 768));
+	for (i = 0; i < ARRAY_SIZE(connectors); i++) {
+		KUNIT_ASSERT_NOT_NULL(test, modes[i]);
+		KUNIT_EXPECT_EQ(test, modes[i]->hdisplay, 1024);
+		KUNIT_EXPECT_EQ(test, modes[i]->vdisplay, 768);
+	}
+	modes_destroy(drm, modes, ARRAY_SIZE(connectors));
+
+	KUNIT_EXPECT_FALSE(test, drm_client_target_cloned(drm, connectors, ARRAY_SIZE(connectors),
+							  modes, offsets, enabled, 800, 600));
+	modes_destroy(drm, modes, ARRAY_SIZE(connectors));
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
+	struct drm_encoder *encoder = &priv->encoder;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	int ret;
+
+	drm->mode_config.max_width = 4096;
+	drm->mode_config.max_height = 4096;
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
+	ret = drm_connector_attach_encoder(connector, encoder);
+	KUNIT_ASSERT_EQ(test, ret, 0);
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
+	mode = drm_connector_preferred_mode(connector, 1920, 1080);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	KUNIT_EXPECT_EQ(test, mode->hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, mode->vdisplay, 1080);
+}
+
+static struct kunit_case drm_test_pick_mode_limits_tests[] = {
+	KUNIT_CASE(drm_test_pick_first_mode_within_limits),
+	KUNIT_CASE(drm_test_pick_cmdline_mode_within_limits),
+	KUNIT_CASE(drm_test_pick_tiled_mode_within_limits),
+	KUNIT_CASE(drm_test_pick_clone_mode_within_limits),
+	KUNIT_CASE(drm_test_probe_keeps_modes_above_limits),
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

