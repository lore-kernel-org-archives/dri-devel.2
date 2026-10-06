Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7466FCA6004
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 20:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C89B510F3DD;
	Tue,  6 Oct 2026 20:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="WFUTQfaC";
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96CA10F3CA
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 20:25:50 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-6cf995766a3so824956eaf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791318350; x=1791923150;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R+ILfk0/yu3AcCYfzlStmh4VnAqvAHjplZrGY6KB/T8=;
 b=WFUTQfaCNbqVfq47qo3OTbIn6531Ruhx1Y6SDhe8z+seidWWbWgpzFGm+0D0I1W65u
 7bXrkN7m8Sj3NNEkPEo53B4m/42HBPUSTQ12t1CMFTvtJ+3Xf4MZyIwq4aVLosJdyoI/
 yucJQSSzkV95YuSGrai8ra9Lqow60u0QMMIfIItiZkegjS2RT2Bg3VFNXA3OdRnh9UAj
 cjXsNXtvqRaBHzZ8TxXSq00XQwpbDEjVd4slWcUH32zZK1IWgCoVsxTH3rHCIM/vVHYR
 NE0OT52yUxMoGDXqnKnq/vVWjCN0Qt0Me8GuVUbjHWAIp9qJPCZ2UVUvJPizwe9Ovvhg
 ycLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791318350; x=1791923150;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R+ILfk0/yu3AcCYfzlStmh4VnAqvAHjplZrGY6KB/T8=;
 b=P1yskqwslRgZCl8ScZf419AljFXMxpKke2amx9cXFsm06U4PsuqrFD3zmc9mBAYsbv
 pQ9wDOpqfwKdcMi04ZO9t+m2BWL3Wr4G8oy6I5ibdGijd+NtKuGkHcriteyNeMwRDOSW
 6lB2D/M2QwV+5RJqCclswTME1u6VcI/MRg5mG77qNDlFeY3mrxTE4BUIDP8bRDVO2AaC
 9L86shjaoBoNepa+qfqO917Lk1bwAt7DfLIS5hTBKc2H+oNm3flhptqdo354VKZENfo5
 2peHc5+E32MNPOKg0OwJFBr5R4Ywpa+eHem60S0b6M6/Ct/NIc+qHz4de+/aVBrVExNX
 ZT2g==
X-Gm-Message-State: AFuF++ne3+8OiOhakGkCFOAklQNETwYBqAIPqG8yqIHT25Le9OdyKvsa
 a17aVveqTR5d6jS+YOj3Ns2ITD0um2cEx7tIj5M6HDweTh7xhhk7eCPwA7lIfPTEYII=
X-Gm-Gg: AYBFou3TdD4cQw95PdIuTbuTBf6oiUgk5BnIszXyAE9LhnI2IhCxHmT/XSWCdJsbf5a
 BdNKwN53B5uLiLKcY29pTc0skvsdMlsnPJUG8VQQgSq/AGD6pFD+q+Aq8pBTWcqQj9tlYVQfQpe
 KpEiiTiqRgcvktk3/7m/Zyf/CfO02qNnCezR7MH43x0JVDC3IwYtK9mbO3msUZD4CNMPxYOl+qr
 CI0M8Vp9eu66Lqc/bbX4XF7wxQdjeVl4f0nIOFK/Z46Cxhpi39zwke/Nc8d/luIvYWbsfVOkrJx
 3ctUsNmBalm7Yn+CXWJ1oCtQRt0UG8t0GTbbiHi+9OjhONenWKJlIE6+4oljQ+XoM5EWnLxjxew
 6f11m6zg/ecKmUe6oiVXX+C85mGJLIkjH82JWIS2ZZc1da5itAsPh1urnknNUVG82fnZPy+rjfX
 8WF00/+qNo3/lx/LSr/i50rHI7bF/wW6bNswuV7qu0mXHdcSMZKfnI1nmP4F/0B2pGYAKPfasdf
 g==
X-Received: by 2002:a05:6820:4c07:b0:6d7:c2d2:3bb6 with SMTP id
 006d021491bc7-6e7a825d4a2mr306044eaf.74.1791318349916; 
 Tue, 06 Oct 2026 13:25:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e793f68bf6sm463442eaf.8.2026.10.06.13.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 13:25:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 15:25:04 -0500
Subject: [PATCH 4/4] arm64: dts: mediatek: mt8395-genio-common: fix the
 panel supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-panel-himax-hx8279-vddp-v1-4-50d884b42aae@baylibre.com>
References: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
In-Reply-To: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=EOMVP3YQwkcIyqlWrQGFAqi7cRnWf4pYZmNhfVKctYk=; 
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqxVk6xsdsb38h2XMoZmyUXwDh+TV2jSd63sKWb
 LEAsaeGN0yJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVZOgAKCRDCzCAB/wGP
 wOTwB/9qpjbVdEYGrVDi0toIg94lEZMC2rKuCDdP4g4DkG41TRMX0aSRt+zR3KkDxJ79JtVyIeK
 S+MIMyG8ojRbQ0JtT2MpPwX99fFJ44xH9o102h6vWagCYrVTTW/foDhJcKWL1r/LSZ3R2e+hdZF
 GWoHtZXRpEuqx1H8Du8FXvgPvATmIBKjVn1zNuKGT8xczC5l7VctkvrZ1m+TgdrzpvIVbWkCYV0
 i7jqtJ1kRXwdmsfY8j22vgm4OSBFZnW7fTwIpWgyiFu3ZpRg6n4ROXFI6k7A36VAL/MH9B7txNx
 pmagYP8bpZRWIwZGRsYixjEAafiGDg+mkOSiHsMiIg9lXTLf
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Point each supply of the Startek KD070FHFID078 panel at the rail that
feeds it on the Genio 1200 EVK, and add the vddp-supply that the
himax,hx8279 binding now requires.

The Genio 1200 EVK is wired as follows:
- VDD (backlight LED power) comes from VSYS through a switch enabled by
  GPIO47. That is the regulator previously described as lcm0_iovcc, so
  rename it to lcm0_vdd and feed it from VSYS.
- IOVCC comes directly from MT6360 LDO2.
- VDDP comes directly from MT6360 LDO1. The lcm0_vddp regulator only
  passed LDO1 through, so drop it.

The previous description pointed vdd-supply at the VDDP rail and used
the VDD switch as the IOVCC regulator. It worked only because the driver
enables all the supplies together.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../boot/dts/mediatek/mt8395-genio-common.dtsi      | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi
index aef908df530e..f415b6f71653 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi
@@ -175,22 +175,16 @@ button-volume-up {
 		};
 	};
 
-	lcm0_iovcc: regulator-vio18-lcm0 {
+	lcm0_vdd: regulator-vsys-lcm0 {
 		compatible = "regulator-fixed";
-		regulator-name = "vio18_lcm0";
+		regulator-name = "vsys_lcm0";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
 		enable-active-high;
 		gpio = <&pio 47 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&dsi0_vreg_en_pins>;
-		vin-supply = <&mt6360_ldo2>;
-	};
-
-	lcm0_vddp: regulator-vsys-lcm0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vsys_lcm0";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&mt6360_ldo1>;
+		vin-supply = <&reg_vsys>;
 	};
 
 	wifi_fixed_3v3: regulator-2 {
@@ -303,8 +297,9 @@ panel@0 {
 		backlight = <&backlight_lcm0>;
 		enable-gpios = <&pio 48 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&pio 108 GPIO_ACTIVE_HIGH>;
-		iovcc-supply = <&lcm0_iovcc>;
-		vdd-supply = <&lcm0_vddp>;
+		iovcc-supply = <&mt6360_ldo2>;
+		vdd-supply = <&lcm0_vdd>;
+		vddp-supply = <&mt6360_ldo1>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&panel_default_pins>;
 

-- 
2.53.0

