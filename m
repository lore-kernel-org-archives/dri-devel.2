Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D70606A329
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gqqy1TAo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF497112320;
	Thu, 26 Nov 2026 11:29:39 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422DF10E60E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:29:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 073AF4E41798;
 Thu, 26 Nov 2026 11:29:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CE5EA60237;
 Thu, 26 Nov 2026 11:29:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2474811E6B36B; Thu, 26 Nov 2026 12:29:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692565; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=P6rNn4aFEjEcZ1z3GBKAStHU3x0wgmSWhq3PX6FCzYU=;
 b=gqqy1TAog2sQ6XPRLl6yS0+Ecpdnbqhh/hNjGnG1E2l0hQLMIdcpCI46OH2KlP+bE/kn3m
 1oGkKoEzEpm0yWgK/LuQNUmnXXdwl1Sy3IZU17z7HhWrGzUWpcUZ115GTNJj6qLSxuO04J
 P1UtLPqxBNPAGGuLOazA9JMw6sGpwrJbM7/GHRRXfiQKzljwf7kmwVguWP1SaOcKJLJ8BK
 jBSe0ZVwCYDUwXq+Ptq+kLidwGtgFjPcxbRizC4oaoByHCd+n3AMR6dsLF38ixgIdVzsBm
 orwKpJ2Xva4CXiXOdlIQUOv0sBQPw+kMd6JBhpG7KlMFCXdgPHr3H9dwDpl3PA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:28:47 +0100
Subject: [PATCH v7 04/43] drm/tests: Add test cases for DRM rotation name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-4-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
In-Reply-To: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Lucas De Marchi <demarchi@kernel.org>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com, 
 victoria@system76.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
X-Last-TLS-Session-Version: TLSv1.3
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

Verify the DRM_ROTATION_FMT()/DRM_ROTATION_FMT_ARGS() helpers.

Tested-by: Oarora Etimis <oaroraetimis@gmail.com>
Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/tests/Makefile            |  1 +
 drivers/gpu/drm/tests/drm_rotation_test.c | 76 +++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 42207df1d1c8..c10bd6a97f5b 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
 	drm_plane_helper_test.o \
 	drm_probe_helper_test.o \
 	drm_rect_test.o \
+	drm_rotation_test.o \
 	drm_sysfb_modeset_test.o \
 	drm_fixp_test.o \
 	drm_kunit_edid.o
diff --git a/drivers/gpu/drm/tests/drm_rotation_test.c b/drivers/gpu/drm/tests/drm_rotation_test.c
new file mode 100644
index 000000000000..c537e7ca35b9
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_rotation_test.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for DRM rotation functions and macros
+ *
+ * Tests DRM_ROTATION_FMT_ARGS()
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_blend.h>
+
+static void drm_test_rotation_fmt_args(struct kunit *test)
+{
+	char buf[128];
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), DRM_ROTATION_FMT, DRM_ROTATION_FMT_ARGS(0));
+	KUNIT_EXPECT_STREQ(test, buf, "(0x00000000)");
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), DRM_ROTATION_FMT, DRM_ROTATION_FMT_ARGS(DRM_MODE_ROTATE_0));
+	KUNIT_EXPECT_STREQ(test, buf, "rotate-0 (0x00000001)");
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), DRM_ROTATION_FMT, DRM_ROTATION_FMT_ARGS(DRM_MODE_ROTATE_90));
+	KUNIT_EXPECT_STREQ(test, buf, "rotate-90 (0x00000002)");
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), DRM_ROTATION_FMT, DRM_ROTATION_FMT_ARGS(DRM_MODE_ROTATE_180));
+	KUNIT_EXPECT_STREQ(test, buf, "rotate-180 (0x00000004)");
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), DRM_ROTATION_FMT, DRM_ROTATION_FMT_ARGS(DRM_MODE_ROTATE_270));
+	KUNIT_EXPECT_STREQ(test, buf, "rotate-270 (0x00000008)");
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), DRM_ROTATION_FMT, DRM_ROTATION_FMT_ARGS(DRM_MODE_REFLECT_X));
+	KUNIT_EXPECT_STREQ(test, buf, "reflect-x (0x00000010)");
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), DRM_ROTATION_FMT, DRM_ROTATION_FMT_ARGS(DRM_MODE_REFLECT_Y));
+	KUNIT_EXPECT_STREQ(test, buf, "reflect-y (0x00000020)");
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), DRM_ROTATION_FMT,
+		 DRM_ROTATION_FMT_ARGS(DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
+				       DRM_MODE_REFLECT_X));
+	KUNIT_EXPECT_STREQ(test, buf, "rotate-0 rotate-90 reflect-x (0x00000013)");
+
+	unsigned int all = DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_180 |
+			   DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), DRM_ROTATION_FMT, DRM_ROTATION_FMT_ARGS(all));
+	KUNIT_EXPECT_STREQ(test, buf,
+			   "rotate-0 rotate-90 rotate-180 rotate-270 reflect-x reflect-y (0x0000003f)");
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), DRM_ROTATION_FMT,
+		 DRM_ROTATION_FMT_ARGS(DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y));
+	KUNIT_EXPECT_STREQ(test, buf, "reflect-x reflect-y (0x00000030)");
+}
+
+static struct kunit_case drm_rotation_tests[] = {
+	KUNIT_CASE(drm_test_rotation_fmt_args),
+	{}
+};
+
+static struct kunit_suite drm_rotation_test_suite = {
+	.name = "drm_rotation",
+	.test_cases = drm_rotation_tests,
+};
+
+kunit_test_suite(drm_rotation_test_suite);
+
+MODULE_DESCRIPTION("Test cases for DRM rotation functions and macros");
+MODULE_LICENSE("GPL");

-- 
2.56.0

