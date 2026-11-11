Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA37606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HL0C7LoU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609871120F0;
	Thu, 12 Nov 2026 12:55:53 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7F510E3A6
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:31:45 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so38424825e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794403904; x=1795008704;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G8qkZnmaQmgcsJmklkVA9+lzZWNtRCGmSFYQH3Mj5xE=;
 b=HL0C7LoUsH1CNhqdtGCTqhsCsJe2qA25Dg6RGijj5Nt4beokpi12hHULveUw8Cl7xg
 NzwxK40xvpgnJhvIOga1hV36160xZyBMs1/y8LPVzTZgr8mVMQ7PG7v6gCs38oeUO4dq
 da+aMQWI/Fnx777WkslBPJIOdBJd1YGCr1d1Ply1fxXYVv05rhuBGR17b7RRDtjZLpB2
 hBRhgx7kT45xUDXvIABQVhzbu5Sxrkd+ej339+gdMjItVqK+vTKcJyiH/UQwUvaNdEbv
 lgYLttqjlsAum1KubcjSfUJP1sIxAyTBlHJerarwUaYHq0M34NJcgd5KjoJJ++/uO5nW
 XlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794403904; x=1795008704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G8qkZnmaQmgcsJmklkVA9+lzZWNtRCGmSFYQH3Mj5xE=;
 b=b1AvFTyG+H4ITo8zlWX5ddCOPTe50+Dfqcwjy6n3I6lpxpKehDRm3/ARjTF2bpc2nx
 S9TU1AwpA8B0WG9JFDPAJLrciO09tOabkjm+ZLAfZOdiAVXFdoK/DlJpajh9aC44G/lZ
 KLkwdAxzJnuGze9nBBJMmcubgTt3srvxbD1PnqVfDZjoiJl/sSuxeDZuEqxnhrLWuc8X
 qv+fm4e92uKw/PiA72wQLoCgzeQaFt17hxR8ZavTXoCjpTUmQUpujwRVGp23NjL854W1
 GaisJgPD+Rz+rXF+PUOZvkJT8O8diCN88DbiNgjIPwfLuzhkISyRjG0KHM2SoLq0iK5s
 4+dQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGG1owuYOlIld0ji7DMjPkjgdkIzDyJLHh9tZuykURrchE8tg+dpdU1An4yvgdSeNFWA2PAZ95g9F0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8io4KRtsy8Jgrlr9xL3VFG8fttYoQIac8nYWM/mCud5QnpqIG
 dT0OauKxltqmqlSEtlRKodYOu9nNmfF3lDozBdMnnHHLZ26plCS6MCIF+PiBj0KIEFQ=
X-Gm-Gg: AYBFou3WhJgMrSNUaDRK+l4aL2VT3TRdwybVEUuerrFGd78DXchm8bQx35v9292qFTM
 nBHNdrT670wbHzXXRJj5DmeySfSCtX2p9F0Zv3zNhVhv4rHPN4GtPc/oPYzOIKlCmmQF3DNDFdG
 qQt6g3W1pit9yw4ExO581KT3IgpZMvv4i/iljAN5TkRyWDANNKT36moR9IzvZXDYEY49D0ImEzk
 wDG56pHYvws86bkzH/76V7LJQWsrKSX5PpHHV4S+c5RJuZqRxnLbCrWXg+K3ZuJVep9U4Gb28S+
 ilLMAaLMBKWbW21asSGAxzSP5XbBTZYyCxSQTOSNufTD65RfSBAn5AJHvb3RtPJ6D1gYAhhX3vU
 U40cCIraJIC84dD+8LMEgP8LohLCB3vE0jwnc+UurxiY5LB7nkH4OTcl3Kr1L7qVIW/7jBuYFVW
 fvHwHfHlPQEQnrsjoTtxHcz1dO2j57sZI6xJV5HBnoIxzAGo71X+RtFPjmdAp1DdDQu45jcXc7L
 UKB36K11p0HROffpGja7o+IC9gIiLMpE43zXOOOs6OZb4Yl4CddrqzHTaWk3GDHkNG59my/5Wsp
 7xH3/Caa4gLmYvJnezk6MQFVCw4tbyAbxL8CNmdUpV2WVK1vKhoq1vPMfbAYnrYNPGFfMOHNwE0
 vu4fgSw/OR3c=
X-Received: by 2002:a7b:c342:0:b0:4a2:f58:9a82 with SMTP id
 5b1f17b1804b1-4ba08e16f94mr38360965e9.13.1794403904169; 
 Wed, 11 Nov 2026 05:31:44 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm11089358f8f.37.2026.11.11.05.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:31:43 -0800 (PST)
From: Frank Obergfell <frank.obergfell@bytesatwork.ch>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Frank Obergfell <frank.obergfell@bytesatwork.ch>
Subject: [PATCH v3 3/5] arm64: dts: freescale: imx93: Add MIPI DSI controller
 node
Date: Wed, 11 Nov 2026 14:31:17 +0100
Message-ID: <20261111133119.1063210-4-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
References: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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

