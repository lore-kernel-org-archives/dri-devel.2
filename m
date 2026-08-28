Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637BBC61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6297B10F395;
	Fri, 28 Aug 2026 13:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Wvy6cXGU";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F9B10F382
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:48:25 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260828134823euoutp02dfd5f478982c2c44b5058f7b4ca8ee9e~P-DocgE7o3189331893euoutp02G;
 Fri, 28 Aug 2026 13:48:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260828134823euoutp02dfd5f478982c2c44b5058f7b4ca8ee9e~P-DocgE7o3189331893euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787924903;
 bh=tz/W1Turf35bQC2fQmw20yKKjXpQ52FbmePBeCxUjaQ=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=Wvy6cXGU3FRwXVQg5CdWoi8kuXpo9Uzk9akEiFrEE0iANugYbjm6ZWFY5V3dBoafN
 zPSaX5+MX0R++J55PrqA8QKcPCiRBUPS/+rBfl3TU+05pTLhc5VoODKtqev7tQyZLo
 HcpM6DVpUa+V1hKA4eKOYsrug0Uiy274vIHHYF28=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260828134822eucas1p15d7a98e2e05c51aaacaac5e946337d07~P-DnydCJI0280302803eucas1p1Q;
 Fri, 28 Aug 2026 13:48:22 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260828134821eusmtip1125830265f6655cf1c8de06e0caa93e6~P-DmMb-TN2815728157eusmtip1A;
 Fri, 28 Aug 2026 13:48:21 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 28 Aug 2026 15:47:29 +0200
Subject: [PATCH v2 05/15] drm/bridge: inno-hdmi: Allow the register map to
 come from a parent
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-jh7110-clean-send-v2-5-331680c8b9d1@samsung.com>
In-Reply-To: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
To: Vinod Koul <vkoul@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>,  Robert Foss <rfoss@kernel.org>,  Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,  Simona
 Vetter <simona@ffwll.ch>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>,  Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,  Heiko
 Stuebner <heiko@sntech.de>, Conor Dooley <conor@kernel.org>,  Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>,  Andy Yan
 <andyshrk@163.com>, Marek Szyprowski <m.szyprowski@samsung.com>,  Maud
 Spierings <maudspierings@gocontroll.com>,  Graham Markall
 <hello@big-grey.co.uk>,  Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260828134822eucas1p15d7a98e2e05c51aaacaac5e946337d07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260828134822eucas1p15d7a98e2e05c51aaacaac5e946337d07
X-EPHeader: CA
X-CMS-RootMailID: 20260828134822eucas1p15d7a98e2e05c51aaacaac5e946337d07
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134822eucas1p15d7a98e2e05c51aaacaac5e946337d07@eucas1p1.samsung.com>
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

On some SoCs the HDMI controller does not own its register window. The
StarFive JH7110 documents one 64 KB block, u0_hdmitx, that holds both
the controller and the PHY, so the parent device maps it and owns the
regmap while the two children share it.

Use a regmap supplied by the parent device when there is one, and keep
mapping our own resource when there is not, so platforms that own their
register window are unaffected.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 12fd208d5e852cdcbdebef7853cb4143c5fe1c0f..ebc5093f13ac4f263b903fb727629dfb83d051e1 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -397,6 +397,7 @@ struct inno_hdmi {
 	struct clk *pclk;
 	struct clk *refclk;
 	void __iomem *regs;
+	struct regmap *regmap;
 	struct regmap *grf;
 
 	struct inno_hdmi_i2c *i2c;
@@ -470,11 +471,23 @@ static int inno_hdmi_find_phy_config(struct inno_hdmi *hdmi,
 
 static inline u8 hdmi_readb(struct inno_hdmi *hdmi, u16 offset)
 {
+	u32 val;
+
+	if (hdmi->regmap) {
+		regmap_read(hdmi->regmap, offset * 4, &val);
+		return val;
+	}
+
 	return readl_relaxed(hdmi->regs + (offset) * 0x04);
 }
 
 static inline void hdmi_writeb(struct inno_hdmi *hdmi, u16 offset, u32 val)
 {
+	if (hdmi->regmap) {
+		regmap_write(hdmi->regmap, offset * 4, val);
+		return;
+	}
+
 	writel_relaxed(val, hdmi->regs + (offset) * 0x04);
 }
 
@@ -1095,9 +1108,19 @@ struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
 	hdmi->dev = dev;
 	hdmi->plat_data = plat_data;
 
-	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(hdmi->regs))
-		return ERR_CAST(hdmi->regs);
+	/*
+	 * On platforms where the controller shares a register space with
+	 * other blocks, the parent owns the regmap. Fall back to mapping
+	 * our own resource where it does not.
+	 */
+	if (dev->parent)
+		hdmi->regmap = dev_get_regmap(dev->parent, NULL);
+
+	if (!hdmi->regmap) {
+		hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(hdmi->regs))
+			return ERR_CAST(hdmi->regs);
+	}
 
 	hdmi->pclk = devm_clk_get_enabled(hdmi->dev, "pclk");
 	if (IS_ERR(hdmi->pclk)) {

-- 
2.34.1

