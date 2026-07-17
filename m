Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B838C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A61D810F533;
	Fri, 17 Jul 2026 12:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="SvW03pgf";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DDB10F533
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:19:00 +0000 (UTC)
Received: from francesco-nb.. (unknown [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id 8559B22734;
 Fri, 17 Jul 2026 14:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1784290739;
 bh=tjucR87tClkz1l16S+aKThSWLFGeiCovQUE3GWKhawk=; h=From:To:Subject;
 b=SvW03pgfGHbcvlEjpleane2zkSv47jHysVnJ90Evye158m0l8ExpCNDEVu1VT94fd
 LtEAmovQ7bafUBcJ9Z3655theSQ7+Q5qaD6NDlIhY37/HzrpOmKOVMB8x1ukBMGXxa
 aRa/sAlNYI/VhFtVdFWFz/HGZY7gADbzQQZ7gAF2JTLo2bDpMTv/gWLTdOKBWO5HKL
 11u4eb4Oz9XgAM3gLYM5ulNg8ufRhKCIKzQucqCqU41584bnhddYQ8TQVNLtcu6M4g
 1SYa0yOTuYLJ/na8xJhY3A9V0TIEkvrl+x4S/Up2d0FKpyJS2WdvuOoR8xi330po9d
 VG9Is131dc91Q==
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
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel format
Date: Fri, 17 Jul 2026 14:18:43 +0200
Message-ID: <20260717121847.488148-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717121847.488148-1-francesco@dolcini.it>
References: <20260717121847.488148-1-francesco@dolcini.it>
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

LCDIF has a hardware-configurable LCD_DATABUS_WIDTH field which selects
the parallel data bus transfer width. The selected mode changes how color
component bits are assigned to the LCD_DATA pins.

This must match the board wiring. On Colibri iMX6ULL, for example, only
18 LCD data lines are routed. A 24-bit panel can still be connected by
wiring the available LCD_DATA signals to the appropriate panel inputs.
Without describing the resulting interface format, LCDIF may assign the
color components to different data lines, causing shifted colors.

Add interface-pix-fmt so the binding can describe the configured LCDIF
bus format. The same property is already used by
display/imx/fsl,imx-parallel-display.yaml.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index 2dd0411ec651..209ee5a96e39 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -58,6 +58,13 @@ properties:
     items:
       - const: rx
 
+  interface-pix-fmt:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - rgb24
+      - rgb565
+      - rgb666
+
   interrupts:
     items:
       - description: LCDIF DMA interrupt
-- 
2.47.3

