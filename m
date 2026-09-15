Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021F8C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC8110F254;
	Tue, 15 Sep 2026 15:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="jc/ZUlIg";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D720F10EB25
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:32:33 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260915153232euoutp01f4930296186b2645e39fd5e3e859c991~ViFtEyF8V0794407944euoutp01S;
 Tue, 15 Sep 2026 15:32:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260915153232euoutp01f4930296186b2645e39fd5e3e859c991~ViFtEyF8V0794407944euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789486352;
 bh=nXZgelnNzGUrF2EXNePQXIahF9E5vFNeqohz/w8zOho=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=jc/ZUlIg4HTF2p8JCNN3vddFqrI0tBuJoufFr4vD6lhTOFOURDZR3RhjdAZCyzxCp
 pl2zrFZRwCiDMvoTkuysiEI8YsiLiHR2J7KpgknDqQEAByfogc3TulJH7g7eteqBcN
 BI+H+kQH3CzVW01Lxx1OtaJEL9iT0cWUjc7uT79I=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153231eucas1p1e106fee2d6f7db2aa8bb93d18d0f5dc1~ViFr7_A351220612206eucas1p1O;
 Tue, 15 Sep 2026 15:32:31 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153229eusmtip195a81a7500ab28abebd77ec7de0ee7a6~ViFqXgBIs0604306043eusmtip1j;
 Tue, 15 Sep 2026 15:32:29 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 15 Sep 2026 17:32:18 +0200
Subject: [PATCH v4 10/20] drm/bridge: inno-hdmi: Add .mode_valid platform
 operation
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-jh7110-clean-send-v4-10-f0e4fd6f2cc8@samsung.com>
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
X-CMS-MailID: 20260915153231eucas1p1e106fee2d6f7db2aa8bb93d18d0f5dc1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153231eucas1p1e106fee2d6f7db2aa8bb93d18d0f5dc1
X-EPHeader: CA
X-CMS-RootMailID: 20260915153231eucas1p1e106fee2d6f7db2aa8bb93d18d0f5dc1
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153231eucas1p1e106fee2d6f7db2aa8bb93d18d0f5dc1@eucas1p1.samsung.com>
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

inno_hdmi_bridge_mode_valid() validates the pixel clock against
hdmi->refclk, but that clock is optional and is only present on
platforms that describe a "ref" clock. Platforms where the pixel clock
is produced by a separate device - such as the StarFive JH7110, whose
PHY is both the clock and the PHY provider - have no "ref" clock, so
the check is skipped entirely and every mode is reported as valid.

A mode the platform cannot generate is then advertised to userspace.
The subsequent modeset appears to succeed, since the atomic enable path
cannot fail, and the display silently stays blank.

Add a .mode_valid platform operation so platforms can reject modes they
are unable to drive. Platforms that do not implement it are unaffected.

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 9 +++++++++
 include/drm/bridge/inno_hdmi.h     | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 06917e83c5e530d158a06ae2a877e78e22ed842d..00450250336adb9530894af767034572d775a8df 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -823,6 +823,7 @@ static enum drm_mode_status inno_hdmi_bridge_mode_valid(struct drm_bridge *bridg
 							const struct drm_display_mode *mode)
 {
 	struct inno_hdmi *hdmi = bridge_to_inno_hdmi(bridge);
+	const struct inno_hdmi_plat_ops *plat_ops = hdmi->plat_data->ops;
 	unsigned long mpixelclk, max_tolerance;
 	long rounded_refclk;
 
@@ -838,6 +839,14 @@ static enum drm_mode_status inno_hdmi_bridge_mode_valid(struct drm_bridge *bridg
 	if (inno_hdmi_find_phy_config(hdmi, mpixelclk) < 0)
 		return MODE_CLOCK_HIGH;
 
+	if (plat_ops && plat_ops->mode_valid) {
+		enum drm_mode_status status;
+
+		status = plat_ops->mode_valid(hdmi->dev, mode);
+		if (status != MODE_OK)
+			return status;
+	}
+
 	if (hdmi->refclk) {
 		rounded_refclk = clk_round_rate(hdmi->refclk, mpixelclk);
 		if (rounded_refclk < 0)
diff --git a/include/drm/bridge/inno_hdmi.h b/include/drm/bridge/inno_hdmi.h
index 5fca651c56b056d814124aa9c7e91aa7fd7ed1cd..1e9974401c39e3773bb339eaec0b45ff1dd9c975 100644
--- a/include/drm/bridge/inno_hdmi.h
+++ b/include/drm/bridge/inno_hdmi.h
@@ -8,15 +8,18 @@
 
 #include <linux/types.h>
 
+#include <drm/drm_modes.h>
+
 struct device;
 struct drm_encoder;
-struct drm_display_mode;
 struct inno_hdmi;
 struct platform_device;
 
 struct inno_hdmi_plat_ops {
 	void (*enable)(struct device *pdev, struct drm_display_mode *mode);
 	void (*disable)(struct device *pdev);
+	enum drm_mode_status (*mode_valid)(struct device *pdev,
+					   const struct drm_display_mode *mode);
 };
 
 struct inno_hdmi_phy_config {

-- 
2.34.1

