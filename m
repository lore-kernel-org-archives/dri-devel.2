Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00E0606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3h45NTC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3976F10E7C9;
	Mon, 23 Nov 2026 08:59:07 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C7B10E7C9
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:58:57 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so22585385e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 00:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795424336; x=1796029136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1EXVEM4I4sHSFjrWWT9LPUpNwHQcqbIl9vwHkY7pXuc=;
 b=q3h45NTCQUeLbXNf87CnjsNaw1XX7h/wsDM9k/00KtEcHTut1eto9xRfcPlaSlbYH4
 COevS0bmC0rQ9dZUa58ten53N1b1NfnTNS7kl1Z8W/n2r1mW7tv9S+39poD+NK8ibcs1
 ZvgKGLFSpxdP/NMG21r3NRBtFruNApB/bvpaays6Qtnr3K8VskHbWliUZ05W2HgGTiPq
 td3jl8pH3nzfEDKWxVJoOPDVkPE1pjCVOP4V3NbnB9ve8gFvAtq5gnRYgJqh94RZwVW1
 qDVDsXgpDdcmZyMpkcagF6RM/6r68k8m+yHEal3YpfmeMKONiJXf7UM82x6oFzlklcIW
 3CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795424336; x=1796029136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1EXVEM4I4sHSFjrWWT9LPUpNwHQcqbIl9vwHkY7pXuc=;
 b=E7YIxRfrhuXE0XXBI3rHkXxmO+B+/LCmcXfq7zAgaB/EkCA5YnCUHSvqsJCcI2d48w
 tP6xwkJgqsiJdd0rPwTHF84YOhsyT2WmBsZr9JusdmA/ij9Q1avhBFgnPCCdLJND9lm6
 VkIw1qlQaa77JFrPq3ul3Yzex8FbkAehkrVzSU+X+6w2GGs5kM4LgYOPPkTJyzwbfyo+
 9EwU+yf+D5RnuGy71vmzHVqJ7A5LfnIK5RT9t7wSCSxSvObaWtDCwnrvc2yK/WFSIJoN
 DdUZazUWKXylOLhw40Xn3EUBbciWc1gOddcZSqDI/KLj2y5jEnzQIr7wNk0hfgFljljH
 mYyQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEkgmwr6RbTSjnlkP/KUyaLOjOJ4l+k/lWIZ2fcZDBTLxf3zqRR7Ma61/4rDBAsow1wr/iDJaXvBN0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/kNG7w0K/V4+4e1VXqmFQMQKzGfK43y8zkl7dqAJBQa31X3/PJ
 YOw13nIhR4cgEqWVQRgAfhAAS3oz4wOjKUAyDI0ahwvks7tLtXZ80x+s
X-Gm-Gg: AZFdTZcH4MjWWKvAPxVJx0ArcVGvN6guAbuCkryB+dUA/PDVJIQNKcljZ4MFsMvZyiS
 QJYgIGNDnMnzq1jnpLIYCK8h2Aetw4rqmPZfa4GKrx7y/FV6MS/dAMQhPUKOKdYu3AZdGE0WId1
 T+X5qpbEueg8tMzqUBkbRykaNxMeVmjOpicQURGEccGz0VF+ZGLpmg7m7HAvzaSqwq+FgABMN0Y
 r0rGMt+er0SlUCpAbJL8Z5kn5R42m/G5wD1YWibEEGOaDfuX7O9DbqgI48ykTD9IJOIyvNsIJYx
 9qYAqrjed9t4mqSbTb5ZFAXVGmxRopZzra2H4rrKf5BHvFOcBrzRxYnH8o6sC6nN/qvatcpplAT
 4D4qss+W0QIVPAx6R4QFNGyz5bGQ6dJb9qXH26dboqwE+cVrFoUPYqS9nIE2Y9MvkwpVtdyWXhN
 Xl/juM2a7X7VpXGCziUy0OipeYTY2XUlNJrGPBlCXtcygen4Jz3blTMYCM9XKQtbI+ZPzjYLsHQ
 NXWTLoGCXySWvVa7n19bR2POVGL9atmL9IbtU3e9IKc+46zImoQkEk6bmGrGAoMnJsi5C6/ka2l
 +4nswjlQDrg7fgVvMqtY6BQ1
X-Received: by 2002:a05:600c:6290:b0:4a3:59c9:a743 with SMTP id
 5b1f17b1804b1-4bb8882a21amr216218545e9.27.1795424335967; 
 Mon, 23 Nov 2026 00:58:55 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm375960755e9.12.2026.11.23.00.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:58:55 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8167: Add DRM nodes for
 primary display path
Date: Mon, 23 Nov 2026 09:57:55 +0100
Message-ID: <20261123085840.8687-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123085840.8687-1-l.scorcia@gmail.com>
References: <20261123085840.8687-1-l.scorcia@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add all the DRM nodes required to get DSI and DPI0 to work on MT8167 SoC.

The primary display pipeline is defined using an OF graph identical to the
fixed fallback implemented in driver code to maintain compatibility with
existing boards. Its block sequence is as follows:

OVL -> COLOR -> CCORR -> AAL -> GAMMA -> DITHER -> RDMA0 -> DSI

If a board wants to use the DPI0 display output the last connection should
be overridden in the board DTS. As far as I know however there are no
devices using the DPI0 display output.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 297 +++++++++++++++++++++++
 1 file changed, 297 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 27cf32d7ae35..a7818fd92edc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -120,10 +120,297 @@ iommu: m4u@10203000 {
 			#iommu-cells = <1>;
 		};
 
+		disp_pwm: pwm@1100f000 {
+			compatible = "mediatek,mt8167-disp-pwm", "mediatek,mt8173-disp-pwm";
+			reg = <0 0x1100f000 0 0x1000>;
+			clocks = <&topckgen CLK_TOP_PWM_MM>, <&mmsys CLK_MM_DISP_PWM_MM>;
+			clock-names = "main", "mm";
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8167-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+
+			port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mmsys_main: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&ovl0_in>;
+				};
+			};
+		};
+
+		ovl0: ovl@14007000 {
+			compatible = "mediatek,mt8167-disp-ovl";
+			reg = <0 0x14007000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_OVL0>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_LOW>;
+			iommus = <&iommu M4U_PORT_DISP_OVL0>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					ovl0_in: endpoint {
+						remote-endpoint = <&mmsys_main>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ovl0_out: endpoint {
+						remote-endpoint = <&color_in>;
+					};
+				};
+			};
+		};
+
+		rdma0: rdma@14009000 {
+			compatible = "mediatek,mt8167-disp-rdma", "mediatek,mt2701-disp-rdma";
+			reg = <0 0x14009000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_LOW>;
+			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					rdma0_in: endpoint {
+						remote-endpoint = <&dither_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					rdma0_out: endpoint {
+						remote-endpoint = <&dsi_in>;
+					};
+				};
+			};
+		};
+
+		wdma: wdma@1400b000 {
+			compatible = "mediatek,mt8167-disp-wdma", "mediatek,mt8173-disp-wdma";
+			reg = <0 0x1400b000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_WDMA>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
+			iommus = <&iommu M4U_PORT_DISP_WDMA0>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+		};
+
+		color: color@1400c000 {
+			compatible = "mediatek,mt8167-disp-color";
+			reg = <0 0x1400c000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_COLOR>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					color_in: endpoint {
+						remote-endpoint = <&ovl0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					color_out: endpoint {
+						remote-endpoint = <&ccorr_in>;
+					};
+				};
+			};
+		};
+
+		ccorr: ccorr@1400d000 {
+			compatible = "mediatek,mt8167-disp-ccorr", "mediatek,mt8183-disp-ccorr";
+			reg = <0 0x1400d000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_CCORR>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					ccorr_in: endpoint {
+						remote-endpoint = <&color_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ccorr_out: endpoint {
+						remote-endpoint = <&aal_in>;
+					};
+				};
+			};
+		};
+
+		aal: aal@1400e000 {
+			compatible = "mediatek,mt8167-disp-aal", "mediatek,mt8173-disp-aal";
+			reg = <0 0x1400e000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_AAL>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					aal_in: endpoint {
+						remote-endpoint = <&ccorr_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					aal_out: endpoint {
+						remote-endpoint = <&gamma_in>;
+					};
+				};
+			};
+		};
+
+		gamma: gamma@1400f000 {
+			compatible = "mediatek,mt8167-disp-gamma", "mediatek,mt8173-disp-gamma";
+			reg = <0 0x1400f000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_GAMMA>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					gamma_in: endpoint {
+						remote-endpoint = <&aal_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					gamma_out: endpoint {
+						remote-endpoint = <&dither_in>;
+					};
+				};
+			};
+		};
+
+		dither: dither@14010000 {
+			compatible = "mediatek,mt8167-disp-dither", "mediatek,mt8183-disp-dither";
+			reg = <0 0x14010000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DISP_DITHER>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dither_in: endpoint {
+						remote-endpoint = <&gamma_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					dither_out: endpoint {
+						remote-endpoint = <&rdma0_in>;
+					};
+				};
+			};
+		};
+
+		dsi: dsi@14012000 {
+			compatible = "mediatek,mt8167-dsi";
+			reg = <0 0x14012000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DSI_ENGINE>, <&mmsys CLK_MM_DSI_DIGITAL>,
+				 <&mipi_tx>;
+			clock-names = "engine", "digital", "hs";
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_LOW>;
+			phys = <&mipi_tx>;
+			phy-names = "dphy";
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dsi_in: endpoint {
+						remote-endpoint = <&rdma0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					dsi_out: endpoint { };
+				};
+			};
+		};
+
+		dpi0: dpi@14013000 {
+			compatible = "mediatek,mt8167-dpi";
+			reg = <0 0x14013000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_DPI0_PXL>, <&mmsys CLK_MM_DPI0_ENGINE>,
+				 <&apmixedsys CLK_APMIXED_LVDSPLL>;
+			clock-names = "pixel", "engine", "pll";
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dpi0_in: endpoint { };
+				};
+
+				port@1 {
+					reg = <1>;
+					dpi0_out: endpoint { };
+				};
+			};
+		};
+
+		mutex: mutex@14015000 {
+			compatible = "mediatek,mt8167-disp-mutex";
+			reg = <0 0x14015000 0 0x1000>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
 		};
 
 		larb0: larb@14016000 {
@@ -145,6 +432,16 @@ smi_common: smi@14017000 {
 			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
 		};
 
+		mipi_tx: dsi-phy@14018000 {
+			compatible = "mediatek,mt8167-mipi-tx", "mediatek,mt2701-mipi-tx";
+			reg = <0 0x14018000 0 0x90>;
+			clocks = <&topckgen CLK_TOP_MIPI_26M_DBG>;
+			clock-output-names = "mipi_tx0_pll";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		imgsys: syscon@15000000 {
 			compatible = "mediatek,mt8167-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
-- 
2.43.0

