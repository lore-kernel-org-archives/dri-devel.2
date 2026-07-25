Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A76C531FC
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFCE710E2EB;
	Mon, 27 Jul 2026 07:17:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZYbbDKJ";
	dkim-atps=neutral
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF1310F4D3
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:19:16 +0000 (UTC)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-ca7a25cd87dso1015993a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784949556; x=1785554356; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e4C2qDdMDmFuAaCYr0SQwKrHQit4QrHO7xfMnvBhehM=;
 b=CZYbbDKJPGOtOYRi1yBl/DQjJYMEr8Qin9Jx6oNRW/qgSyARXmONZ4PXNPw6Eu2K2F
 hbba2BhT0f1FDGglHPSKbvSG3bqKsOiy1BXcp+3SAC4juLCVFuuH2RMy78ZkBNqMtXJ7
 zUDlY/VINLJ2MrInzK2WOrdLcpi9TcsR3VoU5HgGP/fpqmzIFCsOr6oOBNQq4aCSqh6t
 ozvV30IzwufUWMCLoMB2CgGzgQCBCZu2Q9NO3pE0XV3r9T5MnoFciCASaHn2mCdqzKCA
 G3rS/2GCoPoV/bFqZMJndp+vxnO2s3+G6rlebsUCOqmOIcRKgCcnMn/8XCZjizwP2ERj
 4Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784949556; x=1785554356;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e4C2qDdMDmFuAaCYr0SQwKrHQit4QrHO7xfMnvBhehM=;
 b=hKXtrFygQ3AIY74xhfZqz6xkc70W4ltgyBn2OlNmSPG6ALe8dSgxOZFBwztM/g69v1
 LQnSxCHC4AwMk77vTfYKNQztuhbhPwXhBBMtNP9AQbewVN5Pq3g5Tvm+Feg3BNByKwiO
 etQY7tOP2f8CrCLWONYXbJS1DrHK6dcYhZ4mThcQd6VrI5gjpmXd+glavpq0yBANtEbB
 HzBRiq2d2MHOESUcclRNtBVwBeS/IFCa3fpqnIBov8fRYQ9CUmofcsD+w/igHcqdpuiT
 G8eSqR201I7rblMeg9LhdccAkBJygDfxBVzWUAU0ebT1QOczuby80NQe/HVwKxwqwHcW
 QFzQ==
X-Gm-Message-State: AOJu0YwWc00lbxUH0oMVJf2YhvC4rjXVXuxAq5XiPzqSPS+71SkvCCKz
 jvW9GJm1Co7y9vs9q6vfG5IPzIPoKQ7Rj0erAGJVpCl4XyeqMaP8M2ff
X-Gm-Gg: AR+sD11EZDRtKNCf9cKMwveYmoMx+9Hjt50W8hTUdFdS/1wOnoJ3OwpKJSgqmvalKic
 oUoadgXSwFkVHsnMfHbjc2rpH3nv691ySUwj1lW+zjNXT02O2tLpn2gCtfxsSCZufHV2ouSgEYR
 rOIFUI0qvc21SpiO4lwo/+5qr/2mpUEu+W68kLBK+KRIXtxvmKklN826pQLEzpvm+vhnLiBZPKs
 WACBEnOwfzRPs7GNYYV2BjtxB6asHEG4pj1B8n4bP1lOGodkYwhVpoU9g4mfWo6bB7KMxKUb+/H
 qUB0BU3ThYAIibT9HUFskkRkQCm+Fge1Fs/pFWgIX/Cy/AtfhuR+D0KS+WJwSoOww52beRb/xhN
 QFsvVkzVRS13JiZdIj5twKl6txCurItFaXR8Zw6z+TDS91O0C8MSD4SViifa5ZGrs7w==
X-Received: by 2002:a05:6a00:180c:b0:84e:2d5d:5e4d with SMTP id
 d2e1a72fcca58-84e595d6eccmr712341b3a.68.1784949555818; 
 Fri, 24 Jul 2026 20:19:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::403c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53432834sm640542b3a.50.2026.07.24.20.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:19:15 -0700 (PDT)
From: Cody Kang <codykang.hk@gmail.com>
Date: Fri, 24 Jul 2026 23:16:46 -0400
Subject: [PATCH 14/17] riscv: dts: spacemit: k3: add display nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-k3-display-v1-14-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
In-Reply-To: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

Add the SoC-level display nodes: the two Saturn DPUs, the two DP/eDP
controllers with their PHY children.

The PHY PLLs are fed back into the APMU as pixel-clock mux parents, so
updated the &syscon_apmu node in the display dtsi.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k3-display.dtsi | 156 +++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k3-display.dtsi b/arch/riscv/boot/dts/spacemit/k3-display.dtsi
new file mode 100644
index 000000000000..4892ee6acda2
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k3-display.dtsi
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * SpacemiT K3 display subsystem (DPU0/eDP0 + DPU1/DP1) shared
+ * device-tree definitions for inclusion alongside k3.dtsi.
+ *
+ * Copyright (C) 2026 SpacemiT Co., Ltd.
+ */
+
+#include <dt-bindings/clock/spacemit,k3-clocks.h>
+#include <dt-bindings/reset/spacemit,k3-resets.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&soc {
+	dpu0_crtc0: dpu@c0340000 {
+		compatible = "spacemit,k3-saturn-dpu";
+		reg = <0x0 0xc0340000 0x0 0x54000>;
+		interrupts = <90 IRQ_TYPE_LEVEL_HIGH>,
+			     <89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "online", "offline";
+		clocks = <&syscon_apmu CLK_APMU_LCD_PXCLK>,
+			 <&syscon_apmu CLK_APMU_LCD_MCLK>,
+			 <&syscon_apmu CLK_APMU_DPU_ACLK>,
+			 <&syscon_apmu CLK_APMU_DSI_ESC>,
+			 <&syscon_apmu CLK_APMU_LCD_DSC>;
+		clock-names = "pxclk", "mclk", "aclk", "escclk", "dscclk";
+		resets = <&syscon_apmu RESET_APMU_LCD_MCLK>,
+			 <&syscon_apmu RESET_APMU_LCD>,
+			 <&syscon_apmu RESET_APMU_DSI_ESC>,
+			 <&syscon_apmu RESET_APMU_DPU_ACLK>,
+			 <&syscon_apmu RESET_APMU_LCD_DSCCLK>;
+		reset-names = "mclk", "lcd", "esc",
+			      "aclk", "dsc";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dpu0_out: endpoint {
+					remote-endpoint = <&edp0_in>;
+				};
+			};
+		};
+	};
+
+	edp0: edp@cac84000 {
+		compatible = "spacemit,k3-inno-dp";
+		reg = <0x0 0xcac84000 0x0 0x4000>;
+		interrupts = <132 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&syscon_apmu CLK_APMU_EDP0_PXCLK>, <&edp0_phy>;
+		clock-names = "pxclk", "pll";
+		resets = <&syscon_apmu RESET_APMU_EDP0>;
+		phys = <&edp0_phy>;
+		phy-names = "dp";
+		status = "disabled";
+
+		edp0_phy: phy {
+			compatible = "spacemit,k3-inno-dp-phy";
+			#phy-cells = <0>;
+			#clock-cells = <0>;
+			clock-output-names = "edp0_pll_pxclk";
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				edp0_in: endpoint {
+					remote-endpoint = <&dpu0_out>;
+				};
+			};
+			/* port@1 (panel output) is added by boards fitting an eDP panel */
+		};
+	};
+
+	dpu1_crtc0: dpu@c0440000 {
+		compatible = "spacemit,k3-saturn-dpu";
+		reg = <0x0 0xc0440000 0x0 0x54000>;
+		interrupts = <139 IRQ_TYPE_LEVEL_HIGH>,
+			     <138 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "online", "offline";
+		clocks = <&syscon_apmu CLK_APMU_DSI4LN2_LCD_PXCLK>,
+			 <&syscon_apmu CLK_APMU_DSI4LN2_LCD_MCLK>,
+			 <&syscon_apmu CLK_APMU_DSI4LN2_DPU_ACLK>,
+			 <&syscon_apmu CLK_APMU_DSI4LN2_DSI_ESC>,
+			 <&syscon_apmu CLK_APMU_DSI4LN2_LCD_DSC>;
+		clock-names = "pxclk", "mclk", "aclk", "escclk", "dscclk";
+		resets = <&syscon_apmu RESET_APMU_DSI4LN2_LCD_MCLK>,
+			 <&syscon_apmu RESET_APMU_DSI4LN2_LCD_SW>,
+			 <&syscon_apmu RESET_APMU_DSI4LN2_ESCCLK>,
+			 <&syscon_apmu RESET_APMU_DSI4LN2_DPU_ACLK>,
+			 <&syscon_apmu RESET_APMU_DSI4LN2_LCD_DSCCLK>;
+		reset-names = "mclk", "lcd", "esc",
+			      "aclk", "dsc";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dpu1_out: endpoint {
+					remote-endpoint = <&dp1_in>;
+				};
+			};
+		};
+	};
+
+	dp1: dp@cac88000 {
+		compatible = "spacemit,k3-inno-dp";
+		reg = <0x0 0xcac88000 0x0 0x4000>;
+		interrupts = <140 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&syscon_apmu CLK_APMU_EDP1_PXCLK>, <&dp1_phy>;
+		clock-names = "pxclk", "pll";
+		resets = <&syscon_apmu RESET_APMU_EDP1>;
+		phys = <&dp1_phy>;
+		phy-names = "dp";
+		status = "disabled";
+
+		dp1_phy: phy {
+			compatible = "spacemit,k3-inno-dp-phy";
+			#phy-cells = <0>;
+			#clock-cells = <0>;
+			clock-output-names = "edp1_pll_pxclk";
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dp1_in: endpoint {
+					remote-endpoint = <&dpu1_out>;
+				};
+			};
+			/* no port@1: the DP TX drives the external connector directly */
+		};
+	};
+};
+
+/*
+ * Feed the PHY PLL pixel clocks back in as the APMU mux parents. This lives
+ * here, not in k3.dtsi: the PHYs only exist where this file is included.
+ */
+&syscon_apmu {
+	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
+		 <&edp0_phy>, <&dp1_phy>;
+	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
+		      "edp0_pll_pxclk", "edp1_pll_pxclk";
+};

-- 
2.43.0

