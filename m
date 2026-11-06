Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F438606A334
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOy+Q/W0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D019610F663;
	Fri,  6 Nov 2026 13:16:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC3310F1AC
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E947A42A3C;
 Fri,  6 Nov 2026 13:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5696F1F0089F;
 Fri,  6 Nov 2026 13:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970979;
 bh=ly0UqZ5aV7LvMUxII2+XPGYG3Nbyc7e2iRT9zTNHw5c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GOy+Q/W0oPx5cKgMSzyX+xzIerH+DZzBB68d4RU+aIj//lmG7zUK/5mwVXL71Ftat
 GVjfwm6dwOfadJBQHHtZlthN5hl4hBs+2o0t6WLhxQZNr0rjE4fSIiCe5/t29ZeTXS
 PoTJokIWqDUGkaiorn0iX8dyX8IpLZdYwUNv5ds6JPyhlbHbQ+uOD9xi56hPbjKBZG
 QdTtgJZPQdZFcOXPICJ/uJIShUGZjrU7e5UQ6MYKHw5aXwQHS7fxscwVy5uB+iZm/+
 0WLh8BxXUOnARuyAMO9pYC8VaiT9tEokns1+VjUOYELoEff865pgx8qT9c9Z2TmxVT
 5Fz/wwYTCjcSw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:40 +0100
Subject: [PATCH v8 27/39] drm/tests: kunit: Add a drm_printer helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-27-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4114; i=mripard@kernel.org;
 h=from:subject:message-id; bh=VmLDcEJ9WmjL2uarzm4pqOOtk6Q9m91rwmdthx5TGgc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL+1wTHbY80tO3P+A5fP5m7mfmt0+1j5RNunuhLLTh
 3mvXlGN6pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATMSxhbFji1FR9y6hF1PSO
 1bz9dYIT5E0mM+7OPr7rS9q7GZtjRP+azdSrknArOTZxP+OjgIZsecaG/dtfJx87LLWZo6Jtx8n
 NS0+FlLz8Gfn1zJw61Wn7rj1dIiEe8KCUjTPE6SwXyy6nCawWAA==
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
@@ -9,4 +9,5 @@
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_print.h>
 
 #include <kunit/device.h>
@@ -19,4 +20,81 @@
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
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index e653bc7b1e40..d38614d87678 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -16,6 +16,10 @@ struct drm_device;
 struct drm_plane_funcs;
 struct drm_plane_helper_funcs;
+struct drm_printer;
 struct kunit;
 
+struct drm_printer *drm_kunit_helper_printer(struct kunit *test,
+					     int level);
+
 struct device *drm_kunit_helper_alloc_device(struct kunit *test);
 void drm_kunit_helper_free_device(struct kunit *test, struct device *dev);

-- 
2.55.0

