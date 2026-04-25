Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA87FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 11:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7C510E42F;
	Sat, 25 Apr 2026 11:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVUs1NDl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Em8gbfqp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5064310E42F
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:27:22 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P3a2qR625042
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fmLIjn9rXrvUt58W7li1vLjk
 EXxPp633KH6ZWld0lpg=; b=oVUs1NDli2CZHbhP0Uzwp/lzSspjG7iwolA1Ftv0
 cIyuUL/XS+pJmXPUA9igxQftAdMKvZwJ4xVC62pGFz+41u+LhtAeHEuh6DfF/7je
 Ll3Q59Qmg+4dR/2AUfp8Pa6noxqRVs6u7ApIgsFHNdZTk4H502X7KmIjge7yX1MB
 6g+GmriWruNXdAwPoqSYr1vwWnN7CkdVzEPA/SU3mcXQ6uz/MdFUBhKQMpMd9YjR
 pr4m35HQzFtF8RB+/oweJKngb8vw9wsDJMQ/0qL6pnMy9eQzOq7HlaV4JkKbomh1
 strOYyCSKNmBiAhs78AmmfpTCtBsGX7P8BVb7T7dKGfBcA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnu2rs61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:27:21 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-610503b689eso10887454137.0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777116441; x=1777721241;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fmLIjn9rXrvUt58W7li1vLjkEXxPp633KH6ZWld0lpg=;
 b=Em8gbfqp4wPlecj/+LaLzsaWqrDGI4BTczrFurCCBuDTR/g5MBnSJ1n6A6P4sHgMHF
 ypFT7i7u0So0sNNQX5Cpo5ED1KNqlN87YKJDaI+zOb8Kz0XdqRmOdMq+s98SJdnsQi1q
 4nO25vP/9kDUdM9svpfezLd7tUk4mYokow/N/yBuxBMK5dn5piTsHgpuZEpvUpsBkioL
 xsx/Ri+9exWDPDcOjxF4kb0Qsah0+Vgvpcs5ly+jMMJbzZLtvEH+mbtL3ReR4sY8c39/
 KKA6dUKGrGRdZrS1bahYYD75A+etjila6qiiNy94T4MO480xF8Jd2NqQONvlhMyMR0u9
 g4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777116441; x=1777721241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmLIjn9rXrvUt58W7li1vLjkEXxPp633KH6ZWld0lpg=;
 b=KsMhsuaos5IZKAX3lGIFHb2y7k3BUhLJZEtQqYKEhm0M8f2uY0sL67rZOUjzr0Jy7N
 3GR4gXaO/YKpT9DMhj8fjUKmDvCp4M+fe+rPIzU5ejzlmPIfbsyy+OJaEPO6tqEMK4oL
 xWbx3Q0vKuIp5TAC17OfhYRNXPnWxJFvoHNI6yIQBExLtVxb7CZPpl9vpgvudfktafze
 6oJCoCz+Fo5TqiGTk9Wm29UI071sFHcIDoV/7qjqTa8vTV2F2Uu1AcWLYhj6U5pdEQHK
 PthU4HrHU6/hncdaeKt0o9u+3+mZD8HXf8vzrxfZx/yjLwdm28v30qQOd5O+Qkspxwvo
 ucjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vW+93wi3S3eCj/4pTkkN6TK/94H7gmdormtGKOVjrnuI8iJMDTMmKXQZ6E74ZPyRGgqo3x4QWLnI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWVvdYolcsZOavqO0b0SASjvw9XquluESgjMPx/EYOExKgD6z2
 Lq6avP2OeKwxY0FZnXmujHo1AF1PG2yakrDVRWZCKtqh/J5KttbY/px0d+ew3C8XDEb5C1xREIc
 Li/L9MFaFUA5GIVpAK2no9e5Z9ceVwTxAMVoo5n/CdkQyhFN/GrdILbA7sdvo3DglOwPMEuc=
X-Gm-Gg: AeBDiet1fLg9Mj1eofjD+Qnfa+IpcX5ZYVL/q4mRv7D+rEWejXWY3bSDWe4G0GLmTBP
 4tH/kAo82d1jpJm2+dW06oZ/rD2JkdpOH5ccL/ao3R4Wb5fJHHTREiWJuSx5dVLp7rSvbi5MYs+
 9E2XkjTlbcWeYQlNp0I5FuOO0dhaNcj1eDc2OJGkfe+sKhBGPlMZeaTUl2/dIA8DB9o5OhYauHb
 OfQKSX55YOJZnIvhn2yPe0lcbh2rMEwVzQzXAp3ro5mfWxvv5KUeKCRKVJty4H7QbonpBULoOZG
 lIibAKuU95BN6DFGmE/uGKsIwEDOPHdtxEFY16+e8K2texeXdvIRHsYaDZOPI8l6wTDEL1fbcUC
 GUJzbgOkaIrOtHcKm2pTFeCJWk68g8Ac8LpH8cRRRhmIYEEkIm3VT+Wqbxh3gxCIumFdNTyLwuP
 JinbmgY4anY+QZgAIQ9Yphawi+mk1jhCIgRl/f/J9jmMGliQ==
X-Received: by 2002:a05:6102:3e0f:b0:605:19ce:9ccf with SMTP id
 ada2fe7eead31-616f58af7d9mr18831227137.13.1777116440665; 
 Sat, 25 Apr 2026 04:27:20 -0700 (PDT)
X-Received: by 2002:a05:6102:3e0f:b0:605:19ce:9ccf with SMTP id
 ada2fe7eead31-616f58af7d9mr18831208137.13.1777116440223; 
 Sat, 25 Apr 2026 04:27:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb4f5035sm55448141fa.4.2026.04.25.04.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 04:27:18 -0700 (PDT)
Date: Sat, 25 Apr 2026 14:27:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Lukas Timmermann <linux@timmermann.space>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Douglas Anderson <dianders@chromium.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexandre Marquet <tb@a-marquet.fr>
Subject: Re: [PATCH 5/5] ARM: dts: exynos: Add display support for
 exynos5250-manta
Message-ID: <4hbwdx7xfdko4pmmjq55ttfmiszjbtx56wb4io3p7dhq2dydh3@j4dgwilyumg2>
References: <20260423-manta-display-v1-0-196f80c5673a@timmermann.space>
 <20260423-manta-display-v1-5-196f80c5673a@timmermann.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-manta-display-v1-5-196f80c5673a@timmermann.space>
X-Proofpoint-GUID: TFVzx7wvnt2OybJ3c03LdviA-FH5FrvL
X-Authority-Analysis: v=2.4 cv=cbriaHDM c=1 sm=1 tr=0 ts=69eca519 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=5VA55DBcQVjzkzcLKVwA:9
 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: TFVzx7wvnt2OybJ3c03LdviA-FH5FrvL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDExNCBTYWx0ZWRfXx0IMN8M8PPHc
 /aSkj4+vSkaYEzYxbQne02WQDpZiuIyaaW9mt2e4PA/dA4hU+8F1umVOd0HqmlsRBnE6xt9ZnI4
 g0rsoD07cyUlRlVVOAkyqR1GLPDtd5WLSexAwQLa79/7Pm3AJ2anXZc4LO1EpWTZMixz5mf87jS
 klfiRXj6R1nL3KQuCzH18VGJviKYFdW4un6ZWtBuQHjlsP/2jCQ4P/DFhePJl/rr5KX7RCaFmhX
 U1/ec3WrGrdd+v0B1hS2lNBoef2nIozFdhbASyzNsIl4cUv0V4uwhp6c61k5wqQhZQ68FPF/Dvn
 Ut/8tzLKvTPQ4k/7+kOhoUEjrtJ8DeLGbhsKVRoz+jsJ0JXrBrAa69OUDDbll4oMIq/7exIKRfn
 OqHNpZ4brEfKAjAIVLndNTq+TvCJSSl/2G18mCMu3W7/5rpmHsz42EtwgrdWre3q2LrxeZSPliV
 8jSUUUkkj/1L4L9hu7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250114
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

On Thu, Apr 23, 2026 at 11:14:41PM +0200, Lukas Timmermann wrote:
> Adds the necessary entries for panel and backlight as
> well as the fimd controller.
> 
> Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
> Signed-off-by: Lukas Timmermann <linux@timmermann.space>
> ---
>  arch/arm/boot/dts/samsung/exynos5250-manta.dts | 99 ++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/samsung/exynos5250-manta.dts b/arch/arm/boot/dts/samsung/exynos5250-manta.dts
> index 76d3657eb22f..eb97a28ff4e3 100644
> --- a/arch/arm/boot/dts/samsung/exynos5250-manta.dts
> +++ b/arch/arm/boot/dts/samsung/exynos5250-manta.dts
> @@ -25,6 +25,29 @@ aliases {
>  		mmc1 = &mmc_1; /* WiFi */
>  	};
>  
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 0 1000000 0>;
> +
> +		brightness-levels = <2 255>; /* TODO */
> +		num-interpolated-steps = <254>; /* TODO */
> +		default-brightness-level = <102>; /* TODO */
> +		post-pwm-on-delay-ms = <97>; /* TODO */
> +
> +		power-supply = <&backlight_reg>;
> +		enable-gpios = <&gpg0 5 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-0 = <&led_bl_reset &pwm0_out>;
> +		pinctrl-names = "default";
> +	};
> +
> +	backlight_reg: regulator-backlight {
> +		compatible = "regulator-fixed";
> +		regulator-name = "APS_EN_18V";
> +		pinctrl-0 = <&aps_en_18v>;
> +		pinctrl-names = "default";
> +	};
> +
>  	/* Voltage source unknown */
>  	bmp180_vdda_reg: regulator-bmp180-vdda {
>  		compatible = "regulator-fixed";
> @@ -105,6 +128,28 @@ multi-led {
>  		leds = <&status_red>, <&status_green>, <&status_blue>, <&status_white>;
>  	};
>  
> +	panel {
> +		compatible = "samsung,ltl101dl02-002";
> +
> +		backlight = <&backlight>;
> +		power-supply = <&panel_reg>;
> +		enable-gpios = <&gph1 7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&lcd_en>;
> +		pinctrl-names = "default";
> +		no-hpd;
> +
> +		port {
> +			panel: endpoint {
> +				remote-endpoint = <&dp_out>;
> +			};
> +		};
> +	};

No, the panel is not just being attached to the device. I asumme it is
controlled over the AUX bus, so it shoud be a child device of the
AUX bus.

> +
> +	panel_reg: regulator-panel {
> +		compatible = "regulator-fixed";
> +		regulator-name = "LCD_EN";
> +	};
> +
>  	pwrseq: mmc1-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  
> @@ -146,10 +191,36 @@ &cpu1 {
>  	cpu-supply = <&buck2_reg>;
>  };
>  
> +&dp {
> +	status = "okay";
> +
> +	samsung,color-space = <0>;
> +	samsung,color-depth = <1>;
> +	samsung,link-rate = <0x0a>;
> +	samsung,lane-count = <4>;
> +	samsung,dynamic-range = <0>;
> +	samsung,ycbcr-coeff = <0>;
> +
> +	ports {
> +		port {
> +			dp_out: endpoint {
> +				remote-endpoint = <&panel>;
> +			};
> +		};
> +	};
> +};
> +
>  &ehci {
>  	status = "disabled";
>  };
>  
> +&fimd {
> +	status = "okay";
> +
> +	assigned-clocks = <&clock CLK_MOUT_FIMD1>, <&clock CLK_MOUT_VPLL>;
> +	assigned-clock-parents = <&clock CLK_MOUT_VPLL>;
> +};
> +
>  &i2c_1 {
>  	status = "okay";
>  
> @@ -396,6 +467,12 @@ ldo25_reg: LDO25 {
>  	};
>  };
>  
> +&mali {
> +	status = "okay";
> +
> +	mali-supply = <&buck4_reg>;
> +};
> +
>  &mixer {
>  	status = "okay";
>  };
> @@ -489,6 +566,14 @@ wlan_irq: wlan-irq-pins {
>  };
>  
>  &pinctrl_1 {
> +	aps_en_18v: aps-en-18v-pins {
> +		samsung,pins = "gph1-6";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>; /* TODO */
> +		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_INPUT>; /* TODO */
> +		samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_UP>; /* TODO */
> +		samsung,pin-val = <0>; /* TODO */
> +	};
> +
>  	bh1721fvc_reset: bh1721fvc-reset-pins {
>  		samsung,pins = "gph1-2";
>  		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> @@ -509,6 +594,20 @@ bt_wake: bt-wake-pins {
>  		samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
>  	};
>  
> +	lcd_en: lcd-en-pins {
> +		samsung,pins = "gph1-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>; /* TODO */
> +		samsung,pin-val = <0>;
> +	};
> +
> +	led_bl_reset: led-bl-rst-pins {
> +		samsung,pins = "gpg0-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>; /* TODO */
> +		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_PREV>; /* TODO */
> +		samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>; /* TODO */
> +		samsung,pin-val = <0>; /* TODO */
> +	};
> +
>  	msense_reset: msense-reset-pins {
>  		samsung,pins = "gpg2-0";
>  		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
