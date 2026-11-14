Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F706606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=HMnp7Avb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E80A810F0BA;
	Sat, 14 Nov 2026 18:05:45 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6519B10E6F2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679473;
 bh=e8ipKJTJWGJG9WOiOgTygD1raxOORRHRTg7YV8KMdIY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HMnp7AvbJ1Yk8qUJQ653lWGUj8d2Qk7H1x5t4+FbLTUBlVclBdRvRFQrPYxGNPKS4
 AToJHrITdBOmExiiuZ4wq/FvG9bE0tjm2XXCGv9lS+aHuvOWWYnMZi8Wv1mKm1JGPA
 FSsqf8604AGdvHNxY3X5SjDZfsK0uZ2ZjcNwnY2AWTzEwfwyMRNWmil2KTUmE7prm0
 e1Sygdh6xNtAl6+7wgP21d+i9xwdgZn6tMCxn8fNs3ImWFRIkJvMuhlrU+qYGAQa7a
 t4MNVud+sz+8WWxGf1lkDUSwCWm7FjhlEzBVrq5Bw+/Znb8d8ely6Q/HR6VzpSnVou
 soDqrXe9f4Dog==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0758417E15E8;
 Sat, 14 Nov 2026 19:04:32 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:45 +0200
Subject: [PATCH 21/25] drm/tests: hdmi: Add HDMI 2.0 scrambling helpers
 coverage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-21-20e8a33a2286@collabora.com>
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

In order to provide test coverage for the scrambling helpers, i.e.
drm_hdmi_mode_needs_scrambling() and
drm_connector_hdmi_{enable,disable}_scrambling(), as well as the SCDC
status monitoring work, provide a fake DDC adapter modelling the SCDC
register map of a sink, and let __connector_hdmi_init() optionally hook
it up to the connector, so that the sink side of the scrambling setup
can be verified.

Add tests to make sure that:

- drm_hdmi_mode_needs_scrambling() accounts for the mode, bpc and output
  format when comparing the TMDS character rate against 340 MHz
- enabling scrambling configures both the sink and the source, and
  advertises the source SCDC version, while disabling reverts that
- enabling scrambling for a mode not needing it clears any stale
  scrambling setup on the sink side, without involving the source
- enabling scrambling fails without touching the sink when the source or
  the sink lack support, or when there is no DDC adapter
- DDC and source-side failures are reported and rolled back
- disabling scrambling is a no-op unless enabled, and copes with
  scrambler_enabled being forced by the driver
- the monitoring work restores the sink setup when lost, stops once the
  sink reports scrambling as active, and never touches the DDC bus after
  the connector got unregistered

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 700 ++++++++++++++++++++-
 1 file changed, 697 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 294be8f4a307..46654d8fa45c 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -4,6 +4,9 @@
  * Kunit test for drm_hdmi_state_helper functions
  */
 
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_atomic_uapi.h>
@@ -19,6 +22,7 @@
 
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
+#include <drm/display/drm_scdc_helper.h>
 
 #include "../drm_crtc_internal.h"
 
@@ -41,6 +45,16 @@ struct drm_atomic_helper_connector_hdmi_priv {
 
 	u8 spd_infoframe[HDMI_INFOFRAME_SIZE(SPD)];
 	size_t spd_infoframe_len;
+
+	/* Fake DDC adapter exposing an SCDC register map */
+	struct i2c_adapter ddc;
+	u8 scdc_regs[256];
+	unsigned int scdc_xfer_count;
+	int scdc_xfer_err;
+
+	unsigned int scrambler_enable_count;
+	unsigned int scrambler_disable_count;
+	int scrambler_enable_ret;
 };
 
 #define connector_to_priv(c) \
@@ -310,13 +324,87 @@ static const struct drm_encoder_helper_funcs test_encoder_helper_funcs = {
 	.atomic_enable = test_encoder_atomic_enable,
 };
 
+#define TEST_SCDC_I2C_ADDR	0x54
+
+/*
+ * Minimal SCDC sink model: register reads are expected as a one byte offset
+ * write followed by a read, and register writes as a single message carrying
+ * the offset followed by the data, matching drm_scdc_{read,write}().
+ */
+static int fake_scdc_xfer(struct i2c_adapter *adapter,
+			  struct i2c_msg *msgs, int num)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv =
+		i2c_get_adapdata(adapter);
+	unsigned int offset;
+
+	priv->scdc_xfer_count++;
+
+	if (priv->scdc_xfer_err)
+		return priv->scdc_xfer_err;
+
+	if (msgs[0].addr != TEST_SCDC_I2C_ADDR || msgs[0].flags & I2C_M_RD ||
+	    !msgs[0].len)
+		return -ENXIO;
+
+	offset = msgs[0].buf[0];
+
+	if (num == 2 && msgs[0].len == 1 &&
+	    msgs[1].addr == TEST_SCDC_I2C_ADDR && msgs[1].flags & I2C_M_RD) {
+		if (offset + msgs[1].len > sizeof(priv->scdc_regs))
+			return -EINVAL;
+
+		memcpy(msgs[1].buf, &priv->scdc_regs[offset], msgs[1].len);
+		return num;
+	}
+
+	if (num == 1) {
+		if (offset + msgs[0].len - 1 > sizeof(priv->scdc_regs))
+			return -EINVAL;
+
+		memcpy(&priv->scdc_regs[offset], &msgs[0].buf[1], msgs[0].len - 1);
+		return num;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static u32 fake_scdc_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C;
+}
+
+static const struct i2c_algorithm fake_scdc_algorithm = {
+	.master_xfer = fake_scdc_xfer,
+	.functionality = fake_scdc_func,
+};
+
+static void i2c_del_adapter_wrapper(void *ptr)
+{
+	i2c_del_adapter(ptr);
+}
+
+/*
+ * The SCDC monitoring work may still be pending when a test completes, make
+ * sure it is gone before the DDC adapter gets removed.
+ */
+static void cancel_scdc_work_wrapper(void *ptr)
+{
+	struct drm_connector *connector = ptr;
+
+	if (connector->hdmi.scdc_work_initialized)
+		cancel_delayed_work_sync(&connector->hdmi.scdc_work);
+}
+
 static
 struct drm_atomic_helper_connector_hdmi_priv *
 __connector_hdmi_init(struct kunit *test,
 		      const struct drm_connector_hdmi_funcs *hdmi_funcs,
-		      const void *edid_data, size_t edid_len)
+		      const void *edid_data, size_t edid_len,
+		      bool with_scdc)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct i2c_adapter *ddc = NULL;
 	struct drm_connector *conn;
 	struct drm_encoder *enc;
 	struct drm_device *drm;
@@ -356,14 +444,37 @@ __connector_hdmi_init(struct kunit *test,
 	conn->ycbcr_420_allowed = !!(hdmi_funcs->supported_formats &
 				     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
 
+	if (with_scdc) {
+		strscpy(priv->ddc.name, "fake-scdc-ddc", sizeof(priv->ddc.name));
+		priv->ddc.owner = THIS_MODULE;
+		priv->ddc.algo = &fake_scdc_algorithm;
+		priv->ddc.dev.parent = dev;
+		i2c_set_adapdata(&priv->ddc, priv);
+
+		ret = i2c_add_adapter(&priv->ddc);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		ret = kunit_add_action_or_reset(test, i2c_del_adapter_wrapper,
+						&priv->ddc);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		ddc = &priv->ddc;
+	}
+
 	priv->hdmi_funcs = *hdmi_funcs;
 	ret = drmm_connector_hdmi_init(drm, conn,
 				       &dummy_connector_funcs,
 				       &priv->hdmi_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       NULL);
+				       ddc);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
+	if (with_scdc) {
+		ret = kunit_add_action_or_reset(test, cancel_scdc_work_wrapper,
+						conn);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+	}
+
 	drm_connector_helper_add(conn, &dummy_connector_helper_funcs);
 	drm_connector_attach_encoder(conn, enc);
 
@@ -378,7 +489,10 @@ __connector_hdmi_init(struct kunit *test,
 }
 
 #define drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test, funcs, edid)	\
-	__connector_hdmi_init(test, funcs, edid, ARRAY_SIZE(edid))
+	__connector_hdmi_init(test, funcs, edid, ARRAY_SIZE(edid), false)
+
+#define drm_kunit_helper_connector_hdmi_init_with_scdc(test, funcs, edid)	\
+	__connector_hdmi_init(test, funcs, edid, ARRAY_SIZE(edid), true)
 
 static
 struct drm_atomic_helper_connector_hdmi_priv *
@@ -4097,13 +4211,593 @@ static struct kunit_suite drm_atomic_helper_connector_hdmi_infoframes_test_suite
 	.test_cases	= drm_atomic_helper_connector_hdmi_infoframes_tests,
 };
 
+struct drm_hdmi_mode_needs_scrambling_test {
+	const char *desc;
+	u8 vic;
+	unsigned int bpc;
+	enum drm_output_color_format fmt;
+	bool expected;
+};
+
+static const struct drm_hdmi_mode_needs_scrambling_test
+drm_hdmi_mode_needs_scrambling_params[] = {
+	{ "1080p60 RGB 8bpc",     16,  8, DRM_OUTPUT_COLOR_FORMAT_RGB444,   false },
+	{ "2160p30 RGB 8bpc",     95,  8, DRM_OUTPUT_COLOR_FORMAT_RGB444,   false },
+	{ "2160p30 RGB 10bpc",    95, 10, DRM_OUTPUT_COLOR_FORMAT_RGB444,   true },
+	{ "2160p30 YUV422 12bpc", 95, 12, DRM_OUTPUT_COLOR_FORMAT_YCBCR422, false },
+	{ "2160p60 RGB 8bpc",     97,  8, DRM_OUTPUT_COLOR_FORMAT_RGB444,   true },
+	{ "2160p60 YUV420 8bpc",  97,  8, DRM_OUTPUT_COLOR_FORMAT_YCBCR420, false },
+	{ "2160p60 YUV420 12bpc", 97, 12, DRM_OUTPUT_COLOR_FORMAT_YCBCR420, true },
+};
+
+static void
+drm_hdmi_mode_needs_scrambling_desc(const struct drm_hdmi_mode_needs_scrambling_test *t,
+				    char *desc)
+{
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(drm_hdmi_mode_needs_scrambling, drm_hdmi_mode_needs_scrambling_params,
+		  drm_hdmi_mode_needs_scrambling_desc);
+
+/*
+ * Test that drm_hdmi_mode_needs_scrambling() requires scrambling only when the
+ * TMDS character rate resulting from the mode, bpc and output format exceeds
+ * 340 MHz.
+ */
+static void drm_test_hdmi_mode_needs_scrambling(struct kunit *test)
+{
+	const struct drm_hdmi_mode_needs_scrambling_test *params = test->param_value;
+	struct drm_display_mode *mode;
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0,
+						  DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, params->vic);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	KUNIT_EXPECT_EQ(test,
+			drm_hdmi_mode_needs_scrambling(mode, params->bpc, params->fmt),
+			params->expected);
+}
+
+static int count_scrambler_enable(struct drm_connector *connector)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv =
+		connector_to_priv(connector);
+
+	priv->scrambler_enable_count++;
+
+	return priv->scrambler_enable_ret;
+}
+
+static int count_scrambler_disable(struct drm_connector *connector)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv =
+		connector_to_priv(connector);
+
+	priv->scrambler_disable_count++;
+
+	return 0;
+}
+
+static const struct drm_connector_hdmi_funcs scdc_connector_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_2_0,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
+	.scrambler_enable = count_scrambler_enable,
+	.scrambler_disable = count_scrambler_disable,
+	.avi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+	.hdmi = {
+		.clear_infoframe = accept_infoframe_clear_infoframe,
+		.write_infoframe = accept_infoframe_write_infoframe,
+	},
+};
+
+#define SCDC_TMDS_CONFIG_SCRAMBLED \
+	(SCDC_SCRAMBLING_ENABLE | SCDC_TMDS_BIT_CLOCK_RATIO_BY_40)
+
+/*
+ * drm_connector_hdmi_enable_scrambling() arms the SCDC monitoring work with
+ * a delay. Cancel it, so that the test alone controls when the work runs,
+ * whether or not it has already done so. As the fake sink never reports
+ * scrambling as active, a past run leaves the sink setup unchanged.
+ */
+static void scdc_test_stop_work(struct drm_connector *connector)
+{
+	cancel_delayed_work_sync(&connector->hdmi.scdc_work);
+}
+
+static void scdc_test_run_work(struct drm_connector *connector)
+{
+	struct work_struct *work = &connector->hdmi.scdc_work.work;
+
+	work->func(work);
+}
+
+/*
+ * Test that enabling scrambling configures both the sink, through SCDC, and
+ * the source, advertises the source SCDC version and starts monitoring the
+ * sink status, while disabling it reverts all of that.
+ */
+static void drm_test_hdmi_scrambling_enable_disable(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->hdmi.scrambler_needed = true;
+
+	priv->scdc_regs[SCDC_SINK_VERSION] = 1;
+
+	ret = drm_connector_hdmi_enable_scrambling(conn, conn_state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->scdc_regs[SCDC_SOURCE_VERSION], 1);
+	KUNIT_EXPECT_EQ(test, priv->scdc_regs[SCDC_TMDS_CONFIG],
+			SCDC_TMDS_CONFIG_SCRAMBLED);
+	KUNIT_EXPECT_EQ(test, priv->scrambler_enable_count, 1);
+	KUNIT_EXPECT_EQ(test, priv->scrambler_disable_count, 0);
+	KUNIT_EXPECT_TRUE(test, conn->hdmi.scrambler_enabled);
+	/* The work may be executing already, i.e. not pending */
+	KUNIT_EXPECT_TRUE(test, work_busy(&conn->hdmi.scdc_work.work));
+
+	ret = drm_connector_hdmi_disable_scrambling(conn);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->scdc_regs[SCDC_TMDS_CONFIG], 0);
+	KUNIT_EXPECT_EQ(test, priv->scrambler_enable_count, 1);
+	KUNIT_EXPECT_EQ(test, priv->scrambler_disable_count, 1);
+	KUNIT_EXPECT_FALSE(test, conn->hdmi.scrambler_enabled);
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&conn->hdmi.scdc_work));
+}
+
+/*
+ * Test that enabling scrambling for a mode that doesn't need it leaves the
+ * source alone, but clears any stale scrambling setup on the sink side.
+ */
+static void drm_test_hdmi_scrambling_enable_not_needed(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->hdmi.scrambler_needed = false;
+
+	priv->scdc_regs[SCDC_TMDS_CONFIG] = SCDC_TMDS_CONFIG_SCRAMBLED;
+
+	ret = drm_connector_hdmi_enable_scrambling(conn, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->scdc_regs[SCDC_TMDS_CONFIG], 0);
+	KUNIT_EXPECT_EQ(test, priv->scrambler_enable_count, 0);
+	KUNIT_EXPECT_FALSE(test, conn->hdmi.scrambler_enabled);
+	KUNIT_EXPECT_FALSE(test, conn->hdmi.scdc_work_initialized);
+}
+
+/*
+ * Test that enabling scrambling fails without touching the sink when the
+ * source doesn't support it.
+ */
+static void drm_test_hdmi_scrambling_enable_source_unsupported(struct kunit *test)
+{
+	struct drm_connector_hdmi_funcs hdmi_funcs = scdc_connector_hdmi_funcs;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	int ret;
+
+	hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_4;
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test, &hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->hdmi.scrambler_needed = true;
+
+	ret = drm_connector_hdmi_enable_scrambling(conn, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	KUNIT_EXPECT_EQ(test, priv->scdc_xfer_count, 0);
+	KUNIT_EXPECT_EQ(test, priv->scrambler_enable_count, 0);
+	KUNIT_EXPECT_FALSE(test, conn->hdmi.scrambler_enabled);
+}
+
+/*
+ * Test that enabling scrambling fails without touching the sink when the
+ * sink doesn't support it.
+ */
+static void drm_test_hdmi_scrambling_enable_sink_unsupported(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_FALSE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->hdmi.scrambler_needed = true;
+
+	ret = drm_connector_hdmi_enable_scrambling(conn, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	KUNIT_EXPECT_EQ(test, priv->scdc_xfer_count, 0);
+	KUNIT_EXPECT_EQ(test, priv->scrambler_enable_count, 0);
+	KUNIT_EXPECT_FALSE(test, conn->hdmi.scrambler_enabled);
+}
+
+/*
+ * Test that enabling scrambling fails on a connector without a DDC adapter,
+ * which is needed to configure the sink.
+ */
+static void drm_test_hdmi_scrambling_enable_no_ddc(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->hdmi.scrambler_needed = true;
+
+	ret = drm_connector_hdmi_enable_scrambling(conn, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	KUNIT_EXPECT_EQ(test, priv->scrambler_enable_count, 0);
+	KUNIT_EXPECT_FALSE(test, conn->hdmi.scrambler_enabled);
+}
+
+/*
+ * Test that a failure to configure the sink through SCDC is reported and the
+ * source is left alone.
+ */
+static void drm_test_hdmi_scrambling_enable_ddc_error(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->hdmi.scrambler_needed = true;
+
+	priv->scdc_xfer_err = -EIO;
+
+	ret = drm_connector_hdmi_enable_scrambling(conn, conn_state);
+	KUNIT_EXPECT_LT(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->scrambler_enable_count, 0);
+	KUNIT_EXPECT_FALSE(test, conn->hdmi.scrambler_enabled);
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&conn->hdmi.scdc_work));
+}
+
+/*
+ * Test that a failure to enable scrambling on the source side is reported,
+ * and the sink scrambling setup and status monitoring are rolled back.
+ */
+static void drm_test_hdmi_scrambling_enable_source_error(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->hdmi.scrambler_needed = true;
+
+	priv->scrambler_enable_ret = -EIO;
+
+	ret = drm_connector_hdmi_enable_scrambling(conn, conn_state);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+
+	KUNIT_EXPECT_EQ(test, priv->scrambler_enable_count, 1);
+	KUNIT_EXPECT_EQ(test, priv->scdc_regs[SCDC_TMDS_CONFIG], 0);
+	KUNIT_EXPECT_FALSE(test, conn->hdmi.scrambler_enabled);
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&conn->hdmi.scdc_work));
+}
+
+/*
+ * Test that disabling scrambling when it isn't enabled is a no-op.
+ */
+static void drm_test_hdmi_scrambling_disable_not_enabled(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	priv->scdc_regs[SCDC_TMDS_CONFIG] = SCDC_TMDS_CONFIG_SCRAMBLED;
+
+	ret = drm_connector_hdmi_disable_scrambling(conn);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->scdc_xfer_count, 0);
+	KUNIT_EXPECT_EQ(test, priv->scdc_regs[SCDC_TMDS_CONFIG],
+			SCDC_TMDS_CONFIG_SCRAMBLED);
+	KUNIT_EXPECT_EQ(test, priv->scrambler_disable_count, 0);
+}
+
+/*
+ * Test that disabling scrambling works when scrambler_enabled has been forced
+ * by the driver to get a disable at boot, i.e. without going through the
+ * enable path that sets up the status monitoring work.
+ */
+static void drm_test_hdmi_scrambling_disable_forced(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	priv->scdc_regs[SCDC_TMDS_CONFIG] = SCDC_TMDS_CONFIG_SCRAMBLED;
+	WRITE_ONCE(conn->hdmi.scrambler_enabled, true);
+
+	ret = drm_connector_hdmi_disable_scrambling(conn);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->scdc_regs[SCDC_TMDS_CONFIG], 0);
+	KUNIT_EXPECT_EQ(test, priv->scrambler_disable_count, 1);
+	KUNIT_EXPECT_FALSE(test, conn->hdmi.scrambler_enabled);
+	KUNIT_EXPECT_FALSE(test, conn->hdmi.scdc_work_initialized);
+}
+
+/*
+ * Test that the status monitoring work restores the sink scrambling setup
+ * when the sink reports scrambling as inactive, and keeps monitoring.
+ */
+static void drm_test_hdmi_scrambling_work_restore(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->hdmi.scrambler_needed = true;
+
+	ret = drm_connector_hdmi_enable_scrambling(conn, conn_state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	scdc_test_stop_work(conn);
+
+	/* Simulate the sink lost its SCDC setup */
+	priv->scdc_regs[SCDC_TMDS_CONFIG] = 0;
+	priv->scdc_regs[SCDC_SCRAMBLER_STATUS] = 0;
+
+	scdc_test_run_work(conn);
+
+	KUNIT_EXPECT_EQ(test, priv->scdc_regs[SCDC_TMDS_CONFIG],
+			SCDC_TMDS_CONFIG_SCRAMBLED);
+	KUNIT_EXPECT_EQ(test, priv->scrambler_enable_count, 1);
+	/* The re-armed work may be executing already, i.e. not pending */
+	KUNIT_EXPECT_TRUE(test, work_busy(&conn->hdmi.scdc_work.work));
+
+	ret = drm_connector_hdmi_disable_scrambling(conn);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/*
+ * Test that the status monitoring work leaves the sink alone and stops
+ * monitoring once the sink reports scrambling as active.
+ */
+static void drm_test_hdmi_scrambling_work_active(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	unsigned int xfer_count;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->hdmi.scrambler_needed = true;
+
+	ret = drm_connector_hdmi_enable_scrambling(conn, conn_state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	scdc_test_stop_work(conn);
+
+	priv->scdc_regs[SCDC_SCRAMBLER_STATUS] = SCDC_SCRAMBLING_STATUS;
+	xfer_count = priv->scdc_xfer_count;
+
+	scdc_test_run_work(conn);
+
+	/* Only the status register has been read */
+	KUNIT_EXPECT_EQ(test, priv->scdc_xfer_count, xfer_count + 1);
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&conn->hdmi.scdc_work));
+
+	ret = drm_connector_hdmi_disable_scrambling(conn);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/*
+ * Test that the status monitoring work never accesses the DDC bus once the
+ * connector got unregistered, as the adapter may already be gone.
+ */
+static void drm_test_hdmi_scrambling_work_unregistered(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *conn;
+	unsigned int xfer_count;
+	int ret;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_scdc(test,
+				&scdc_connector_hdmi_funcs,
+				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.supported);
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	conn_state->hdmi.scrambler_needed = true;
+
+	ret = drm_connector_hdmi_enable_scrambling(conn, conn_state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	scdc_test_stop_work(conn);
+
+	conn->registration_state = DRM_CONNECTOR_UNREGISTERED;
+	xfer_count = priv->scdc_xfer_count;
+
+	scdc_test_run_work(conn);
+
+	KUNIT_EXPECT_EQ(test, priv->scdc_xfer_count, xfer_count);
+	KUNIT_EXPECT_FALSE(test, delayed_work_pending(&conn->hdmi.scdc_work));
+
+	conn->registration_state = DRM_CONNECTOR_INITIALIZING;
+
+	ret = drm_connector_hdmi_disable_scrambling(conn);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+static struct kunit_case drm_atomic_helper_connector_hdmi_scrambling_tests[] = {
+	KUNIT_CASE_PARAM(drm_test_hdmi_mode_needs_scrambling,
+			 drm_hdmi_mode_needs_scrambling_gen_params),
+	KUNIT_CASE(drm_test_hdmi_scrambling_enable_disable),
+	KUNIT_CASE(drm_test_hdmi_scrambling_enable_not_needed),
+	KUNIT_CASE(drm_test_hdmi_scrambling_enable_source_unsupported),
+	KUNIT_CASE(drm_test_hdmi_scrambling_enable_sink_unsupported),
+	KUNIT_CASE(drm_test_hdmi_scrambling_enable_no_ddc),
+	KUNIT_CASE(drm_test_hdmi_scrambling_enable_ddc_error),
+	KUNIT_CASE(drm_test_hdmi_scrambling_enable_source_error),
+	KUNIT_CASE(drm_test_hdmi_scrambling_disable_not_enabled),
+	KUNIT_CASE(drm_test_hdmi_scrambling_disable_forced),
+	KUNIT_CASE(drm_test_hdmi_scrambling_work_restore),
+	KUNIT_CASE(drm_test_hdmi_scrambling_work_active),
+	KUNIT_CASE(drm_test_hdmi_scrambling_work_unregistered),
+	{ }
+};
+
+static struct kunit_suite drm_atomic_helper_connector_hdmi_scrambling_test_suite = {
+	.name		= "drm_atomic_helper_connector_hdmi_scrambling",
+	.test_cases	= drm_atomic_helper_connector_hdmi_scrambling_tests,
+};
+
 kunit_test_suites(
 	&drm_atomic_helper_connector_hdmi_check_test_suite,
 	&drm_atomic_helper_connector_hdmi_reset_test_suite,
 	&drm_atomic_helper_connector_hdmi_mode_valid_test_suite,
 	&drm_atomic_helper_connector_hdmi_infoframes_test_suite,
+	&drm_atomic_helper_connector_hdmi_scrambling_test_suite,
 );
 
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
+MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@collabora.com>");
 MODULE_DESCRIPTION("Kunit test for drm_hdmi_state_helper functions");
 MODULE_LICENSE("GPL");

-- 
2.56.0

