Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97196606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VXJuUB8r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C405A10F314;
	Tue, 20 Oct 2026 07:36:44 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E6710E987
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:20:50 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so2287240c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792405250; x=1793010050; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VgK4Knz1UTecYHn0SL3JT3fee9wk3Cp4TEKus9TadaQ=;
 b=VXJuUB8rlVWoMTTOBAihAzSqHTJ4uTRMWLflEPtONqKRUjJhXRlN/Z2qsadjiHxS+C
 X7H3XwOug3dxBUQoOgVqAywaQ8oUYgYaA7k9LDI78j0fTK1alUjgOpXn/m0f57qbX4K0
 0RKhuq1X61WgK3JfGgrUlK+JEw/cAaGORXu3V02WR9ofDeUGzqGpq2GBrLNkvR3+O4tq
 DEXnbguzBaybDfKB07ZzW+uj86FP8ABhBr47M2eGN33b2gyDCJJrRWm85DdWOdra81JN
 H5cbjbuCnttV5yUVidt5VkTG0PHaY/Hdlbg++v/bHjldVJVs4wJiAXzbKWY13Hm8tjdm
 +c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405250; x=1793010050;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VgK4Knz1UTecYHn0SL3JT3fee9wk3Cp4TEKus9TadaQ=;
 b=Wum/BqPgyrMm9e/lAcQFmhaYYDYZWlIvYlxeflx3leQgL6QlEZAxNnZ2+AB6n2/Pr6
 vOXbF+utuWD1ULeD3pdw5c9mJo+E8uy3JMTasTlbnCt5DGc4gevOBKMtZmnlvpSaMWh2
 IX0ROO2hxJ+LKyzfxW5Z6ZMm2h7TdhIPM2UYNcg0LYZArjSuzQz8dA7YpVOQq95uMJoS
 KqYUPr+MENVqxRcOH4Vfh+kQbR7Och/jmqC1fSi1wCD6iy9liGg8ZOO/oJq7wZed7iuE
 MnohOHKXTG3GEoijfa790k/nqmLdZd3A8CmBkubu0AuvnWS4QyTkz2CY5u607ezLe94g
 Yxvw==
X-Gm-Message-State: AFq9FYLxZswfVCxyPnI0nMGripLP0vHvOZX6M6gF3vcArYy0I9q74exE
 Zlqp5wwJIou93DREDxWiViWttrCaqS5f7uZTToUervVvDtc9Dr7rP7Ig
X-Gm-Gg: AYBFou0JEKVO88ooESuQpDLve/mrMxY/zIXmbePCrP1JUchhOdJlYZGYnqp/aItT7Za
 fG0dIFWQ25brMOB1ndltdqrVxr4/dI2g1pOybVMD6vNO6w+lflLABdafcPHXkrZDuGDjwrZWsAf
 qBq9Rmch7uViT8WfES+P1Q8wHTuyG8phRe4i8aH41hm5jY2omqhxTbxAqRmQFvWyrSjQ6uagN3X
 tvmU/0wktjO9x8FWJ4ogQ1FK5FcczcE+YGlWbpggO4bliTgPpuKKX6XjQL+iBi5hMmrfNq9u0ZC
 3jLAS0e33D1BK5Zfhwj7MPSM6iN/d5Rl9c8resv86yhFtx76Rl/XYAbNnwtF/C1Nw1W3aCt+DMp
 kXIS5XA7YFZI+KpwauCFsQSIuzxie+zUnWpFR0TieMr0+iT7Cz8gHRgMW4c3PPRZeeYRjT80dNx
 BfVVO6ikbjqkFclhvgivLJNEkRaMoMZWX4ske5MiZa7mJ7JkdA3o7/nlDcNB1LQXxYSKuJQFeSy
 Kc=
X-Received: by 2002:a05:7022:ea9c:b0:149:49c:233 with SMTP id
 a92af1059eb24-185138b5a78mr9592984c88.27.1792405249689; 
 Mon, 19 Oct 2026 03:20:49 -0700 (PDT)
Received: from [127.0.1.1] ([67.159.246.222]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18319d3b880sm26324251c88.10.2026.10.19.03.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:20:47 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
Date: Mon, 19 Oct 2026 07:17:16 -0300
Subject: [PATCH v2 3/3] ARM: dts: imx6q-apalis: Add VGA overlay
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-v2-apalis-imx6-enable-vga-v2-3-ef6a3a780472@toradex.com>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
In-Reply-To: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792405217; l=4062;
 i=leonardo.costa@toradex.com; s=20261001; h=from:subject:message-id;
 bh=r+aca+myZbkHcW0Bz/oaFLZH6+eopUpkEgtw7VP1FW4=;
 b=Zvh0iDVRcy5Gtps1SXd63pWalIOszDSoQM1rurde5ryRdO6K2rMFmCqUHSbRjy9tbneq4/t3j
 sSjRGYh4TiPDpQo5LJT494T+Ww6uL06s9RSdMfWvljaiQEMcGs5xrW/
X-Developer-Key: i=leonardo.costa@toradex.com; a=ed25519;
 pk=4xvoVLDt+NxIz9D8BJHhT0fD43Ig6XgSDw4jRN/gHzk=
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Leonardo Costa <leonardo.costa@toradex.com>

Add a device tree overlay for the VGA output available on the Apalis
Evaluation Board, which is driven from a parallel RGB interface passing
through a non-programmable video DAC to a VGA connector, without VESA
DDC I2C signals.

The non-programmable video DAC consists of a simple resistor ladder that
converts the digital 16-bit RGB signal to VGA. The VGA output is gated by
an active-low data-enable signal.

The overlay is also combined with the various Apalis Evaluation Board
device trees to provide ready-to-use DTBs.

Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
 .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 80 ++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index b5fad2ba764c..9c218260fdcb 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -60,6 +60,22 @@ dtb-$(CONFIG_SOC_IMX53) += \
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
@@ -186,11 +202,16 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
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
index 000000000000..991c2b7c2777
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso
@@ -0,0 +1,80 @@
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
+		compatible = "dumb-vga-dac";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				vga_enc_in: endpoint {
+					data-enable-active = <0>;
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

