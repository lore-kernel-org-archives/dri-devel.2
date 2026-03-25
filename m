Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5BFFEA830
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9A110E805;
	Wed, 25 Mar 2026 07:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZVxqyGJ8";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 330E010E803
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:58:42 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2b04fc8851cso21774415ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774425522; x=1775030322;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylCJHL4jz4SMJERGBRhfgz5hmf9BV/IyctYJz76/DdA=;
 b=ZVxqyGJ8YcriXjeKp9nUpOdes+aHDzDTqIrthRiDRSkLKB/OO+aQGuCQfWc7c9x1H3
 SHgCJpQPJD6VYKiR7PdfP5FEEi8qss0HjP5xeos4DJrmqtNy1xx8Lfm94bj5PDZkp6IC
 SX+WLbqbTPeha9YbZw6uYc+fDvP1281p+J6v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774425522; x=1775030322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ylCJHL4jz4SMJERGBRhfgz5hmf9BV/IyctYJz76/DdA=;
 b=iCfQT4pgTmviUwztDh2Qxh7D9sxJv9ZsEJQWNTz7uwu3UYau0yZrA3Eaz6U5/zWakK
 yFQkuWEzDUUBdpdotDhLwDbfBfZ1133BpHeZOAFX1JjjBXOQK6BO/8YXseEH1ZoL5g6y
 ocr1gYcaK0mc20U0gtT/MaSqpADpa1vcXC30wKDsMUFDNMMkKpnAfxvIzpH0b0G6Kpdv
 fXcnctmdpQenloRzBqYS9LiUS54MXwrSatXKMiM5mVmO890qg455uRC8beWlcMo2vqnp
 yvTNx5TQEv0Om+Jus51UnqRyBRB1CDY0Y2PNJ/+FHIDmEcEO/ZJ4cxJ/JCrQaL9X3zYV
 iEuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURs/Bg3dwwup6Pla+liHhzPvee2p7bdSvJukq+SU0wECSBnB/5M/JXUstKRpUaoBNXgkugj+PfcSY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBbq8IslL7jhYcs1qvgSPVGJskSsXrVbi9B77tsM3zBbvvYipb
 eBtfzCSNJ01b3HCpHT4/U/Y7uH2anjbG2oWhrVElop7z+p75xS4qW3fA0yK3UYmcIQ==
X-Gm-Gg: ATEYQzwQ32zARRzzNk7BCjZm2voZlzm7/C0nB/j3Hu1IrWc5L0HwGL1VBu31ebARkeK
 j4FYrpnfn+R3Wged6jApePQURPQuk/IV/sYyIC3RwLSi6GhIUSoD526PKYF34HMPmrvkHKDpd0X
 +GTuao0axOEB++JwolpDJ2ls74L+h7R9IfOWoo0Ww60VBlVHFFrtmb50bmqN4NQg9hs0qGDGoWK
 bHcfCwHPxVMgwXYIMcSIn2huNCMoCpbA+bh0GFTWrjEnEMGUayle5rSqdYhZJScDXhRrkvbrgy7
 /P+SldlZVxIkhyyonRi+z14CUr9T0ri8ZQ+AQYkRK5AVbOKVREG0Y2x3GJviVPlAljTbttFlpXK
 uW9cH3tWMai+MwV+sVAfhNDLYYqwdJTfIefRW2qFZdldE+IPBLEe0HBxDZSUKtKy/websi/+J/m
 waVLd9VjAXNwmeyCIZFU7ta8GxRDQiqfBMzeI4dbGBfi8WeRKsCi5lLnOorru/ni/7kguViYBhL
 Decr4k=
X-Received: by 2002:a17:903:3843:b0:2b0:9a61:916 with SMTP id
 d9443c01a7336-2b0b0a7f831mr28028415ad.31.1774425521733; 
 Wed, 25 Mar 2026 00:58:41 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:7ff0:bee3:7d45:eab])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08366c3f7sm219682465ad.60.2026.03.25.00.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 00:58:41 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Icenowy Zheng <icenowy@aosc.io>,
 Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: dts: mediatek: mt8173: Add GPU device nodes
Date: Wed, 25 Mar 2026 15:19:49 +0800
Message-ID: <20260325071951.544031-6-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325071951.544031-1-wenst@chromium.org>
References: <20260325071951.544031-1-wenst@chromium.org>
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

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.53.0.1018.g2bb0e51243-goog

