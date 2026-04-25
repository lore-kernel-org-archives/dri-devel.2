Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0767EFF8850
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8F710E528;
	Sun, 26 Apr 2026 06:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="dBHPlb3a";
	dkim-atps=neutral
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE4F10E0A0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 03:10:24 +0000 (UTC)
Received: by mail-dl1-f99.google.com with SMTP id
 a92af1059eb24-12dca45ca21so1012244c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777086623; x=1777691423; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Q87q408S6kD03eCdhgkumlXWLlyzkrJl5PR3laXuXk=;
 b=dBHPlb3aFy/0o91PX3/QVYqvidWdUD1X+WsxVKn3lpFwwG/Fnkd+FiBFVysVFyutdY
 c0iswpQeROvX/4tG7lwa3Z3h/hrXum2BD2xBG+YuCYbGSmdMll/25mPTJzIZCgoHrf6l
 C0UOic4j15jhtQPr7NhRBVGdTdI2KdysgORJnmrhTFcuEmSIfdMFv2mbvdt0FPhakVh1
 k3kjT4l8PjjbZ1ja91BsEWF37KLJqae/dQBbbEshdMJf0/vMkirhL0yLeqoswebPRVmR
 WO4ZNPkCvrRy2Zn483MSGlQMNQI9I3DmtnmpohfGpTzK910ZLg3zo3yoxR89bjvZvTp4
 AcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777086623; x=1777691423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Q87q408S6kD03eCdhgkumlXWLlyzkrJl5PR3laXuXk=;
 b=FB1DFEgent+oGnvf8h8UOFtFl5rxSlV4w/U8Dq/GgmIZVZ8rrctGqhncpX640Tgul0
 i7MICJdKw7496Be5j/m0n114NHKTDTrlfxVDOm/m1DGyZck9Fy/Rv124zej4a2muTnYx
 BOJ34hTRXkIzgmnZRIUMM/QWJpmm4OeiatVlRmAj+Mtsbe61fgNhRuXkRoeFFeiJiMqg
 71AUChf3GHfrl6TYIEhuibGqbJqNXsCrclbXotQFBC2nSaBiWW5fHcW5VTEm7LhPSXYG
 yBZKCUakVGbZXFL/zOlVLaoRzbjHnzE5ly8qr0DTfeiWI8XWANLojAkEi1VONEYH1sM+
 nkRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hecZQQi32Pka3UOGbdMw826uBkzPCtxliVbqzeqidklu8WIZl/6qrmIEYZ04KZKZU8OAoOZ2HRPg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAYg5DMNyqyqz7seLPrQrNejrUTl3EcTtTO99K4hG0PMBYgJJz
 /r1cucNCr7Ah+X8D+nGIVhp3EMxwFU/judeLtHF4UAU+WXXg2nJIwCVtMGmEf6AfFgT2yUVbOWn
 Ce9W+j98JBfUuqZe8gb0oPk7B7ayybdgIeEnn
X-Gm-Gg: AeBDieskVWmi+rE6wqmGwep+ZR5gx12tVkiWpMad0LuSQZxOFwXTsdEw/tug4p3ThIC
 y42YmzbtORWW4qIhXt3clNkyC65Vx9glCNjRVzGNgsjk+KtE2N6crxICRt2n7bfho3ojdpl7BB2
 xvhcC0xmtpaOKNfBEOpPmnG/RnkYR8DoR73D78ce8ucFfyZWk8gDi7428PRnC2MLrJirpUJ65KQ
 KdjXBnWadIIlZ7ZjOXZaXRBwEuJky23IhuwoYGN7Vyv6unhcGAeFQ2TENYCWibDMCVHMYRbouQW
 goSaJmbCHYoJTRpct0W/pdy+8EQp2Wb6jNcp+JQSFL5BB5xcF71lTHLqHJ4zHhhGTlfA0ZRsOyD
 G0btnoWH4vryPEWkYIRd+9lDfFEmZdLOrTt4aUvCWjb3rZF6ZyuXTpww=
X-Received: by 2002:a05:693c:4011:b0:2e6:e916:70ff with SMTP id
 5a478bee46e88-2e6e916770cmr11635454eec.28.1777086623456; 
 Fri, 24 Apr 2026 20:10:23 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2e53a3ae691sm1728646eec.11.2026.04.24.20.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 20:10:23 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>
Subject: [PATCH v8 4/6] arm64: dts: rockchip: rk3588s-orangepi-5: rename PLDO
 regulator labels to match schematic
Date: Fri, 24 Apr 2026 22:10:09 -0500
Message-ID: <20260425031011.2529364-5-dennis@ausil.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425031011.2529364-1-dennis@ausil.us>
References: <20260425031011.2529364-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:46:56 +0000
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

The Orange Pi 5, 5B and 5 Pro schematics label the RK806 PLDO outputs
using the pattern VCC_*_S0 / VCCA_*_S0 / VDDA_*_S0. Rename the base
dtsi regulator labels (and the es8388 supply references) to match:

  pldo-reg1: avcc_1v8_s0 -> vcc_1v8_s0
  pldo-reg2: vcc_1v8_s0  -> vcca_1v8_s0
  pldo-reg3: avdd_1v2_s0 -> vdda_1v2_s0
  pldo-reg4: vcc_3v3_s0  -> vcca_3v3_s0

Also update the saradc vref-supply reference to track the pldo-reg1
rename. No functional change.

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
index dafad29f9854..fd5c6a025cd1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
@@ -274,10 +274,10 @@ es8388: audio-codec@10 {
 		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x10>;
 		clocks = <&cru I2S1_8CH_MCLKOUT>;
-		AVDD-supply = <&vcc_3v3_s0>;
-		DVDD-supply = <&vcc_1v8_s0>;
-		HPVDD-supply = <&vcc_3v3_s0>;
-		PVDD-supply = <&vcc_3v3_s0>;
+		AVDD-supply = <&vcca_3v3_s0>;
+		DVDD-supply = <&vcca_1v8_s0>;
+		HPVDD-supply = <&vcca_3v3_s0>;
+		PVDD-supply = <&vcca_3v3_s0>;
 		assigned-clocks = <&cru I2S1_8CH_MCLKOUT>;
 		assigned-clock-rates = <12288000>;
 		#sound-dai-cells = <0>;
@@ -441,7 +441,7 @@ &rknn_mmu_2 {
 };
 
 &saradc {
-	vref-supply = <&avcc_1v8_s0>;
+	vref-supply = <&vcc_1v8_s0>;
 	status = "okay";
 };
 
@@ -666,8 +666,8 @@ regulator-state-mem {
 				};
 			};
 
-			avcc_1v8_s0: pldo-reg1 {
-				regulator-name = "avcc_1v8_s0";
+			vcc_1v8_s0: pldo-reg1 {
+				regulator-name = "vcc_1v8_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -678,8 +678,8 @@ regulator-state-mem {
 				};
 			};
 
-			vcc_1v8_s0: pldo-reg2 {
-				regulator-name = "vcc_1v8_s0";
+			vcca_1v8_s0: pldo-reg2 {
+				regulator-name = "vcca_1v8_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -691,8 +691,8 @@ regulator-state-mem {
 				};
 			};
 
-			avdd_1v2_s0: pldo-reg3 {
-				regulator-name = "avdd_1v2_s0";
+			vdda_1v2_s0: pldo-reg3 {
+				regulator-name = "vdda_1v2_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1200000>;
@@ -703,8 +703,8 @@ regulator-state-mem {
 				};
 			};
 
-			vcc_3v3_s0: pldo-reg4 {
-				regulator-name = "vcc_3v3_s0";
+			vcca_3v3_s0: pldo-reg4 {
+				regulator-name = "vcca_3v3_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <3300000>;
-- 
2.53.0

