Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F35606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tLmSvOJc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70D510E7CD;
	Tue, 10 Nov 2026 08:33:29 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046B110E877
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:24:05 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so5437045e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794227043; x=1794831843;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qYbJCi5+nwNEi61CS2emr9alE1zi1Zmi+juvvOHmGRo=;
 b=tLmSvOJcucNCkcJjZIDQHq3ulg0JCpzZVcH7j/DxLCzXN2X5CZf1/BOxv/aqp3u1mc
 DCBt12pJbtxsEhKHrJ/tthVQe+PgNhDue6YHLeJnrfwCtJ7Uz2nowlIyvBChbk3kSNGp
 SQxo90lec/jWMRWeqE+HJvsDau3UoOt1Do28waWVugxS0RR61gEh1SYYaa4Ie0xddX3o
 bkMOIP6jiNTv5VA7kPzNcrrMSxrmHTaVBcI8y5VtjqilqkuZjTaOjG7tscVq/RpDPYgd
 ahXvR7dwGuc47zFN6416ktV7pyq4w90ZyAhe3g60QEMAtKBeYxkfADq6fg5wh7MUe74F
 peMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794227043; x=1794831843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qYbJCi5+nwNEi61CS2emr9alE1zi1Zmi+juvvOHmGRo=;
 b=2DPzTLWJv7o6kd9Rt2/d7ar3qd3BOD+cdv+ew2NtQZD9fuZ0NkR39tRHBhz5f9pEh0
 EpUF3RuO1CBcznZ8He20pNprwpoJ4QcdfFX7kuCievSq0mofcQO5gCR4FDH98X5bI5r/
 SzXedQ9skR16YVDJWTsk1g1ADXozw2b9VCS17Qz7Kl0NaCLM5zzizPF4PoJqzteOsvNX
 o5pwd4d7eTgS5bDm2lpgmi9rtjG3IkqPErtriWlm0gINjO8PBaaiS8xYmwjLhKS7s67d
 KNnRXH4wNjDHkht+VTDvFFyBZCg+ewZlIw7jH3jQmA3HycRHVroNoL7b0QtrX722Blxa
 iSfA==
X-Forwarded-Encrypted: i=1;
 AL+hErEFDdryu1DvPmyIDKjLjo9l/gcp6u2f7eCLz3e6GPf24ZXQsWwJFy6pW1gQGsap4xSkXiPhi0DyBm4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9C6cJSaJJWHA/vG58tocR2u5dW4BG5XT2HKwK837A1ZrGb/nup
 5eX+4fOMpzs/ro9OOQDCs3mvQ26ULlRy4hJMlSU6deNzcZUJABhlYzNxe9024uHEUJU=
X-Gm-Gg: AYBFou3Id05q9ptEF1fJ7SqFJ7SxtHikkbpVYFRP7gzdVJrM2Rs9igt09tjBVbHhRSM
 IrFo/JzyopTvtUG6LNlXoCpMsoM19Qb4B0YnzBpbsnisY3W6F0L8LOmU5a+D+Ha9GKJLRkCTNVR
 8qPav+7i7cy2dOFkkNhlsM2HTwgx1N5Q1MOTnOm/eOWFB1tKdUBx9Hzdq/O/nd3UGiAeHPYkScv
 kOVO1QXUnPjwqE8a/Xq0SDf9wbGBqgjQ0mR4ySq168clmcoRZOTV/2lln4/Lu5cfAYP3HGjXxhP
 FopfqLahUj10lPl+H4i6XTfkWok5HMj0zhDTNZtE9pSvWzW9BYVOxa0NXi6JLPMSxk/l0+U0Utb
 7ppPlMznRMU+z6dkitWviejOLVe8cLfzTV503FzdGBd2ry2IpuCJ6eQ2lPJ4sQEpvUW3uOzMRg3
 sWzhJthTpOC8WSfMDfP3UyMHM3Rq3U5aSUttm2GJwp642Sj8UwFhrcNSKeUd0Kya8yrcDdhWX50
 kbyV2RbBHHAqvrNxE+J/QkFL99t2ATv3p/mllfBlKwHDlSwZuK11421RyFJTCm1unzwdtTDXz+e
 mYHyBd/2EkTpKtR9xFU3hi45FfBlufKT0iOr6aVIioGK5Uydt8Bj7V7mNHIWDrnJ/iNrjjqlWjX
 zKPasGbSfkw==
X-Received: by 2002:a05:600c:8b70:b0:4a2:fd2:985d with SMTP id
 5b1f17b1804b1-4b963c73ab1mr72661995e9.12.1794227043509; 
 Mon, 09 Nov 2026 04:24:03 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597652ca7sm10500318f8f.39.2026.11.09.04.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:24:02 -0800 (PST)
From: Frank Obergfell <frank.obergfell@bytesatwork.ch>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Frank Obergfell <frank.obergfell@bytesatwork.ch>
Subject: [PATCH 3/5] arm64: dts: freescale: imx93: Add MIPI DSI controller node
Date: Mon,  9 Nov 2026 13:22:48 +0100
Message-ID: <20261109122250.720757-4-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109122250.720757-1-frank.obergfell@bytesatwork.ch>
References: <20261109122250.720757-1-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add dsi node to the i.MX93 for support with mipi dsi panels

Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index e926b6360a9d..1123e372eb79 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -58,6 +58,39 @@ npu@4a900000 {
 						 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 			assigned-clock-rates = <800000000>, <133000000>;
 		};
+
+		dsi: dsi@4ae10000 {
+			compatible = "fsl,imx93-mipi-dsi";
+			reg = <0x4ae10000 0x10000>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX93_CLK_MIPI_DSI_GATE>,
+				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
+				 <&clk IMX93_CLK_MIPI_PHY_CFG>,
+				 <&clk IMX93_CLK_24M>;
+			clock-names = "pclk", "pix", "phy_cfg", "phy_ref";
+			fsl,media-blk-ctrl = <&media_blk_ctrl>;
+			power-domains = <&media_blk_ctrl 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					dsi_to_lcdif: endpoint {
+						remote-endpoint = <&lcdif_to_dsi>;
+					};
+				};
+
+				dsi_out_port: port@1 {
+					reg = <1>;
+				};
+			};
+		};
 	};
 
 	sram: sram@20480000 {
@@ -183,6 +216,7 @@ lcdif_to_ldb: endpoint@1 {
 
 		lcdif_to_dsi: endpoint@2 {
 			reg = <2>;
+			remote-endpoint = <&dsi_to_lcdif>;
 		};
 	};
 };
-- 
2.47.3

