Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9127FF8873
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484BF10EE52;
	Wed, 29 Apr 2026 04:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="fcjCNlbE";
	dkim-atps=neutral
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com
 [209.85.161.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A6010EE3E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 04:15:39 +0000 (UTC)
Received: by mail-oo1-f97.google.com with SMTP id
 006d021491bc7-67e0d3f288aso7369946eaf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 21:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777436138; x=1778040938; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x93/l1w2YfvuQmLZ4l2/nRL+2Tpf+p0vaW0AsgHcapU=;
 b=fcjCNlbEfvhMGpcEEQSax0BI7YY0h7CToUQyvwyeygiyO0y2bGkIK5V54l9/bXFWF8
 WM78mv2XcfafRV37CYtx/Ev+5SiV8ab+85Cr3Fgyw6oeOESkgEzG24OeGctBXb30WoaD
 NP4FVWMb6sUC0Ad5Y8pDQAnXoG5dDwHvAQx8R+VTfY7aLZQEBxtAtcZA47EwcxrD3bvr
 5NzPSlrjsIbr/jW5DImxzRGGjCloVZKpPyv1CwMK88GgaLavHaOVvPFDMLQ7aooZkptm
 5Hs+wnczpxobgtALfldl3GnO8GA2tcVubWATn1KGCo/uo2vK15wO7UkWhtSP9nr9Rv+B
 jc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777436138; x=1778040938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x93/l1w2YfvuQmLZ4l2/nRL+2Tpf+p0vaW0AsgHcapU=;
 b=gzqs4uFvalE2kWnzM2sg3Ql8UMSEXBQUOUD8twmA2qqqJjYAljhMCL9cGV1sq9bSdB
 v6PxxWmtBjZVVaYWjTqtAMKibRp+Rb3FPorP9Thl90Dy4QD4CgeVIAHa6Des7GHjeETK
 0yAtRU9QFoSfoIbnz9dSYwdelDfZXBYc4xBjkwAOwFkMUOrshF2KlxpVjjruE3HgRglX
 lclo1+NujHiwkkSdKA4SS+JyetapSjqwB/6lIdYlfCo3yRoAfjewd4FPECssqY7aZQTu
 Mm6YxM3mXHC57Zs8KJNgiSaYn0OVHQRgrgB24x1wODKqtlIZaIK1s8qphN/4/2SuM0zn
 aepg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vC/7vii3b0juKKMp0efZZjSUnP/WHNUW4dnO8dxleYRNWU3b2hmYaoMtdyY8KrnvqTqFfpbls+yg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4dOX/Ey00RLR+XKOUNzuAUOXjUbh1p56rVHXadUWMYuZyBZBq
 iIlYA9RVZPGdskEL3FyxToFkNwfAw4jjOJ7GU58O2DB+/PQVALoE26+MRnTd6G4t3e6hLcN/8xV
 e04k0zHm/LweO5G+SLTNUF/6Kz4AQzj0JYUvT
X-Gm-Gg: AeBDietRSo6hSQkAFwtaWEmWWpVXUauZDWRBLxor2XkzDApKC43+FdDv4tS1mYRqO+C
 5ddvWSjvy58Zrz4otBcFfiKcKOgCAWd0z7CGWbmKCI8/dOjbwbJi8ivatKiPCjPpg/eeLh4LmM2
 6YNqH4ZENea3smYVRwcn7/83MuKuaQOVkgbf01LYYCWxuxWjRetwp4uPB4edfGN7sgPUPpwWcFv
 LqW7rJ5okD5tUZhNZQEaS1XxJ5EZLnbg791oIzThZuTAaRoMYeblCxhWFxZLhoLuk7siE1sSS3u
 KIdh0tySQpCLrR6OyBrj/uOptmRSumYfia4ktqKwKdlw6hikrbhuWVhbk+XGrP8HckYWMKQN/yq
 v9vlu7pne5zJgj7TPW1XWgDDXGuaS6g881+rw4oEladvHzwXkKPbQZpw=
X-Received: by 2002:a05:6820:2908:b0:694:92fe:54f1 with SMTP id
 006d021491bc7-6966854819amr1134201eaf.54.1777436138476; 
 Tue, 28 Apr 2026 21:15:38 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-6966baf952asm41557eaf.9.2026.04.28.21.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:15:38 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Dennis Gilmore <dennis@ausil.us>
Subject: [PATCH 3/3] arm64: dts: rockchip: orangepi-5-pro: Add LT8711UXD
 DP-to-HDMI bridge
Date: Tue, 28 Apr 2026 23:15:28 -0500
Message-ID: <20260429041528.558254-4-dennis@ausil.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429041528.558254-1-dennis@ausil.us>
References: <20260429041528.558254-1-dennis@ausil.us>
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

Wire up the second HDMI port on the Orange Pi 5 Pro. It uses a Lontium
LT8711UXD high performance two lane Type-C/DP1.4 to HDMI2.0 converter,
designed to connect a USB Type-C source or a DP1.4 source to an HDMI2.0
sink. The bridge can be controlled via i2c or run as an autonomous device.

The Orange Pi 5 Pro has i2c wired up to i2c6, however there are 10k
resistors left off of R9 and R17 to enable MODE_SEL, and R27 for
I2C_ADDR resulting in MODE_SEL going to GND and the bridge let in
autonomous mode. As shipped I verified that the bridge does not show up
on the i2c bus.

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 .../dts/rockchip/rk3588s-orangepi-5-pro.dts   | 88 ++++++++++++++++++-
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts
index 895d954a9f23..67363709c4ca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts
@@ -14,6 +14,44 @@ aliases {
 		mmc2 = &sdio;
 	};
 
+	hdmi1-con {
+		compatible = "hdmi-connector";
+		label = "HDMI1 OUT";
+		type = "a";
+
+		port {
+			hdmi1_con_in: endpoint {
+				remote-endpoint = <&lt8711uxd_out>;
+			};
+		};
+	};
+
+	hdmi-bridge {
+		compatible = "lontium,lt8711uxd";
+		vdd-supply = <&vcc3v3_dp>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt8711uxd_in: endpoint {
+					remote-endpoint = <&dp0_out_con>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				lt8711uxd_out: endpoint {
+					remote-endpoint = <&hdmi1_con_in>;
+				};
+			};
+		};
+	};
+
 	analog-sound {
 		compatible = "simple-audio-card";
 		pinctrl-names = "default";
@@ -72,6 +110,19 @@ fan: pwm-fan {
 		pwms = <&pwm2 0 20000000 0>;
 	};
 
+	vcc3v3_dp: regulator-vcc3v3-dp {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dp_bridge_en>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc3v3_dp";
+		regulator-always-on;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
 	vcc3v3_eth: regulator-vcc3v3-eth {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -116,6 +167,24 @@ typea_con: usb-a-connector {
 	};
 };
 
+&dp0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp0m0_pins>;
+	status = "okay";
+};
+
+&dp0_in {
+	dp0_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_dp0>;
+	};
+};
+
+&dp0_out {
+	dp0_out_con: endpoint {
+		remote-endpoint = <&lt8711uxd_in>;
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1m4_xfer>;
@@ -217,6 +286,12 @@ bt_wake_host_irq: bt-wake-host-irq {
 		};
 	};
 
+	dp {
+		dp_bridge_en: dp-bridge-en {
+			rockchip,pins = <3 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
 	ethernet {
 		ethernet_en: ethernet-en {
 			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_down>;
@@ -350,9 +425,16 @@ &usb_host0_xhci {
 
 &usbdp_phy0 {
 	/*
-	 * The USB3 Type-A host connector is wired to PHY lanes 2/3. Lanes 0/1
-	 * are connected to the LT8711UXD DP-to-HDMI bridge on the board.
-	 * dp-lane-mux routes USB3 SuperSpeed to the correct lanes.
+	 * USBDP PHY0 is wired to a USB3 Type-A host connector via lanes 2/3.
+	 * Additionally lanes 0/1 and the aux channel are wired to the
+	 * Lontium LT8711UXD DP-to-HDMI bridge feeding the HDMI1 connector.
 	 */
 	rockchip,dp-lane-mux = <0 1>;
 };
+
+&vp1 {
+	vp1_out_dp0: endpoint@a {
+		reg = <ROCKCHIP_VOP2_EP_DP0>;
+		remote-endpoint = <&dp0_in_vp1>;
+	};
+};
-- 
2.54.0

