Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0C3FA0C37
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 07:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3CFB10E688;
	Wed, 15 Apr 2026 07:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="S+4j2/wk";
	dkim-atps=neutral
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com
 [209.85.222.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E54F10E083
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 21:41:15 +0000 (UTC)
Received: by mail-ua1-f98.google.com with SMTP id
 a1e0cc1a2514c-9539d9f1675so3611974241.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1776202874; x=1776807674; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Q87q408S6kD03eCdhgkumlXWLlyzkrJl5PR3laXuXk=;
 b=S+4j2/wkiWczfEx006UuDInnd1ASc9N+8IHKCtWNJhGmbpruYO53SAKJ6Ex08AbL6D
 MzgN2OI5JKTOR4DUN4MYt82MO6t3VETBL1mdj2dQvqZRzpeEcLaIbj0yg9ppKcpY+1Mb
 CoZQKN6LwumgmC6mPx3ty1Iab8tG+e7uMmamzen2v9+ACITjpQ86dzcRCndRLg24mShN
 vOEfgjHidgjFiBYGVWdt/B26tNJY2kvoiDywjRpsybfDXeyWaC/X+1mGTKYDP7w3blBa
 hbP1Y0zit3yt0DQPVGDnrhWhAHgVoFwAREGKfS/7VJs+oxF6A4cqfeblC9/CPrPRxV+b
 AtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776202874; x=1776807674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Q87q408S6kD03eCdhgkumlXWLlyzkrJl5PR3laXuXk=;
 b=Yr1L0bGfw3I7BhIO5V+ZpbserQ1AlcvCwbts0lMpIQPJgAKoUMjlo2jEaC+Ieqrk2E
 9YpXPAxAfChljN34Nc/F4XaRRFmtWjVZe/K9dVKx/p/xN7Cn9UJyboMb0Fd03LmZuyJe
 GqbGFp4p5vkHzB4heFwrHAqaCciuIy6WL296asI4gJobYZsnznGd0VGAdIT41iMg7ku+
 MZtw02Qo6vrG5KZt/N9hgenWeRP6cJgrqoUs+QlM9bkdnIsm3AOGFnlnr23Ej21Tg9xT
 FKHHjXX1eq1+/cMSoFYCMfJx1kMJbaFRkbDj8o+hu8Fu14Iv7fC9BcIaeKTh96ohg+sn
 FN5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/Jz8p4+8IA8ccujXoYNHdGBTPNC1wR9Bwdtw5cQ8O0lXJ21hoeWndnFY0PZacVgClWBbUk4pt50Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJxVrCKAdZ8vncSXJBYgYOtWj1NzE1lY5wdEis8b+HyylOZFTv
 qfWlRtW5wzNyCYcf/Nn0mbJzR6S0wxaS3L45ASGPvDfi2KV2C45jA5ApORdMjRqHvf/qAXXuFiY
 +u/KOrbZeARsncNqwvwSLGueN17SC4Ib4Gu5X
X-Gm-Gg: AeBDiev++BdFmngKDI+tt793fzQz9cbrS7HV7VIPR2YMY46Q3kMrVu/2+8K6wjXnJnb
 RApUnNLl8bRAolpRgMJlHx+SJztA8b/vHTONTtwJ5K2slYtE7eEVSOBkJP7XVOF7d4CrKAAconC
 kayKU1u0XCtJQYYstBAIUgpD7WErXcSq51Tw8KBCM4egHdfREJLLcrbcM9t2neflpUuuafXlXJW
 BhK3UU+cp0Fr19t4vfHTkppk4t1ISQbWFeHbUSK6AFVqHVYNHAE2b24AycUFpSql/DslDS6Cg8S
 31W3h21IPGWrJvp5Q490AWQe2JFT4QdTNjS0pyALPatJFOuc2ddCErUv4WVIinRncdu3w7HMPp1
 AAMHsZlNavCSwK+O1D7dzfiW7GJ0v40LOZobrjav/FAQ2wHRvuCvxpEw=
X-Received: by 2002:a05:6102:4b81:b0:605:5d09:8631 with SMTP id
 ada2fe7eead31-60a010583b2mr9353897137.29.1776202874377; 
 Tue, 14 Apr 2026 14:41:14 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-95691131afesm346899241.1.2026.04.14.14.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 14:41:14 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: 
Cc: Alexey Charkov <alchark@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, FUKAUMI Naoki <naoki@radxa.com>,
 Heiko Stuebner <heiko@sntech.de>, Hsun Lai <i@chainsx.cn>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jimmy Hon <honyuenkwun@gmail.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Michael Riesch <michael.riesch@collabora.com>,
 Mykola Kvach <xakep.amatop@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Robert Foss <rfoss@kernel.org>,
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v7 4/6] arm64: dts: rockchip: rk3588s-orangepi-5: rename PLDO
 regulator labels to match schematic
Date: Tue, 14 Apr 2026 16:40:55 -0500
Message-ID: <20260414214104.1363987-5-dennis@ausil.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414214104.1363987-1-dennis@ausil.us>
References: <20260414214104.1363987-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Apr 2026 07:14:48 +0000
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

