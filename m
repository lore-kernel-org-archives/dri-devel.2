Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C36CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4564C10F20B;
	Mon,  8 Jun 2026 11:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Jgbtoy12";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF3F10F20A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 11:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780917570; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MDBnO0TqcGEwPFTTvTd/cPaE4bO3Cq6kyoqVXtWvMGpeTbSUrYC4AEo6czAAbgiGc+TOpYpYrA0OogWPd73kUTCnmVbtp05w4i5XCKeyUA6DBMhisIQEtCRqpGovhtiaF67dng+JDXFW+ePob3l2/7G0Efj2SDoab5PWPNcY/0c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780917570;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1to7idDhOP2VxQhysUm+4CWP7+1PqSSDup0jP0EDL70=; 
 b=kL2WFIO5nL6e0+IVyeoOUxLRVqD9lGZ19VPvsOq4aoXkzr6FaXiTjtMOkHDB2Vu+KE+MmXwPoIMRkM9OW6GqHKHeuGxe3WfyTjhJba1C7dY7EB4yEfgKEZXToQMNmisWQl2BqYasO9iI2gRGECydD2MZzpeIP4YQ+yi9ZBj9XAg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780917570; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=1to7idDhOP2VxQhysUm+4CWP7+1PqSSDup0jP0EDL70=;
 b=Jgbtoy12uZd+rJVXbV5Z6MwOvVmZn0blVCd3vqTyM2Qemn1hFT/yQin3xFyR5w1l
 CV7vxKx5BVZ6eejj4lqcV632p++C6MdhxyvMVTrublyKVXn4p5ScSQf5sxtlrmq6DcD
 RYxHuKOr9gfsRJENGoEBGnT2Wwdw/VEbPZ+g6Y1c=
Received: by mx.zohomail.com with SMTPS id 1780917568590800.9724640375255;
 Mon, 8 Jun 2026 04:19:28 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 08 Jun 2026 13:19:08 +0200
Subject: [PATCH 2/2] drm/display: hdmi: Round odd max_bpc down to even numbers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-hdmi-max-bpc-fix-v1-2-6e8dcebc7274@collabora.com>
References: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
In-Reply-To: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

The HDMI state helpers will count down from the max bpc to 8 in steps of
2, trying each value as a possible output bpc. This goes awry if max bpc
is restricted by userspace to an odd number with the "max bpc" connector
property.

Prevent this, without introducing any additional bpc format trial steps,
by simply subtracting max_bpc modulo 2 from max_bpc as the starting
point for the for loop.

Additionally, add a KUnit test to validate the handling of this.

Fixes: 26ff1c38fc29 ("drm/connector: hdmi: Compute bpc and format automatically")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  2 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 71 ++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 8303475ec021..9fbf88054ad8 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -648,7 +648,7 @@ hdmi_compute_format_bpc(const struct drm_connector *connector,
 	unsigned int bpc;
 	int ret;
 
-	for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
+	for (bpc = max_bpc - max_bpc % 2; bpc >= 8; bpc -= 2) {
 		ret = hdmi_try_format_bpc(connector, conn_state, mode, bpc, fmt);
 		if (!ret)
 			continue;
diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index e89e1af7a811..dd1043ef8804 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -1327,6 +1327,76 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+/*
+ * Test that given a request for an odd-numbered max bpc, the HDMI state helpers
+ * will succeed an atomic check but round down to the even-numbered bpc on the
+ * output, while leaving the requested value alone.
+ */
+static void drm_test_check_odd_max_bpc(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_modeset_acquire_ctx ctx;
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
+
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
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
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	conn_state->max_requested_bpc = 11;
+
+	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_conn_state;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_new_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_bpc, 10);
+	KUNIT_EXPECT_EQ(test, conn_state->max_requested_bpc, 11);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 /*
  * Test that if we filter a rate through our hook, it's indeed rejected
  * by the whole atomic_check logic.
@@ -2227,6 +2297,7 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_8bpc),
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_10bpc),
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_12bpc),
+	KUNIT_CASE(drm_test_check_odd_max_bpc),
 	/*
 	 * TODO: We should have tests to check that a change in the
 	 * format triggers a CRTC mode change just like we do for the

-- 
2.54.0

