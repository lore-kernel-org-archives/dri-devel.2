Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3718C79F91
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A5810E2B0;
	Sat,  5 Sep 2026 15:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lyp3LeJ2";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0FDC10E42F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 21:33:35 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-5302b692c8eso14930121cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788557615; x=1789162415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KWoJYzcW0AWxwtfPly+dHtM2f9cvjv3KZD392LRH0AA=;
 b=lyp3LeJ2vUHdq0umYoplxZamypGZAgEpRtAy1Qrqu8EMFORt7TQoZBVR0aLNQ/afAz
 i1wFmGHVDwWJfN8dY9zchozeC0aEG0FSTwPQx2o3h6JHvCzDaEM40KuCOTygZ7tnW9Zl
 vtQkaF2R7hNz23T5Pfu1QsYuWzmcu4SVnToYjCuFwkqPg+atVIhkoYi+BgNswChHyz+Q
 efOMcNrQKJWmG2SN1PieujI1soj0/uHOMOOToxIFZ20g1TmCkPTs0uR6JMSOioXnRMw+
 aCsW+EAn0S3PWCsvqz3Yl/z4TL7gddUM5riiUj1xCOvRqr+2MlbSX2Vn0vyqt9BOjkeC
 5vKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788557615; x=1789162415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KWoJYzcW0AWxwtfPly+dHtM2f9cvjv3KZD392LRH0AA=;
 b=STsUC7cQ20H1qKy4k9VxibLhSxt5LdyOvTzQSfV6WJm4mbLiLfj/N+OR8YrXzUe2UH
 mmVfUqjaV4/fCsfMNKP73ladNYiKWjXa/NhIPAcKMuzig3W2J3IsPOG2MQIPvgTRqIS7
 wftjic9ZdR8FUFgCKimebfj0gc/3k4MNTfCSmw93uLbY/6WbBRjeHowVE2lcDaTcALLq
 7hwKU6Ie0sXJUJ5EaWcLRiT8YtKkljOMGXrlVAwA7hj+iPbb/fVJuNV5jEH8E/LFdgZz
 kGLUTUqtNboHqCP6YSAA0Ihs7Do/7jmhZN4OXMuqEWYYr0XAnuklt2RmOvOpNr/G9Pni
 kD2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3XzEL8/Pe2cgpNXb7HOOS18XJcuMOVYvjq90A8HSM/e/gQZrxwTwO8Rrnf7eij+ThLwuygrQ+u8k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n7kzhwVx4p6TayVas2iqg0ZU6s37AMWMNT8lwWMLPPcUWjpfFt
 Ql1150ermO7Zp4f0VdfbThCp669PmqXvshe32OA/FZx05MD1J2nIWwU=
X-Gm-Gg: AYBFou0g2bDwgDuGdk+W22bput3oBbQkKHZNvon/6wsKfvXgLsAAVn7VfxGG2ZdA1p0
 fEqKD+WzxBv7364GR2JwGTVp2lVJwp/jpiBX+BJwhc6oL2+EJygFBCV+lFMxWHVz8SatJI27xxp
 +3k5Mn/FyisnLllE4kPUwFAkVDXTbLtWqo1zGSBp4+Uswxf1zzoKtMBj0qWKb/lp5LAKb9knqPV
 w8v7twoMa2Vj8rF+22H6IH+xGpwL93Si0FnmxutBPHQZ0RXf2CgfgqqCgRIA6tjk8wcI6VNpTOh
 ffo0H/lSj7UkjhOwTa5TV3n+6N9xGEmNvQCo9xOa5O1WeJGrhT7LqYgvLpdgNAzKivkL+unTFUZ
 6b0IVLH5MMjW4eWSntPlQAqaeRsYj3ucbUuYrHwt0oz5LiT2Aapsus8J5BubrQ7sUB9r5bP4lLB
 C6MO5n5k5xH4SwHQnMfdkwJkVUTXDKEJd7pxhH1ARnAnRN3twTAEdYLSCNYD48iGlbkb9bbbR7Q
 DEQhd80+VKtB0iOALfr07IIYg==
X-Received: by 2002:a05:622a:11cd:b0:530:27d9:ffc2 with SMTP id
 d75a77b69052e-530546cf80fmr94981561cf.5.1788557614529; 
 Fri, 04 Sep 2026 14:33:34 -0700 (PDT)
Received: from X570.phub.net.cable.rogers.com
 ([2607:fea8:744f:d200:9441:f2ae:56aa:8a81])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53054227a0esm29646561cf.29.2026.09.04.14.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 14:33:34 -0700 (PDT)
From: Barzin Lotfabadi <barzin221@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Ryan Walklin <ryan@testtoast.com>, dri-devel@lists.freedesktop.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: allwinner: h616: add display engine and HDMI
 nodes
Date: Fri,  4 Sep 2026 17:33:28 -0400
Message-ID: <20260904213329.3910099-2-barzin221@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904213329.3910099-1-barzin221@gmail.com>
References: <20260904213329.3910099-1-barzin221@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

The H616 and its variants (H618, H700, T507) carry a Display Engine 3.3
(DE33) block feeding a TCON TOP, a TV TCON and a DesignWare HDMI 2.0
transmitter with an Allwinner-specific PHY.  None of this is described in
the SoC .dtsi, so nothing probes and the HDMI port stays dark even though
the DE33 mixer support is present in the sun4i DRM driver.

Add the display pipeline:

  display-engine        - the DRM pipeline root
  bus@1000000           - DE33 bus, holding the display clock controller
                          and the mixer
  clock@8000            - display clock controller
  mixer@100000          - DE33 mixer 0
  tcon-top@6510000      - TCON TOP, muxing the mixer onto the TCONs
  lcd-controller@6515000 - TCON TV 0
  hdmi@6000000          - DesignWare HDMI TX controller v2.12a
  hdmi-phy@6010000      - Allwinner H616 HDMI PHY

All register addresses, clock indices and reset lines were read from the
vendor device tree shipped with the board and translated to the mainline
dt-bindings macros; the clock and reset numbering was verified identical
between the vendor and mainline CCU headers.

The mixer's three register regions are named "layers", "top" and
"display".  On DE33 the global control registers moved out of the mixer
block into separate windows, and the driver looks up the latter two by
name, so these names are load-bearing rather than decorative.

Everything is left disabled; boards opt in.


Signed-off-by: Barzin Lotfabadi <barzin221@gmail.com>
---
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index 1598e8625..21aa94482 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -7,7 +7,10 @@
 #include <dt-bindings/clock/sun50i-h616-ccu.h>
 #include <dt-bindings/clock/sun50i-h6-r-ccu.h>
 #include <dt-bindings/clock/sun6i-rtc.h>
+#include <dt-bindings/clock/sun8i-de2.h>
+#include <dt-bindings/clock/sun8i-tcon-top.h>
 #include <dt-bindings/reset/sun50i-h616-ccu.h>
+#include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -94,6 +97,12 @@ l2_cache: l2-cache {
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun50i-h6-display-engine";
+		allwinner,pipelines = <&mixer0>;
+		status = "disabled";
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -965,6 +974,188 @@ ohci3: usb@5311400 {
 			status = "disabled";
 		};
 
+		bus: bus@1000000 {
+			compatible = "allwinner,sun50i-h616-de33",
+				     "allwinner,sun50i-a64-de2";
+			reg = <0x1000000 0x400000>;
+			allwinner,sram = <&sram_c 1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1000000 0x400000>;
+
+			display_clocks: clock@8000 {
+				compatible = "allwinner,sun50i-h616-de33-clk";
+				reg = <0x8000 0x100>;
+				clocks = <&ccu CLK_DE>,
+					 <&ccu CLK_BUS_DE>;
+				clock-names = "mod", "bus";
+				resets = <&ccu RST_BUS_DE>;
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			mixer0: mixer@100000 {
+				compatible = "allwinner,sun50i-h616-de33-mixer-0";
+				reg = <0x100000 0x100000>,
+				      <0x8100 0x40>,
+				      <0x280000 0x20000>;
+				reg-names = "layers", "top", "display";
+				clocks = <&display_clocks CLK_BUS_MIXER0>,
+					 <&display_clocks CLK_MIXER0>;
+				clock-names = "bus", "mod";
+				resets = <&display_clocks RST_MIXER0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					mixer0_out: port@1 {
+						reg = <1>;
+
+						mixer0_out_tcon_top_mixer0: endpoint {
+							remote-endpoint = <&tcon_top_mixer0_in_mixer0>;
+						};
+					};
+				};
+			};
+		};
+
+		tcon_top: tcon-top@6510000 {
+			compatible = "allwinner,sun50i-h6-tcon-top";
+			reg = <0x6510000 0x1000>;
+			clocks = <&ccu CLK_BUS_TCON_TOP>,
+				 <&ccu CLK_TCON_TV0>;
+			clock-names = "bus", "tcon-tv0";
+			clock-output-names = "tcon-top-tv0";
+			resets = <&ccu RST_BUS_TCON_TOP>;
+			#clock-cells = <1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_top_mixer0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					tcon_top_mixer0_in_mixer0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&mixer0_out_tcon_top_mixer0>;
+					};
+				};
+
+				tcon_top_mixer0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					tcon_top_mixer0_out_tcon_tv: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&tcon_tv_in_tcon_top_mixer0>;
+					};
+				};
+
+				tcon_top_hdmi_in: port@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+
+					tcon_top_hdmi_in_tcon_tv: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_tv_out_tcon_top_hdmi>;
+					};
+				};
+
+				tcon_top_hdmi_out: port@5 {
+					reg = <5>;
+
+					tcon_top_hdmi_out_hdmi: endpoint {
+						remote-endpoint = <&hdmi_in_tcon_top>;
+					};
+				};
+			};
+		};
+
+		tcon_tv: lcd-controller@6515000 {
+			compatible = "allwinner,sun50i-h6-tcon-tv",
+				     "allwinner,sun8i-r40-tcon-tv";
+			reg = <0x6515000 0x1000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON_TV0>,
+				 <&tcon_top CLK_TCON_TOP_TV0>;
+			clock-names = "ahb", "tcon-ch1";
+			resets = <&ccu RST_BUS_TCON_TV0>;
+			reset-names = "lcd";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_tv_in: port@0 {
+					reg = <0>;
+
+					tcon_tv_in_tcon_top_mixer0: endpoint {
+						remote-endpoint = <&tcon_top_mixer0_out_tcon_tv>;
+					};
+				};
+
+				tcon_tv_out: port@1 {
+					reg = <1>;
+
+					tcon_tv_out_tcon_top_hdmi: endpoint {
+						remote-endpoint = <&tcon_top_hdmi_in_tcon_tv>;
+					};
+				};
+			};
+		};
+
+		hdmi: hdmi@6000000 {
+			compatible = "allwinner,sun50i-h616-dw-hdmi",
+				     "allwinner,sun50i-h6-dw-hdmi";
+			reg = <0x6000000 0x10000>;
+			reg-io-width = <1>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_HDMI>,
+				 <&ccu CLK_HDMI_SLOW>,
+				 <&ccu CLK_HDMI>,
+				 <&ccu CLK_HDMI_CEC>;
+			clock-names = "iahb", "isfr", "tmds", "cec";
+			resets = <&ccu RST_BUS_HDMI_SUB>;
+			reset-names = "ctrl";
+			phys = <&hdmi_phy>;
+			phy-names = "phy";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hdmi_in: port@0 {
+					reg = <0>;
+
+					hdmi_in_tcon_top: endpoint {
+						remote-endpoint = <&tcon_top_hdmi_out_hdmi>;
+					};
+				};
+
+				hdmi_out: port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
+		hdmi_phy: hdmi-phy@6010000 {
+			compatible = "allwinner,sun50i-h616-hdmi-phy";
+			reg = <0x6010000 0x10000>;
+			clocks = <&ccu CLK_BUS_HDMI>,
+				 <&ccu CLK_HDMI_SLOW>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_HDMI>;
+			reset-names = "phy";
+			#phy-cells = <0>;
+		};
+
 		rtc: rtc@7000000 {
 			compatible = "allwinner,sun50i-h616-rtc";
 			reg = <0x07000000 0x400>;

-- 
2.51.0

