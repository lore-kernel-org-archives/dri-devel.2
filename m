Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FEDC982F8
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C0110EB1B;
	Mon, 21 Sep 2026 15:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="UQzciu0C";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B69210EB16;
 Mon, 21 Sep 2026 15:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790006057; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kWnnucDCgjsMc15Ca0bKXevcthUdeUiLDSsY0dk+/jvyQp8ixUOIWll+G5S+XuSuhtwvK1EyNag2i+olZhnWcZiGXJJ1S+Ef9sVNgs/dyioFhMb7C/tq4UGgSbBxNWSkeoPKkdP1swQtPzxYGUQIzTl+QZBq5bDiTcx0VsUTFJQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790006057;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Vfsv6aK7GfXtbnn5HLKv5OIremt2SvHxyOB3/TnLMqk=; 
 b=Q3TpK1kH0CGindO0+wI9IwuKPEcUjMsHktQQctrUO+STTAeOmAKM2LUDwO0cqndgfdS5XFzYhTtMhTABSO5/DL2BIJ8k8nbHcOOcRpAlRA2rsbMFK22WKncysYFJEuNu9gHZXP+jTRCwGJ2Z42JxCko3uH7BXX0xHuKBekjNRWw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006057; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Vfsv6aK7GfXtbnn5HLKv5OIremt2SvHxyOB3/TnLMqk=;
 b=UQzciu0CaHxexI609MxVKwGZBAEhRpOtHL83rl6k/scIKUKnsy3+Rhpb/2nAyW5G
 aoP52cFNgjrGaoYxpJIVZ2sOMnk9OQeM5E+zQS9Ub9ZCJYMTtul1C/Vx/7U5nRiK6DT
 PS3m7PRsGjWyU2Gu95kX/W/h8Kg3HCpcKQ9Q5xoM=
Received: by smtp.zohomail.com with SMTPS id 1790006055625821.5593241292398;
 Mon, 21 Sep 2026 08:54:15 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:50 +0200
Subject: [PATCH RFC 24/25] drm/tests: hdmi: Add Quick Media Switching tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-24-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
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

Add KUnit tests to validate the HDMI Quick Media Switching (QMS)
functionality in the HDMI state helpers.

This includes tests to validate that the QMS TFR min and QMS TFR max
flags are respected.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 587 +++++++++++++++++++++
 drivers/gpu/drm/tests/drm_kunit_edid.h             | 140 +++++
 2 files changed, 727 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index e2d98280ea23..961a4b48afd8 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -4200,6 +4200,587 @@ static void drm_test_check_hdmi_vrr_constrained_rate(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+/*
+ * Check that on a QMS-capable sink, an atomic commit with the qms_enabled
+ * connector property set succeeds, and produces the right connector state
+ * values.
+ */
+static void drm_test_check_hdmi_vrr_qms(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr_qms);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.qms_capable);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
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
+retry_crtc_state:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	crtc_state->vrr_enabled = true;
+	crtc_state->vrr_state.vrr_min_n = 48000;
+	crtc_state->vrr_state.vrr_min_d = 1001;
+	/* Equivalent fraction, as an added hurdle */
+	crtc_state->vrr_state.vrr_max_n = 48000 * 2;
+	crtc_state->vrr_state.vrr_max_d = 1001 * 2;
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
+	conn_state->hdmi.qms_enabled = true;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_new_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_EQ(test, conn_state->hdmi.qms_tfr_byte, 6);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Check that on a QMS-capable sink, an atomic commit with the qms_enabled
+ * connector property set fails if the requested target rate is not supported
+ * by QMS.
+ */
+static void drm_test_check_hdmi_vrr_qms_fail(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr_qms);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.qms_capable);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
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
+retry_crtc_state:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	crtc_state->vrr_enabled = true;
+	crtc_state->vrr_state.vrr_min_n = 67;
+	crtc_state->vrr_state.vrr_min_d = 1;
+	crtc_state->vrr_state.vrr_max_n = 67;
+	crtc_state->vrr_state.vrr_max_d = 1;
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
+	conn_state->hdmi.qms_enabled = true;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_EXPECT_LT(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Check that on a QMS-capable sink, an atomic commit with the qms_enabled
+ * connector property set fails if the requested target rate is not a fixed
+ * rate.
+ */
+static void drm_test_check_hdmi_vrr_qms_nonfixed_fail(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr_qms);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.qms_capable);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
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
+retry_crtc_state:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	crtc_state->vrr_enabled = true;
+	crtc_state->vrr_state.vrr_min_n = 30;
+	crtc_state->vrr_state.vrr_min_d = 1;
+	crtc_state->vrr_state.vrr_max_n = 60;
+	crtc_state->vrr_state.vrr_max_d = 1;
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
+	conn_state->hdmi.qms_enabled = true;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_EXPECT_LT(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Check that on a QMS-capable sink with QMS TFR min set, an atomic commit with
+ * the qms_enabled connector property set succeeds even if the target rate is
+ * below the monitor's range, and that it produces the right connector state
+ * values.
+ */
+static void drm_test_check_hdmi_vrr_qms_tfr_min(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr_qms);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.qms_capable);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.qms_tfr_min);
+	/*
+	 * The CinemaVRR flag provides equivalent functionality to QMS Min TFR
+	 * for non-QMS VRR, so it should be false to ensure that this unit test
+	 * tests the right thing.
+	 */
+	KUNIT_ASSERT_FALSE(test, conn->display_info.hdmi.cinema_vrr);
+
+	KUNIT_ASSERT_LT(test, 24, conn->display_info.monitor_range.min_vfreq);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
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
+retry_crtc_state:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	crtc_state->vrr_enabled = true;
+	crtc_state->vrr_state.vrr_min_n = 24;
+	crtc_state->vrr_state.vrr_min_d = 1;
+	crtc_state->vrr_state.vrr_max_n = 24;
+	crtc_state->vrr_state.vrr_max_d = 1;
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
+	conn_state->hdmi.qms_enabled = true;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_new_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_EQ(test, conn_state->hdmi.qms_tfr_byte, 2);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Check that on a QMS-capable sink without the QMS max TFR flag, an atomic
+ * commit with QMS enabled and a target rate above 60Hz fails.
+ */
+static void drm_test_check_hdmi_vrr_qms_no_tfr_max_fail(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr_qms);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.qms_capable);
+	KUNIT_ASSERT_FALSE(test, conn->display_info.hdmi.qms_tfr_max);
+
+	KUNIT_ASSERT_LE(test, 100, conn->display_info.monitor_range.max_vfreq);
+
+	ret = drm_connector_attach_qms_enabled_property(conn);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
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
+retry_crtc_state:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	crtc_state->vrr_enabled = true;
+	crtc_state->vrr_state.vrr_min_n = 100;
+	crtc_state->vrr_state.vrr_min_d = 1;
+	crtc_state->vrr_state.vrr_max_n = 100;
+	crtc_state->vrr_state.vrr_max_d = 1;
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
+	conn_state->hdmi.qms_enabled = true;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_EXPECT_LT(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Check that on a QMS-capable sink with the QMS max TFR flag, an atomic commit
+ * with QMS enabled and a target rate above 60Hz succeeds.
+ */
+static void drm_test_check_hdmi_vrr_qms_tfr_max(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr_qms);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.qms_capable);
+
+	KUNIT_ASSERT_LE(test, 100, conn->display_info.monitor_range.max_vfreq);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
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
+	/* Manual override to not have to define an additional EDID. */
+	conn->display_info.hdmi.qms_tfr_max = true;
+
+retry_crtc_state:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	crtc_state->vrr_enabled = true;
+	crtc_state->vrr_state.vrr_min_n = 1000; /* Intentional tomfoolery. */
+	crtc_state->vrr_state.vrr_min_d = 10;
+	crtc_state->vrr_state.vrr_max_n = 100;
+	crtc_state->vrr_state.vrr_max_d = 1;
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
+	conn_state->hdmi.qms_enabled = true;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_new_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	KUNIT_EXPECT_EQ(test, conn_state->hdmi.qms_tfr_byte, 11);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 static struct kunit_case drm_atomic_helper_connector_hdmi_vrr_tests[] = {
 	KUNIT_CASE(drm_test_check_hdmi_vrr),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_sink_fail),
@@ -4210,6 +4791,12 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_vrr_tests[] = {
 			 check_vrr_target_errors_gen_params),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate_cinema_vrr),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_constrained_rate),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_qms),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_qms_fail),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_qms_nonfixed_fail),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_qms_tfr_min),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_qms_no_tfr_max_fail),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_qms_tfr_max),
 	{ }
 };
 
diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.h b/drivers/gpu/drm/tests/drm_kunit_edid.h
index 10175c9e1b2e..71029101a4ab 100644
--- a/drivers/gpu/drm/tests/drm_kunit_edid.h
+++ b/drivers/gpu/drm/tests/drm_kunit_edid.h
@@ -152,4 +152,144 @@ static const unsigned char test_edid_hdmi_vrr[] = {
 	0x00, 0x00, 0x00, 0x68
 };
 
+/*
+ * Max resolution: 3840x2160@60Hz with YUV420
+ * Max BPC:        16 for all modes
+ * Max TMDS clock: <340MHz, so set to 0
+ * VRR range: 30Hz to 120Hz
+ * CinemaVRR flag is unset
+ * QMS flag is set
+ * QMS TFRmin flag is set
+ *
+ * edid-decode (hex):
+ *
+ * 00 ff ff ff ff ff ff 00 31 d8 45 00 00 00 00 00
+ * 01 24 01 03 80 60 36 78 0f ee 91 a3 54 4c 99 26
+ * 0f 50 54 20 00 00 01 01 01 01 01 01 01 01 01 01
+ * 01 01 01 01 01 01 04 74 80 18 71 38 2d 40 58 2c
+ * 45 00 c0 1c 32 00 00 1e 04 74 00 30 f2 70 5a 80
+ * b0 58 8a 00 c0 1c 32 00 00 1e 00 00 00 fc 00 54
+ * 65 73 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd
+ * 00 18 78 18 87 22 00 0a 20 20 20 20 20 20 01 7c
+ *
+ * 02 03 29 31 42 3f 5f 6d 03 0c 00 10 00 78 00 20
+ * 00 00 00 20 61 6d d8 5d c4 01 00 80 07 40 1e 78
+ * 10 00 00 e2 0e 61 e2 00 ed 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 28
+ *
+ * ----------------
+ *
+ * Block 0, Base EDID:
+ *  EDID Structure Version & Revision: 1.3
+ *  Vendor & Product Identification:
+ *    Manufacturer: LNX
+ *    Model: 69
+ *    Made in: week 1 of 2026
+ *  Basic Display Parameters & Features:
+ *    Digital display
+ *    Maximum image size: 96 cm x 54 cm
+ *    Gamma: 2.20
+ *    RGB color display
+ *    Default (sRGB) color space is primary color space
+ *    First detailed timing is the preferred timing
+ *    Supports GTF timings within operating range
+ *  Color Characteristics:
+ *    Red  : 0.6396, 0.3300
+ *    Green: 0.2998, 0.5996
+ *    Blue : 0.1503, 0.0595
+ *    White: 0.3125, 0.3291
+ *  Established Timings I & II:
+ *    DMT 0x04:   640x480    59.940476 Hz   4:3     31.469 kHz     25.175000 MHz
+ *  Standard Timings: none
+ *  Detailed Timing Descriptors:
+ *    DTD 1:  1920x1080  120.000000 Hz  16:9    135.000 kHz    297.000000 MHz (960 mm x 540 mm)
+ *                 Hfront   88 Hsync  44 Hback  148 Hpol P
+ *                 Vfront    4 Vsync   5 Vback   36 Vpol P
+ *    DTD 2:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz (960 mm x 540 mm)
+ *                 Hfront  176 Hsync  88 Hback  296 Hpol P
+ *                 Vfront    8 Vsync  10 Vback   72 Vpol P
+ *    Display Product Name: 'Test EDID'
+ *    Display Range Limits:
+ *      Monitor ranges (GTF): 24-120 Hz V, 24-135 kHz H, max dotclock 340 MHz
+ *  Extension blocks: 1
+ * Checksum: 0x7c
+ *
+ * ----------------
+ *
+ * Block 1, CTA-861 Extension Block:
+ *  Revision: 3
+ *  Supports YCbCr 4:4:4
+ *  Supports YCbCr 4:2:2
+ *  Native detailed modes: 1
+ *  Video Data Block:
+ *    VIC  63:  1920x1080  120.000000 Hz  16:9    135.000 kHz    297.000000 MHz
+ *    VIC  95:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz
+ *  Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
+ *    Source physical address: 1.0.0.0
+ *    DC_48bit
+ *    DC_36bit
+ *    DC_30bit
+ *    DC_Y444
+ *    Maximum TMDS clock: 0 MHz
+ *    Extended HDMI video details:
+ *  Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8:
+ *    Version: 1
+ *    SCDC Present
+ *    Supports 16-bits/component Deep Color 4:2:0 Pixel Encoding
+ *    Supports 12-bits/component Deep Color 4:2:0 Pixel Encoding
+ *    Supports 10-bits/component Deep Color 4:2:0 Pixel Encoding
+ *    Supports QMS
+ *    VRRmin: 30 Hz
+ *    VRRmax: 120 Hz
+ *    Supports QMS TFRmin
+ *  YCbCr 4:2:0 Video Data Block:
+ *    VIC  97:  3840x2160   60.000000 Hz  16:9    135.000 kHz    594.000000 MHz
+ *  Video Capability Data Block:
+ *    YCbCr quantization: Selectable (via AVI YQ)
+ *    RGB quantization: Selectable (via AVI Q)
+ *    PT scan behavior: Always Underscanned
+ *    IT scan behavior: Supports both over- and underscan
+ *    CE scan behavior: Always Overscanned
+ * Checksum: 0x28  Unused space in Extension Block: 86 bytes
+ *
+ * ----------------
+ *
+ * edid-decode 1.32.0
+ *
+ * Warnings:
+ *
+ * Block 1, CTA-861 Extension Block:
+ *  IT Video Formats are overscanned by default, but normally this should be underscanned.
+ *
+ * EDID conformity: PASS
+ */
+static const unsigned char test_edid_hdmi_vrr_qms[] = {
+	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x45, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x24, 0x01, 0x03, 0x80, 0x60, 0x36, 0x78,
+	0x0f, 0xee, 0x91, 0xa3, 0x54, 0x4c, 0x99, 0x26, 0x0f, 0x50, 0x54, 0x20,
+	0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04, 0x74, 0x80, 0x18, 0x71, 0x38,
+	0x2d, 0x40, 0x58, 0x2c, 0x45, 0x00, 0xc0, 0x1c, 0x32, 0x00, 0x00, 0x1e,
+	0x04, 0x74, 0x00, 0x30, 0xf2, 0x70, 0x5a, 0x80, 0xb0, 0x58, 0x8a, 0x00,
+	0xc0, 0x1c, 0x32, 0x00, 0x00, 0x1e, 0x00, 0x00, 0x00, 0xfc, 0x00, 0x54,
+	0x65, 0x73, 0x74, 0x20, 0x45, 0x44, 0x49, 0x44, 0x0a, 0x20, 0x20, 0x20,
+	0x00, 0x00, 0x00, 0xfd, 0x00, 0x18, 0x78, 0x18, 0x87, 0x22, 0x00, 0x0a,
+	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x01, 0x7c, 0x02, 0x03, 0x29, 0x31,
+	0x42, 0x3f, 0x5f, 0x6d, 0x03, 0x0c, 0x00, 0x10, 0x00, 0x78, 0x00, 0x20,
+	0x00, 0x00, 0x00, 0x20, 0x61, 0x6d, 0xd8, 0x5d, 0xc4, 0x01, 0x00, 0x80,
+	0x07, 0x40, 0x1e, 0x78, 0x10, 0x00, 0x00, 0xe2, 0x0e, 0x61, 0xe2, 0x00,
+	0xed, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x28
+};
+
 #endif // DRM_KUNIT_EDID_H_

-- 
2.55.0

