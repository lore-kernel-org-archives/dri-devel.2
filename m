Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58DB606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ej57/db/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2380E1129FB;
	Fri, 20 Nov 2026 12:57:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93AE10E8D1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:56:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B0831439A3;
 Fri, 20 Nov 2026 12:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108E71F000D3;
 Fri, 20 Nov 2026 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179410;
 bh=qjLDn09dTMF+yGot0oyS/QwR+JADoWCgWlYkoQAGJ34=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ej57/db/g79EuQaNBRPB/APBGn495+GGMLvKvCSV5DV+H2X/aLicMOnnlcmLVb3hD
 oKFRKRvcJrf0GjOicUM87bEkFbNcbVtiVDSXqS7imocWMP4bamaOrrxipxYmGOwrbC
 anPv3zNGggVJFYFX7i/3aIXP6x3EdJvbQo7c6GALOcanFO7POj5i0IQS9yXTWS00Qm
 EXMxRgMdMDOBCngj1WYQMT1Xf5gzmzcMLHwzamLPE54Uc1AUMs31zea7ZoCRj7UVmg
 EoEKrUv+cEdU7WB5mk+5pwROkazLJgYtjTinFP8BX8xxm+zroGMiPQ5xJduuUdq/2H
 51fKeGfv71VCA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:18 +0100
Subject: [PATCH v9 26/42] drm/tests: kunit: Add a drm_printer helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-26-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4541; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SVSu4TnbJ7fs2BcenZ5opVCd0fx1y4OKeAmbkC2JQdI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMznp5ZgZ1Ht1rwo7bTJg7kZV5b8y5NxVCtR0Z7JO5j
 yZbhs3omMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOR+8xYH8u4vuHek9A7Wy2+
 Br+/ZsXG9kPlwaLos8vP/ly5R/xUeH/XySNG67XlI3suNF5duyjuBGOdXce9vP2NizYFCVe5asR
 Zcme4ps7dqNcfuqtv2/J3nAfW7HZ8tYtFvVg6T2775WSnul0A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some DRM helpers report the state of an object through a drm_printer,
most notably to report which fields of two states differ when comparing
them.

Tests exercising such code paths need to pass a drm_printer as well, and
would rather have its output show up in the KTAP log of the test than
anywhere else, so that a failure comes with the report that caused it.

Add drm_kunit_helper_printer() that returns a drm_printer whose messages
are logged through kunit_log() at the LOGLEVEL_* level requested by the
caller.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 78 +++++++++++++++++++++++++++++++
 include/drm/drm_kunit_helpers.h           |  4 ++
 2 files changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 63d024946500..5fdffbf78245 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -6,20 +6,98 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_print.h>
 
 #include <kunit/device.h>
 #include <kunit/resource.h>
 
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/platform_device.h>
 
 #define KUNIT_DEVICE_NAME	"drm-kunit-mock-device"
 
+struct drm_printer_ctx {
+	struct drm_printer	p;
+	int			level;
+	struct kunit		*test;
+};
+
+/*
+ * kunit_log() is a macro that only accepts a compile-time log level,
+ * so the level has to be dispatched to the matching kunit_log() call.
+ */
+static void drm_kunit_printf(struct drm_printer *p, struct va_format *vaf)
+{
+	struct drm_printer_ctx *ctx = p->arg;
+
+	switch (ctx->level) {
+	case LOGLEVEL_EMERG:
+		kunit_log(KERN_EMERG, ctx->test, "%pV", vaf);
+		break;
+	case LOGLEVEL_ALERT:
+		kunit_log(KERN_ALERT, ctx->test, "%pV", vaf);
+		break;
+	case LOGLEVEL_CRIT:
+		kunit_log(KERN_CRIT, ctx->test, "%pV", vaf);
+		break;
+	case LOGLEVEL_ERR:
+		kunit_log(KERN_ERR, ctx->test, "%pV", vaf);
+		break;
+	case LOGLEVEL_WARNING:
+		kunit_log(KERN_WARNING, ctx->test, "%pV", vaf);
+		break;
+	case LOGLEVEL_NOTICE:
+		kunit_log(KERN_NOTICE, ctx->test, "%pV", vaf);
+		break;
+	case LOGLEVEL_DEBUG:
+		kunit_log(KERN_DEBUG, ctx->test, "%pV", vaf);
+		break;
+	case LOGLEVEL_INFO:
+	default:
+		kunit_log(KERN_INFO, ctx->test, "%pV", vaf);
+		break;
+	}
+}
+
+/**
+ * drm_kunit_helper_printer - Creates a &drm_printer logging into a KUnit test log
+ * @test: The test context object
+ * @level: The log level to log the messages at, one of the LOGLEVEL_* constants
+ *
+ * Creates a &struct drm_printer that will log anything printed through
+ * it, using kunit_log(), both to the kernel log at the @level log
+ * level and to the log of the KUnit test @test.
+ *
+ * This is the KUnit counterpart of the drm_print.h printers like
+ * drm_info_printer() or drm_err_printer(), and @level should be the
+ * log level of the printer it replaces.
+ *
+ * Returns:
+ * A pointer to the &drm_printer, or an ERR_PTR() otherwise.
+ */
+struct drm_printer *
+drm_kunit_helper_printer(struct kunit *test, int level)
+{
+	struct drm_printer_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->level = level;
+	ctx->p.printfn = drm_kunit_printf;
+	ctx->p.arg = ctx;
+	ctx->test = test;
+
+	return &ctx->p;
+}
+EXPORT_SYMBOL_GPL(drm_kunit_helper_printer);
+
 static const struct drm_mode_config_funcs drm_mode_config_funcs = {
 	.atomic_check	= drm_atomic_helper_check,
 	.atomic_commit	= drm_atomic_helper_commit,
 };
 
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index 97d35818f2ce..6aafaeeacf32 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -13,12 +13,16 @@ struct drm_connector;
 struct drm_crtc_funcs;
 struct drm_crtc_helper_funcs;
 struct drm_device;
 struct drm_plane_funcs;
 struct drm_plane_helper_funcs;
+struct drm_printer;
 struct kunit;
 
+struct drm_printer *drm_kunit_helper_printer(struct kunit *test,
+					     int level);
+
 struct device *drm_kunit_helper_alloc_device(struct kunit *test);
 void drm_kunit_helper_free_device(struct kunit *test, struct device *dev);
 
 struct drm_device *
 __drm_kunit_helper_alloc_drm_device_with_driver(struct kunit *test,

-- 
2.56.1

