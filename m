Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26B6C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCAC10EB0A;
	Mon, 21 Sep 2026 15:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="CH8pIiTi";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16ED610EAFE;
 Mon, 21 Sep 2026 15:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790006051; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JbERihLlTl6ddoNa7uvB4QYs45V6byIzhah4jwffUAZ4gblS6HIgxrV94wvZfmXm25GzrDNLhBdKikYGPe+eLlHBoIYToKVk9cHtyrLEZXwQqefEXHHPz8IIqcWSdKy/g0Yu6pu/719zUFCmyh3yEEjNpkz/GTmviPzSChK3cOc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790006051;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6omB1+qDFmqaueIObGOPy4D/eBZasljicjGizkGe7WQ=; 
 b=dBjJllzz5y69ffDZum0f9ml1BKSGwHyZDcoLCLmZQCjmoYjP/hTluSdEa2PzRUlBX5rIJhNqoIBCfGRG2rKvNhmLoih2UX3FntywjTIcAfXeKFm5rCx/+9f58Zvc4tSK4QX/KbUAcKjUA+yzka+XRON1V80IXsxxeOVhBDCG9LQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006051; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=6omB1+qDFmqaueIObGOPy4D/eBZasljicjGizkGe7WQ=;
 b=CH8pIiTi8UrYxx7DCM3CVe+7rBmdBalPDGRE+rQttc2Vf+gqdb4mjd07gd6Z5aUC
 1re/e5KO4/Xvzd+eSpfxLyPpFaJLJFN/egD54q7mGw2G6uHDzyA1sytkCVp3fYZ7dcO
 KovmTE3Y/zKwLgnFvn2BFhYCxdQRAPE3kj6xzCZ0=
Received: by smtp.zohomail.com with SMTPS id 1790006050167952.4265439297211;
 Mon, 21 Sep 2026 08:54:10 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:49 +0200
Subject: [PATCH RFC 23/25] drm/tests: hdmi: Add Fixed/Constrained rate VRR
 tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-23-2fcd7d011646@collabora.com>
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

Add tests to verify the functionality of the
VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR} properties and the HDMI state
helpers that make use of them.

This includes tests for fixed rate scenarios, as well as a test for a
constrained game mode scenario. A parametric test case checks that
various erroneous target rates are rejected.

Proper handling of CinemaVRR is tested as well.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 532 +++++++++++++++++++++
 1 file changed, 532 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 1486c16c2f78..e2d98280ea23 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -3674,10 +3674,542 @@ static void drm_test_check_hdmi_vrr_flush_vsync(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+/*
+ * Check that on a VRR-capable sink with VRR enabled and a fixed target rate
+ * set, an atomic commit works, and the derived vtotals are as expected.
+ */
+static void drm_test_check_hdmi_vrr_fixed_rate(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int mode_refresh;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.cinema_vrr);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	mode_refresh = drm_mode_vrefresh(preferred);
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
+	crtc_state->vrr_state.vrr_min_n = 40;
+	crtc_state->vrr_state.vrr_min_d = 1;
+	/* Equivalent fraction, expressed differently to pose a hurdle */
+	crtc_state->vrr_state.vrr_max_n = 40000;
+	crtc_state->vrr_state.vrr_max_d = 1000;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.base_vtotal,
+			preferred->crtc_vtotal * mode_refresh / 40);
+
+	/* Minimum rate is 24Hz because of the CinemaVRR flag */
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.max_vtotal,
+			preferred->crtc_vtotal * mode_refresh / 24);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Check that the drm_hdmi_helper_vrr_flush() and drm_hdmi_helper_vrr_vsync()
+ * helpers return the expected values on a VRR-capable sink with VRR enabled
+ * and a fixed target set.
+ */
+static void drm_test_check_hdmi_vrr_fixed_rate_flush_vsync(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int mode_refresh;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	mode_refresh = drm_mode_vrefresh(preferred);
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
+	crtc_state->vrr_state.vrr_min_n = 40000;
+	crtc_state->vrr_state.vrr_min_d = 1001;
+	/* Equivalent fraction, expressed differently to pose a hurdle */
+	crtc_state->vrr_state.vrr_max_n = 80000;
+	crtc_state->vrr_state.vrr_max_d = 2002;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.base_vtotal,
+			mult_frac(preferred->crtc_vtotal, mode_refresh * 1000, 39960));
+
+	/* Fixed rate case: flush should never trigger a vtotal update. */
+	KUNIT_EXPECT_FALSE(test, drm_crtc_helper_vrr_flush(crtc_state));
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal, 0);
+
+	/*
+	 * Invoking drm_hdmi_helper_vrr_flush() again should not change
+	 * cur_vtotal, meaning it should return false.
+	 */
+	KUNIT_EXPECT_FALSE(test, drm_crtc_helper_vrr_flush(crtc_state));
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal, 0);
+
+	/* First vsync will set cur_vtotal. */
+	KUNIT_EXPECT_TRUE(test, drm_crtc_helper_vrr_vsync(crtc_state));
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal,
+			crtc_state->vrr_state.base_vtotal);
+	/* First vsync with fixed rate will still be dynamic. */
+	KUNIT_EXPECT_TRUE(test, crtc_state->vrr_state.dynamic);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	/* Try a second commit to evaluate the dynamic flag */
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable_2:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm, crtc, conn,
+						     preferred, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_enable_2;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+retry_crtc_state_2:
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state_2;
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state_2;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	KUNIT_EXPECT_FALSE(test, drm_crtc_helper_vrr_flush(crtc_state));
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal,
+			crtc_state->vrr_state.base_vtotal);
+	KUNIT_EXPECT_FALSE(test, crtc_state->vrr_state.dynamic);
+	KUNIT_EXPECT_FALSE(test, drm_crtc_helper_vrr_vsync(crtc_state));
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.cur_vtotal,
+			crtc_state->vrr_state.base_vtotal);
+	/* Subsequent vsyncs with fixed rate won't be dynamic. */
+	KUNIT_EXPECT_FALSE(test, crtc_state->vrr_state.dynamic);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+struct vrr_target_error_params {
+	unsigned int vrr_min_n;
+	unsigned int vrr_min_d;
+	unsigned int vrr_max_n;
+	unsigned int vrr_max_d;
+	bool cinema_vrr_override;
+	const char *desc;
+};
+
+static struct vrr_target_error_params vrr_target_errors[] = {
+	{ 26, 1, 26 * 2000, 2000, false, "VRR target <= min rate should fail" },
+	{ 200, 1, 200, 1, true, "VRR target <= max rate should fail" },
+	{ 60, 1, 40, 1, true, "VRR max target <= VRR min target should fail" },
+	{ 40, 1, 60, 0, true, "VRR max target denominator of 0 should fail" },
+	{ 40, 0, 60, 1, true, "VRR min target denominator of 0 should fail" },
+	{ 25000, 1001, 30, 1, true, "CinemaVRR with non-fixed rate should fail" },
+};
+
+KUNIT_ARRAY_PARAM_DESC(check_vrr_target_errors, vrr_target_errors, desc);
+
+/*
+ * Check that on a VRR-capable sink with VRR enabled and various erroneous
+ * combinations of target rates set, an atomic commit fails.
+ */
+static void drm_test_check_hdmi_vrr_target_rate_fail(struct kunit *test)
+{
+	const struct vrr_target_error_params *params = test->param_value;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
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
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
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
+	/*
+	 * Allow individual test parameters to play with the CinemaVRR flag
+	 * without needing to bring their own modified EDID.
+	 */
+	conn->display_info.hdmi.cinema_vrr = params->cinema_vrr_override;
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
+	crtc_state->vrr_state.vrr_min_n = params->vrr_min_n;
+	crtc_state->vrr_state.vrr_min_d = params->vrr_min_d;
+	crtc_state->vrr_state.vrr_max_n = params->vrr_max_n;
+	crtc_state->vrr_state.vrr_max_d = params->vrr_max_d;
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
+ * Check that on a VRR-capable sink that has the CinemaVRR flag set, with VRR
+ * enabled and a fixed target rate set, an atomic commit succeeds at a rate
+ * only possible if CinemaVRR is supported and a fixed target is used.
+ */
+static void drm_test_check_hdmi_vrr_fixed_rate_cinema_vrr(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int mode_refresh;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.cinema_vrr);
+	KUNIT_ASSERT_LT(test, 24, conn->display_info.monitor_range.min_vfreq);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	mode_refresh = drm_mode_vrefresh(preferred);
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
+
+	/* 24/1.001 Hz should work */
+	crtc_state->vrr_state.vrr_min_n = 24000;
+	crtc_state->vrr_state.vrr_min_d = 1001;
+	crtc_state->vrr_state.vrr_max_n = 24000;
+	crtc_state->vrr_state.vrr_max_d = 1001;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.base_vtotal,
+			mult_frac(preferred->crtc_vtotal, mode_refresh * 1000, 23976));
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
+/*
+ * Check that on a VRR-capable sink, an atomic commit with a VRR minimum and
+ * maximum target rate that's more narrow than the monitor's target rate
+ * succeeds and produces the expected derived values.
+ */
+static void drm_test_check_hdmi_vrr_constrained_rate(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int mode_refresh;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_capable);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	mode_refresh = drm_mode_vrefresh(preferred);
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
+	crtc_state->vrr_state.vrr_min_n = 40;
+	crtc_state->vrr_state.vrr_min_d = 1;
+	crtc_state->vrr_state.vrr_max_n = 80;
+	crtc_state->vrr_state.vrr_max_d = 1;
+
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.base_vtotal,
+			preferred->crtc_vtotal * mode_refresh / 80);
+	KUNIT_EXPECT_EQ(test, crtc_state->vrr_state.max_vtotal,
+			preferred->crtc_vtotal * mode_refresh / 40);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 static struct kunit_case drm_atomic_helper_connector_hdmi_vrr_tests[] = {
 	KUNIT_CASE(drm_test_check_hdmi_vrr),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_sink_fail),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_flush_vsync),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate_flush_vsync),
+	KUNIT_CASE_PARAM(drm_test_check_hdmi_vrr_target_rate_fail,
+			 check_vrr_target_errors_gen_params),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate_cinema_vrr),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_constrained_rate),
 	{ }
 };
 

-- 
2.55.0

