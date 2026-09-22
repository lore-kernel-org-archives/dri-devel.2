Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED989C98304
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9AA610EB12;
	Tue, 22 Sep 2026 06:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="3YfTvu3Y";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D6A10E65E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
 Reply-To:Content-ID:Content-Description;
 bh=qi+MaOlSGpl/UUecjy/28ZAgDgwsiLraw70UPSo95Vg=; t=1790057855; x=1791267455; 
 b=3YfTvu3YWckhUvZrdB69pb2lFV0WVjUV7hmKAfHv1PShDykjrRigd/aS4+29yZbWA77DAtzKLui
 U8KWniJSGN2YFRsfeGC1/KHUWL5aYNwX21pnHV2hLl+YtJ1hiFH6ucoL73fxed49hFdRC8QRvWebn
 EWWvVlpoyvaQ5EWZcPogHCOLD6Is+YUCe9AwSd6iZcGwu1/+A+Qd00Rtpvs8+rMRZTg3jAqNNyaYV
 tzJAAOFpgYNIMtBNdsprYc+x4ch2acAKwU31Mm6gObWmKSxx994z5iVW65C/HEKvUTEjzWlHao71v
 ewa3pCvdr5P4VvGPEg1+ffhClA4tGBLy2cOw==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:06 +0200
Subject: [PATCH RFC 9/9] ARM: dts: ti/omap: omap4-embt2ws: Add displays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-9-45ff36b364cf@kemnade.info>
References: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
In-Reply-To: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 hns@goldelico.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=3329; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=mV1ffW5qREuPIii6GlOu11q/oHXgWJFzo/LvMNKCgQs=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBOn/WsLTWp0vhN8ask1Z5GVm2tKzih1n5vgy+41/
 abKlhNFHaUsDGJcDLJiiiy/rBXcPqk8yw2eGmEPM4eVCWQIAxenAExE9z0jw9N+vbKD1bwigr+f
 fzT8rl3yQbM9m9PQ7qv1vIafUwSOlDEynNFu8RNVvxVyX4vz2kEvtfUnuFdrZF6pT6qWnvCU6dt
 xNgA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
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

Add the displays. They are behind a DSI to DPI bridge. Specifying the
required clock needs some more thought to find a sane rate, so leave it
out for now. Also do not enable the shared reset line yet, to have some
more recovery chances in case of possible display initialisation problems.
There were situations in development where displays suddenly work in a
sane way after several resets.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts | 120 ++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
index e11d1931c42a..856b92fb1866 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
@@ -120,6 +120,12 @@ lb_v50: regulator-lb-v50 {
 		enable-active-high;
 	};
 
+	unknown_reg: regulator-unknown {
+		compatible = "regulator-fixed";
+		regulator-name = "unknown";
+		regulator-always-on;
+	};
+
 	wl12xx_pwrseq: wl12xx-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&twl 1>;
@@ -140,6 +146,120 @@ wl12xx_vmmc: wl12xx-vmmc {
 	};
 };
 
+&dss {
+	status = "okay";
+};
+
+&dsi1 {
+	status = "okay";
+
+	bridge@0 {
+		compatible = "toshiba,tc358762";
+		dsi-lanes = <2>;
+		reg = <0>;
+		vddc-supply = <&unknown_reg>;
+		/* reset-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>; */
+		toshiba,lptxtimecnt = <7>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				bridge_in_right: endpoint {
+					remote-endpoint = <&dsi_out_right>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				bridge_out_right: endpoint {
+					remote-endpoint = <&panel_in_right>;
+				};
+			};
+		};
+
+		spi {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			display@0 {
+				compatible = "epson,panel-bt200";
+				reg = <0>;
+
+				port {
+					panel_in_right: endpoint {
+						remote-endpoint = <&bridge_out_right>;
+					};
+				};
+			};
+		};
+	};
+
+	port {
+		dsi_out_right: endpoint {
+			remote-endpoint = <&bridge_in_right>;
+			lanes = <2 3 4 5 0 1>;
+		};
+	};
+};
+
+&dsi2 {
+	status = "okay";
+
+	bridge@0 {
+		compatible = "toshiba,tc358762";
+		reg = <0>;
+		dsi-lanes = <2>;
+		toshiba,lptxtimecnt = <7>;
+		vddc-supply = <&unknown_reg>;
+		/* reset-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>; */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				bridge_in_left: endpoint {
+					remote-endpoint = <&dsi_out_left>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				bridge_out_left: endpoint {
+					remote-endpoint = <&panel_in_left>;
+				};
+			};
+		};
+
+		spi {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			display@0 {
+				compatible = "epson,panel-bt200";
+				reg = <0>;
+
+				port {
+					panel_in_left: endpoint {
+						remote-endpoint = <&bridge_out_left>;
+					};
+				};
+			};
+		};
+	};
+
+	port {
+		dsi_out_left: endpoint {
+			remote-endpoint = <&bridge_in_left>;
+			lanes = <2 3 0 1 4 5>;
+		};
+	};
+};
+
 &gpio1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpio1_hog_pins &gpio1wk_hog_pins>;

-- 
2.47.3

