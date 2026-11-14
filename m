Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503F606A335
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=MSp5zZ0w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4390F10F09F;
	Sat, 14 Nov 2026 18:05:22 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0789D10F0AD
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679470;
 bh=4TSCcyN1t6iIHTjCztU5C2xk2WINIACBF89BHGcwxPs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MSp5zZ0wEnrQ0sPdKOE2H3ZDNpvr+rHLFjb0+RYQzz0dLpREx69ysAhhrJhRsvNFd
 /T2PRN93IAEnzAlIlXax8V1hu5RWZWOu/BBMnb3o98b+QWOrIxPWlI4drxjaeT/H9Y
 jUBU/TWtBUnhYO6pByf/rjaRR3IOaIgxMX+MiwRR95cX7BzjhOlS4UFCUDi1BBa7lJ
 nKvoo7+Yqq4kg1OBHbr5/g/NUk9QScDYl1vY5A+qbTkPF6yuPXFXc656MwXSWb01cT
 rEO8iODOZk41Gl99tits5clATRwB1BxfaBPj81Y+x37Dy30hgjNB7Vru0NWhRdxdDd
 QH8c+oMnqGOdw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 03E5C17E3BCC;
 Sat, 14 Nov 2026 19:04:29 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:41 +0200
Subject: [PATCH 17/25] drm/tests: connector: Add HDMI source-side scrambler
 coverage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-17-20e8a33a2286@collabora.com>
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

Add KUnit tests for the HDMI source-side scrambling validation done by
the new drmm_connector_hdmi_init() helper.

Connector initialization derives scrambler support from the
driver-provided supported_hdmi_ver capability.  Therefore, connectors
that advertise HDMI 2.0 or later must provide both .scrambler_enable()
and .scrambler_disable() callbacks.  Registration is rejected if either
callback is missing.  Conversely, connectors advertising an earlier
version are never reported as scrambling capable, even when providing
those callbacks.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 125 +++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 698706fca5db..1520e4f8a9ab 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -1429,6 +1429,126 @@ static void drm_test_connector_hdmi_init_max_tmds_rate_no_version(struct kunit *
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
 
+/*
+ * Test that the registration of an HDMI connector advertising HDMI 2.0 support
+ * succeeds when the .scrambler_{enable,disable} callbacks are provided.
+ */
+static void drm_test_connector_hdmi_init_scrambler_valid(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs_scrambler,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, drm_connector_hdmi_scrambler_supported(&priv->connector));
+}
+
+/*
+ * Test that the registration of an HDMI connector not advertising HDMI 2.0
+ * support succeeds, and the connector is not reported as scrambling capable.
+ */
+static void drm_test_connector_hdmi_init_scrambler_unsupported(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, drm_connector_hdmi_scrambler_supported(&priv->connector));
+}
+
+/*
+ * Test that the registration of an HDMI connector not advertising HDMI 2.0
+ * support, but providing the .scrambler_{enable,disable} callbacks anyway,
+ * succeeds and the connector is still not reported as scrambling capable.
+ */
+static void drm_test_connector_hdmi_init_scrambler_cb_ignored(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs_scrambler;
+	priv->hdmi_funcs.supported_hdmi_ver = HDMI_VERSION_1_4;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, drm_connector_hdmi_scrambler_supported(&priv->connector));
+}
+
+enum drm_connector_hdmi_scrambler_cb {
+	SCRAMBLER_CALLBACK_ENABLE,
+	SCRAMBLER_CALLBACK_DISABLE,
+	SCRAMBLER_CALLBACK_ALL,
+};
+
+struct drm_connector_hdmi_init_scrambler_missing_cb_case {
+	const char *desc;
+	enum drm_connector_hdmi_scrambler_cb cb;
+};
+
+/*
+ * Test that the registration of an HDMI connector advertising HDMI 2.0 support
+ * fails when any single .scrambler_* callback is missing.
+ */
+static void drm_test_connector_hdmi_init_scrambler_missing_cb(struct kunit *test)
+{
+	const struct drm_connector_hdmi_init_scrambler_missing_cb_case *params = test->param_value;
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	priv->hdmi_funcs = dummy_hdmi_funcs_scrambler;
+
+	switch (params->cb) {
+	case SCRAMBLER_CALLBACK_ENABLE:
+		priv->hdmi_funcs.scrambler_enable = NULL;
+		break;
+	case SCRAMBLER_CALLBACK_DISABLE:
+		priv->hdmi_funcs.scrambler_disable = NULL;
+		break;
+	case SCRAMBLER_CALLBACK_ALL:
+		priv->hdmi_funcs.scrambler_enable = NULL;
+		priv->hdmi_funcs.scrambler_disable = NULL;
+		break;
+	}
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       &priv->hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
+static const struct drm_connector_hdmi_init_scrambler_missing_cb_case
+drm_connector_hdmi_init_scrambler_missing_cb_tests[] = {
+	{ "scrambler_enable",	SCRAMBLER_CALLBACK_ENABLE },
+	{ "scrambler_disable",	SCRAMBLER_CALLBACK_DISABLE },
+	{ "scrambler_*",	SCRAMBLER_CALLBACK_ALL },
+};
+
+static void
+drm_connector_hdmi_init_scrambler_missing_cb_desc(const struct drm_connector_hdmi_init_scrambler_missing_cb_case *t,
+						  char *desc)
+{
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_scrambler_missing_cb,
+		  drm_connector_hdmi_init_scrambler_missing_cb_tests,
+		  drm_connector_hdmi_init_scrambler_missing_cb_desc);
+
 static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE(drm_test_connector_hdmi_init_valid),
 	KUNIT_CASE(drm_test_connector_hdmi_init_bpc_8),
@@ -1461,6 +1581,11 @@ static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_at_limit),
 	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_off_limit),
 	KUNIT_CASE(drm_test_connector_hdmi_init_max_tmds_rate_no_version),
+	KUNIT_CASE(drm_test_connector_hdmi_init_scrambler_valid),
+	KUNIT_CASE(drm_test_connector_hdmi_init_scrambler_unsupported),
+	KUNIT_CASE(drm_test_connector_hdmi_init_scrambler_cb_ignored),
+	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_scrambler_missing_cb,
+			 drm_connector_hdmi_init_scrambler_missing_cb_gen_params),
 	{ }
 };
 

-- 
2.56.0

