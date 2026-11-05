Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648160707B1
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ineubcq6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E49B112856;
	Thu,  5 Nov 2026 15:55:39 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C88311290E;
 Thu,  5 Nov 2026 15:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793894123; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kf31MRyW7L2Pc0Iz8CugK41cjnyU0E89zIQ+WlO9Oa1C7EZRse5PbPQ88k+Cy/JPKnbqXmQg4j5a/LjK8uefsxvC7aJTKdJWe/Pi/ajPOvqxnA0L9TprHWqETXCl1ySAHbsmYhQ6+obzS92Nhfy3GPxzsa2lVrO7X+v/Oy9dgx0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793894123;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=k7aC2DLgVXmwj4L3M+AhqzHnHGRutw5CQW3KARyJJWU=; 
 b=G3PzGlG9ZPmGF5eBq1ebh0BfE4fZYnLUKtOpHbSlAUotV4Mqi6BNjvwx3SY5/TrP4xXO60+TEjlLn7uD4uLRQJx9vyfKI3QAZFhs8FrcXjABegXzadAAEKU/MzdBSknvDk7ahS40rvxfNDZAJcip//9QE3RFxALcqK+645VoPCk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=Ineubcq6VUldGDdkiT/4zgSGvl8XJCNmxs9BP2ovDs9ZJdfwpK0/K7zdS2oZxb+zXednXJXkwL7+0dwA5guXeT1cjrLSRnL2fO5Z//bjhsFNlLqmUaTzkP4beR/oKrfAXIAB8SSwSm+jMnlKP7PU1LijaQRjw5Mq/h6gkG724nw=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=k7aC2DLgVXmwj4L3M+AhqzHnHGRutw5CQW3KARyJJWU=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17938941227261011.6961433029587; 
 Thu, 5 Nov 2026 07:55:22 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:18 +0100
Subject: [PATCH v2 27/27] drm/tests: hdmi: Add tests for
 vrr_display_{min,max} properties
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-27-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
In-Reply-To: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Attach the vrr_display_min and vrr_display_max properties to the KUnit
HDMI state helper test connector, and add two simple tests to verify the
introduced drm_connector_hdmi_update_vrr_limits() helper sets the
properties right depending on EDID.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 4c7e563ca51d..7bd06b65d241 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -308,6 +308,9 @@ __connector_hdmi_init(struct kunit *test,
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	conn->hdmi.qms_supported = true;
 
+	ret = drm_connector_attach_vrr_display_limits_properties(conn);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	drm_mode_config_reset(drm);
 
 	if (edid_data && edid_len) {
@@ -3676,6 +3679,88 @@ static void drm_test_check_hdmi_vrr_flush_vsync(struct kunit *test)
 			crtc_state->vrr_state.max_vtotal);
 }
 
+/*
+ * Check that on a VRR-capable sink, the HDMI VRR limits helper sets the
+ * display_min/display_max connector properties to the right values.
+ */
+static void drm_test_check_hdmi_vrr_display_limits(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	u64 disp_min, disp_max;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_vrr);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_cap.supported);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	ret = drm_connector_hdmi_update_vrr_limits(conn, preferred);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_object_property_get_value(&conn->base, conn->vrr_display_min_property,
+					    &disp_min);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = drm_object_property_get_value(&conn->base, conn->vrr_display_max_property,
+					    &disp_max);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, disp_min, 30);
+	KUNIT_EXPECT_EQ(test, disp_max, 120);
+}
+
+/*
+ * Check that on a non-VRR-capable sink, the HDMI VRR limits helper sets the
+ * display_min/display_max connector properties to 0.
+ */
+static void drm_test_check_hdmi_vrr_display_limits_zero(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	u64 disp_min, disp_max;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+				8,
+				&dummy_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+	KUNIT_ASSERT_FALSE(test, conn->display_info.hdmi.vrr_cap.supported);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	ret = drm_connector_hdmi_update_vrr_limits(conn, preferred);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_object_property_get_value(&conn->base, conn->vrr_display_min_property,
+					    &disp_min);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = drm_object_property_get_value(&conn->base, conn->vrr_display_max_property,
+					    &disp_max);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, disp_min, 0);
+	KUNIT_EXPECT_EQ(test, disp_max, 0);
+}
+
 /*
  * Check that on a VRR-capable sink with VRR enabled and a fixed target rate
  * set, an atomic commit works, and the derived vtotals are as expected.
@@ -4622,6 +4707,8 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_vrr_tests[] = {
 	KUNIT_CASE(drm_test_check_hdmi_vrr),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_sink_fail),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_flush_vsync),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_display_limits),
+	KUNIT_CASE(drm_test_check_hdmi_vrr_display_limits_zero),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate),
 	KUNIT_CASE(drm_test_check_hdmi_vrr_fixed_rate_flush_vsync),
 	KUNIT_CASE_PARAM(drm_test_check_hdmi_vrr_target_rate_fail,

-- 
2.56.0

