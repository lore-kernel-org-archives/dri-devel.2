Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6E5CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 22:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5EB10E24E;
	Wed, 20 May 2026 22:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pnnCukyt";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C875110E24E
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 22:26:27 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-452169ae568so3459866f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779315986; x=1779920786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YG82xVAXQwQE8PumNL8zBtus2ibRKhYEPkSULunC6/w=;
 b=pnnCukytOy41y/mbtm83ar2/a3+nzJ+zJbkjCyq+58XXpnULc6YCPqHIyNs4MngmF8
 Y/ckHb8h35OfEZqflGKx8WtAmGhgZR73fxlNutvatUI7B77u1KaQlWYBuKvuANKHvYtZ
 Y+OknrZu2eJmiii9cNKzOwAcU4S4EqVBByd7NRf2Dpj6TjMnQNQxibjw0NMXDV+lgiG0
 ZXsmnYU64sFKH8QTjEYceK2UAZ3ZMOWQpAhPO8uvDPx7BxKxyDEn88hzYgkm2r2/9o+o
 qI7e9RIZLDK3WH4hgbWLPFQLeK3KqdHbqVaf5QScab6jpop3RLV+uZzKYU7pLlfsopDh
 8FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779315986; x=1779920786;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YG82xVAXQwQE8PumNL8zBtus2ibRKhYEPkSULunC6/w=;
 b=fAvSrZPXFlXebVvJWdr8PifYYHEOGEQ8VmpxyhKjXKQbJhT386rMvtrryJlg4ZuWam
 tbQqHW3MhHmobCBjfyvUQzyr0/k2N+Q3p3p9Hh3044Y3r0KJr+K1CYYQXgZ+ByLw5xEj
 VdLWyFUuWgtf6BglRVjKwq6NiOggv2tX7QFpHYxg5S9S9psDPbSfBl8VQwoakgngdF8q
 9sajCJzCbI0hYwGD+QdZfj17DW1R/t5awp3WaVX+nZSy0uK4MjO6QfM68FRubZfQmgac
 5bs3SwvMR3NurPbJmhfHlIY2c2yImsIyMpTkSJg9wRR/vQxiYRZR6vz4ftYeDfmdUErz
 FV1g==
X-Gm-Message-State: AOJu0YwNawEu9/V+SvH5pHFqSfhrbyWbNBWGkohssHW4RdConp4ETjyj
 LLEWIoDrg8p6S/Y8/dGClDLOppnxU7Y4fcHeyTypSWwNQLKSy5Ifjnc=
X-Gm-Gg: Acq92OFXIoPKguYDoqBSSYHMnh6tKnYugSYNkSxdmFT/cP0HfIdzJcuQBtAFpoO6Wjm
 q/ZQq9CQRFsRk4+zr3XaJ8dnTGVaEKanpu/uk8Xi3T/4tu9wibO+3cup8hhgM7JW8h06E+8jBiB
 Xl6G+PU7wGdMWdCuHNrorDP4/k74qhAmLRXvFoTQWY3EYcEc5zUXrVpU+wIK7+E8xvi1PBxxsqE
 9E1mNEwomRt+iz4SwbwfeK8hPiyljm8IlO9pDiBWXAxvUg1D5TgwHkTPiEbiGiDngy1fetZkA7+
 NjtQm8bbBQt0WOaxCYa60nlfTKfyqKchYt5Kpc7cxKuSmprtb5m6W6+b0Y77QbakbkqJnonhz9e
 E61kVX1xGR310iFjQG6ahVbuwND/ajdzDB3fE9etbgZxOishYuFUMDZQmNJTiGl4f5jzi+9SWd9
 USSA6yIaNUedtdcBZzQtNzci+HHuhZhuDRWVbZNDsCJS/dw0oD4OjL9vBidMOWjVsMOJlsCwyZw
 mEctaJLtMkBmTa+nWxPrc10gV9JW/Q59hag/MZ5MCNe8hcsQb83oE8b0Wd02BLxvp2h8g==
X-Received: by 2002:a5d:584c:0:b0:452:c246:ab69 with SMTP id
 ffacd0b85a97d-45ea38c687bmr331364f8f.13.1779315985965; 
 Wed, 20 May 2026 15:26:25 -0700 (PDT)
Received: from ?IPV6:2a01:cb08:52d:7400:bbd7:ca83:de4a:f625?
 (2a01cb08052d7400bbd7ca83de4af625.ipv6.abo.wanadoo.fr.
 [2a01:cb08:52d:7400:bbd7:ca83:de4a:f625])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe1a41sm61784681f8f.31.2026.05.20.15.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 15:26:25 -0700 (PDT)
Message-ID: <f5f70aa2-a1b8-40e0-838f-6709e6e08a5a@gmail.com>
Date: Thu, 21 May 2026 00:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] arm64: dts: qcom: sc8280xp-arcata: Enable backlight
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-2-9df52552bf87@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-2-9df52552bf87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/20/26 18:40, Jérôme de Bretagne via B4 Relay wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> Add backlight nodes and enable backlight so that it can be controlled
> with the corresponding buttons found on Surface Pro Type Cover keyboards.
> 
> The nodes are almost identical to the ones from the ThinkPad X13s with
> a different enable GPIO for the vreg_edp_bl node.
> 
> The difference was found by looking at the output of /sys/kernel/debug/gpio
> on the ThinkPad X13s to see the properties of its enable gpio9:
> 
>    gpiochip1: GPIOs 742-751, parent: platform/c440000.spmi:pmic@1:gpio@8800, c440000.spmi:pmic@1:gpio@8800:
>     ...
>     gpio9 : out  high normal  vin-1 pull-down 10uA              push-pull  medium  atest-1 dtest-0
>     ...
> 
> The same gpio9 on the Surface Pro 9 5G has different properties:
> 
>    gpiochip0: 10 GPIOs, parent: platform/c440000.spmi:pmic@1:gpio@8800, c440000.spmi:pmic@1:gpio@8800:
>     ...
>     gpio9 : in   high normal  vin-1 pull-up 30uA                push-pull  low     atest-1 dtest-0
>     ...
> 
> Looking for a match on the Surface Pro 9 5G pointed to this only one:
> 
>    gpiochip2: 10 GPIOs, parent: platform/c440000.spmi:pmic@3:gpio@8800, c440000.spmi:pmic@3:gpio@8800:
>     ...
>     gpio6 : out  high normal  vin-1 pull-down 10uA              push-pull  medium  atest-1 dtest-0
>     ...
> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---
>   .../boot/dts/qcom/sc8280xp-microsoft-arcata.dts    | 49 ++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
> index f2b4470d4407fb5b6a3dbac8bc972c010c31bd06..14287092fb07ea15e527fd318f7ea2155448b26c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
> @@ -46,6 +46,16 @@ wcd938x: audio-codec {
>   		#sound-dai-cells = <1>;
>   	};
>   
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pmc8280c_lpg 3 1000000>;
> +		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
> +		power-supply = <&vreg_edp_bl>;
> +
> +		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
> +		pinctrl-names = "default";
> +	};
> +


Investigating the feedback I got from an AI bot review [1], I plan to 
update this patch in v2. Let me know what you think.

I was skeptical at first but upon review I've tried the following patch:


diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts 
b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
index f938e68c69ea..82e0a01276a8 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
@@ -198,7 +198,7 @@ vreg_edp_bl: regulator-edp-bl {
                 regulator-min-microvolt = <3600000>;
                 regulator-max-microvolt = <3600000>;

-               gpio = <&pmc8280c_gpios 6 GPIO_ACTIVE_HIGH>;
+               gpio = <&pmc8280_2_gpios 6 GPIO_ACTIVE_HIGH>;
                 enable-active-high;

                 pinctrl-0 = <&edp_bl_reg_en>;
@@ -1050,6 +1050,11 @@ vol_up_n: vol-up-n-state {
  };

  &pmc8280_2_gpios {
+       edp_bl_reg_en: edp-bl-reg-en-state {
+               pins = "gpio6";
+               function = "normal";
+       };
+
         wwan_sw_en: wwan-sw-en-state {
                 pins = "gpio1";
                 function = "normal";
@@ -1061,11 +1066,6 @@ edp_bl_pwm: edp-bl-pwm-state {
                 pins = "gpio8";
                 function = "func1";
         };
-
-       edp_bl_reg_en: edp-bl-reg-en-state {
-               pins = "gpio6";
-               function = "normal";
-       };
  };

  &pmr735a_gpios {



and ... backlight still works! It can also be enabled/disabled with:
    /sys/class/backlight/backlight/bl_power
as expected.

I have no clue why both gpio6 on pmc8280_2 and gpio6 on pmc8280c can 
enable and disable the backlight. Is it a common scenario?

Anyway, if I follow my own investigation fully based on the X13s 
reference and the properties of its backlight enable GPIO, I should 
switch to pmc8280_2 to use the better match.

I will update this patch in v2.

Jérôme


[1] https://lore.kernel.org/all/20260520165709.E485C1F00893@smtp.kernel.org/

