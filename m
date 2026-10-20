Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1160A6F41
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NqSVxfzJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FCC510F27B;
	Tue, 20 Oct 2026 13:00:31 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C08FD10F27B
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:00:24 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261020130022euoutp02c671aa9ae1c3cd5af2fa41d11f22be03~gPl19xHKh2498724987euoutp02O
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:00:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261020130022euoutp02c671aa9ae1c3cd5af2fa41d11f22be03~gPl19xHKh2498724987euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792501222;
 bh=Iw1az4Kib7cvVuGTwU1tMkWhsplAcQjO4HtOutKS2HU=;
 h=From:To:Cc:Subject:Date:References:From;
 b=NqSVxfzJgeuRoJUtofNm2H5DROWhpQc51d8lLcKU1qu4tgAbQUNxa1xvvs/Q3doUW
 Bsxd93IN/5DjakiKZ2ouEcXEjgZQt39R4jM39uPQQAAyYaxTf4YXbAo4I/LA1H+RZJ
 OAEl/3PEyBeAGF70r/7jnpzFhMM7FxrkCtb/RZgE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261020130022eucas1p2564adcaa74eea27cb4b88164b385b184~gPl1pD_OD2670526705eucas1p2S;
 Tue, 20 Oct 2026 13:00:22 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261020130022eusmtip18541a70a3a4a1d4b0cf168dfec2fe45b~gPl1JNYNI2031520315eusmtip1u;
 Tue, 20 Oct 2026 13:00:22 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH] drm/arm/hdlcd: Attach the output bridge directly
Date: Tue, 20 Oct 2026 15:00:07 +0200
Message-ID: <20261020130009.2017776-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261020130022eucas1p2564adcaa74eea27cb4b88164b385b184
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261020130022eucas1p2564adcaa74eea27cb4b88164b385b184
X-EPHeader: CA
X-CMS-RootMailID: 20261020130022eucas1p2564adcaa74eea27cb4b88164b385b184
References: <CGME20261020130022eucas1p2564adcaa74eea27cb4b88164b385b184@eucas1p2.samsung.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit d700fd0ff100 ("drm/bridge: tda998x: Remove component
support") the TDA998x driver no longer registers itself as a component,
so the HDLCD component master never gets bound and the display stays
dead on Juno board.

Drop the component framework and get the output bridge with
devm_drm_of_get_bridge() at probe time, deferring until it becomes
available. Create the encoder in the HDLCD driver, attach the bridge
with DRM_BRIDGE_ATTACH_NO_CONNECTOR and use drm_bridge_connector for
the connector, like tilcdc does since the TDA998x component support
removal.

This also makes HDLCD work with any DRM bridge, not only TDA998x.

As a side effect, interlaced modes are no longer exposed on the HDMI
connector. The connector created by TDA998x itself always allowed them,
while drm_bridge_connector only allows them when all bridges in the
chain set interlace_allowed, which TDA998x does not. HDLCD has no
interlaced scanout support, so these modes were not usable anyway.

Fixes: d700fd0ff100 ("drm/bridge: tda998x: Remove component support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch has been developed with LLM assistance, but the results has
been tested on the real Juno R1 board (juno-r1-scmi.dtb) with HDMI
monitor.

Bst regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 drivers/gpu/drm/arm/Kconfig     |  4 +-
 drivers/gpu/drm/arm/hdlcd_drv.c | 85 +++++++++++++++------------------
 drivers/gpu/drm/arm/hdlcd_drv.h |  1 +
 3 files changed, 42 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
index ed3ed617c688..6dcc063aa503 100644
--- a/drivers/gpu/drm/arm/Kconfig
+++ b/drivers/gpu/drm/arm/Kconfig
@@ -9,7 +9,9 @@ config DRM_HDLCD
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
-	select DRM_BRIDGE # for TDA998x
+	select DRM_BRIDGE
+	select DRM_BRIDGE_CONNECTOR
+	select DRM_DISPLAY_HELPER
 	help
 	  Choose this option if you have an ARM High Definition Colour LCD
 	  controller.
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 81d45f2dd6a7..340b1bb38bf9 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -13,17 +13,17 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/clk.h>
-#include <linux/component.h>
 #include <linux/console.h>
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
-#include <linux/of_graph.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
@@ -238,12 +238,43 @@ static const struct drm_driver hdlcd_driver = {
 	.minor = 0,
 };
 
-static int hdlcd_drm_bind(struct device *dev)
+static int hdlcd_attach_bridge(struct drm_device *drm, struct drm_bridge *bridge)
 {
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
+	struct drm_connector *connector;
+	int ret;
+
+	ret = drmm_encoder_init(drm, &hdlcd->encoder, NULL,
+				DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	hdlcd->encoder.possible_crtcs = drm_crtc_mask(&hdlcd->crtc);
+
+	ret = drm_bridge_attach(&hdlcd->encoder, bridge, NULL,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret)
+		return ret;
+
+	connector = drm_bridge_connector_init(drm, &hdlcd->encoder);
+
+	return PTR_ERR_OR_ZERO(connector);
+}
+
+static int hdlcd_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
 	struct drm_device *drm;
 	struct hdlcd_drm_private *hdlcd;
+	struct drm_bridge *bridge;
 	int ret;
 
+	/* there is only one output port inside each device, find its bridge */
+	bridge = devm_drm_of_get_bridge(dev, dev->of_node, 0, 0);
+	if (IS_ERR(bridge))
+		return dev_err_probe(dev, PTR_ERR(bridge),
+				     "failed to find output bridge\n");
+
 	hdlcd = devm_drm_dev_alloc(dev, &hdlcd_driver, typeof(*hdlcd), base);
 	if (IS_ERR(hdlcd))
 		return PTR_ERR(hdlcd);
@@ -260,12 +291,9 @@ static int hdlcd_drm_bind(struct device *dev)
 	if (ret)
 		goto err_free;
 
-	/* Set the CRTC's port so that the encoder component can find it */
-	hdlcd->crtc.port = of_graph_get_port_by_id(dev->of_node, 0);
-
-	ret = component_bind_all(dev, drm);
+	ret = hdlcd_attach_bridge(drm, bridge);
 	if (ret) {
-		DRM_ERROR("Failed to bind all components\n");
+		DRM_ERROR("failed to attach bridge\n");
 		goto err_unload;
 	}
 
@@ -311,10 +339,7 @@ static int hdlcd_drm_bind(struct device *dev)
 	pm_runtime_disable(drm->dev);
 err_pm_active:
 	drm_atomic_helper_shutdown(drm);
-	component_unbind_all(dev, drm);
 err_unload:
-	of_node_put(hdlcd->crtc.port);
-	hdlcd->crtc.port = NULL;
 	hdlcd_irq_uninstall(hdlcd);
 	of_reserved_mem_device_release(drm->dev);
 err_free:
@@ -322,16 +347,14 @@ static int hdlcd_drm_bind(struct device *dev)
 	return ret;
 }
 
-static void hdlcd_drm_unbind(struct device *dev)
+static void hdlcd_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
-	component_unbind_all(dev, drm);
-	of_node_put(hdlcd->crtc.port);
-	hdlcd->crtc.port = NULL;
 	pm_runtime_get_sync(dev);
 	drm_atomic_helper_shutdown(drm);
 	hdlcd_irq_uninstall(hdlcd);
@@ -342,38 +365,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 	dev_set_drvdata(dev, NULL);
 }
 
-static const struct component_master_ops hdlcd_master_ops = {
-	.bind		= hdlcd_drm_bind,
-	.unbind		= hdlcd_drm_unbind,
-};
-
-static int compare_dev(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-static int hdlcd_probe(struct platform_device *pdev)
-{
-	struct device_node *port;
-	struct component_match *match = NULL;
-
-	/* there is only one output port inside each device, find it */
-	port = of_graph_get_remote_node(pdev->dev.of_node, 0, 0);
-	if (!port)
-		return -ENODEV;
-
-	drm_of_component_match_add(&pdev->dev, &match, compare_dev, port);
-	of_node_put(port);
-
-	return component_master_add_with_match(&pdev->dev, &hdlcd_master_ops,
-					       match);
-}
-
-static void hdlcd_remove(struct platform_device *pdev)
-{
-	component_master_del(&pdev->dev, &hdlcd_master_ops);
-}
-
 static void hdlcd_shutdown(struct platform_device *pdev)
 {
 	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.h b/drivers/gpu/drm/arm/hdlcd_drv.h
index f1c1da2ac2db..6fb48727e54e 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.h
+++ b/drivers/gpu/drm/arm/hdlcd_drv.h
@@ -11,6 +11,7 @@ struct hdlcd_drm_private {
 	void __iomem			*mmio;
 	struct clk			*clk;
 	struct drm_crtc			crtc;
+	struct drm_encoder		encoder;
 	struct drm_plane		*plane;
 	unsigned int			irq;
 #ifdef CONFIG_DEBUG_FS
-- 
2.43.0

