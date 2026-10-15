Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B54CCA462
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9A510EB46;
	Thu, 15 Oct 2026 15:10:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA0010F21C
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:09:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D69A260120;
 Thu, 15 Oct 2026 15:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154751F000C4;
 Thu, 15 Oct 2026 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792076998;
 bh=m4YO7J8vJYYnWqb4YX4pDXMQqVrTFT9G/H7TunfVCKk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SdB37i89g07usjdID7Vo0zM8uJX2gwJCwhs2p+3UEFZaAs/+VjZ/NeHKw3MlNxpYp
 N3yN31X7JrM444tD83PKvoti0jauuDyRNtHIy3lyt8iulTOKGLeT68/nWKdgS0p4KA
 MzrIh/ABAYkAYYW1wQzutK/R66yJ7O1r+KCx/A+QdKghgqj6JHNXpRzTSnoCuq1rjC
 iRveoaT3tL/a8QdFPc68c6Q1IFY0hPbkr6/apQgvCiKDYm9LAtS/QrDyrQez//Ydt2
 N5jFkWu6UbftrqNBLH2vCRFsvywS/QOa+37ua5KaLa6fVvgzMgOfCo41eUd6Fo9vM1
 usnsrarDxSJ/Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:04 +0200
Subject: [PATCH v6 12/28] drm/mode-config: Read out hardware state in
 drm_mode_config_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-12-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3423; i=mripard@kernel.org;
 h=from:subject:message-id; bh=urlPu7DlVZNR5+DbJ6/32WGqJ8+7044jMajc+3a2OyE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3vRLBD7Lqtpin7ancN/tmcoCXW/P/1pRVHTyqtvzQ
 xwn/rXldUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJcDsy1lnIesqYTBa1mPRm
 27b9G/5JSb44MGv3wfK1Qsbn7mxY7qHnqXUm+enjHY0dE9fy56q4HWasz05h+7hQxjNbzvZgwK3
 IKboVgR6uM75cr55jMmXV8sxPPTaWx1vmzL53ObFQnv1CfjInAA==
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
 drivers/gpu/drm/drm_mode_config.c | 49 +++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index c1e993a78702..13e7d7f40d0a 100644
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
@@ -320,25 +321,11 @@ void drm_mode_config_reset(struct drm_device *dev)
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
@@ -406,10 +393,42 @@ int drm_mode_config_create_initial_state(struct drm_device *dev)
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
+	if (dev->mode_config.funcs->atomic_sro_readout_state) {
+		ret = dev->mode_config.funcs->atomic_sro_readout_state(dev);
+		if (!ret)
+			return 0;
+	}
+
+	return drm_mode_config_create_state(dev);
+}
 EXPORT_SYMBOL(drm_mode_config_create_initial_state);
 
 /*
  * Global properties
  */

-- 
2.55.0

