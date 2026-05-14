Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261F9CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6788710E5FE;
	Thu, 14 May 2026 12:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YQYjIDhh";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4998C10E5FE
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:25:31 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D432D18E9;
 Thu, 14 May 2026 14:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778761521;
 bh=CIep6fJfVAhn74HMjDE/V/v4KeGkg+5aWPNFXSJzT0U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YQYjIDhhkCHX8nArOf2h6dbnWacNVL70EWQkXCc2DJHlBaDUz85dJsBY97GCRVyFV
 mbr2VgnaU0nQriM19y1Tivxj8pdIf9d4pluL/qocq23/spJ4H1oGfKJmnbwZtmtiis
 gxUcFGHyeMBlAtjLkdJjTuYm8tjXqIeYmPthQbwo=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Thu, 14 May 2026 15:24:57 +0300
Subject: [PATCH 5/5] arm64: dts: renesas: Add Renesas R-Car V4H DSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-rcar-du-dsc-v1-5-d65f7a9e9841@ideasonboard.com>
References: <20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com>
In-Reply-To: <20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=zG6hvH8cY6/FnPokxtHg066A+36wEiN+1/jJynaivt4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBb8wHjTOJGQXLyHTo6PmhuCSYT02JRE/rO4wV
 YUftPFPBdmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagW/MAAKCRD6PaqMvJYe
 9fbkD/9R5Ih+b15fuThFLtbiiOt5NFTKqAxVt3j+l9D+ymrjBkXmlat1+kWdrwl2BizAvoX+NJj
 FOgZp68ziea6NeZsYr297co/P6SqSbK99C8nmi1YYZEE1BF+YOF23TZwFBusEs80iox/T40xEOK
 grGNDkKfrkKECs9rftl4ZCEO1vCV3NcM57dl4lKq61WsDcjVMxaBn5a9bC1qWbhhP4C2I0TROB2
 Abg1bgyLLPb1J9+OsuMH4J0+DKLLgMzikayLHEH6cHAlvtqzaX5H9E9JwrokrfdGnZbljUFVug1
 mTY0DS3fwCTgaq5Ce8/lLb+cbBqYSS8i23eJSyoMPh2zeoGkRaWruryhEP0Gc0/yQnZD4AASoZ0
 ei/hUnO2ywY3ywWerQu5hPLPJB8sfsJ++kRHryhjPzYyhWVPS5mCRG5u2SuIZE9Iz2E/vKHsV80
 D8+agw6/gRq4LTBr+Q/9l8zjEoOsl8RoiwZrFeGyJhiKqpyul9GUWbSlW6UeMSFQGIV+pF+58Ji
 OfCjMMmN5kYDlbVcCbyiEcNm0InHIGw1ZnJY5x5DsFNnBaSWPSkRay/b6UEG7bGzped+D+EHV9h
 ghuycW6O7aflAgzP6GMn5nAmK3wMOQuHXdYIbETGdgIc+FyOwnoldCjBiQCESWfhqDK8bjxqAwF
 65A5IMq/z2e367g==
X-Developer-Key: i=tomi.valkeinen+renesas@ideasonboard.com; a=openpgp;
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

The Renesas DSC Display Stream Compression is a bridge embedded in the
Renesas R-Car V4H SoC. The bridge is placed between DU and DSI1 units.
Describe the bridge in DT and enable it on Retronix Sparrow Hawk board
to keep DSI1 operational on this board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi          | 31 +++++++++++++++++++++-
 .../boot/dts/renesas/r8a779g3-sparrow-hawk.dts     |  5 ++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 82a7278836e5..52a6176f9fd0 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -2298,6 +2298,35 @@ du_out_dsi0: endpoint {
 				port@1 {
 					reg = <1>;
 					du_out_dsi1: endpoint {
+						remote-endpoint = <&dsc_in_dsi1>;
+					};
+				};
+			};
+		};
+
+		dsc: dsc@feb8d000 {
+			compatible = "renesas,r8a779g0-dsc";
+			reg = <0 0xfeb8d000 0 0x400>;
+			interrupts = <GIC_SPI 559 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 2819>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 2819>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dsc_in_dsi1: endpoint {
+						remote-endpoint = <&du_out_dsi1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					dsc_out_dsi1: endpoint {
 						remote-endpoint = <&dsi1_in>;
 					};
 				};
@@ -2534,7 +2563,7 @@ ports {
 				port@0 {
 					reg = <0>;
 					dsi1_in: endpoint {
-						remote-endpoint = <&du_out_dsi1>;
+						remote-endpoint = <&dsc_out_dsi1>;
 					};
 				};
 
diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
index 812b133cf29e..f418998c6b05 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
@@ -288,6 +288,11 @@ channel4 {
 	};
 };
 
+/* Page 27 / DSI to Display */
+&dsc {
+	status = "okay";
+};
+
 /* Page 27 / DSI to Display */
 &dsi1 {
 	status = "okay";

-- 
2.43.0

