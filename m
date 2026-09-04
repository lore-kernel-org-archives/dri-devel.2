Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCC6C61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC6C10F96B;
	Fri,  4 Sep 2026 13:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="X4alJFAh";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6916A10F957
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:27:47 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260904132746euoutp02317f9999860bc633cc4b58121d4a386f~SISn2zDD32525625256euoutp02S;
 Fri,  4 Sep 2026 13:27:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260904132746euoutp02317f9999860bc633cc4b58121d4a386f~SISn2zDD32525625256euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1788528466;
 bh=Y+0vqJ0NYM3Dng5ZYIoY4i+P6yjASTBFUK6zbbQuTxg=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=X4alJFAhLxvdDFhECWfwyZH22jUzn/LpCS3FGnOXfVHR0SAh7HMQpfqU41HhoN5d1
 CUxGXt5Yr9To5MGonOHmLBhu4gHvLwxHgwkjjQwRlcc8ogIsZl4mYyRsi/VTeieHBV
 G4G5+xNOBl/eaPldSf4n5CiS2I03Dr6rT2ATneYI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260904132745eucas1p1cd078aae0c24302622db6e2e0f617c31~SISnPWdTJ1560415604eucas1p11;
 Fri,  4 Sep 2026 13:27:45 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260904132743eusmtip186dec72c13e302f75e2a0700e1e97482~SISlhpwE01776617766eusmtip1b;
 Fri,  4 Sep 2026 13:27:43 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 04 Sep 2026 15:27:20 +0200
Subject: [PATCH v3 19/19] MAINTAINERS: Add StarFive JH7110 display subsystem
 entry
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-jh7110-clean-send-v3-19-484f9ae72715@samsung.com>
In-Reply-To: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
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
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,  Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Michal Wilczynski
 <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260904132745eucas1p1cd078aae0c24302622db6e2e0f617c31
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260904132745eucas1p1cd078aae0c24302622db6e2e0f617c31
X-EPHeader: CA
X-CMS-RootMailID: 20260904132745eucas1p1cd078aae0c24302622db6e2e0f617c31
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132745eucas1p1cd078aae0c24302622db6e2e0f617c31@eucas1p1.samsung.com>
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

The JH7110 display subsystem spans a PHY driver, a DRM bridge driver,
a parent device and their bindings, and has no existing maintainer entry.

Add an entry covering them so patches reach someone who can review them.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c9dfb48e900df71a86d4686d3ec2c..055a6d0f3967c8171a0c6a3f9dde0ea72f166274 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26078,6 +26078,19 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
 
+STARFIVE JH7110 DISPLAY SUBSYSTEM
+M:	Michal Wilczynski <m.wilczynski@samsung.com>
+R:	Icenowy Zheng <zhengxingda@iscas.ac.cn>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml
+F:	Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsystem.yaml
+F:	Documentation/devicetree/bindings/phy/starfive,jh7110-inno-hdmi-phy.yaml
+F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-vout-subsystem.yaml
+F:	drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
+F:	drivers/phy/starfive/phy-jh7110-inno-hdmi.c
+F:	drivers/soc/starfive/jh7110-hdmi-subsystem.c
+F:	drivers/soc/starfive/jh7110-vout-subsystem.c
+
 STARFIVE JH7110 DPHY RX DRIVER
 M:	Jack Zhu <jack.zhu@starfivetech.com>
 M:	Changhuang Liang <changhuang.liang@starfivetech.com>

-- 
2.34.1

