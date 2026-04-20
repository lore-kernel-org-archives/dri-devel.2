Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413F6F588C1
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F04B10E59F;
	Mon, 20 Apr 2026 12:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Z0fQarDf";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B7B110E05F
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:54:38 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id BC1CF2686;
 Mon, 20 Apr 2026 14:52:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776689580;
 bh=Oiz5DcZZ+DuJWvzr1nBXRDeSsfJx63ROnXwUjMVTm5E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Z0fQarDfz5TN93BteK/73IdldZ9LSM3BkYAPYPyadjRjphF0n0nLgPURDQ+GoCUh0
 L6or1eF7gl+byO1t6xYfQw/k3mo9LCDJzsN5X0X116nE46co+zCrka0ogDwDhKFMlo
 ItUI1h8rqsgsbE9FQE2iCflhcIRl1rRnxFm4HB0g=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 20 Apr 2026 15:54:10 +0300
Subject: [PATCH 03/15] dt-bindings: mfd: syscon: Add
 ti,am625-dss-dpi0-clk-ctrl compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-beagley-ai-display-v1-3-f628543dfd14@ideasonboard.com>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
In-Reply-To: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Oiz5DcZZ+DuJWvzr1nBXRDeSsfJx63ROnXwUjMVTm5E=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp5iID3mds9SIGbvEfz3naXxh1VwFLf/K4KaPwa
 DniCJqKzDCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeYiAwAKCRD6PaqMvJYe
 9RM2D/99FJ31zzsAadlo21e9gejFxnhb5q1nSdT9HU2ATpl2ylnO+m4rEbuSDHt+W+w/Ivk63Ec
 ylN4TYhj6N3SfQEabifUg+O1y/Qe50x8Be2MpHa+Vwh6F0+q/ANwHxRd/z9RucYf/xyJSbo7Bau
 S9koUaHDktjz5200XA2nqTmlGamu4PSWMHqC2z6fkUV0GJkeKQDLY0jp3ulKJDbmsMHl+809IZ+
 EZP3nw0fJ3m1jN3/LY3pEgFRC5FIQEEreaRstmsszYDJKbopK7o7pkdIgc4hC1ZAkrGoMmvWhGi
 H8uD1YXL38SRyPYO50IcJaQqAWGirG+G11t2BOEjBGbHKl2si9J05ZOD93jyKOGG9kKgiVbd0OS
 Aik5EpIOWj5WitSWdWtNNPs5fW1fGrLv4eBZaHbML9Y9MndsVSsJgvCVvOxFKafoG1UEVQM5an3
 eR7LLDUB5uL6I9qKRbZ8gtEQ4YYo2vvOT16m+V2TmOUlE6xdwhmheu9tatOxG8W0FPeZ+qWFSoC
 BrijYGMsJYYF6wO4VpUWJEKRoxfJ6XTWHv3Aygijv0b1uMlFPtGAeTuWESTJ+MAAmUramda0ag+
 2g4xzVY7NZk5HVGT31A2oPj7BcYhg9+xQSWy1WpskMY4pOK+yX/Y7O9O8VhwP3Y/1Nz0AZfC//J
 pIZU1A49H0xqAfA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

The DPI output pipeline in K3 SoCs contains the display subsystem (DSS)
which produces the in-SoC parallel video signal, and a DPI block which
adjusts the signal to the external MIPI DPI output.

The DSS IP has registers to configure whether the data and sync signals
are driven on rising or falling clock edge, and on some SoCs these are
automatically conveyed to the DPI block which needs that configuration
to properly output the MIPI DPI signal.

However, on some SoCs the DPI block configuration has to be done
manually, using an extra register outside the DSS, DPI0_CLK_CTRL in
MAIN_CTRL_MMR_CFG0 block, which controls the DPI block's behavior. Note
that while the register is named "CLK_CTRL", it's not really related to
clocks, but the sync and data signals.

Currently the DPI0_CLK_CTRL is never written, so it's always 0, meaning
the data and sync are always driven on a rising clock edge regardless of
the DSS configuration.

DPI0_CLK_CTRL register seems to be an independent "quirk" register,
inside MAIN_CTRL_MMR_CFG0 block, which contains general purpose system
registers. The registers surrounding DPI0_CLK_CTRL seem to be controlled
by the system firmware or linux clock drivers. So, it is just this
single register we can map, and we can't create a syscon node for the
whole (or big parts of) MAIN_CTRL_MMR_CFG0.

I see two options to handle the register:

1) We could add that single register to the DSS binding as a new reg
   block. That feels wrong, as it's not a DSS register.
2) Add it as a syscon node, which can then be used by tidss driver.
   It is a bit silly to create a syscon node for a single 32-bit
   register, though.

Neither option feels good, but I do lean towards the latter approach.

Add 'ti,am625-dss-dpi0-clk-ctrl' compatible to syscon.yaml so we can add
the syscon node for the register.

Original patch from Louis Chauvet <louis.chauvet@bootlin.com>

Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1228207/am62a7-rgb-display-flickering-and-pixel-issue/
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index e57add2bacd3..415cc21fd328 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -126,6 +126,7 @@ select:
           - ti,am62-opp-efuse-table
           - ti,am62-usb-phy-ctrl
           - ti,am625-dss-oldi-io-ctrl
+          - ti,am625-dss-dpi0-clk-ctrl
           - ti,am62p-cpsw-mac-efuse
           - ti,am654-dss-oldi-io-ctrl
           - ti,j784s4-acspcie-proxy-ctrl
@@ -239,6 +240,7 @@ properties:
               - ti,am62-opp-efuse-table
               - ti,am62-usb-phy-ctrl
               - ti,am625-dss-oldi-io-ctrl
+              - ti,am625-dss-dpi0-clk-ctrl
               - ti,am62p-cpsw-mac-efuse
               - ti,am654-dss-oldi-io-ctrl
               - ti,j784s4-acspcie-proxy-ctrl

-- 
2.43.0

