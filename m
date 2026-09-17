Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D92C982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6071510E731;
	Thu, 17 Sep 2026 14:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="TtipBJko";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DAF010E708
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:00:55 +0000 (UTC)
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net
 [178.82.167.143])
 by mail11.truemail.it (Postfix) with ESMTPA id 282F622817;
 Thu, 17 Sep 2026 16:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1789653654;
 bh=PFbHrnCbgfpqZStiZJ8Sb/nHDFg7+/3mGwQ68I1HP3A=; h=From:To:Subject;
 b=TtipBJkoMi6cb3iVLiD7pa++jODJA5EF5UJJPbuB9G6kDhgrasJYojd+g6IDXKSFf
 u7BGs/ZojQDywBeGS0BBpSeSaMlGYE3MXoYcuYNvRL+yMMYRjF8ED2I3jNt8J9rYiy
 uJHbWWqGoEcb88/dq1g8IzYQG+wWNizk5rBGXEEm8/4yILdEneOa584tOTyz7Y1SDm
 HXxHTw7d23EXswFiPYpgDJjH6UJro2SqFlktKmRtDlpc+NWA639jJFdfECov5xzc11
 cGJJUFBwQXHI63P3x0zuSBVHpicWZrhQTL9qso4uu66THawaE32dNtIiS0i8dBzzyT
 p2aZV/IBs/LeA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Subject: [PATCH v5 3/4] ARM: dts: imx6ull-colibri: Set LCDIF bus width
Date: Thu, 17 Sep 2026 16:00:38 +0200
Message-ID: <20260917140042.118181-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917140042.118181-1-francesco@dolcini.it>
References: <20260917140042.118181-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The Colibri family standard defines an 18-bit parallel RGB interface on
the edge connector. The additional six LCDIF data signals required for a
24-bit interface are mapped to module-specific pins whose location is not
fixed across the Colibri family and which may not be available at all.

Generic Colibri carrier boards can therefore only rely on an 18-bit
interface. Set the LCDIF bus-width property accordingly.

A 24-bit interface can still be used by a specific carrier and module
combination by overriding the property in the carrier board device tree.

Link: https://docs.toradex.com/104446-colibri-arm-som-imx6ull-datasheet.pdf
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v5: improved commit message, added rev-by
v4: no changes
v3: no changes
v2: use the common bus-width property instead of the legacy interface-pix-fmt
---
 arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
index ec3c1e7301f4..1eb1cf2d7395 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi
@@ -229,6 +229,7 @@ &lcdif {
 
 	port {
 		lcdif_out: endpoint {
+			bus-width = <18>;
 			remote-endpoint = <&lcd_panel_in>;
 		};
 	};
-- 
2.47.3

