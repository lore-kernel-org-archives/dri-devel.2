Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3859BC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8267510F063;
	Thu, 23 Jul 2026 10:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mjt/XHQ0";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2279E10F063
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:06:22 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso251207f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784801180; x=1785405980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OkrjSwuUycBg+RRlfYmBdI9gqjZZ1EenX4uhPobHFtc=;
 b=Mjt/XHQ0l6P2xVw4KB5z6u3jKQVj+EX9rXguTakpY0iBAwCmAg13QQyIEXosbQkL+C
 r9w2y76OfI9GJ2InVP5MmXKEXFV9WOpQtIIgN8de7YFvI+MmzOhPUjVs4NRZW9KcCbj/
 2uEOAgSL2Ft9TgT1Psgf61E0ak+qJ1+XkpNBuzmBBQE3CLcMpnN/aoDgk4rU8f6LoC+A
 A6Yz6CHz0+98lEY9xDRZg5ked+hx02XdN/wSRwfcd1Nuj2+YYSE2WALLR+41stxiTpNk
 Ms0H22YsWcmJnJ/DdJMfeRwSjAhWra/LnoTroth6xUkiyoPXOVRb/2Qy6OcCSgMxhjM7
 qVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784801180; x=1785405980;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OkrjSwuUycBg+RRlfYmBdI9gqjZZ1EenX4uhPobHFtc=;
 b=sZJObSABalyxLvpksxrm28and6oLgU/1mXksjCisHa72lK5f50peW85DnI+/N05LPo
 6LyhRu1HwD3KJwkfIfNEDXmbTKPQJ6faVBgPRefR8mXE04PnhRNsxJAGfBkfmlLsdkeI
 qXSO5P21pU/fwF9LCk1OGBoMBeh0ZaUOax0BMoI1DxqxjqU4rUVbGf4+44GEMZfLxvyO
 2K0apRnZ941q7c21Wifo0duL3br95AonjVaIyK5euXyP5oOTAKBjNkaDfnL6jd1XqXPW
 xM5q4ZRaP+1xtZdHINho4DE4dWXILe/ctBGI9qV73w7s/Qw4U17ACo/9RJVcElxazOJ5
 IStA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roi/B0o0APPrEnP1e9ASswwWPnNi4RgCKs8/ctgegdCZ1tyS0XyTV4oReDa7nvynUk3T6cKc765LmU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxX+pT0cndFg3lnaQm26E35KxpuN7uOlrxk2wqBoE7SFedIn3/v
 C8otaaSBiT5/qvttyyby5Dyk6pijOa3y2IzSaQXn8X1lFDXr41UuRpwb
X-Gm-Gg: AR+sD12WEtkqxs2Ekkn1RzqcdL/6MaQNYgFgAv/4WJTOZxaEOZGd+P397mdaUfiUkrM
 cnA4oC1eNU7hdJG4toFJXwLmjwLjuAf+thGi7HFc9qjzvDQJ7OVpxXWIOb0pTdwj/Ub7U0QMRwD
 IdZal3MguvHHla410sVoHLUPOleBUV2ynrl/DGslmAIt9Cxp5SOHbVakxExCpol1zRKuOtcrymE
 7jnx91xVmn/vIHoRgUuLY/X3oBzRN49sFMjWJ2Hg6wriE5cMIhznFb0JFXJWPjZJR1QG7mHi22F
 PdqIl+zoYnspVXoDx+bjH9xNs+9gsFTG5j6cuv4C36Hg/tNr76v6sfBw5UcUK5dpmYOPaAiLFgT
 xjCxfARmjkbTg2d6YLyLfGgjeh33E6ChYku+SwOAE2pt9dtVLpcWL8WEYd5k60SnU84UmuoMaws
 96vU5s4JLdAQuX9Dxj7OHoL9ojX5gc+E7b4DdfWkZBaEHr
X-Received: by 2002:a05:6000:2309:b0:47f:9208:9e4 with SMTP id
 ffacd0b85a97d-47f92080a4cmr1526100f8f.31.1784801180254; 
 Thu, 23 Jul 2026 03:06:20 -0700 (PDT)
Received: from localhost.localdomain ([86.126.27.145])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm14212163f8f.3.2026.07.23.03.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 03:06:19 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com
Subject: [PATCH v4 2/4] ARM: dts: Rename the TPS65217 regulator nodes
Date: Thu, 23 Jul 2026 10:06:00 +0000
Message-ID: <20260723100605.628882-3-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723100605.628882-1-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The TPS65217 regulator nodes are named regulator@0 to regulator@6 and
rely on the deprecated 'regulator-compatible' property to be matched
against the driver, which looks for "dcdc1" to "ldo4".

Documentation/devicetree/bindings/regulator/tps65217.txt states the
regulators must be named after their hardware counterparts, dcdc[1-3]
and ldo[1-4].

Rename the nodes accordingly and drop 'regulator-compatible' along with
the unit addresses it made necessary.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../boot/dts/ti/omap/am335x-bone-common.dtsi  | 14 ++++-----
 .../arm/boot/dts/ti/omap/am335x-chilisom.dtsi | 14 ++++-----
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts | 14 ++++-----
 arch/arm/boot/dts/ti/omap/am335x-nano.dts     | 14 ++++-----
 .../dts/ti/omap/am335x-osd335x-common.dtsi    | 14 ++++-----
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts   | 14 ++++-----
 arch/arm/boot/dts/ti/omap/am335x-shc.dts      | 31 +++++--------------
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts     | 14 ++++-----
 arch/arm/boot/dts/tps65217.dtsi               | 31 +++++--------------
 9 files changed, 63 insertions(+), 97 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index 1d83fc116b66..e5ca2bd65736 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -337,12 +337,12 @@ pwrbutton {
 	};
 
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -351,7 +351,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -360,22 +360,22 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			regulator-name = "vio,vrtc,vdds";
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			regulator-name = "vdd_1v8";
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			regulator-name = "vdd_3v3a";
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/ti/omap/am335x-chilisom.dtsi b/arch/arm/boot/dts/ti/omap/am335x-chilisom.dtsi
index bd43da6356b6..9ee6d6d4a9c1 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-chilisom.dtsi
@@ -70,12 +70,12 @@ tps: tps@24 {
 
 &tps {
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -84,7 +84,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -93,25 +93,25 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			regulator-name = "vio,vrtc,vdds";
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			regulator-name = "vdd_3v3aux";
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			regulator-name = "vdd_1v8";
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			regulator-name = "vdd_3v3d";
 			regulator-boot-on;
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
index d595e79d6b05..fecfe12e1349 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
@@ -323,12 +323,12 @@ backlight {
 	};
 
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -337,7 +337,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -346,24 +346,24 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			regulator-name = "vio,vrtc,vdds";
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			regulator-name = "vdd_1v8";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			regulator-name = "vdd_3v3a";
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/ti/omap/am335x-nano.dts b/arch/arm/boot/dts/ti/omap/am335x-nano.dts
index d51cdd6e1ab4..c1143f0a3356 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-nano.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-nano.dts
@@ -431,7 +431,7 @@ &usb0 {
 
 &tps {
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			/* +1.5V voltage with ±4% tolerance */
 			regulator-min-microvolt = <1450000>;
 			regulator-max-microvolt = <1550000>;
@@ -439,7 +439,7 @@ dcdc1_reg: regulator@0 {
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.1V with ±4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <915000>;
@@ -448,7 +448,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with ±4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <915000>;
@@ -457,7 +457,7 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			/* +1.8V voltage with ±4% tolerance */
 			regulator-min-microvolt = <1750000>;
 			regulator-max-microvolt = <1870000>;
@@ -465,7 +465,7 @@ ldo1_reg: regulator@3 {
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			/* +3.3V voltage with ±4% tolerance */
 			regulator-min-microvolt = <3175000>;
 			regulator-max-microvolt = <3430000>;
@@ -473,7 +473,7 @@ ldo2_reg: regulator@4 {
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			/* +1.8V voltage with ±4% tolerance */
 			regulator-min-microvolt = <1750000>;
 			regulator-max-microvolt = <1870000>;
@@ -481,7 +481,7 @@ ldo3_reg: regulator@5 {
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			/* +3.3V voltage with ±4% tolerance */
 			regulator-min-microvolt = <3175000>;
 			regulator-max-microvolt = <3430000>;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi
index 93a3af83feac..021cf5cbbb96 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi
@@ -69,12 +69,12 @@ pwrbutton {
 	};
 
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -83,7 +83,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -92,24 +92,24 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			regulator-name = "vio,vrtc,vdds";
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			regulator-name = "vdd_1v8";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			regulator-name = "vdd_3v3a";
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
index 10d54e0ad15a..363638e74719 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
@@ -433,12 +433,12 @@ backlight {
 	};
 
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			/* VDD_1V8 system supply */
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_CORE voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -447,7 +447,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_MPU voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -456,26 +456,26 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			/* VRTC 1.8V always-on supply */
 			regulator-name = "vrtc,vdds";
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			/* 3.3V rail */
 			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			/* VDD_3V3A 3.3V rail */
 			regulator-name = "vdd_3v3a";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			/* VDD_3V3B 3.3V rail */
 			regulator-name = "vdd_3v3b";
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-shc.dts b/arch/arm/boot/dts/ti/omap/am335x-shc.dts
index 597482822608..473058584691 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-shc.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-shc.dts
@@ -254,26 +254,19 @@ &tps {
 	ti,pmic-shutdown-controller;
 
 	regulators {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		dcdc1_reg: regulator@0 {
-			reg = <0>;
+		dcdc1_reg: dcdc1 {
 			regulator-name = "vdds_dpr";
-			regulator-compatible = "dcdc1";
 			regulator-min-microvolt = <1300000>;
 			regulator-max-microvolt = <1450000>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
-			reg = <1>;
+		dcdc2_reg: dcdc2 {
 			/*
 			 * VDD_MPU voltage limits 0.95V - 1.26V with
 			 * +/-4% tolerance
 			 */
-			regulator-compatible = "dcdc2";
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1375000>;
@@ -282,51 +275,41 @@ dcdc2_reg: regulator@1 {
 			regulator-ramp-delay = <70000>;
 		};
 
-		dcdc3_reg: regulator@2 {
-			reg = <2>;
+		dcdc3_reg: dcdc3 {
 			/*
 			 * VDD_CORE voltage limits 0.95V - 1.1V with
 			 * +/-4% tolerance
 			 */
 			regulator-name = "vdd_core";
-			regulator-compatible = "dcdc3";
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1125000>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
-			reg = <3>;
+		ldo1_reg: ldo1 {
 			regulator-name = "vio,vrtc,vdds";
-			regulator-compatible = "ldo1";
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
-			reg = <4>;
+		ldo2_reg: ldo2 {
 			regulator-name = "vdd_3v3aux";
-			regulator-compatible = "ldo2";
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
-			reg = <5>;
+		ldo3_reg: ldo3 {
 			regulator-name = "vdd_1v8";
-			regulator-compatible = "ldo3";
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
-			reg = <6>;
+		ldo4_reg: ldo4 {
 			regulator-name = "vdd_3v3a";
-			regulator-compatible = "ldo4";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-sl50.dts b/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
index c5259eb7d21c..0cc9289c752b 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
@@ -607,14 +607,14 @@ &tps {
 	interrupts = <7>;	/* NNMI */
 
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			/* VDDS_DDR */
 			regulator-min-microvolt = <1500000>;
 			regulator-max-microvolt = <1500000>;
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -623,7 +623,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -632,28 +632,28 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			/* VRTC / VIO / VDDS*/
 			regulator-always-on;
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			/* VDD_3V3AUX */
 			regulator-always-on;
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			/* VDD_1V8 */
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			/* VDD_3V3A */
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 0d463de5650f..e7db105b3657 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -27,42 +27,25 @@ pwrbutton {
 	};
 
 	regulators {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		dcdc1_reg: regulator@0 {
-			reg = <0>;
-			regulator-compatible = "dcdc1";
+		dcdc1_reg: dcdc1 {
 		};
 
-		dcdc2_reg: regulator@1 {
-			reg = <1>;
-			regulator-compatible = "dcdc2";
+		dcdc2_reg: dcdc2 {
 		};
 
-		dcdc3_reg: regulator@2 {
-			reg = <2>;
-			regulator-compatible = "dcdc3";
+		dcdc3_reg: dcdc3 {
 		};
 
-		ldo1_reg: regulator@3 {
-			reg = <3>;
-			regulator-compatible = "ldo1";
+		ldo1_reg: ldo1 {
 		};
 
-		ldo2_reg: regulator@4 {
-			reg = <4>;
-			regulator-compatible = "ldo2";
+		ldo2_reg: ldo2 {
 		};
 
-		ldo3_reg: regulator@5 {
-			reg = <5>;
-			regulator-compatible = "ldo3";
+		ldo3_reg: ldo3 {
 		};
 
-		ldo4_reg: regulator@6 {
-			reg = <6>;
-			regulator-compatible = "ldo4";
+		ldo4_reg: ldo4 {
 		};
 	};
 };
-- 
2.43.0

