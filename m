Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EF6606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=d6BWzGxy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0936A10F091;
	Sat, 14 Nov 2026 18:04:47 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABB910F091
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679472;
 bh=27/R3zwTOahXNB477OaTEOZ6QcZZkQ5UURFGh0TKeDI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=d6BWzGxyZU6nqkdYOp001+yt/vzPdbIxB5yHTuV3ZKs91qXe0TiF6m2BT3lX3JpfJ
 UfubobQ8nEn+9zE4W1fxD6mKbO2Sf/tYSQhK5CpqouafXTkOlKBpPM6G9zAtxOhrRn
 GinW8ofE/mQ0aFakwiHklhtW0ySwquOgPYimMdEV7BlnVUNSWANmRLnBtsk633ijsG
 8XjqhRCdOuXbnpE4VO4sX/qu0rdvMPDEuK2wZ3ftI6v6WkWVWFeGJc+3cnjp66p7l6
 mnSR0tRqdSm9i4xvzXc1EusKsu3uE7Ssde3R/K8Xu0tgDLeZ8/rlNz3GzucP2ocKLI
 hE6lHW5PEnuxw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 42E2D17E3BF6;
 Sat, 14 Nov 2026 19:04:32 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:44 +0200
Subject: [PATCH 20/25] drm/tests: hdmi: Add SPD InfoFrame vendor/product
 coverage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-20-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vendor and product strings provided through struct
drm_connector_hdmi_funcs end up in the SPD InfoFrame, whose fields are
defined by the HDMI specification as fixed-size: 8 bytes for the vendor
name and 16 bytes for the product description, padded with zeros and
left without any trailing NUL when a name spans the whole field.

Add a connector variant implementing the SPD InfoFrame hooks, along with
parametrized tests covering both the padded and the exact length cases.
Check the names both in the connector state and in the packed InfoFrame
passed to the .write_infoframe() hook, which is captured for that
purpose.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 167 ++++++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index b98060b73742..294be8f4a307 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -38,6 +38,9 @@ struct drm_atomic_helper_connector_hdmi_priv {
 	size_t current_edid_len;
 
 	int hdmi_update_failures;
+
+	u8 spd_infoframe[HDMI_INFOFRAME_SIZE(SPD)];
+	size_t spd_infoframe_len;
 };
 
 #define connector_to_priv(c) \
@@ -3444,6 +3447,167 @@ static void drm_test_check_infoframes(struct kunit *test)
 	drm_modeset_acquire_fini(&ctx);
 }
 
+struct drm_hdmi_spd_infoframe_test {
+	const char *name;
+	const char *vendor;
+	const char *product;
+	char expected_vendor[HDMI_SPD_INFOFRAME_VENDOR_LEN];
+	char expected_product[HDMI_SPD_INFOFRAME_PRODUCT_LEN];
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
+static int capture_spd_write_infoframe(struct drm_connector *connector,
+				       const u8 *buffer, size_t len)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv =
+		connector_to_priv(connector);
+
+	if (len > sizeof(priv->spd_infoframe))
+		return -EINVAL;
+
+	memcpy(priv->spd_infoframe, buffer, len);
+	priv->spd_infoframe_len = len;
+
+	return 0;
+}
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
+	.hdmi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+	.spd = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = capture_spd_write_infoframe,
+	},
+};
+
+/*
+ * Test that the vendor and product names end up in the SPD InfoFrame padded
+ * with zeros, and without any trailing NUL when spanning the whole field,
+ * both in the connector state and in the packed buffer handed over to the
+ * driver.
+ */
+static void drm_test_check_spd_infoframe(struct kunit *test)
+{
+	const struct drm_hdmi_spd_infoframe_test *param = test->param_value;
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_spd_funcs;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_display_mode *preferred;
+	struct hdmi_spd_infoframe *frame;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	const u8 *payload;
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
+	drm_encoder_helper_add(&priv->encoder, &test_encoder_helper_funcs);
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
+	KUNIT_ASSERT_EQ(test, priv->hdmi_update_failures, 0);
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
+	KUNIT_ASSERT_EQ(test, priv->spd_infoframe_len, HDMI_INFOFRAME_SIZE(SPD));
+	KUNIT_EXPECT_EQ(test, priv->spd_infoframe[0], HDMI_INFOFRAME_TYPE_SPD);
+
+	payload = priv->spd_infoframe + HDMI_INFOFRAME_HEADER_SIZE;
+	KUNIT_EXPECT_MEMEQ(test, payload, param->expected_vendor,
+			   HDMI_SPD_INFOFRAME_VENDOR_LEN);
+	KUNIT_EXPECT_MEMEQ(test, payload + HDMI_SPD_INFOFRAME_VENDOR_LEN,
+			   param->expected_product,
+			   HDMI_SPD_INFOFRAME_PRODUCT_LEN);
+	KUNIT_EXPECT_EQ(test,
+			payload[HDMI_SPD_INFOFRAME_VENDOR_LEN +
+				HDMI_SPD_INFOFRAME_PRODUCT_LEN],
+			HDMI_SPD_SDI_PC);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+}
+
 static int reject_infoframe_write_infoframe(struct drm_connector *connector,
 					    const u8 *buffer, size_t len)
 {
@@ -3917,9 +4081,10 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
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
2.56.0

