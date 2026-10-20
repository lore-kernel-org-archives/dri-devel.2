Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F91606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITqedP9f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D76810E5E8;
	Tue, 20 Oct 2026 23:04:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C268810E90C
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:04:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 699F241B30;
 Tue, 20 Oct 2026 23:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC451F000C9;
 Tue, 20 Oct 2026 23:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792537449;
 bh=H7wFHZnciW9Pf28TVKxrZFY03mYFgE43S37eCBdMlpY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ITqedP9fPRTEDVupCS4ICjQ90O3eRM8wd0qNFb1pPZiPabdt9btbfb4swKMHEwi/v
 AomYgVuYO1hobt+TG26xhQvNnSq0Y6c6hNy+ZB91TTleIIUWbZfkvUhJAqpQ7Pzemp
 7XV46E8o0GjM/5Ma86aBY15IWaR+c8GlbHcH4tKKoZgYiISEsf+QsuTSX5QdOkgEJm
 Qsay+T0UJLbHK/3iJQK77XXnCCWrSBjZ71vnaVprH+DRPdUkWZUCYIGKfgttTFn5su
 r1dHVyHKc/DUqkPxPWh8oHVL3DlPaF9T9jOqnmdjQdJWwdNe5kmXssyDmhNYzTvt9q
 BaOOTqV6/na2g==
Message-ID: <sashiko-outbox-179591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] arm64: dts: imx8dxl-evk: Add onboard GPIO mux
 controller
To: Frank.Li@oss.nxp.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261020-dxl_lcdif-v3-5-adc944659e14@nxp.com>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
 <20261020-dxl_lcdif-v3-5-adc944659e14@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 23:04:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm64: dts: imx8dxl-evk: spi0_mux and m4_debug_mux driven low on p=
robe
--

commit a3a65e29ad3fd8c46c72a9be8f8c719076ef18d5
Author: Frank Li <Frank.Li@nxp.com>

arm64: dts: imx8dxl-evk: Add onboard GPIO mux controller

This commit adds four gpio-mux controllers and a pinctrl-multiplexer node
to describe the onboard signal multiplexer on imx8dxl-evk, and removes the
regulator-m2uart1sel node.

> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/b=
oot/dts/freescale/imx8dxl-evk.dts
> index 0ede0c7ed422c..0ee2a028ebff6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -97,14 +97,68 @@ vdevbuffer: memory-vdevbuffer@90400000 {
>  		};
>  	};
> =20
> -	m2_uart1_sel: regulator-m2uart1sel {
> -		compatible =3D "regulator-fixed";
> -		regulator-min-microvolt =3D <3300000>;
> -		regulator-max-microvolt =3D <3300000>;
> -		regulator-name =3D "m2_uart1_sel";
> -		gpio =3D <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -		regulator-always-on;
> +	m4_debug_mux: mux-controller-0 {
> +		compatible =3D "gpio-mux";
> +		#mux-control-cells =3D <0>;
> +		#mux-state-cells =3D <1>;
> +		mux-gpios =3D <&pca6416_1 3 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	spi3_mux: mux-controller-1 {
> +		compatible =3D "gpio-mux";
> +		#mux-control-cells =3D <0>;
> +		#mux-state-cells =3D <1>;
> +		mux-gpios =3D <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	uart1_mux: mux-controller-2 {
> +		compatible =3D "gpio-mux";
> +		#mux-control-cells =3D <0>;
> +		#mux-state-cells =3D <1>;
> +		mux-gpios =3D <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	spi0_mux: mux-controller-3 {
> +		compatible =3D "gpio-mux";
> +		#mux-control-cells =3D <0>;
> +		#mux-state-cells =3D <1>;
> +		mux-gpios =3D <&pca6416_1 7 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	pinctrl-gpiomux {
> +		compatible =3D "pinctrl-multiplexer";
> +
> +		m4_debug_fun: cm4-uart-grp {
> +			mux-states =3D <&m4_debug_mux 1>;
> +		};
> +
> +		spi0_fun: spi0-grp {
> +			mux-states =3D <&spi0_mux 1>;
> +		};
> +
> +		spi3_fun: spi3-grp {
> +			mux-states =3D <&spi3_mux 1>;
> +		};
> +
> +		uart1_fun: uart1-grp {
> +			mux-states =3D <&uart1_mux 1>;
> +		};
> +
> +		lcd_0_fun: lcd0-grp {
> +			mux-states =3D <&spi0_mux 0>;
> +		};
> +
> +		lcd_1_fun: lcd1-grp {
> +			mux-states =3D <&spi3_mux 0>;
> +		};
> +
> +		lcd_2_fun: lcd2-grp {
> +			mux-states =3D <&uart1_mux 0>;
> +		};
> +
> +		lcd_3_fun: lcd3-grp {
> +			mux-states =3D <&m4_debug_mux 0>;
> +		};
>  	};
> =20
>  	mux3_en: regulator-0 {

[ ... ]

> @@ -658,7 +712,7 @@ &cm40_intmux {
> =20
>  &cm40_lpuart {
>  	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&pinctrl_cm40_lpuart>;
> +	pinctrl-0 =3D <&pinctrl_cm40_lpuart>, <&m4_debug_fun>;
>  	status =3D "disabled";
>  };
> =20

[Severity: High]
Does adding spi0_mux and m4_debug_mux without an active consumer or
idle-state =3D <1> cause those muxes to be driven low (state 0, lcd_0_fun
and lcd_3_fun) at boot instead of keeping the hardware pull-up default
(state 1)?

When mux_gpio_probe() in drivers/mux/gpio.c probes each gpio-mux node, it
requests the mux gpios as outputs initialized low (state 0):

drivers/mux/gpio.c:mux_gpio_probe() {
	...
	mux_gpio->gpios =3D devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
	...
}

Because neither spi0_mux nor m4_debug_mux specifies idle-state =3D <1>, both
lines remain driven low unless an enabled device selects spi0_fun or
m4_debug_fun:

1. In arch/arm64/boot/dts/freescale/imx8dxl-evk.dts, spi0_fun is defined in
pinctrl-gpiomux, but has no consumer. Meanwhile, &sai0 is enabled (used by
sound-bt-sco) and muxes its signals onto the spi0 pads via pinctrl_sai0
without referencing spi0_fun:

	&sai0 {
		pinctrl-names =3D "default";
		pinctrl-0 =3D <&pinctrl_sai0>;
		...
		status =3D "okay";
	};

	pinctrl_sai0: sai0grp {
		fsl,pins =3D <
			IMX8DXL_SPI0_CS0_ADMA_SAI0_RXD		0x06000060
			IMX8DXL_SPI0_CS1_ADMA_SAI0_RXC		0x06000040
			IMX8DXL_SPI0_SCK_ADMA_SAI0_TXC		0x06000060
			IMX8DXL_SPI0_SDI_ADMA_SAI0_TXD		0x06000060
			IMX8DXL_SPI0_SDO_ADMA_SAI0_TXFS		0x06000040
		>;
	};

2. For m4_debug_mux, m4_debug_fun is only attached to &cm40_lpuart, which h=
as
status =3D "disabled", while &adc0 and imx8dxl-cm4 are enabled and share the
pads controlled by m4_debug_mux (&pca6416_1 3).

Should &sai0 include <&spi0_fun> in pinctrl-0, and should the mux controlle=
rs
specify idle-state =3D <1> (or have m4_debug_fun selected by an enabled
consumer) so that sai0 and the m4 / adc0 signals are not disconnected on
probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-dxl_lcdif-=
v3-0-adc944659e14@nxp.com?part=3D5
