Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A693C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C50710E76F;
	Mon, 29 Jun 2026 08:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R+j0ypsj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B1410E74E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:17:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB749600D8;
 Mon, 29 Jun 2026 08:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19811F00A3A;
 Mon, 29 Jun 2026 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721078;
 bh=GkjXTU+izgKnZyY0axYfKS98wB3rWbL4LvYZqlCTGoM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=R+j0ypsj97RSUVisSaW2vm31JqksmcoBp1pQjPgP7mJii65IlNYipun98d+Nk58pS
 K8WAir8rGBM/pjhnwnnV/vlt04XLSwHlQqp1gFZW0PXBKDZ3uFNdPX0uLjUV9uxuet
 94/3v4b3olOSvhHFYnG8x0W+a+Mm9bjaK3aO9ov0M+6xeMdpbqWCEqJktR8S+ck0d6
 w3tqxGvPA5GlgcZJIBKMNWTIUCz+f9T+MOdtuFRpf5JBkMODU0FlEYRIbToS61bz5d
 bEzgO15AVGofd7vpA3DSxYBBH90nFizaJtg18zrY8XDdgUAr3nalPj04eJ1rdN1rI4
 Pt+t2zA6vt8Uw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:14 +0200
Subject: [PATCH v4 16/30] drm/mode-config: Read out hardware state in
 drm_mode_config_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-16-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3356; i=mripard@kernel.org;
 h=from:subject:message-id; bh=clg80pj6MHzkUOoGArZm2MlTP2cyzYrv7zdXG+oslPo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWuwPV864zKy29nNtbKZ62vTg+ZGJDfW8N+QKV016t
 OxNjej7jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRRn3G+tJpX2yKDX7q1TLd
 v2/36En/tF2xtTbph/Un7XSW1c4JDs98qPPjqpid+gGlx8o/3zWrMDbcbp769OmiM5UGRpwloYV
 fOXjEBXkftXHxfijrzpaVnlj6696ElZfSdx7advnOg3v1XksB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

drm_mode_config_create_state() creates the initial state for all
KMS objects at driver registration time.

Call the drm_mode_config_funcs.atomic_sro_readout_state hook from it
so that the initial state is populated from the hardware rather than
being left as a pristine default.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c | 47 ++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index f432f485a914..7c351c6f34a4 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -22,10 +22,11 @@
 
 #include <linux/export.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_sro.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_managed.h>
@@ -315,25 +316,11 @@ void drm_mode_config_reset(struct drm_device *dev)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 }
 EXPORT_SYMBOL(drm_mode_config_reset);
 
-/**
- * drm_mode_config_create_initial_state - Allocates the initial state
- * @dev: drm device
- *
- * This functions creates the initial state for all the objects. Drivers
- * can use this in e.g. probe to initialize their software state.
- *
- * It has two main differences with drm_mode_config_reset(): the reset()
- * hooks aren't called and thus the hardware will be left untouched, but
- * also the &drm_private_obj structures will be initialized as opposed
- * to drm_mode_config_reset() that skips them.
- *
- * Returns: 0 on success, negative error value on failure.
- */
-int drm_mode_config_create_initial_state(struct drm_device *dev)
+static int drm_mode_config_create_state(struct drm_device *dev)
 {
 	struct drm_crtc *crtc;
 	struct drm_colorop *colorop;
 	struct drm_plane *plane;
 	struct drm_connector *connector;
@@ -401,10 +388,40 @@ int drm_mode_config_create_initial_state(struct drm_device *dev)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
 	return 0;
 }
+
+/**
+ * drm_mode_config_create_initial_state - Allocates the initial state
+ * @dev: drm device
+ *
+ * This functions creates the initial state for all the objects. Drivers
+ * can use this in e.g. probe to initialize their state.
+ *
+ * It creates the initial state in several steps. It first tries to
+ * read-out the initial state from the hardware for all objects if state
+ * read-out is enabled and the driver supports it. Then, if state
+ * read-out isn't supported or fails, it creates a new, pristine state
+ * using the objects atomic_create_state callback.
+ *
+ * For historical reasons, drm_mode_config_reset() is similar, but
+ * doesn't support state read-out, and will always reset the hardware.
+ * It will also ignore all &drm_private_obj.
+ *
+ * Returns: 0 on success, negative error value on failure.
+ */
+int drm_mode_config_create_initial_state(struct drm_device *dev)
+{
+	int ret;
+
+	ret = dev->mode_config.funcs->atomic_sro_readout_state(dev);
+	if (!ret)
+		return 0;
+
+	return drm_mode_config_create_state(dev);
+}
 EXPORT_SYMBOL(drm_mode_config_create_initial_state);
 
 /*
  * Global properties
  */

-- 
2.54.0

