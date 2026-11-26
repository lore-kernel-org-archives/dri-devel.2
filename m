Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39280606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQk+Wr2o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2396C112748;
	Thu, 26 Nov 2026 21:45:31 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A7C112736
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:57 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso5707103f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729496; x=1796334296; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rgoIgw35YcjRzBDNQLX8AgVyjJr3fxJKdB7QZhfiyn4=;
 b=gQk+Wr2omOeQDAYfQLxAZ9E39qO3X/YTmzeERKw4VF8IbmyhPt0+cMio6gJUzjEZtx
 hJrf3HucEzLqIIuGrTBArbf8wDOAtTwjgn7UBiIRaPCpLgCW7XwOyzF5XaVFmgg0eKXA
 rNjG4PvgLhTnH8sp7P7+H9YhN8awuPZx142Bjf06Uj+ESNtKgtnSZGkgR3GaO+ttcs8F
 sDgzWpDz/lUw0hkO7PGLJxtF89Uk4lfVO7nqw96G1ppW1+QLRqOFl8Kn3n7bNa/F8N68
 YZtRFBTn/M8AJXUjhO9/vJicR6lphjt629tsHZLLdkRzpew4fo7X59maBmEFEs3+AHFc
 faGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729496; x=1796334296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rgoIgw35YcjRzBDNQLX8AgVyjJr3fxJKdB7QZhfiyn4=;
 b=XkRcoWHZjyTib1YsSad+3fTO8OcgahfTfIDjzHWhwSYL7G2Dg/Q7ZJ2t/7vQEKvFsM
 jvrUPq+ZdMrWXyOL4dLDfWb7ySkznjCvx7JTnniu/AHPsXbKHgS5n/iuHsLQUOlYg3E/
 mwl1CwXPC5zn74hmq6/36g+RrHVfzXqXjBC7mJ5aQwGwJiu7/akHkxxITtQZprYW1E8I
 k0n+heHVvv1gvrwALwQM9iQKdcxfF2RbLquMPolIP2EoNc0sOB0E+15w3ZtYm5bmIT9V
 2Kqhi2HsKewzbXQnZOJjQswsxenm6RtV4XFcv3zUcaFnENv3AmAi//V79uLmid5RAgyk
 Mfbg==
X-Forwarded-Encrypted: i=1;
 AL+hErEvGQbvTiouVVyLupmjvn4WTN5a5gku0V9OhKifWWeqpEnkDaEuNA0UNhHOYc51ysBeVyL4ohw7rhs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8OhTZhX+fE/RZF/PwKTVMx1wuwLF7OGsbPdzPyJcIJfWC9oqVC
 UDm2Mqps63qmmff8LlE5xoqmu3a0kZeiLhNZmdSs89N5Lwyce/y3l4+7
X-Gm-Gg: AZFdTZcZNtqCp7LxT3u3jfcw1p/P0BAcUslkQj/moe37KmMy5jW1+P+lGzgGUA4GUE2
 oicMBYEDSFRoQVPBwgQoIjsO0cIT3rcnd6hYLJujvLUU4sLkvm84jmDaTZU7zCfxTAX1rOZil9B
 Q7052ySrrix+3OG5y6R72JkoGRekrEkT9lxh/ShFiwBJal7TNM4UTzx541Z5nS1e+DFBbcHhyyx
 KIVPpVa368ndpSyhbLITn1bga8qaHTHoOiuZchINwwA+IIp5E2v9x/pK/mvGqOMJyoL9y7iIQOZ
 6WJNjbVV0raszLOaFVOQ42Ct2YXoSFoKHOoABWrnc9Z+O3AdEV8V6lUkcF9upGMickS1IBznzIH
 K92DrRSMkHRwDkbFV0/moTyftgdjwGjcoGaoRRlWz9PNAnFNUcsfhdg3NfniowC1zoKs98plC0H
 /RmVHSr22qcS01OKeYzFESrQCPjYCGq+TgCijUzy083BlyD2/XTuNHJHjCdstcRoMBHBLaa0QEM
 ZoTYGJjBhMlVEDWLJ71nRzB3DWbD0oVlYQC7VEt73owI14CWnmmjt5yj5vmkFf4Vyu5V/7fAPO0
 zh72WrLBAWnjGod+qnKe8WWLlshv1Zvt7Z4RIFZtgBe2n8vOhWmJXheO42XOZyDIg8wfXEb8Pon
 oSMzKr43ysRGCUKyxKdXiRRGForkV1VK6P/JgQLGptZ7iQgyP8rOiqzl3/vOD1FBJ2sZAG7roi1
 QcuVba3w1ETGfT16JfXBnPqQln8c9y4dSdlFJOn34OG18mwPCB4ZWkbIat1UWvgnbWgql2j4GFk
 SOvt8kzXDBIU7vVh1cVJvDNDWyMroQIHvQE/vmEGg==
X-Received: by 2002:a5d:5846:0:b0:4a6:4ac6:d950 with SMTP id
 ffacd0b85a97d-4abb400ae95mr45098156f8f.39.1795729495913; 
 Thu, 26 Nov 2026 13:44:55 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:54 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 jernej.skrabec@gmail.com, p.zabel@pengutronix.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] arm64: dts: allwinner: h616: Enable HDMI on several
 boards
Date: Thu, 26 Nov 2026 22:44:33 +0100
Message-ID: <20261126214433.3562326-12-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
References: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that H616 display pipeline is added, enable HDMI on several boards.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../dts/allwinner/sun50i-h313-tanix-tx1.dts   | 30 +++++++++++++++++++
 .../allwinner/sun50i-h616-orangepi-zero.dtsi  | 25 ++++++++++++++++
 .../allwinner/sun50i-h616-orangepi-zero2.dts  |  5 ++++
 .../dts/allwinner/sun50i-h616-x96-mate.dts    | 30 +++++++++++++++++++
 .../allwinner/sun50i-h618-orangepi-zero3.dts  |  5 ++++
 .../sun50i-h618-transpeed-8k618-t.dts         | 30 +++++++++++++++++++
 .../sun50i-h618-yuzukihd-chameleon.dts        | 30 +++++++++++++++++++
 7 files changed, 155 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h313-tanix-tx1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h313-tanix-tx1.dts
index 7906b79c0389..c5226a427eaa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h313-tanix-tx1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h313-tanix-tx1.dts
@@ -26,6 +26,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -75,6 +86,10 @@ &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -84,6 +99,17 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	hvcc-supply = <&reg_aldo1>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &ir {
 	status = "okay";
 };
@@ -178,6 +204,10 @@ reg_dcdc3: dcdc3 {
 	};
 };
 
+&tcon_tv0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
index 0d3e761f6466..51c8ebdbdc88 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
@@ -22,6 +22,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -64,6 +75,10 @@ &codec {
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -81,6 +96,12 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mdio0 {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -113,6 +134,10 @@ flash@0 {
 	};
 };
 
+&tcon_tv0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
index 90c25e12e189..0f25b043e020 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
@@ -28,6 +28,11 @@ &gpu {
 	mali-supply = <&reg_dcdcc>;
 };
 
+&hdmi {
+	hvcc-supply = <&reg_bldo1>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_dcdce>;
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
index 085f3e4e8eaa..568de6f57015 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
@@ -23,6 +23,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	reg_vcc5v: vcc5v {
 		/* board wide 5V supply directly from the DC input */
 		compatible = "regulator-fixed";
@@ -42,6 +53,10 @@ &cpu0 {
 	cpu-supply = <&reg_dcdca>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -55,6 +70,17 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	hvcc-supply = <&reg_bldo1>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &ir {
 	status = "okay";
 };
@@ -202,6 +228,10 @@ sw {
 	};
 };
 
+&tcon_tv0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
index c51d4d9120de..4a1754eeb0b6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
@@ -31,6 +31,11 @@ &gpu {
 	mali-supply = <&reg_dcdc1>;
 };
 
+&hdmi {
+	hvcc-supply = <&reg_aldo1>;
+	status = "okay";
+};
+
 &mmc0 {
 	/*
 	 * The schematic shows the card detect pin wired up to PF6, via an
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
index efe0faa252f5..2f09a5cabed5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
@@ -24,6 +24,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	reg_vcc5v: vcc5v {
 		/* board wide 5V supply directly from the DC input */
 		compatible = "regulator-fixed";
@@ -61,6 +72,10 @@ &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -74,6 +89,17 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	hvcc-supply = <&reg_aldo1>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &ir {
 	status = "okay";
 };
@@ -177,6 +203,10 @@ &pio {
 	vcc-pi-supply = <&reg_dldo1>;
 };
 
+&tcon_tv0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-yuzukihd-chameleon.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-yuzukihd-chameleon.dts
index 9e275f0217ec..11b087dad0c1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-yuzukihd-chameleon.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-yuzukihd-chameleon.dts
@@ -24,6 +24,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	reg_vcc5v: vcc5v {
 		/* board wide 5V supply directly from the USB-C socket */
 		compatible = "regulator-fixed";
@@ -52,6 +63,10 @@ &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -73,6 +88,17 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	hvcc-supply = <&reg_aldo1>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mmc0 {
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
@@ -187,6 +213,10 @@ reg_dcdc3: dcdc3 {
 	};
 };
 
+&tcon_tv0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.43.0

