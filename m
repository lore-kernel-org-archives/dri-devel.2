Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B132CD6E4A
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 05:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0168A11270E;
	Sat, 30 May 2026 05:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HCA9jAAI";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C25E112193
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:56:14 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso95586155e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780070173; x=1780674973; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1A+YljpcvCERY1OoB5p2TF1PX3S8oCba6E+e91fZVo=;
 b=HCA9jAAId6FdfBhST1RAw5mmKLeFbmgOCkZ39FBB6lI+3QOkfmyuhDuHBObMGTVnHA
 ErV9EEOh1ibLXJ4v2cHR9THBV1e4cgPk4l0cdcqGeYpVTj6FVZWJVm9GKtxe1al0ERFH
 JmEf6kZPDRXupsY9DF3r7FBBqHfndxv+Eftqk1BzAkrVxcEx9LJOfb4zFbDYBXe+lqjh
 loTBnQ6eSSD1sHPW7tEvolFt6HLu10xRjcsYYXpC1xDYhRdW7EM0/35R6drV20yiwtjB
 wWpvvRCQusVf4Hck+baLE4pZMQ0oXBihyUh7Qa0yFI7UCrKSkn6txWzt70el0ZQvQ+aW
 0zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780070173; x=1780674973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p1A+YljpcvCERY1OoB5p2TF1PX3S8oCba6E+e91fZVo=;
 b=D92CF7PRKRYUzxQLE0cmu++lIqeOV5d8/ZnHiHAy8ZVym14rj9ku3sEVWshxxHMYtj
 +vmAioFPKlxhb2X5XjiI34HISyo4fT/uXPOVFbVQ2zGR6+jxvXLxREwokBJ97lM9lI+9
 FG59MHKct9+n0918OMUQ7+mdpM1PCMmkeB1YPkt8bJoC1YFNX31yPvFKlAl/z3ZS/pu+
 7F1kV7dSOBHsMWXYebwgUOU3Q/5dtVaCiL4MMAbqn59pCjXsuVcBxCRdPbzw6FUA3Jw8
 spwyPnEdtFNOeXTj3mmuAeEp4XqXwUnbGbKyQyYdZ6iZWDsD4cj+cKigrTvnNtBHOV8A
 kZbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pwCHplbpso7UufO1hqtPDfGpLR+4UuNT48kUyjkLpDAWUATVK5QtP2D7wggU6KBCTgfw/pq/b4mw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnNQ0cLHsBATB5baBWiND6WdbLec8hAlR35NIVNQ5BYyIa6lcq
 p+mdw8vHPjtm2D3oil6kqvDFLuGyJn23HeY+SuPuaWXuWga0zziTIajN
X-Gm-Gg: Acq92OEZylhMeYhA/H7oa7cBruw1Zd5IcUI+3Ueh/1z9aqBlNLw2C/QBvjaIBHcIgei
 1lTnlZH3UzvHFYRp+nvUHqOEkHGeFWAoNoK6+8HPzd+/LjGAHUlSMTTBdVPP8FV2HOLURgP2wuO
 ga+zR/EklhiUldjaSwE66SCYdFo1sY15xIGkX/dtHNN+PQH8el2Zt925CqmuOWRKjuXBZJGr4FZ
 1TIJWaJFWBCw4MY2wkAFlemnj0ukjBIKKY6UQhXhi0qKYepp0mGX1+/Hc1GPap7Q7D0QahjgnZJ
 OMRgk3k/okjFEJdtPiDfokkg8VTq34Rn+EYQdYFNGsqT6QMM7F8bBM18AeGsBjGMx+omdsJphf3
 rp2TWkLmhfrZhJIjQzFM/f+FYmAsEXatejPpLxoUYZybGZIFm6bySPthfZeGmsYwAa4JKUVn9pM
 6ApPCDt0JQ0YdG8Uha4cZAjX0CFyR3GWWtFzK45gyiCiB8j6S7vWpQAXHg9YYQC0MB4FjtwlGEt
 +cTe/fCY2dSZDlo1bLJVTi0jV+p1nU6oVhJ0io9
X-Received: by 2002:a05:600c:4703:b0:490:9d1b:f086 with SMTP id
 5b1f17b1804b1-490a2915c45mr3835355e9.14.1780070172686; 
 Fri, 29 May 2026 08:56:12 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 (2a01cb09e0354cc878d00097536575e1.ipv6.abo.wanadoo.fr.
 [2a01:cb09:e035:4cc8:78d0:97:5365:75e1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cabfd6esm55150315e9.15.2026.05.29.08.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:56:12 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Midgy BALON <midgy971@gmail.com>
Subject: [PATCH v2 3/4] arm64: dts: rockchip: rk356x: Add NPU and its IOMMU
Date: Fri, 29 May 2026 17:58:23 +0200
Message-Id: <20260529155824.3099831-4-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260529155824.3099831-1-midgy971@gmail.com>
References: <20260529155824.3099831-1-midgy971@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 30 May 2026 05:55:09 +0000
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

From: Midgy BALON <midgy971@gmail.com>

Add the RKNN core 0 and its IOMMU to the RK3568 SoC dtsi, mirroring
the RK3588 pattern in rk3588-base.dtsi but with rk3568-specific clocks,
resets, power domain, and a rockchip,pmu phandle required for the NPU
NOC bus de-idle sequence.

Both nodes remain disabled by default; boards enable them as needed.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 8893b7b6c..2c2a57ea3 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -929,6 +929,37 @@ qos_rga_wr: qos@fe158300 {
 		reg = <0x0 0xfe158300 0x0 0x20>;
 	};
 
+	rknn_core_0: npu@fde40000 {
+		compatible = "rockchip,rk3568-rknn-core";
+		reg = <0x0 0xfde40000 0x0 0x1000>,
+		      <0x0 0xfde41000 0x0 0x1000>,
+		      <0x0 0xfde43000 0x0 0x1000>;
+		reg-names = "pc", "cna", "core";
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>,
+			 <&scmi_clk SCMI_CLK_NPU>, <&cru PCLK_NPU_PRE>;
+		clock-names = "aclk", "hclk", "npu", "pclk";
+		assigned-clocks = <&scmi_clk SCMI_CLK_NPU>;
+		assigned-clock-rates = <200000000>;
+		resets = <&cru SRST_A_NPU>, <&cru SRST_H_NPU>;
+		reset-names = "srst_a", "srst_h";
+		power-domains = <&power RK3568_PD_NPU>;
+		rockchip,pmu = <&pmu>;
+		iommus = <&rknn_mmu_0>;
+		status = "disabled";
+	};
+
+	rknn_mmu_0: iommu@fde4b000 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xfde4b000 0x0 0x40>;
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "aclk", "iface";
+		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>;
+		power-domains = <&power RK3568_PD_NPU>;
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	qos_npu: qos@fe180000 {
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe180000 0x0 0x20>;
-- 
2.39.5

