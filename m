Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7075AC624DD
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3434F10EE8F;
	Tue,  1 Sep 2026 18:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IkpTEUb6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA3610EE85
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288695;
 bh=cihigF4VnR53Ld2/oM7OfeYgsP2+G6E2xvoDukRhIWk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IkpTEUb6bF0P7+vfKu6YN5lXXxM1DUVGzB+Yuadf0Kr5klRniY5bc/k97wSFu5aLF
 5uXVeEItUgakdpz+080O6B84iGh9YnK9IVrMYv3+Gh0E2KC3bxctEQMSXqxg9+ZTLH
 x795Dco/PhLNHuz9pJPJt1cSRiPlYy+FhRwJfBdcHBxyCd7oZrlsSpV952u5SFHNS+
 j1XQo0Qi8YM7ImZYEle6mfBHBA0rx9PEwpOmTRyyqIVGKa8aWtAi8+UPdzvZ0lGccx
 +G+QN5aAxOga9DfwngAr+NuJS/GbErWNh6wZAkRNDRrqquvYILeztOWG87qG9Cc+ne
 gy3IXM928jFsw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B59717E3CAB;
 Tue, 01 Sep 2026 20:51:35 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:38 +0300
Subject: [PATCH v11 74/74] drm/tests: hdmi: Add SPD InfoFrame
 vendor/product coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-74-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org
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

The vendor and product strings provided through struct
drm_connector_hdmi_funcs end up in the SPD InfoFrame, whose fields are
defined by the HDMI specification as fixed-size: 8 bytes for the vendor
name and 16 bytes for the product description, padded with zeros and
left without any trailing NUL when a name spans the whole field.

Nothing exercises that so far, since the SPD InfoFrame is only generated
for connectors implementing the related hooks, which none of the
existing test funcs provides.

Add a connector variant supplying those hooks, along with parametrized
tests covering both the padded and the exact length cases.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 164 ++++++++++++++++++++-
 1 file changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 68b442c32a2a..415d82e75eaa 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -3205,6 +3205,167 @@ static void drm_test_check_infoframes(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+struct drm_hdmi_spd_infoframe_test {
+	const char *name;
+	const char *vendor;
+	const char *product;
+	unsigned char expected_vendor[HDMI_SPD_INFOFRAME_VENDOR_LEN];
+	unsigned char expected_product[HDMI_SPD_INFOFRAME_PRODUCT_LEN];
+};
+
+static const struct drm_hdmi_spd_infoframe_test drm_hdmi_spd_infoframe_tests[] = {
+	{
+		.name = "shorter-than-field",
+		.vendor = "Vend",
+		.product = "Prod",
+		.expected_vendor = { 'V', 'e', 'n', 'd' },
+		.expected_product = { 'P', 'r', 'o', 'd' },
+	},
+	{
+		.name = "whole-field",
+		.vendor = "VendorVe",
+		.product = "ProductProductPr",
+		.expected_vendor = {
+			'V', 'e', 'n', 'd', 'o', 'r', 'V', 'e',
+		},
+		.expected_product = {
+			'P', 'r', 'o', 'd', 'u', 'c', 't',
+			'P', 'r', 'o', 'd', 'u', 'c', 't',
+			'P', 'r',
+		},
+	},
+};
+
+static void drm_hdmi_spd_infoframe_desc(const struct drm_hdmi_spd_infoframe_test *t,
+					char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(drm_hdmi_spd_infoframe, drm_hdmi_spd_infoframe_tests,
+		  drm_hdmi_spd_infoframe_desc);
+
+/*
+ * The SPD InfoFrame is only generated for connectors implementing the
+ * related hooks, hence the SPD tests cannot rely on the plain dummy funcs.
+ */
+static const struct drm_connector_hdmi_funcs dummy_connector_hdmi_spd_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_4,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
+	.avi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+	.spd = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+	.hdmi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+};
+
+/*
+ * Test that the vendor and product names end up in the SPD InfoFrame padded
+ * with zeros, and without any trailing NUL when spanning the whole field.
+ */
+static void drm_test_check_spd_infoframe(struct kunit *test)
+{
+	const struct drm_hdmi_spd_infoframe_test *param = test->param_value;
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_spd_funcs;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_display_mode *preferred;
+	struct hdmi_spd_infoframe *frame;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	hdmi_funcs.vendor = param->vendor;
+	hdmi_funcs.product = param->product;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&hdmi_funcs,
+				test_edid_hdmi_1080p_rgb_max_200mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	conn = &priv->connector;
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+retry_conn_enable:
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
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
+	crtc_state->mode_changed = true;
+
+	ret = drm_atomic_check_only(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_crtc_state;
+	}
+	KUNIT_ASSERT_EQ(test, ret, 0);
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
+	conn_state = conn->state;
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+	KUNIT_ASSERT_TRUE(test, conn_state->hdmi.infoframes.spd.set);
+
+	frame = &conn_state->hdmi.infoframes.spd.data.spd;
+
+	KUNIT_EXPECT_MEMEQ(test, frame->vendor, param->expected_vendor,
+			   sizeof(frame->vendor));
+	KUNIT_EXPECT_MEMEQ(test, frame->product, param->expected_product,
+			   sizeof(frame->product));
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 static int reject_infoframe_write_infoframe(struct drm_connector *connector,
 					    const u8 *buffer, size_t len)
 {
@@ -3723,9 +3884,10 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
-
 static struct kunit_case drm_atomic_helper_connector_hdmi_infoframes_tests[] = {
 	KUNIT_CASE(drm_test_check_infoframes),
+	KUNIT_CASE_PARAM(drm_test_check_spd_infoframe,
+			 drm_hdmi_spd_infoframe_gen_params),
 	KUNIT_CASE(drm_test_check_reject_avi_infoframe),
 	KUNIT_CASE(drm_test_check_reject_hdr_infoframe_bpc_8),
 	KUNIT_CASE(drm_test_check_reject_hdr_infoframe_bpc_10),

-- 
2.55.0

