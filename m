Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385A0C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F0310EC06;
	Wed, 29 Jul 2026 12:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="RtLSnqi/";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A056510EBCB;
 Wed, 29 Jul 2026 12:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785327252; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Sn1Baa8zXJdV89a3aR0P/0aHltAXSFfmsnwVL5kPjua1lYerm/ivtRrF3s/LKe2rCTkjjHqK6lYt41JMyUe9WbNbrBoJOIcSVmBgImroJqj4gjLn5CfXcrMULHOi3pmsLMPBxTWy0YwA59gWf5kM/7c48VdZLcXCTmMRh9orVdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785327252;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=D/RuhdB8lsmvvuNIUNLDVMxhzAcXl4NwBtQrivDS8oc=; 
 b=OVrL1Sse/she+EAJO6j0o91jL+VA8EhisnrPEAttZkgcdw6WnxbIruWZJxJk2r5kOwLWqiQQHfJSOxNOpqnMY/5mVWw2pvrYM5MkqM3AeZ2sYg6tvqPKRuv+OAvhx4hho/smfNMlHBI+4cF99jWWgyXeYU1O3ZJPQvSZ7w+1+a8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785327252; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=D/RuhdB8lsmvvuNIUNLDVMxhzAcXl4NwBtQrivDS8oc=;
 b=RtLSnqi/uG8LTiaPi0on4kg8ihd/bmHB5UieYZBkCLNEuhb0nWIPzHNGuvzzASbo
 Hnc9EzsH67JL3Hx1ENLAf/cVRs1JGf8eP/xVp4nMgHB7gNSYkYz2OHcce+tfcvMOX53
 L5fZC3QRCFYMjSa9l6RT6MAud8w/R6y9k2BMFzX0=
Received: by mx.zohomail.com with SMTPS id 1785327250275251.40259905514847;
 Wed, 29 Jul 2026 05:14:10 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 29 Jul 2026 14:13:28 +0200
Subject: [PATCH v2 2/2] drm/connector: hdmi: Implement "min bpc" property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-min-bpc-v2-2-7d0036ef437c@collabora.com>
References: <20260729-min-bpc-v2-0-7d0036ef437c@collabora.com>
In-Reply-To: <20260729-min-bpc-v2-0-7d0036ef437c@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Xaver Hugl <xaver.hugl@kde.org>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Mario Kleiner <mario.kleiner.de@gmail.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Marius Vlad <marius.vlad@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

Act on the "min bpc" property's min_requested_bpc state in the common
HDMI state helpers, and register the property on HDMI connectors.

Also add two KUnit tests to verify that the property behaves as
expected.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  10 +-
 drivers/gpu/drm/drm_connector.c                    |   4 +
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 146 +++++++++++++++++++++
 3 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index ce17eeefc2da..fa015d218b41 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -636,10 +636,12 @@ hdmi_compute_format_bpc(const struct drm_connector *connector,
 			unsigned int max_bpc, enum drm_output_color_format fmt)
 {
 	struct drm_device *dev = connector->dev;
-	unsigned int bpc;
+	unsigned int bpc, min_bpc;
 	int ret;
 
-	for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
+	min_bpc = max(conn_state->min_requested_bpc, 8);
+
+	for (bpc = max_bpc; bpc >= min_bpc; bpc -= 2) {
 		ret = hdmi_try_format_bpc(connector, conn_state, mode, bpc, fmt);
 		if (!ret)
 			continue;
@@ -657,8 +659,8 @@ hdmi_compute_format_bpc(const struct drm_connector *connector,
 		return 0;
 	}
 
-	drm_dbg_kms(dev, "Failed. %s output format not supported for any bpc count.\n",
-		    drm_hdmi_connector_get_output_format_name(fmt));
+	drm_dbg_kms(dev, "Failed. %s output format not supported for any bpc <= %u and >= %u.\n",
+		    drm_hdmi_connector_get_output_format_name(fmt), max_bpc, min_bpc);
 
 	return -EINVAL;
 }
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3ecc079404a1..f019bd5fef69 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -640,6 +640,10 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	ret = drm_connector_attach_min_bpc_property(connector, max_bpc);
+	if (ret)
+		return ret;
+
 	connector->hdmi.funcs = hdmi_funcs;
 
 	return 0;
diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 353a261d42da..8f8f7a528e08 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -1361,6 +1361,150 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+/*
+ * Test that an atomic check with a min bpc of 10 fails on a connector that
+ * maxes out at 8bpc even if the EDID could go higher.
+ */
+static void drm_test_check_min_bpc_10bit_connector_fail(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_display_mode *preferred;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420) |
+				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	conn = &priv->connector;
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, priv->crtc,
+						     conn, preferred, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_conn_state:
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	if (PTR_ERR(conn_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	conn_state->min_requested_bpc = 10;
+
+	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_state;
+	}
+	KUNIT_EXPECT_LT(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Test that an atomic check with a min bpc of 10 succeeds on a connector that
+ * can do 10bpc if the EDID can also do 10bpc.
+ */
+static void drm_test_check_min_bpc_10bit_success(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_display_mode *preferred;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				12,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	conn = &priv->connector;
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.edid_hdmi_rgb444_dc_modes &
+				DRM_EDID_HDMI_DC_30);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, priv->crtc,
+						     conn, preferred, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_conn_state:
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	if (PTR_ERR(conn_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	conn_state->min_requested_bpc = 10;
+
+	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_state;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_new_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+	KUNIT_EXPECT_GE(test, conn_state->hdmi.output_bpc, 10);
+	KUNIT_ASSERT_EQ(test, conn_state->hdmi.output_format, DRM_OUTPUT_COLOR_FORMAT_RGB444);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 /*
  * Test that if we filter a rate through our hook, it's indeed rejected
  * by the whole atomic_check logic.
@@ -2476,6 +2620,8 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_8bpc),
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_10bpc),
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_12bpc),
+	KUNIT_CASE(drm_test_check_min_bpc_10bit_connector_fail),
+	KUNIT_CASE(drm_test_check_min_bpc_10bit_success),
 	KUNIT_CASE_PARAM(drm_test_check_hdmi_color_format,
 			 check_hdmi_color_format_gen_params),
 	KUNIT_CASE_PARAM(drm_test_check_hdmi_color_format_420_only,

-- 
2.55.0

