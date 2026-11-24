Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4C606A6AD
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=tMIwHnJq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB8610F73B;
	Tue, 24 Nov 2026 15:54:25 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F87D10E23E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:54:14 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261124155412euoutp02178212c561898661f7bf228a4aae0ce4~rBinHKyZG0605106051euoutp02v;
 Tue, 24 Nov 2026 15:54:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261124155412euoutp02178212c561898661f7bf228a4aae0ce4~rBinHKyZG0605106051euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795535653;
 bh=fYqYtqLCxFzrbG4bQL5hJxs4tyB4s8JGl8XcNj0I9fA=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=tMIwHnJqir4LlGumuKnJdzTeMaxsf2yRnHPoXWZZFdyE21SNpTdBx8an8uNf/hcgV
 r7qN7UVznneM+WdDnumMAcbbf/zDHHokOCCqlx6dHnLiF+6KpSUtsSr+OCd5vuu9Gl
 HyrteH5n0BW/90cp8x0WW/4+lldEi2/uZO310MR0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261124155412eucas1p2f62b824c68f30e1a52d7b9d878def311~rBimq-HwK0855908559eucas1p2B;
 Tue, 24 Nov 2026 15:54:12 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261124155410eusmtip15a92a207f9a897eb81d9d5ac72b66abc~rBik9MesT2656326563eusmtip1M;
 Tue, 24 Nov 2026 15:54:10 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 24 Nov 2026 16:52:43 +0100
Subject: [PATCH v8 07/18] drm/bridge: inno-hdmi: Split probe out of bind
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-jh7110-clean-send-v8-7-de92635dd857@samsung.com>
In-Reply-To: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Robert Foss
 <rfoss@kernel.org>,  Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Yakir Yang
 <kuankuan.y@gmail.com>,  Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>,  Conor Dooley <conor@kernel.org>, William Qiu
 <william.qiu@starfivetech.com>,  Xingyu Wu <xingyu.wu@starfivetech.com>,
 Sandy Huang <hjc@rock-chips.com>,  Manivannan Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>,  Byron Stanoszek <gandalf@winds.org>,
 Owen O'Hehir <oo.hehir@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4781;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=jcXvJkngPj8K0oC+gCf19Vgf5aixeuhmBNQVmJeOnJo=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWSzbhZt0r7A3cqzbYbu7Z+plrMM1qddTLl4oXQHg8IVn
 h8fHHZodZSyMIhxMMiKKbKc3RhtJPmP4Wn58ce/YOawMoEMYeDiFICJ1Jow/E/eMbP6YdJ7Re7D
 LksMC5MypZY4npCse8/2c/33u4cTVxxj+CsuPf3g7nnKEieXH5GOvZe7wCTYJ1hM+49qWMWKAFX
 bLVwA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261124155412eucas1p2f62b824c68f30e1a52d7b9d878def311
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261124155412eucas1p2f62b824c68f30e1a52d7b9d878def311
X-EPHeader: CA
X-CMS-RootMailID: 20261124155412eucas1p2f62b824c68f30e1a52d7b9d878def311
References: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
 <CGME20261124155412eucas1p2f62b824c68f30e1a52d7b9d878def311@eucas1p2.samsung.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

inno_hdmi_bind() both sets up the bridge and attaches it to a DRM
encoder. A platform whose HDMI controller is a child of a larger device
needs the first half without the second, since it registers as its own
platform driver and lets the DRM core bind the bridge later.

Move the setup into a new exported inno_hdmi_probe(), and reduce
inno_hdmi_bind() to a wrapper around it. Like inno_hdmi_probe() and
dw_hdmi_bind(), it now takes the platform_device, so the Rockchip glue
does the to_platform_device() conversion instead.

No functional change intended.

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Tested-by: Byron Stanoszek <gandalf@winds.org>
Tested-by: Owen O'Hehir <oo.hehir@gmail.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c            | 39 +++++++++++++++++++++++----
 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c |  2 +-
 include/drm/bridge/inno_hdmi.h                |  6 ++++-
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 48bb19d59314067343db2c1f3fa6be4d3f8dd1da..9368814c1414c2e7a00f44dcced996a397ede150 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -1061,11 +1061,24 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(struct inno_hdmi *hdmi)
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
+ *
+ * It registers the bridge but does not attach it, for glue drivers that probe
+ * as their own platform device rather than through a component bind.
+ *
+ * Return: the inno_hdmi instance on success, or an ERR_PTR() on failure.
+ */
+struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
+				  const struct inno_hdmi_plat_data *plat_data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
+	struct device *dev = &pdev->dev;
 	struct inno_hdmi *hdmi;
 	int irq;
 	int ret;
@@ -1133,7 +1146,23 @@ struct inno_hdmi *inno_hdmi_bind(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	return hdmi;
+}
+EXPORT_SYMBOL_GPL(inno_hdmi_probe);
+
+struct inno_hdmi *inno_hdmi_bind(struct platform_device *pdev,
+				 struct drm_encoder *encoder,
+				 const struct inno_hdmi_plat_data *plat_data)
+{
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
 
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
index 33ff195bd2e65367792710ed2bcfb2f7c217d8e6..1f04489477e07f61e8793e08e03e73566366c725 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
@@ -127,7 +127,7 @@ static int inno_hdmi_rockchip_bind(struct device *dev, struct device *master, vo
 
 	dev_set_drvdata(dev, hdmi);
 
-	hdmi->base = inno_hdmi_bind(dev, encoder, plat_data);
+	hdmi->base = inno_hdmi_bind(to_platform_device(dev), encoder, plat_data);
 
 	connector = drm_bridge_connector_init(drm, encoder);
 	if (IS_ERR(connector)) {
diff --git a/include/drm/bridge/inno_hdmi.h b/include/drm/bridge/inno_hdmi.h
index 5bbcaeea94e2a20fd0dc0ae0c6946eb5604bbaf6..507d5e999183ca02e7dcbe4ce7568acc21426a89 100644
--- a/include/drm/bridge/inno_hdmi.h
+++ b/include/drm/bridge/inno_hdmi.h
@@ -12,6 +12,7 @@ struct device;
 struct drm_encoder;
 struct drm_display_mode;
 struct inno_hdmi;
+struct platform_device;
 
 struct inno_hdmi_plat_ops {
 	void (*enable)(struct device *pdev, struct drm_display_mode *mode);
@@ -29,7 +30,10 @@ struct inno_hdmi_plat_data {
 	struct inno_hdmi_phy_config *default_phy_config;
 };
 
-struct inno_hdmi *inno_hdmi_bind(struct device *pdev,
+struct inno_hdmi *inno_hdmi_bind(struct platform_device *pdev,
 				 struct drm_encoder *encoder,
 				 const struct inno_hdmi_plat_data *plat_data);
+
+struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
+				  const struct inno_hdmi_plat_data *plat_data);
 #endif /* __INNO_HDMI__ */

-- 
2.34.1

