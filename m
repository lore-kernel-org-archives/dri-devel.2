Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC93C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 476F510E15A;
	Fri, 28 Aug 2026 13:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="B/w8SZId";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8415D10F3A6
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:48:17 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260828134816euoutp018a0c3e2648795ffd6e03561f443696bd~P-DhYbMaO2677926779euoutp018;
 Fri, 28 Aug 2026 13:48:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260828134816euoutp018a0c3e2648795ffd6e03561f443696bd~P-DhYbMaO2677926779euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787924896;
 bh=uMTpvxWIHTWA5WP2+3K9U8sgXeHo5NdCmMYa7bPSnFI=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=B/w8SZIdtavo0kLqWnRiPR2OA723DIkfCChmZ+OPJqHz5nfOte89SnOIh+yWFQaPv
 NQJxv8AiBNCaZDDSihO5pm6DSn6G7W4nQ3kb3msDcDh8cXjR79awH+wMAIcZIuFwmd
 itwk5250Em5HcXDkBo2frc2bh01uxLTdtk0OEa4U=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260828134815eucas1p2b2aabc17e9cc6346e5a93bde5c650958~P-DhB-03v2418024180eucas1p29;
 Fri, 28 Aug 2026 13:48:15 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260828134813eusmtip1ecc4bb650325f36fd9950693c44853ee~P-DfbWOlr2831928319eusmtip1V;
 Fri, 28 Aug 2026 13:48:13 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 28 Aug 2026 15:47:25 +0200
Subject: [PATCH v2 01/15] dt-bindings: phy: Add starfive,jh7110-inno-hdmi-phy
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-jh7110-clean-send-v2-1-331680c8b9d1@samsung.com>
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
X-CMS-MailID: 20260828134815eucas1p2b2aabc17e9cc6346e5a93bde5c650958
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260828134815eucas1p2b2aabc17e9cc6346e5a93bde5c650958
X-EPHeader: CA
X-CMS-RootMailID: 20260828134815eucas1p2b2aabc17e9cc6346e5a93bde5c650958
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134815eucas1p2b2aabc17e9cc6346e5a93bde5c650958@eucas1p2.samsung.com>
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

Add the dt-binding for the StarFive JH7110 Innosilicon HDMI PHY.

This device is a child of the starfive,jh7110-hdmi-subsystem node. It
functions as both a PHY provider for the controller and as a clock
provider for the variable pixel clock (hdmi_pclk), which it generates
from its refoclk.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../phy/starfive,jh7110-inno-hdmi-phy.yaml         | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-inno-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-inno-hdmi-phy.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b1ab3c555fbf60a971f511af29a03a6b2e4ae097
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-inno-hdmi-phy.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/starfive,jh7110-inno-hdmi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Innosilicon INNO HDMI PHY
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+description:
+  The PHY portion of the StarFive JH7110 INNO HDMI IP.
+
+properties:
+  compatible:
+    const: starfive,jh7110-inno-hdmi-phy
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: refoclk
+
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    const: hdmi_pclk
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - clock-output-names
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  # Shown as a child of the HDMI subsystem node; see
+  # Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsystem.yaml
+  # for the full node.
+  - |
+    phy {
+        compatible = "starfive,jh7110-inno-hdmi-phy";
+        #clock-cells = <0>;
+        clock-output-names = "hdmi_pclk";
+        clocks = <&xin24m>;
+        clock-names = "refoclk";
+        #phy-cells = <0>;
+    };
+
+...

-- 
2.34.1

