Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6966ACD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19A910F45C;
	Fri, 15 May 2026 07:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aCZlCXTk";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B1110F45C
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:56:50 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F793149B;
 Fri, 15 May 2026 09:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778831799;
 bh=CIep6fJfVAhn74HMjDE/V/v4KeGkg+5aWPNFXSJzT0U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aCZlCXTk+ribB7Tk1Q7yeYzLxt6LMShlYBE0PNZyH9MfLrLLjqizIWyfcyltTjwDV
 1DLhqzDIDgRs4NgeIhzut3F5OI4rDJzfrxxShbry3GyU++jFgWt0OsTOXc10uNIN4B
 yRd5Z0NO6euV75McqAheWzuiMQH5UyL5RF8uCtVE=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Fri, 15 May 2026 10:56:18 +0300
Subject: [PATCH v2 5/5] arm64: dts: renesas: Add Renesas R-Car V4H DSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-rcar-du-dsc-v2-5-f6b9240a1240@ideasonboard.com>
References: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
In-Reply-To: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=zG6hvH8cY6/FnPokxtHg066A+36wEiN+1/jJynaivt4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBtG3V2D0sCuzzvIDDLjNaQOoP5/uI2Jk+MiI7
 i6zYEAqkLiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagbRtwAKCRD6PaqMvJYe
 9bquEACSnIb46pwik25cjMRUVn+aEm5XkfmxwAfDli3vvEHCOplKE58rCCuu1iBkYV12VEljdC5
 aonBbYx+AAJIIugqaOtB4nklDSvTbb8y9m6Fr5kF/dFF74tFGwjqSve0GlRjOxrAc09fu5RptjK
 eYvWzAT8ANlqiK4brTDpGjict2pfpzIb5uNCwAtGGc0sdZova7Lj4gHMyJfXoR/8YNTrhSq7ApB
 8lyTIE7z8jzWDTXmSkCYgTnVDU4GZoVVATVihaTyIwtGGFwCQL/TIG0WXP3XjocZ00KRKRnhTAH
 LLBSbLOi2+NwgLqJElDhZljOh4dmd5KwE7aUyDbMIVd4GQI5Hle7IPR2365cr6K91QgGwffRRji
 LV/1BVeH0nydxP3R6l6ECkP4GAJV/5yGJy4GMFazsxUbuzWY84dO5orNBvN+d8Px+CC9pCE7pov
 Je8tSEp97vbZ5bLkjqVYdM5hpaW75jpFJvcZEuRq3A6kkEAEUsDPByHEc2sPeoMPIYK46LucW8v
 WEd7gudjM1p0hWx7Rbik39hPuuxeuNxQX9HFV9UNpB4Ta89eenZKMF1BVYY+ilPK75Cg3thi/gk
 7Woz7WZpEWQ6hshKvfMvyBcMEfswnVKNHPuzVJlGCxPfRBk/2ok/q30rttslGLZgmJbIjquIsge
 uE0ssPXJUla4i9Q==
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

