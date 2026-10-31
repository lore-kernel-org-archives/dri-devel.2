Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329B606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=gUmmKxN+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8575310EA1C;
	Sun,  1 Nov 2026 12:02:00 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE5410E2EF
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:57:06 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jHBdX36ysz8vTW;
 Sat, 31 Oct 2026 22:57:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793483824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6uCfJ+8CnteF7kubtyKLhjEI6t6YiAeXrR2BoYOOyA=;
 b=gUmmKxN+FHeYhM9NsxDZOz+NjHObPqPEd+DsIKke2Y8KOFdbMKlsN7IG4Qvr75XzhcrlZS
 3PpW9I3YnMNLbJqOes2EA3ckPjFdAsNcA1y2Pof0CdyxY0GjQoKtcUV8mxShT9R/t3yy2b
 QPaK54ryOnjaNea0WwFjNKhVlhSr3AVreCB9ReoXWUfc9zli7K30oZT8CQlhcbkbOvClyQ
 cUj+3jvZvKTjPpMEbCdOSqUc//LbLfzB6lM68WvQ5vgqsKwvyAuXfz/MEzwqjbzc1Qatpz
 iFxGcFWulOAJm7/qy9EKSEymkRjujtVzMvz5HvW5fn3xsFNI33NTnMopJmp1qg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/tests: client-modeset: Test cloning with video= on
 one connector
Date: Sat, 31 Oct 2026 21:57:00 +0000
Message-ID: <20261031215700.1077873-3-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031215700.1077873-1-hugo@hsal.es>
References: <20261031215700.1077873-1-hugo@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jHBdX36ysz8vTW
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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

Add a drm_client_target_cloned() test with two connectors. The first
one has a video= mode and only 1920x1080, the second one has no video=
mode and only 1024x768. The connectors share no mode, so the function
must not report them as clonable

Without the previous commit the first connector keeps its cmdline mode
through the 1024x768 pass and the test fails

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../gpu/drm/tests/drm_client_modeset_test.c   | 109 +++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
index ec58fe064d862..a8b316fbe8433 100644
--- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
+++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
@@ -10,6 +10,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_probe_helper.h>
@@ -195,7 +196,113 @@ static struct kunit_suite drm_test_pick_cmdline_test_suite = {
 	.test_cases = drm_test_pick_cmdline_tests
 };
 
-kunit_test_suite(drm_test_pick_cmdline_test_suite);
+static int drm_client_target_cloned_add_dmt_mode(struct drm_connector *connector,
+						 int hsize, int vsize)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_find_dmt(connector->dev, hsize, vsize, 60, false);
+	if (!mode)
+		return 0;
+
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static int drm_client_target_cloned_get_modes_1080p(struct drm_connector *connector)
+{
+	return drm_client_target_cloned_add_dmt_mode(connector, 1920, 1080);
+}
+
+static int drm_client_target_cloned_get_modes_xga(struct drm_connector *connector)
+{
+	return drm_client_target_cloned_add_dmt_mode(connector, 1024, 768);
+}
+
+static const struct drm_connector_helper_funcs drm_client_target_cloned_1080p_helper_funcs = {
+	.get_modes = drm_client_target_cloned_get_modes_1080p,
+};
+
+static const struct drm_connector_helper_funcs drm_client_target_cloned_xga_helper_funcs = {
+	.get_modes = drm_client_target_cloned_get_modes_xga,
+};
+
+/*
+ * Only the first connector has a video= mode, so the cmdline pass stops
+ * at the second one. The first connector has no 1024x768 mode, so the
+ * 1024x768 pass must not report the two connectors as clonable
+ */
+static void drm_test_target_cloned_cmdline_on_one_connector(struct kunit *test)
+{
+	struct drm_connector *connectors[2];
+	const struct drm_display_mode *modes[ARRAY_SIZE(connectors)] = {};
+	struct drm_client_offset offsets[ARRAY_SIZE(connectors)] = {};
+	bool enabled[ARRAY_SIZE(connectors)] = { true, true };
+	struct drm_device *drm;
+	struct device *dev;
+	bool cloned;
+	int i, ret;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0,
+						  DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	for (i = 0; i < ARRAY_SIZE(connectors); i++) {
+		connectors[i] = drmm_kzalloc(drm, sizeof(*connectors[i]), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, connectors[i]);
+
+		ret = drmm_connector_init(drm, connectors[i],
+					  &drm_client_modeset_connector_funcs,
+					  DRM_MODE_CONNECTOR_Unknown, NULL);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		/* Drop any video= option the kernel was booted with */
+		memset(&connectors[i]->cmdline_mode, 0,
+		       sizeof(connectors[i]->cmdline_mode));
+		connectors[i]->force = DRM_FORCE_UNSPECIFIED;
+	}
+
+	drm_connector_helper_add(connectors[0],
+				 &drm_client_target_cloned_1080p_helper_funcs);
+	drm_connector_helper_add(connectors[1],
+				 &drm_client_target_cloned_xga_helper_funcs);
+
+	KUNIT_ASSERT_TRUE(test,
+			  drm_mode_parse_command_line_for_connector("1920x1080@60",
+								    connectors[0],
+								    &connectors[0]->cmdline_mode));
+
+	mutex_lock(&drm->mode_config.mutex);
+	for (i = 0; i < ARRAY_SIZE(connectors); i++) {
+		ret = drm_helper_probe_single_connector_modes(connectors[i],
+							      1920, 1080);
+		KUNIT_EXPECT_EQ(test, ret, 1);
+	}
+	cloned = drm_client_target_cloned(drm, connectors, ARRAY_SIZE(connectors),
+					  modes, offsets, enabled, 1920, 1080);
+	mutex_unlock(&drm->mode_config.mutex);
+
+	KUNIT_EXPECT_FALSE(test, cloned);
+
+	modes_destroy(drm, modes, ARRAY_SIZE(connectors));
+}
+
+static struct kunit_case drm_test_target_cloned_tests[] = {
+	KUNIT_CASE(drm_test_target_cloned_cmdline_on_one_connector),
+	{}
+};
+
+static struct kunit_suite drm_test_target_cloned_test_suite = {
+	.name = "drm_test_target_cloned",
+	.test_cases = drm_test_target_cloned_tests
+};
+
+kunit_test_suites(&drm_test_pick_cmdline_test_suite,
+		  &drm_test_target_cloned_test_suite);
 
 /*
  * This file is included directly by drm_client_modeset.c so we can't
-- 
2.56.0

