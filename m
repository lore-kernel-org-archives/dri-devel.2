Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F4FC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8513E10E55F;
	Tue, 28 Jul 2026 09:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SsJ+EI82";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D702D10E55F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:18:39 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so43458185ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785230319; x=1785835119;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AETGy+ANMs/4mEVJOXJB8nyO+6HDkmoHxo4KA1OMiIw=;
 b=SsJ+EI82yHklhizzp//aQtmb24c2QsRHosNDQywOY5rIGAoqVaHEpFbt6nP27x77SJ
 YZcWMJHRL6UNvEvpKBFqyEx7eF1ToF6vfsEkGVD9XPEdBD0TUGkcsFq9CUtfgJwla5OQ
 xzNatiTUlH6g5zrsQ2DHUmfIzT05KSj1oRBaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785230319; x=1785835119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AETGy+ANMs/4mEVJOXJB8nyO+6HDkmoHxo4KA1OMiIw=;
 b=IwoaE9Tyz3PwYrf02LDjvGWmTRGMWwt0+QpkAnG9dUZgU3fflXCeEEwXFI+Dbex0sZ
 0RIn0186Bq6DeKW9jJUb+lSHDtWU5lGy7ERp4aHz2daX0Kad0F6amx7yzWcUs38/T8L3
 ao7YGS5tf2LpLNR6htKECUX+9t4nU9sOBVPAP1YjfdKIcaucJ0J7y+k8x0ZhWquxjYRz
 GS2LF9ZpjDvnsaFpDEGFPIw+JGkZsBYO1Jn+bP7lZyrLcFtW7lHe37+W0eMknT6udvzn
 acQtlDm2AXWIYvHTQdjWn18mS/WD4uZWPxv6IUyr1wqUOIaYjwkQrsBiiBFHg4sFr6e8
 1BAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrB7Ko6FqAaB4m7ime0MZRHnav5RyJIsBV/F0wDdNJsxUCe6ZvjAgqqxXp16e1GCstP7y9hWA2m3dw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrIUw/eALeAEjPJWCelC8o3NEXodBR8NbackDZPhwn42z/fWsN
 LTSlFR+cd1C6eyB1993o1L0t424R5v0rx01D1iM2BlFU5Y41i/iPJ4A11zMeGPMHLQ==
X-Gm-Gg: AR+sD13fMhUvZUrZIxMQuPoOgLtnJh2qPnQ+uxjrEJMnQWos1RhvWm3LIyC7IphNaX1
 5PK3NAC92hzHc/Q5IFujdPOGxiH5vuO7N7BXmagPAnW3bjvxkOVO9fcWSyCYUuGde6G4qCtO9Tf
 vAJc5bSqteJvYES5qjScHvWo9AOOQmRltYStZJYr0mwbtjzi2pJc1ZHa0hHDo0d7n3hNSaKPntl
 EXdN3w8spI5gNR42/xmQgYypxHTv4Iu/Jg9uqY9Bez44cXjrwEtrUDYQivhcJxr2A+zZy8TgC3w
 oGw696F4z1WQCvMfX38C1xfRTDXscglxO1s/RyyiJQR2HQ/xJMiBZYHz+07sIH06sLZxj0JWV33
 ELpJqN62b80JdSGCSgniTshc1pe/w+rfqSiOnf958pkY4+Vn8ejG6oBPmSDGqpEow4BgJ+IZa2N
 P40RNMbDwjQuLUy7jFH22gTBwlDfc+JfYkn7iUaNBWu7XSPVZ5TJe6zfxkNyqOWeHztBeNxA==
X-Received: by 2002:a17:903:19f0:b0:2c9:fc14:588f with SMTP id
 d9443c01a7336-2d015f024b4mr18169045ad.29.1785230319419; 
 Tue, 28 Jul 2026 02:18:39 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:c85f:b2bb:a077:d544])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81dcc1sm48616965ad.84.2026.07.28.02.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 02:18:38 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, YoungJoon Lee <getfeus@gmail.com>
Subject: [PATCH v4 5/5] arm64: dts: mediatek: mt8173: Add GPU device nodes
Date: Tue, 28 Jul 2026 17:18:03 +0800
Message-ID: <20260728091804.382753-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728091804.382753-1-wenst@chromium.org>
References: <20260728091804.382753-1-wenst@chromium.org>
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

The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is part
of the Series6XT, another variation of the Rogue family of GPUs.

On top of the GPU is a glue layer that handles some clock and power
signals.

Add device nodes for both. While there is supposed to be two different
power domains to the GPU, MediaTek does not have any information on how
this is integrated internally. Assign the same GPU power domain to both.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 556e806b7787..169ba4fd183e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1002,6 +1002,37 @@ u2port1: usb-phy@11291000 {
 			};
 		};
 
+		gpu: gpu@13000000 {
+			compatible = "mediatek,mt8173-gpu", "img,img-gx6250",
+				     "img,img-rogue";
+			reg = <0 0x13000000 0 0x10000>;
+			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&mfgtop CLK_MFG_G3D>,
+				 <&mfgtop CLK_MFG_MEM>,
+				 <&mfgtop CLK_MFG_AXI>;
+			clock-names = "core", "mem", "sys";
+			/*
+			 * Binding and GPU core HW have two power domain
+			 * inputs, but MediaTek does not have information
+			 * on how this is done internally.
+			 */
+			power-domains = <&mfgtop>, <&mfgtop>;
+			power-domain-names = "a", "b";
+		};
+
+		mfgtop: clock-controller@13fff000 {
+			compatible = "mediatek,mt8173-mfgtop";
+			reg = <0 0x13fff000 0 0x1000>;
+			clocks = <&topckgen CLK_TOP_AXI_MFG_IN_SEL>,
+				 <&topckgen CLK_TOP_MEM_MFG_IN_SEL>,
+				 <&topckgen CLK_TOP_MFG_SEL>,
+				 <&clk26m>;
+			clock-names = "sys", "mem", "core", "clk26m";
+			power-domains = <&spm MT8173_POWER_DOMAIN_MFG>;
+			#clock-cells = <1>;
+			#power-domain-cells = <0>;
+		};
+
 		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8173-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
-- 
2.55.0.229.g6434b31f56-goog

