Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3544606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hNPa0U/x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25ED10E263;
	Thu,  5 Nov 2026 10:32:29 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E124E11231D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:32:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1C44F1A07FE;
 Thu,  5 Nov 2026 10:32:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E5C795FF85;
 Thu,  5 Nov 2026 10:32:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E6A4810329267; Thu,  5 Nov 2026 11:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793874739; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=NHF/C0B6VR5CCEw0CB0/0Ffnk61+Mmzx7DVRfoty6b8=;
 b=hNPa0U/xBGfTsJajA+2APdmifg0n1NzWF+8W1sJfyJepfpVZfvS1zcb6SriKr8XQgHXn8d
 3iOjXJWsp9plUamab3pgrT8Je7IWPJcWXrNpD3JYSwcYSJiZLbxYmSiq4uXwphtfGmL2xx
 QwVIOM2zt9q+s9rAG+CedAUE0SR81mOIKzMmLYosvDrgTGjkoZm3zXy3SoG8o9rKRPKPFv
 n4ovTC4CorsMAOfPgQ4vBUS98kaIrkqY27NqDemiibH8GT+UtGuADg+GWJ38Rue+cNEa+W
 uZUjKUqEB84Hi/L3fgiGseB3VT5g1lzZv4td0i2L68Zq5/GuWtxMQfUGBWYRug==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 05 Nov 2026 11:32:06 +0100
Subject: [PATCH v4 2/3] drm/vc4: dsi: stop using deprecated
 drmm_of_get_bridge()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261105-drm-fix-of_get_bridge-build-regression-v4-2-906ca343ac1b@bootlin.com>
References: <20261105-drm-fix-of_get_bridge-build-regression-v4-0-906ca343ac1b@bootlin.com>
In-Reply-To: <20261105-drm-fix-of_get_bridge-build-regression-v4-0-906ca343ac1b@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
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

drmm_of_get_bridge() is deprecated, switch to
of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() returns
a refcounted bridge, ensure it is put by using bridge.next_bridge.

drm_panel.h becomes unused, drop the include.

Also remove an outdated comment: now panels are just bridges.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v4:
- Fix next_bridge leak on component rebind (sashiko)
- Remove outdated comment (Maíra)

Changes in v3:
- fix bridge reference leak in error path
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 5ed3c35ee9c7..581b54e04ce4 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -35,7 +35,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -554,7 +553,6 @@ struct vc4_dsi {
 
 	struct platform_device *pdev;
 
-	struct drm_bridge *out_bridge;
 	struct drm_bridge bridge;
 
 	void __iomem *regs;
@@ -1163,8 +1161,7 @@ static int vc4_dsi_bridge_attach(struct drm_bridge *bridge,
 {
 	struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
 
-	/* Attach the panel or bridge to the dsi bridge */
-	return drm_bridge_attach(encoder, dsi->out_bridge,
+	return drm_bridge_attach(encoder, dsi->bridge.next_bridge,
 				 &dsi->bridge, flags);
 }
 
@@ -1748,9 +1745,10 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
-	dsi->out_bridge = drmm_of_get_bridge(drm, dev->of_node, 0, 0);
-	if (IS_ERR(dsi->out_bridge))
-		return PTR_ERR(dsi->out_bridge);
+	struct drm_bridge *next_bridge __free(drm_bridge_put) =
+		of_drm_get_bridge_by_endpoint(dev->of_node, 0, 0);
+	if (IS_ERR(next_bridge))
+		return PTR_ERR(next_bridge);
 
 	/* The esc clock rate is supposed to always be 100Mhz. */
 	ret = clk_set_rate(dsi->escape_clock, 100 * 1000000);
@@ -1774,15 +1772,27 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
+	dsi->bridge.next_bridge = drm_bridge_get(next_bridge);
+
 	ret = drm_bridge_attach(encoder, &dsi->bridge, NULL, 0);
-	if (ret)
+	if (ret) {
+		drm_bridge_clear_and_put(&dsi->bridge.next_bridge);
 		return ret;
+	}
 
 	return 0;
 }
 
+static void vc4_dsi_unbind(struct device *dev, struct device *master, void *data)
+{
+	struct vc4_dsi *dsi = dev_get_drvdata(dev);
+
+	drm_bridge_clear_and_put(&dsi->bridge.next_bridge);
+}
+
 static const struct component_ops vc4_dsi_ops = {
 	.bind   = vc4_dsi_bind,
+	.unbind = vc4_dsi_unbind,
 };
 
 static int vc4_dsi_dev_probe(struct platform_device *pdev)

-- 
2.56.0

