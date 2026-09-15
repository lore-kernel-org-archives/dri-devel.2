Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC21DC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108DD10EBC2;
	Tue, 15 Sep 2026 15:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Z7rsCyo3";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3985E10E5F9
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:32:29 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260915153227euoutp02da5d00a633ae74f96045171cb773d03f~ViFov_OY20357903579euoutp02l;
 Tue, 15 Sep 2026 15:32:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260915153227euoutp02da5d00a633ae74f96045171cb773d03f~ViFov_OY20357903579euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789486347;
 bh=StUKRyQIsugn3KQ1WNplMQECw8amPdm71mIJ7v2jvYg=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=Z7rsCyo3R4Yv5kCrLWjEocmoIaH2MQMuuy2VH2ios6nbcc9yeudbOThdgkx0QFFOb
 8B2hQ6xGpM9gK5MLqo5B8pfsfJCvkbvtMFzbzV2hll5x40JPA4ZGbb5nq7KG/HF4Yy
 mZDFirkTFy34CciglLVm812gn3Ut8qpoFvcga7Qw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153226eucas1p1d69e9e853b4b5cfb1d42c2c585b57f95~ViFnftGyS1408514085eucas1p1M;
 Tue, 15 Sep 2026 15:32:26 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153224eusmtip1f47b9d063d7792081016464514cb6a81~ViFlavdY-0419804198eusmtip12;
 Tue, 15 Sep 2026 15:32:24 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 15 Sep 2026 17:32:15 +0200
Subject: [PATCH v4 07/20] drm/bridge: inno-hdmi: Split probe out of bind
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-jh7110-clean-send-v4-7-f0e4fd6f2cc8@samsung.com>
In-Reply-To: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
To: Vinod Koul <vkoul@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>,  Robert Foss <rfoss@kernel.org>,  Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>,  Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,  Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  Maud Spierings <maud_spierings@murena.io>, 
 Graham Markall <hello@big-grey.co.uk>,  Icenowy Zheng
 <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260915153226eucas1p1d69e9e853b4b5cfb1d42c2c585b57f95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153226eucas1p1d69e9e853b4b5cfb1d42c2c585b57f95
X-EPHeader: CA
X-CMS-RootMailID: 20260915153226eucas1p1d69e9e853b4b5cfb1d42c2c585b57f95
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153226eucas1p1d69e9e853b4b5cfb1d42c2c585b57f95@eucas1p1.samsung.com>
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

inno_hdmi_bind() both sets up the bridge and attaches it to a DRM
encoder. A platform whose HDMI controller is a child of a larger device
needs the first half without the second, since it registers as its own
platform driver and lets the DRM core bind the bridge later.

Move the setup into a new exported inno_hdmi_probe(), with a matching
inno_hdmi_remove(), and reduce inno_hdmi_bind() to a wrapper around it.

No functional change intended.

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 49 +++++++++++++++++++++++++++++++++-----
 include/drm/bridge/inno_hdmi.h     |  4 ++++
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index dd35f5a875d3d842fee6d2ead0de88503f9914e1..840f1c7bc202951d3dfee3711f61105f328c3326 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -929,7 +929,14 @@ static irqreturn_t inno_hdmi_irq(int irq, void *dev_id)
 {
 	struct inno_hdmi *hdmi = dev_id;
 
-	drm_helper_hpd_irq_event(hdmi->bridge.dev);
+	/*
+	 * The interrupt is requested in probe, but bridge.dev is only set once
+	 * the DRM master binds and attaches the bridge, which may never happen.
+	 * Drop hotplug events that arrive before then rather than dereference a
+	 * NULL drm_device.
+	 */
+	if (hdmi->bridge.dev)
+		drm_helper_hpd_irq_event(hdmi->bridge.dev);
 
 	return IRQ_HANDLED;
 }
@@ -1061,11 +1068,24 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(struct inno_hdmi *hdmi)
 	return adap;
 }
 
-struct inno_hdmi *inno_hdmi_bind(struct device *dev,
-				 struct drm_encoder *encoder,
-				 const struct inno_hdmi_plat_data *plat_data)
+/**
+ * inno_hdmi_probe - Internal helper to perform common setup
+ * @pdev: platform device
+ * @plat_data: SoC-specific platform data
+ *
+ * This function handles all the common hardware setup: allocating the main
+ * struct, mapping registers, getting clocks, initializing the hardware,
+ * setting up the IRQ, and initializing the DDC adapter and bridge struct.
+ * It returns a pointer to the inno_hdmi struct on success, or an ERR_PTR
+ * on failure.
+ *
+ * This function is used by modern, decoupled MFD/glue drivers. It registers
+ * the bridge but does not attach it.
+ */
+struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
+				  const struct inno_hdmi_plat_data *plat_data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
+	struct device *dev = &pdev->dev;
 	struct inno_hdmi *hdmi;
 	int irq;
 	int ret;
@@ -1128,7 +1148,24 @@ struct inno_hdmi *inno_hdmi_bind(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	return hdmi;
+}
+EXPORT_SYMBOL_GPL(inno_hdmi_probe);
+
+struct inno_hdmi *inno_hdmi_bind(struct device *dev,
+				 struct drm_encoder *encoder,
+				 const struct inno_hdmi_plat_data *plat_data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct inno_hdmi *hdmi;
+	int ret;
+
+	hdmi = inno_hdmi_probe(pdev, plat_data);
+	if (IS_ERR(hdmi))
+		return hdmi;
+
+	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/include/drm/bridge/inno_hdmi.h b/include/drm/bridge/inno_hdmi.h
index 5bbcaeea94e2a20fd0dc0ae0c6946eb5604bbaf6..81da9d9bcd79db8fe26c6dff4569371e484df608 100644
--- a/include/drm/bridge/inno_hdmi.h
+++ b/include/drm/bridge/inno_hdmi.h
@@ -12,6 +12,7 @@ struct device;
 struct drm_encoder;
 struct drm_display_mode;
 struct inno_hdmi;
+struct platform_device;
 
 struct inno_hdmi_plat_ops {
 	void (*enable)(struct device *pdev, struct drm_display_mode *mode);
@@ -32,4 +33,7 @@ struct inno_hdmi_plat_data {
 struct inno_hdmi *inno_hdmi_bind(struct device *pdev,
 				 struct drm_encoder *encoder,
 				 const struct inno_hdmi_plat_data *plat_data);
+
+struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
+				  const struct inno_hdmi_plat_data *plat_data);
 #endif /* __INNO_HDMI__ */

-- 
2.34.1

