Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06368606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=L2RSvLDh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F14910F95D;
	Wed, 11 Nov 2026 08:24:09 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7AC10F924
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:13:12 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so30923655e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794384791; x=1794989591;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G8qkZnmaQmgcsJmklkVA9+lzZWNtRCGmSFYQH3Mj5xE=;
 b=L2RSvLDhSsS5QwLkDBIIk2rCLmYGRCIZxYiE8MrMGpcRFJv38V6eQGPqkzxWic0KZ3
 aVbUx9agIv2v5zsqaaL/PXdOKmxbSP4CocLtIsti0FgGVR635GjD0xIeHPd0ap9s+BL2
 YDQQHuCKzEKrD8SM8nLKjf7pHH7+qWU/ukvPQzXeWJhCFxDJu79Y5yuIG6mvtAyhzodL
 oHbOdtLl5lRGsr+3ctn2MGdF+1AgbtKVZ0TxiLglnNpRN9WU2oT1BpdJHK9SfV3ma0Uo
 exU8uM7o2k4ZorVLokjP2+CrhoywXCLyPtCW3vhOBhQ3ITN+PcfgpGvb4FZ8Gf4VSgqs
 5qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794384791; x=1794989591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G8qkZnmaQmgcsJmklkVA9+lzZWNtRCGmSFYQH3Mj5xE=;
 b=UoZqnuytbcbcl54bo8w/qpYVyVvv4qfKr1T8ii3tRu3k6An0pOsvltwUk0sh1p1amm
 WcSFRo6bq31xwfL+uHHTZpxVEKtTvn4NRtFtwD8/piDE/Acjyg2vhDdwcWDamc2Dz8jb
 FTpFxuayHMddqphBzzBvengKzLeUZazb0dq+RuahOO29cvNRrCCD1c6eQIRgDM++aOS3
 abA6JkvvWk2Ii/5ZYRM3Lp6wV9/QkRvDqfUNVRFqUxveTf5kED0RnrZy1v5IoMvkqkHj
 javjl0GHssqwSVQdx2IO8AWy4gfUH/3aHalN4x7HFVO3Ws4rPZ7LTvHQQ5TdGSOv6iAt
 UXLg==
X-Forwarded-Encrypted: i=1;
 AL+hErG1P1xMptJHeRdebg2dtXS2eihEnNcumyUMo6GQGtol4p9GG+ym9Mm9MPsN7RQdA2mdv6gf168QRjI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/dvVgDTF85FljdgUfzzIL8+8hi2v7GVvLTsB/W8wB/jSceRl/r
 FNmRe9GgSnhaZ4Z7dVZUU6CbgLElcYbCNxk5v2VLdpB0/0Do2hhsiT8rf3TIX95Yfh1WxvVQNTY
 OhMiTKJM=
X-Gm-Gg: AYBFou1IedF6YVdJw3JnFUvPM3xKjmTXA6OasgGzPzTSABVprhXhN9QmtMaoOM4EjLa
 RCt3wba19Idy9PuMLWdJr03k8IYT+r0OHZbsEOwTTBKli+bnOePwvtUtYouL/CzifwRGz70IvSU
 uqRxkTsgJzr9NrFcL3qzn9N2Q2+JKJBWn6hqfr+/Xs/BG3zGnwLs+sbTd6nDKNq72u3+1+dvI7S
 kWGpV7/lmhQIrf+y7yePyTbd1gUh/T818hY8ifVHrKnWjYFzuM7wWGoS+V9TiEXTpUhFt2oVr98
 doVI7X0KMbVAXKyOk+OutC2DNsjFU/ApSk2ZcKPPcgANuC4XlpqsCZ7qP7yiNdDXltqcOCxWjkC
 XchdeBR6oPq2AuQa6OiWC9NfmMaZIsUFWtucKYsQOUWBsN49oWeK+bUWqRazMGIN01iURETagoz
 Pmr/xy2OeRaVqlJqavK5hiM6HDFXSB732/z/GRkrznt0203qqEsV4jh1fjQXqLDtQyGmYXK+VQw
 ayhjx0aZa4e1yGIYaijsJJ6tnXAQ4VkpwWxF0ubvf60NzuObW9Z/8d5oJc2jDEtQtld1CWlpUF3
 HbYf678sBG7QCvcAX548CGQ7l3DPap4k9M7wdyzgL9KrchLHyv+++8yGk9/WomlCWLgfVKIiDSY
 zc5rYKkUvmxo=
X-Received: by 2002:a05:600c:4704:b0:4b3:8529:eb27 with SMTP id
 5b1f17b1804b1-4ba09389f82mr26248335e9.27.1794384790692; 
 Wed, 11 Nov 2026 00:13:10 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02242bd9sm113233815e9.15.2026.11.11.00.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:13:10 -0800 (PST)
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
Subject: [PATCH v2 3/5] arm64: dts: freescale: imx93: Add MIPI DSI controller
 node
Date: Wed, 11 Nov 2026 09:11:48 +0100
Message-ID: <20261111081150.950272-4-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111081150.950272-1-frank.obergfell@bytesatwork.ch>
References: <20261111081150.950272-1-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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

Add dsi node to the i.MX93 for support with mipi dsi panels.

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

