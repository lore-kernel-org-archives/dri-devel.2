Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE978CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9618D10E758;
	Tue, 13 Oct 2026 07:52:59 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3C910E4F9
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:25:48 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so1060551f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 00:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791789946; x=1792394746; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GVFgubLFwSlRx0dc28Lupwth5R3tDS9aeaXU7vAsa6I=;
 b=Ae5/qgS+QxWToI0HaZlKMIKa2ecUfXunuf5cC1VpmFqA/S7TmG4YYwiXxTbvZSbU/v
 FI/Vd66VzGSIuMrIChoDOaCcExHwMXBi+u3bO0PV47QMkoMOmYEFBEhZzJscvXUW3PpK
 dEtu7fE6afFRzX7Y58zw+eXDhtjgYpJnoVIDoZPo+VXUhcp289fr5qT4g0NrMBI78LfU
 Zfxd3QxW3I35KUpAux7Yda99vaZayKQbHQbxeBGtrZJZu+Xok0BXQ8tKSitsFB+qla3J
 Id5vx1pluzj0NpNd9laUXBs34zXtO7c4xYNtKlLRp+Xt/mUzo6dnC8uBasSkERsXxEPS
 YOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791789946; x=1792394746;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GVFgubLFwSlRx0dc28Lupwth5R3tDS9aeaXU7vAsa6I=;
 b=NuyDIx+b6idklAWJck+2tsPMjQEB305UpbRuZR1HH4ktyQeCyvkAu7QZPIWPntOO/B
 0kYgcmmHOxAoUxNE00M3uT+ZUvusPZEUwxi61RIaViBKj0cl248Os//F7BR1P3+Eip3Q
 LmXTy1K5xgRTibeLCToXY4NSCCsIUDDWRqNEd5udjGvP//B+Tf4m4AjetUYUXTRUSNL0
 Qw2VWt/L91DiqCHls/njBYYrFZuO572Rn7eyCjXtMZumE0PDaWDKn0TGEeW4wIWegQk0
 gZMEWf42286pNxBUzO4aT8aYbft21k42F9qA/e2r68zeQQ/K5OMFzxDEFQ4+DIy0921L
 /z1g==
X-Gm-Message-State: AFq9FYJqR1MGWePcaZFYgmN3EKKYMBsw7PiAzadVW7qerOeMNqU4ZXXS
 kVxrreYzoGRFWFeu3r2bnpFmceg5pAiI+/yb74HCH9rWwMKZ2MStrUf5
X-Gm-Gg: AYBFou38K5t7VlV6QdM3IFkkkQ/1zckbssZqD2rZIWJDBtqK2gkOEI8TvfZPV9i1YcW
 0m4BSUjQt/09SJjPQYR7ioOFy9RnsJmhPtHmGGmFanD4jdLe3BdkhRZ8XFDtlksZ2MMH9oqiKPC
 U4pA48HNFOv1sf1DxBRyvjETnoZgSSujZTGQzC4nlnUwEGZKreaRVAXUOhDPpvhdhDA3z0kZWdq
 kVCyK/Kuqx10Ifxbt66qIRxJlKwNXhD8SmEmgW9nc8wIPJiFL7tta/JDaJurcrp91WAshwuY9Ip
 Cethr60FPMZAZl3s5RYRhYYDxXJz1uJ8qrWEqXl9HcZYhtbt4b2X1ayQatblzCLSr6CrbATDbDz
 4u0yUIm1z9gXyFu6BWCnWWth5slrwbYXM1/hfJzqup+bjY8/ZDaSaOsSX76TQz/TOLYGsVznehH
 vmoUg0FfKkc/iBeT77KSxq3szRrrhxDhkOS0kN6grq4OCJmUvMM0lZQXGOPsxLtyhgOBkub8OmV
 XGpSSD8jtaSu6gd0d/z0cIpfNcI5jB4a2N8rS9YSCp1tVXQs9j8gTiM7QT5hUry
X-Received: by 2002:a5d:5f51:0:b0:487:b4a:3f54 with SMTP id
 ffacd0b85a97d-48dbaaec8f8mr15252003f8f.29.1791789946187; 
 Mon, 12 Oct 2026 00:25:46 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aadf9bsm17523377f8f.29.2026.10.12.00.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:25:45 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
Date: Mon, 12 Oct 2026 04:25:25 -0300
Subject: [PATCH 3/3] ARM: dts: imx6q-apalis: Add VGA overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-v1-apalis-imx6-enable-vga-v1-3-8905d8746504@toradex.com>
References: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
In-Reply-To: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Leonardo Costa <leonardo.costa@toradex.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791789940; l=3858;
 i=leonardo.costa@toradex.com; s=20261001; h=from:subject:message-id;
 bh=J15XFPQXwHwXqajYWDHAsZeClrpxiXPgtU/y11V0Fb8=;
 b=YNznv4USjYwddWq+/qaJHmbbnVovBRRKYP/qeKShQ1yQNEDDt04txudw7FbYWa1YbUcBfvhlF
 4c32Lwb0NINAXgbhaKdb/hcrLlgT4dfPwEKirLnrKQUQndhNJbVX9qv
X-Developer-Key: i=leonardo.costa@toradex.com; a=ed25519;
 pk=4xvoVLDt+NxIz9D8BJHhT0fD43Ig6XgSDw4jRN/gHzk=
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:58 +0000
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

From: Leonardo Costa <leonardo.costa@toradex.com>

Add a device tree overlay for the VGA output available on the Apalis
Evaluation Board, which is driven from a parallel RGB interface passing
through a non-programmable video DAC to a VGA connector, without VESA
DDC I2C signals.

The overlay is also combined with the various Apalis Evaluation Board
device trees to provide ready-to-use DTBs.

Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
 .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 79 ++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index c5caca92ea10..b5ad9172e1f4 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -59,6 +59,22 @@ dtb-$(CONFIG_SOC_IMX53) += \
 imx53-qsb-hdmi-dtbs := imx53-qsb.dtb imx53-qsb-hdmi.dtbo
 imx53-qsrb-hdmi-dtbs := imx53-qsrb.dtb imx53-qsb-hdmi.dtbo
 
+imx6q-apalis-eval-v1.2-vga-dtbs := \
+	imx6q-apalis-eval-v1.2.dtb \
+	imx6q-apalis-eval-vga.dtbo
+
+imx6q-apalis-eval-vga-dtbs := \
+	imx6q-apalis-eval.dtb \
+	imx6q-apalis-eval-vga.dtbo
+
+imx6q-apalis-v1.2-eval-v1.2-vga-dtbs := \
+	imx6q-apalis-v1.2-eval-v1.2.dtb \
+	imx6q-apalis-eval-vga.dtbo
+
+imx6q-apalis-v1.2-eval-vga-dtbs := \
+	imx6q-apalis-v1.2-eval.dtb \
+	imx6q-apalis-eval-vga.dtbo
+
 imx6qdl-dhcom-pdk2-overlay-497-200-x12-dtbs := \
 	imx6q-dhcom-pdk2.dtb \
 	imx6qdl-dhcom-pdk2-overlay-497-200-x12.dtbo
@@ -184,11 +200,16 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-yapp4-ursa.dtb \
 	imx6q-apalis-eval.dtb \
 	imx6q-apalis-eval-v1.2.dtb \
+	imx6q-apalis-eval-v1.2-vga.dtb \
+	imx6q-apalis-eval-vga.dtb \
+	imx6q-apalis-eval-vga.dtbo \
 	imx6q-apalis-ixora.dtb \
 	imx6q-apalis-ixora-v1.1.dtb \
 	imx6q-apalis-ixora-v1.2.dtb \
 	imx6q-apalis-v1.2-eval.dtb \
 	imx6q-apalis-v1.2-eval-v1.2.dtb \
+	imx6q-apalis-v1.2-eval-v1.2-vga.dtb \
+	imx6q-apalis-v1.2-eval-vga.dtb \
 	imx6q-apalis-v1.2-ixora.dtb \
 	imx6q-apalis-v1.2-ixora-v1.1.dtb \
 	imx6q-apalis-v1.2-ixora-v1.2.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso
new file mode 100644
index 000000000000..a449ef9fbfaf
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * VGA output connected to a parallel RGB LCD interface through a
+ * non-programmable video DAC with a VGA connector.
+ *
+ * The VGA output is available on the Apalis Evaluation Board without VESA DDC
+ * I2C signals.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	disp1 {
+		compatible = "fsl,imx-parallel-display";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu2_vdac>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "rgb565";
+
+		port@0 {
+			reg = <0>;
+
+			vga_display_in: endpoint {
+				remote-endpoint = <&ipu2_di0_disp0>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			vga_display_out: endpoint {
+				remote-endpoint = <&vga_enc_in>;
+			};
+		};
+	};
+
+	vga-encoder {
+		compatible = "toradex,apalis-imx6-vga-dac";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				vga_enc_in: endpoint {
+					remote-endpoint = <&vga_display_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				vga_enc_out: endpoint {
+					remote-endpoint = <&vga_connector_in>;
+				};
+			};
+		};
+	};
+
+	vga-connector {
+		compatible = "vga-connector";
+
+		port {
+			vga_connector_in: endpoint {
+				remote-endpoint = <&vga_enc_out>;
+			};
+		};
+	};
+};
+
+&ipu2_di0_disp0 {
+	remote-endpoint = <&vga_display_in>;
+};

-- 
2.43.0

