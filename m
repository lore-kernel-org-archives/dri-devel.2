Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFBE6083600
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=ve05YNgq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AFB6112DD4;
	Fri,  6 Nov 2026 13:59:22 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBCB112DB7
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:59:08 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261106135906euoutp01242be43f0a893b0fcbd059f1e0fbc795~leW_iHHW50203402034euoutp01P;
 Fri,  6 Nov 2026 13:59:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261106135906euoutp01242be43f0a893b0fcbd059f1e0fbc795~leW_iHHW50203402034euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793973547;
 bh=/3KceGI8tevjeMAc5p6gBD6k/sRI+27w7Vfy8EdpXIo=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=ve05YNgq5O2+klCMWPpjm9X2VrB5kUkUe7pKfHv1QQmb4t5T/qVsccLdEZOLC1S4x
 e4Bvr6qeSdxI35hd2tATsdr9lhv59t9P1MWvL6mveSl5It8vPTcGkjVpRX8L76nQWC
 Zuy0WnjHOPDMyqETu2+eHBBMV7nht/e//+eTURa8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261106135906eucas1p2c3d4a479c32e76358b3421ad18669af1~leW_P1XIl1705017050eucas1p2B;
 Fri,  6 Nov 2026 13:59:06 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261106135904eusmtip1c6eebbd7e01c9c4442292b1ce08a6963~leW8enwxY0678706787eusmtip1U;
 Fri,  6 Nov 2026 13:59:04 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 06 Nov 2026 14:58:43 +0100
Subject: [PATCH v7 09/19] drm/bridge: inno-hdmi: Use a regmap for register
 access
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-jh7110-clean-send-v7-9-68f7ea9913db@samsung.com>
In-Reply-To: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
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
 <cristian.ciocaltea@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3645;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=cHmSf28NaXYp/pbjB3hJNBZgPy6fnc9jpetj7Bfi7HM=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWS9vStunJ15PXtzxhfvtgNX4lK6hRbET4nW/8QzfV9ic
 fjUwm89HaUsDGIcDLJiiixnN0YbSf5jeFp+/PEvmDmsTCBDGLg4BWAiU38wMnyedkYgoviNv0/U
 t05Bz5pD7nPOi4atEY2qLburtcA+ZhfD/+jeR/tW3ptj3uHx85nd44id0sKMs09rtUrPffrNcrv
 sGQYA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261106135906eucas1p2c3d4a479c32e76358b3421ad18669af1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106135906eucas1p2c3d4a479c32e76358b3421ad18669af1
X-EPHeader: CA
X-CMS-RootMailID: 20261106135906eucas1p2c3d4a479c32e76358b3421ad18669af1
References: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
 <CGME20261106135906eucas1p2c3d4a479c32e76358b3421ad18669af1@eucas1p2.samsung.com>
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

On some SoCs the HDMI controller does not own its register window. The
StarFive JH7110 documents one 64 KB block, u0_hdmitx, that holds both
the controller and the PHY, so the parent device maps it and owns the
regmap while the two children share it.

Access the registers through a regmap. Use the one supplied by the
parent device when there is one, and otherwise create an MMIO regmap
over our own resource. The MMIO regmap uses 32-bit accesses with a
4-byte stride, matching the readl_relaxed() and writel_relaxed() calls
it replaces, so the Rockchip platforms see the same register accesses.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/Kconfig     |  1 +
 drivers/gpu/drm/bridge/inno-hdmi.c | 39 ++++++++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c7da6b02d7b6b281f328fb3016ea2f167f8da093..34bcee88170317a4796178452ab5d2e673daf1fd 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -105,6 +105,7 @@ config DRM_INNO_HDMI
 	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
+	select REGMAP_MMIO
 
 config DRM_ITE_IT6263
 	tristate "ITE IT6263 LVDS/HDMI bridge"
diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index aa64ffdbd30721603aebbcd5d5747851be789911..05007ed1d7af0b0f72721a0fd4def08fa621b525 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -396,7 +396,7 @@ struct inno_hdmi {
 	struct drm_bridge bridge;
 	struct clk *pclk;
 	struct clk *refclk;
-	void __iomem *regs;
+	struct regmap *regmap;
 	struct regmap *grf;
 
 	struct inno_hdmi_i2c *i2c;
@@ -468,14 +468,25 @@ static int inno_hdmi_find_phy_config(struct inno_hdmi *hdmi,
 	return -EINVAL;
 }
 
+static const struct regmap_config inno_hdmi_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 static inline u8 hdmi_readb(struct inno_hdmi *hdmi, u16 offset)
 {
-	return readl_relaxed(hdmi->regs + (offset) * 0x04);
+	u32 val;
+
+	if (regmap_read(hdmi->regmap, offset * 4, &val))
+		return 0;
+
+	return val;
 }
 
 static inline void hdmi_writeb(struct inno_hdmi *hdmi, u16 offset, u32 val)
 {
-	writel_relaxed(val, hdmi->regs + (offset) * 0x04);
+	regmap_write(hdmi->regmap, offset * 4, val);
 }
 
 static inline void hdmi_modb(struct inno_hdmi *hdmi, u16 offset,
@@ -1082,6 +1093,7 @@ struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct inno_hdmi *hdmi;
+	void __iomem *regs;
 	int irq;
 	int ret;
 
@@ -1097,9 +1109,24 @@ struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
 	hdmi->dev = dev;
 	hdmi->plat_data = plat_data;
 
-	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(hdmi->regs))
-		return ERR_CAST(hdmi->regs);
+	/*
+	 * On platforms where the controller shares a register space with
+	 * other blocks, the parent owns the regmap. Otherwise map our own
+	 * resource.
+	 */
+	if (dev->parent)
+		hdmi->regmap = dev_get_regmap(dev->parent, NULL);
+
+	if (!hdmi->regmap) {
+		regs = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(regs))
+			return ERR_CAST(regs);
+
+		hdmi->regmap = devm_regmap_init_mmio(dev, regs,
+						     &inno_hdmi_regmap_config);
+		if (IS_ERR(hdmi->regmap))
+			return ERR_CAST(hdmi->regmap);
+	}
 
 	hdmi->pclk = devm_clk_get_enabled(hdmi->dev, "pclk");
 	if (IS_ERR(hdmi->pclk)) {

-- 
2.34.1

