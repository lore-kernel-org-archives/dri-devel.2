Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098D606A895
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P3bihgTu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2191310F0AB;
	Sat, 14 Nov 2026 18:04:48 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B83110F0BC
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679469;
 bh=rti5ipMK2h3EGihdfWLuNjjqPKtvAKFomDVqin/3CzM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=P3bihgTumiDhTllY46nBZNV85JgKWT4uVzVDEERx1plpA1z1AqfERRwXbLX1ZyU8f
 UdYZKttfQ9kq3gLKHTcd11RzHa61D8UuQIYncUhou7qDMjsuizHGHbdB/wJl5ZVS1F
 j6BaJusnsG4tZL8KRFcKZwxYNzgzoPMK5liBDSfVKddekAc3NPSEb2m2qQ4xBtWOb8
 SIKxHfG2vvigfQCu39sWxpQNcjHZnwR0SEtN+4vCQ2WL31K38rNNiGNzbdjWYr3/ue
 OZ9r4AiX5CQtjU1+UwYcOQNTuRqm2x2x/CC9jRo7zDmER1zFPShLfII+sZwbFIrC5N
 tryZKQyNEr34A==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 40E6917E101E;
 Sat, 14 Nov 2026 19:04:29 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:40 +0200
Subject: [PATCH 16/25] drm/tests: connector: Add HDMI max_tmds_char_rate
 init coverage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-16-20e8a33a2286@collabora.com>
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

Add KUnit tests for the new drmm_connector_hdmi_init() extension, which
infers the connector's max_tmds_char_rate from the HDMI specification
version advertised by the driver, for every known version.  Also
validate a driver-capped max_tmds_char_rate against the version-inferred
limit: override below, accept at, reject above, reject when no version
is advertised.  Additionally, make sure an HDMI 2.0 connector capped at
the HDMI 1.3 limit is still reported as scrambling capable.

Since HDMI_VERSION_2_0 requires scrambler callbacks to be provided, add
a dummy_hdmi_funcs_scrambler instance for tests that initialize HDMI 2.0
connectors.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 207 +++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 591557c4a8bb..698706fca5db 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -54,6 +54,34 @@ static const struct drm_connector_hdmi_funcs dummy_hdmi_funcs = {
 	},
 };
 
+static int accept_scrambler_enable(struct drm_connector *connector)
+{
+	return 0;
+}
+
+static int accept_scrambler_disable(struct drm_connector *connector)
+{
+	return 0;
+}
+
+static const struct drm_connector_hdmi_funcs dummy_hdmi_funcs_scrambler = {
+	.vendor = "Vendor",
+	.product = "Product",
+	.supported_hdmi_ver = HDMI_VERSION_2_0,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
+	.scrambler_enable = accept_scrambler_enable,
+	.scrambler_disable = accept_scrambler_disable,
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
 static const struct drm_connector_funcs dummy_funcs = {
 	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
@@ -1229,6 +1257,178 @@ KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_type_invalid,
 		  drm_connector_hdmi_init_type_invalid_tests,
 		  drm_connector_hdmi_init_type_desc);
 
+/*
+ * Test that the registration of an HDMI connector without an explicit max TMDS
+ * character rate being provided succeeds, and the connector limit is inferred
+ * from the advertised HDMI specification version.
+ */
+struct drm_connector_hdmi_init_max_tmds_rate_inferred_case {
+	const char *desc;
+	enum hdmi_version ver;
+	unsigned long long expected;
+};
+
+static void drm_test_connector_hdmi_init_max_tmds_rate_inferred(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	const struct drm_connector_hdmi_init_max_tmds_rate_inferred_case *params =
+		test->param_value;
+	int ret;
+
+	priv->hdmi_funcs = params->ver < HDMI_VERSION_2_0 ?
+				dummy_hdmi_funcs : dummy_hdmi_funcs_scrambler;
+	priv->hdmi_funcs.supported_hdmi_ver = params->ver;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			params->expected);
+}
+
+static const struct drm_connector_hdmi_init_max_tmds_rate_inferred_case
+drm_connector_hdmi_init_max_tmds_rate_inferred_tests[] = {
+	{ "unknown",	HDMI_VERSION_UNKNOWN,	0 },
+	{ "1.0",	HDMI_VERSION_1_0,	HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ },
+	{ "1.1",	HDMI_VERSION_1_1,	HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ },
+	{ "1.2",	HDMI_VERSION_1_2,	HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ },
+	{ "1.3",	HDMI_VERSION_1_3,	HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ },
+	{ "1.4",	HDMI_VERSION_1_4,	HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ },
+	{ "2.0",	HDMI_VERSION_2_0,	HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ },
+	{ "2.1",	HDMI_VERSION_2_1,	HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ },
+	{ "2.2",	HDMI_VERSION_2_2,	HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ },
+};
+
+static void drm_connector_hdmi_init_max_tmds_rate_inferred_desc(
+	const struct drm_connector_hdmi_init_max_tmds_rate_inferred_case *t,
+	char *desc)
+{
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_max_tmds_rate_inferred,
+		  drm_connector_hdmi_init_max_tmds_rate_inferred_tests,
+		  drm_connector_hdmi_init_max_tmds_rate_inferred_desc);
+
+/*
+ * Test that the registration of an HDMI connector providing a max TMDS
+ * character rate strictly below the version-inferred limit succeeds, and
+ * the connector limit is overridden.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_override(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_4;
+	priv->hdmi_funcs.supported_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ);
+}
+
+/*
+ * Test that the registration of an HDMI 2.0 connector capping its max TMDS
+ * character rate at the HDMI 1.3 limit succeeds, and the connector limit is
+ * overridden while the scrambling capability is still reported.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_override_hdmi20(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs_scrambler;
+	priv->hdmi_funcs.supported_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+	KUNIT_EXPECT_TRUE(test, drm_connector_hdmi_scrambler_supported(&priv->connector));
+}
+
+/*
+ * Test that the registration of an HDMI connector providing a max TMDS
+ * character rate equal to the version-inferred limit succeeds.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_at_limit(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_2;
+	priv->hdmi_funcs.supported_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, priv->connector.hdmi.max_tmds_char_rate,
+			HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ);
+}
+
+/*
+ * Test that the registration of an HDMI connector providing a max TMDS
+ * character rate that exceeds the limit inferred from the advertised HDMI
+ * specification version fails.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_off_limit(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_2;
+	priv->hdmi_funcs.supported_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
+/*
+ * Test that the registration of an HDMI connector providing a non-zero max
+ * TMDS character rate without an HDMI specification version fails, as the
+ * version-inferred limit defaults to zero and any positive override would
+ * exceed it.
+ */
+static void drm_test_connector_hdmi_init_max_tmds_rate_no_version(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs;
+	priv->hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_UNKNOWN;
+	priv->hdmi_funcs.supported_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
 static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE(drm_test_connector_hdmi_init_valid),
 	KUNIT_CASE(drm_test_connector_hdmi_init_bpc_8),
@@ -1254,6 +1454,13 @@ static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 			 drm_connector_hdmi_init_type_valid_gen_params),
 	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_type_invalid,
 			 drm_connector_hdmi_init_type_invalid_gen_params),
+	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_max_tmds_rate_inferred,
+			 drm_connector_hdmi_init_max_tmds_rate_inferred_gen_params),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_override),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_override_hdmi20),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_at_limit),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_off_limit),
+	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_no_version),
 	{ }
 };
 

-- 
2.56.0

