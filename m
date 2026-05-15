Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3653DCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B8810F4AE;
	Fri, 15 May 2026 09:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="p0ryn/q/";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 191DD10F4A5
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:10:09 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8BDC19EF;
 Fri, 15 May 2026 11:09:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778836198;
 bh=sQ7dH7dQ/n7Rrc06bQe/1ItYvKBy46snwgvffXpYWQw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=p0ryn/q/koHB4EiO3lUEZBGJiilxYg2Ju3pwaRJUOMw68YWtiDt9cVXiQ4C+H8Did
 nObo5oRehPB4FD7buNzVMzIStwCmCtx1JqMGya1UjIQSfojdL2vHklf8+OHu2AfCXR
 VQyD1FQRerLK9u+x0h3Mb3yV3DKMtaMeUm0fsTdg=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Fri, 15 May 2026 12:09:32 +0300
Subject: [PATCH v3 7/7] arm64: dts: renesas: white-hawk: Add second mini-DP
 output support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-rcar-du-dsc-v3-7-164157820498@ideasonboard.com>
References: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
In-Reply-To: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2737;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=C9rP9GABvcYb9jE1vUzXF6HhHnFgCbKipQ/Ea+SbMGY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBuLiiTqP0RYYEkYtroljiEpni+J1CY4V6VoG8
 JXMaS1cCKKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagbi4gAKCRD6PaqMvJYe
 9SBaEACOaDZzTIQrGoWXa20lEGTRBsBiOPRk39I3W4jUj2vT/HXxsm754izvyNcLrExit01qCd+
 0Dyqc8bdMokPw+kZ9tgcrgpNygj0GhyCKOQUgWNEIoQz8B4C9R9xbf7ytyhZV7RsDDLWKMTgbGo
 UFFvlY215G98Woio/0cc31juMbD/c2QIgS393VE57YTCnhibSXTgNx2pRBxg0l5IWLlMZZ7T09j
 cTCUq4mbClqGEXyjT6pQkj1357ODLklbv7DJexilLJdhTllNuiFD4C041C8oOyGhacqlF2q3gvf
 RpfEbfdmRpNxeDEiH0kckpiEUhSEC0NdrGf4wlH79b7kMisNDFib44xrT8Ou6k8iR801Mfr3dK7
 8fBfvQjSZjm7bRCIcNpR6eCMekjYtFcRhknWIT1MypuQnO7+1vH6eFEeypoQ+r5pwfiyIBqL6zK
 vZaIn+4BG3qZHKGbnvuQCgy3cWxZTs0ujKIFCqfnb9xqmJNXtt+I75atA9Xi1F8syp6wvPg9Vyy
 hWTl5euKDxQE1vbl8FY+U7parLfPJgfOJCDJG3wpSMa5g08p63E/w+QR8E2fejHGYwSv7qqgIOU
 sxrmtu+HcF/Rl64O2XqqStalOCKhN4QxLswKXuDaweH3EZTkwHHCYSDezJrc+JmgXVehZIqKYTG
 jLnzcMA7RbZc6rg==
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add support for the mini-DisplayPort connector on the White Hawk
BreakOut board.  This port is driven by a TI SN65DSI86 DSI to eDP
bridge, which in turn gets the pixel data from the second DSI channel on
the R-Car V4H SoC.  Note that this port is not present on the White Hawk
Single development board.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[tomi.valkeinen: added status=okay for dsc]
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 .../arm64/boot/dts/renesas/r8a779g0-white-hawk.dts | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts
index 784d4e8b204c..89d60b83ac4f 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts
@@ -12,4 +12,98 @@
 / {
 	model = "Renesas White Hawk CPU and Breakout boards based on r8a779g0";
 	compatible = "renesas,white-hawk-breakout", "renesas,white-hawk-cpu", "renesas,r8a779g0";
+
+	sn65dsi86_refclk2: clk-x16 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <38400000>;
+	};
+
+	mini-dp-con2 {
+		compatible = "dp-connector";
+		label = "CN15";
+		type = "mini";
+
+		port {
+			mini_dp_con_in2: endpoint {
+				remote-endpoint = <&sn65dsi86_out2>;
+			};
+		};
+	};
+};
+
+&dsc {
+	status = "okay";
+};
+
+&dsi1 {
+	status = "okay";
+
+	ports {
+		port@1 {
+			dsi1_out: endpoint {
+				remote-endpoint = <&sn65dsi86_in2>;
+				data-lanes = <1 2 3 4>;
+			};
+		};
+	};
+};
+
+&i2c4 {
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	bridge@2c {
+		pinctrl-0 = <&irq1_pins>;
+		pinctrl-names = "default";
+
+		compatible = "ti,sn65dsi86";
+		reg = <0x2c>;
+
+		clocks = <&sn65dsi86_refclk2>;
+		clock-names = "refclk";
+
+		interrupts-extended = <&intc_ex 1 IRQ_TYPE_LEVEL_HIGH>;
+
+		enable-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+
+		vccio-supply = <&reg_1p8v>;
+		vpll-supply = <&reg_1p8v>;
+		vcca-supply = <&reg_1p2v>;
+		vcc-supply = <&reg_1p2v>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				sn65dsi86_in2: endpoint {
+					remote-endpoint = <&dsi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				sn65dsi86_out2: endpoint {
+					remote-endpoint = <&mini_dp_con_in2>;
+				};
+			};
+		};
+	};
+};
+
+&pfc {
+	i2c4_pins: i2c4 {
+		groups = "i2c4";
+		function = "i2c4";
+	};
+
+	irq1_pins: irq1 {
+		groups = "intc_ex_irq1_a";
+		function = "intc_ex";
+	};
 };

-- 
2.43.0

