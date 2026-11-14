Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C8606A333
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hrxwIO4j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7E710E6F2;
	Sat, 14 Nov 2026 18:04:47 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19FCD10F092
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679470;
 bh=GZ9U5z/SysjEyMtbn5QF+NDNHaZaDxjfik51M+8KLu0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hrxwIO4jNAzjMve8Y9N7wUO8kkXf4ehDXzgqmP4khTDF2CH2Xpcm3JNXFr2Dg7hek
 n+171fUP+4RcR5Rt+OsOYNYUAOzD0jB2uldFNwVHPZofldMhYE3/gEEio2Ym8xWCCK
 423rUkbWNwTdC8DfnAwaCFEv8BnxgShfagSk6+DSR+4hDDEwLCW3HOgWF8faJCYmFN
 7uGOigvoZ2WY7VBNq9A6Gyy9z+nLi24mQ70dkbHdYWLDg25zUQr0pk/UZL1/+up8II
 9xgTUZQy58NxHiAOxBlXbiCfKQSKQv5KWRBnS/UFrJdVk9ecmKG70chLLRPpMUVKxq
 UFNGI71uPFurA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B70AB17E3BEA;
 Sat, 14 Nov 2026 19:04:30 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:42 +0200
Subject: [PATCH 18/25] drm/tests: hdmi: Cover mode validation against
 connector max_tmds_char_rate
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-18-20e8a33a2286@collabora.com>
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

Test the hdmi_clock_valid() logic that rejects modes whose TMDS
character rate exceeds connector->hdmi.max_tmds_char_rate.

Exercise both an explicit limit set through drm_connector_hdmi_funcs'
supported_tmds_char_rate and the limit inferred from supported_hdmi_ver.

Also verify that a driver hook can further restrict the connector limit.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 116 +++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index f1bdd197429c..d94ec8680a1e 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -190,6 +190,32 @@ static const struct drm_connector_hdmi_funcs reject_100mhz_connector_hdmi_funcs
 	},
 };
 
+static enum drm_mode_status
+accept_any_connector_tmds_char_rate_valid(const struct drm_connector *connector,
+					  const struct drm_display_mode *mode,
+					  unsigned long long tmds_rate)
+{
+	return MODE_OK;
+}
+
+static const struct drm_connector_hdmi_funcs reject_over_165mhz_connector_hdmi_funcs = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_1_3,
+	.supported_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
+	.tmds_char_rate_valid = accept_any_connector_tmds_char_rate_valid,
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
 static int dummy_connector_get_modes(struct drm_connector *connector)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv =
@@ -2762,6 +2788,93 @@ static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, preferred->clock, 25200);
 }
 
+/*
+ * Test that the max_tmds_char_rate inferred from supported_hdmi_ver is applied
+ * as a mode-filtering limit: with an HDMI 1.3 connector and no driver hook,
+ * drm_hdmi_connector_mode_valid() will reject modes whose TMDS character rate
+ * exceeds 340 MHz, even though the sink itself advertises a higher limit
+ * (600 MHz).
+ */
+static void
+drm_test_check_mode_valid_reject_inferred_max_tmds_char_rate(struct kunit *test)
+{
+	struct drm_connector_hdmi_funcs hdmi_funcs = dummy_connector_hdmi_funcs;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+
+	hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_3;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test, &hdmi_funcs,
+					test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	KUNIT_ASSERT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 2560);
+	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 1600);
+	KUNIT_EXPECT_EQ(test, preferred->clock, 268500);
+}
+
+/*
+ * Test that a connector-provided max_tmds_char_rate limit (165 MHz) takes
+ * precedence over a permissive .tmds_char_rate_valid() driver hook and
+ * drm_hdmi_connector_mode_valid() will reject modes whose computed TMDS
+ * character rate exceeds the connector limit.
+ */
+static void
+drm_test_check_mode_valid_connector_max_tmds_char_rate_precedes_driver_hook(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+					&reject_over_165mhz_connector_hdmi_funcs,
+					test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	KUNIT_ASSERT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 2048);
+	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 1152);
+	KUNIT_EXPECT_EQ(test, preferred->clock, 162000);
+}
+
+/*
+ * Test that a connector-provided max_tmds_char_rate (165 MHz) can be further
+ * limited by a more restrictive (100 MHz) .tmds_char_rate_valid() driver hook
+ * and drm_hdmi_connector_mode_valid() will reject modes whose computed TMDS
+ * character rate exceeds the hook limit.
+ */
+static void
+drm_test_check_mode_valid_driver_hook_limits_connector_max_tmds_char_rate(struct kunit *test)
+{
+	struct drm_connector_hdmi_funcs hdmi_funcs = reject_100mhz_connector_hdmi_funcs;
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_display_mode *preferred;
+
+	hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_3;
+	hdmi_funcs.supported_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test, &hdmi_funcs,
+					test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	KUNIT_ASSERT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ);
+
+	preferred = find_preferred_mode(&priv->connector);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 1440);
+	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 900);
+	KUNIT_EXPECT_EQ(test, preferred->clock, 88750);
+}
+
 /*
  * Test that drm_hdmi_connector_mode_valid() will accept modes that require a
  * 4:2:0 chroma subsampling, even if said mode would violate maximum clock
@@ -2852,6 +2965,9 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_mode_valid_tests[] = {
 	KUNIT_CASE(drm_test_check_mode_valid_reject),
 	KUNIT_CASE(drm_test_check_mode_valid_reject_rate),
 	KUNIT_CASE(drm_test_check_mode_valid_reject_max_clock),
+	KUNIT_CASE(drm_test_check_mode_valid_reject_inferred_max_tmds_char_rate),
+	KUNIT_CASE(drm_test_check_mode_valid_connector_max_tmds_char_rate_precedes_driver_hook),
+	KUNIT_CASE(drm_test_check_mode_valid_driver_hook_limits_connector_max_tmds_char_rate),
 	KUNIT_CASE(drm_test_check_mode_valid_yuv420_only_max_clock),
 	KUNIT_CASE(drm_test_check_mode_valid_reject_yuv420_only_connector),
 	KUNIT_CASE(drm_test_check_mode_valid_accept_yuv420_also_connector_rgb),

-- 
2.56.0

