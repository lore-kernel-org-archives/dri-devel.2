Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323E3C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE9110F3D8;
	Fri, 28 Aug 2026 14:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="bl2PC9N3";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D277910F3D5
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787926016; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BlbPkjJ9m6AYBqhREK5lCy4aiTb9ged5wJxLjkhaPVol5mLOZw6rhAmamqO1ZhWrivEK9lErXTYkb6PyO6fykOAyAO/f/sUmHoY2pU8kBymGEoCfmfiTcaxS9a9e9Sb3pzaL7+TLzka70wnZyZJyx4thhLi94+0eKa7ewAqx3B0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787926016;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FE7n+qckKFOEEQ74l64QMsqQistEWo8wsohkjnRXH7A=; 
 b=DD1C7sAsZGAzMfKprpWejU1fhOTU3+pIA/+hXhqIYdC7Gh5GF5A84ieIzAbRBmuAViOhwwuPvNZO0hzmuj3NuLXMrMSYQeKuqM3IK1nQQoZPl7aEhNsMI6qa8BBE4gZj4UwsFz0kCzdY4t3iGXd2hkfmLJNny963Rm4gXRfS3Co=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787926016; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=FE7n+qckKFOEEQ74l64QMsqQistEWo8wsohkjnRXH7A=;
 b=bl2PC9N3856C5YebB8QpWlFL/9XDBPmsVsLUK8Ren0pL+UtoiDwLxknChIIJiVOg
 j1BsgouR0J2OYbQMT0UhyaS36twuWiGW/iYB74Sg0ut2aWqyGdAqeiPHwNZhs1g3SAL
 HF/IZ5/+yBVaC8vVHxPJvNPAg0nZ3eo5FzanPFqdZ2VsJO9v/FFmk3q/iixFArJSZCr
 mvR+wVgrsPRvLKAmvpIUIXIWkSy17PwjbBDnSOEqpPw1274BSogxdbrApIXO4IbYrht
 V7RgnrSv0pNpGfaRMTO4pG1wV+Q0+qS71TqrM+qGEjRqnRrRlYs1YKmGJITiaIjCeCP
 rtC1KgOVPg==
Received: by mx.zohomail.com with SMTPS id 1787926012797893.2630690373096;
 Fri, 28 Aug 2026 07:06:52 -0700 (PDT)
Message-ID: <e0e0c41c4c6b0b674c4cfc3b6927d60c40fbf733.camel@icenowy.me>
Subject: Re: [PATCH v2 14/15] riscv: dts: starfive: jh7110: Update DT for
 display subsystem
From: Icenowy Zheng <uwu@icenowy.me>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Vinod Koul
 <vkoul@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Andrzej Hajda	 <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart	
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, David Airlie	 <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>, Philipp Zabel	 <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng	
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Heiko
 Stuebner <heiko@sntech.de>,  Conor Dooley <conor@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>, Marek
 Szyprowski	 <m.szyprowski@samsung.com>, Maud Spierings
 <maudspierings@gocontroll.com>,  Graham Markall <hello@big-grey.co.uk>
Date: Fri, 28 Aug 2026 22:06:38 +0800
In-Reply-To: <20260828-jh7110-clean-send-v2-14-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134839eucas1p2d19363d17d4dbf5a7ae5228444af16fa@eucas1p2.samsung.com>
 <20260828-jh7110-clean-send-v2-14-331680c8b9d1@samsung.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-08-28=E4=BA=94=E7=9A=84 15:47 +0200=EF=BC=8CMichal Wilczynsk=
i=E5=86=99=E9=81=93=EF=BC=9A
> Activate the display subsystem by adding the dc8200, hdmi and voutcrg
> nodes as direct soc children. Each references the PD_VOUT power
> domain
> through power-domains, so genpd powers the domain on demand, and the
> HDMI-PHY -> voutcrg -> HDMI-controller probe order is resolved by
> deferred probe.
>=20
> The monolithic hdmi node is modelled as a container with hdmi_phy
> and hdmi_controller children. This lets the PHY (clock provider,
> depending only on xin24m) and the controller (clock consumer) probe
> independently, breaking the circular clock dependency with voutcrg.
>=20
> voutcrg consumes the pixel clock from the &hdmi_phy node instead of
> the
> old fixed-clock, and dc8200 gets its pixel clocks from voutcrg's
> MUXes
> and is marked dma-noncoherent for framebuffer DMA. The old, incorrect
> hdmitx0-pixel-clock fixed-clock node is removed.
>=20
> Co-developed-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
> =C2=A0arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 119
> +++++++++++++++++++++++-
> =C2=A0arch/riscv/boot/dts/starfive/jh7110.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 87
> +++++++++++++++--
> =C2=A02 files changed, 196 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index
> a7a1c09a2c9075711f3a214a49618911fdc7b421..7aadc35f4a6aa724c86a868ef65
> c5c829e666ee2 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -33,6 +33,25 @@ memory@40000000 {
> =C2=A0		bootph-pre-ram;
> =C2=A0	};
> =C2=A0
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		/* vout applies for space from this CMA
> +		 * Without this CMA reservation,
> +		 * vout may not work properly.
> +		 */
> +		linux,cma {
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +			size =3D <0x0 0x20000000>;
> +			alignment =3D <0x0 0x1000>;
> +			alloc-ranges =3D <0x0 0x70000000 0x0
> 0x20000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
> =C2=A0	gpio-restart {
> =C2=A0		compatible =3D "gpio-restart";
> =C2=A0		gpios =3D <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> @@ -73,12 +92,47 @@ codec {
> =C2=A0			};
> =C2=A0		};
> =C2=A0	};
> +
> +	hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint =3D <&hdmi_out_con>;
> +			};
> +		};
> +	};
> =C2=A0};
> =C2=A0
> =C2=A0&cpus {
> =C2=A0	timebase-frequency =3D <4000000>;
> =C2=A0};
> =C2=A0
> +&dc8200 {
> +	status =3D "okay";
> +
> +	ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		dpu_port0: port@0 {
> +			reg =3D <0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			dpu_out_dpi0: endpoint@0 {
> +				reg =3D <0>;
> +				remote-endpoint =3D <&hdmi_in>;
> +			};
> +		};
> +
> +		dpu_port1: port@1 {
> +			reg =3D <1>;
> +		};
> +	};
> +};
> +
> =C2=A0&dvp_clk {
> =C2=A0	clock-frequency =3D <74250000>;
> =C2=A0};
> @@ -99,8 +153,31 @@ &gmac1_rmii_refin {
> =C2=A0	clock-frequency =3D <50000000>;
> =C2=A0};
> =C2=A0
> -&hdmitx0_pixelclk {
> -	clock-frequency =3D <297000000>;
> +&hdmi_controller {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&hdmi_pins>;
> +
> +	ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		port@0 {
> +			reg =3D <0>;
> +
> +			hdmi_in: endpoint {
> +				remote-endpoint =3D <&dpu_out_dpi0>;
> +			};
> +		};
> +
> +		hdmi_out_port: port@1 {
> +			reg =3D <1>;
> +			hdmi_out_con: endpoint {
> +				remote-endpoint =3D <&hdmi_con_in>;
> +			};
> +
> +		};
> +	};
> =C2=A0};
> =C2=A0
> =C2=A0&i2srx_bclk_ext {
> @@ -351,6 +428,40 @@ &syscrg {
> =C2=A0};
> =C2=A0
> =C2=A0&sysgpio {
> +	hdmi_pins: hdmi-0 {
> +		hdmi-cec-pins {
> +			pinmux =3D <GPIOMUX(14,
> GPOUT_SYS_HDMI_CEC_SDA,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> GPOEN_SYS_HDMI_CEC_SDA,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> GPI_SYS_HDMI_CEC_SDA)>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		hdmi-hpd-pins {
> +			pinmux =3D <GPIOMUX(15, GPOUT_HIGH,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPOEN_ENABLE,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPI_SYS_HDMI_HPD)>;
> +			input-enable;
> +			bias-disable; /* external pull-up */
> +		};
> +
> +		hdmi-scl-pins {
> +			pinmux =3D <GPIOMUX(0, GPOUT_SYS_HDMI_DDC_SCL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 GPOEN_SYS_HDMI_DDC_SCL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 GPI_SYS_HDMI_DDC_SCL)>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		hdmi-sda-pins {
> +			pinmux =3D <GPIOMUX(1, GPOUT_SYS_HDMI_DDC_SDA,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 GPOEN_SYS_HDMI_DDC_SDA,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 GPI_SYS_HDMI_DDC_SDA)>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +	};
> +
> =C2=A0	i2c0_pins: i2c0-0 {
> =C2=A0		i2c-pins {
> =C2=A0			pinmux =3D <GPIOMUX(57, GPOUT_LOW,
> @@ -629,3 +740,7 @@ &U74_3 {
> =C2=A0&U74_4 {
> =C2=A0	cpu-supply =3D <&vdd_cpu>;
> =C2=A0};
> +
> +&voutcrg {
> +	status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index
> 9c3e4598747eb5541effe697044484715569a285..024e33b0e97cb13928d69d1d809
> 0ed14d22bb022 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -290,12 +290,6 @@ gmac1_rmii_refin: gmac1-rmii-refin-clock {
> =C2=A0		#clock-cells =3D <0>;
> =C2=A0	};
> =C2=A0
> -	hdmitx0_pixelclk: hdmitx0-pixel-clock {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "hdmitx0_pixelclk";
> -		#clock-cells =3D <0>;
> -	};
> -
> =C2=A0	i2srx_bclk_ext: i2srx-bclk-ext-clock {
> =C2=A0		compatible =3D "fixed-clock";
> =C2=A0		clock-output-names =3D "i2srx_bclk_ext";
> @@ -352,6 +346,13 @@ tdm_ext: tdm-ext-clock {
> =C2=A0		#clock-cells =3D <0>;
> =C2=A0	};
> =C2=A0
> +	xin24m: xin24m {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "xin24m";
> +	};
> +
> =C2=A0	soc {
> =C2=A0		compatible =3D "simple-bus";
> =C2=A0		interrupt-parent =3D <&plic>;
> @@ -1199,22 +1200,92 @@ csi_phy: phy@19820000 {
> =C2=A0			#phy-cells =3D <0>;
> =C2=A0		};
> =C2=A0
> +		dc8200: display@29400000 {
> +			compatible =3D "verisilicon,dc";
> +			reg =3D <0x0 0x29400000 0x0 0x2800>;
> +			interrupts =3D <95>;
> +			dma-noncoherent;
> +
> +			power-domains =3D <&pwrc JH7110_PD_VOUT>;
> +
> +			clocks =3D <&voutcrg
> JH7110_VOUTCLK_DC8200_CORE>,
> +				<&voutcrg
> JH7110_VOUTCLK_DC8200_AXI>,
> +				<&voutcrg
> JH7110_VOUTCLK_DC8200_AHB>,
> +				<&voutcrg
> JH7110_VOUTCLK_DC8200_PIX0>,
> +				<&voutcrg
> JH7110_VOUTCLK_DC8200_PIX1>;
> +			clock-names =3D "core", "axi", "ahb", "pix0",
> "pix1";
> +
> +			resets =3D <&voutcrg
> JH7110_VOUTRST_DC8200_CORE>,
> +				 <&voutcrg
> JH7110_VOUTRST_DC8200_AXI>,
> +				 <&voutcrg
> JH7110_VOUTRST_DC8200_AHB>;
> +			reset-names =3D "core", "axi", "ahb";
> +		};
> +
> +		hdmi_subsystem: hdmi@29590000 {
> +			compatible =3D "starfive,jh7110-hdmi-
> subsystem";
> +			reg =3D <0x0 0x29590000 0x0 0x4000>;
> +
> +			/*
> +			 * This MFD's PHY child is the first device
> in the vout
> +			 * region to touch registers, so it owns the
> NoC display
> +			 * bus clock + reset that gate access to the
> region.
> +			 * PD_VOUT is powered on by genpd via power-
> domains.
> +			 */
> +			power-domains =3D <&pwrc JH7110_PD_VOUT>;
> +			clocks =3D <&syscrg
> JH7110_SYSCLK_NOC_BUS_DISP_AXI>;
> +			resets =3D <&syscrg
> JH7110_SYSRST_NOC_BUS_DISP_AXI>;

I think the NOC clocks/resets should be also needed by the DC8200
either?

Although patching the DC8200 driver to add support for these
clocks/resets looks a little dirty...

Maybe it's still good to have a vout subsys instead of a hdmi subsys...

Thanks,
Icenowy

> +
> +			hdmi_phy: phy {
> +				compatible =3D "starfive,jh7110-inno-
> hdmi-phy";
> +
> +				clocks =3D <&xin24m>;
> +				clock-names =3D "refoclk";
> +
> +				/* Output clock: The variable pixel
> clock */
> +				#clock-cells =3D <0>;
> +				clock-output-names =3D "hdmi_pclk";
> +
> +				/* PHY provider for the controller
> */
> +				#phy-cells =3D <0>;
> +			};
> +
> +			hdmi_controller: controller {
> +				compatible =3D "starfive,jh7110-inno-
> hdmi-controller";
> +				interrupts =3D <99>;
> +
> +				clocks =3D <&voutcrg
> JH7110_VOUTCLK_HDMI_TX_SYS>,
> +					 <&voutcrg
> JH7110_VOUTCLK_HDMI_TX_MCLK>,
> +					 <&voutcrg
> JH7110_VOUTCLK_HDMI_TX_BCLK>,
> +					 <&hdmi_phy>;
> +				clock-names =3D "sys", "mclk", "bclk",
> "pclk";
> +
> +				resets =3D <&voutcrg
> JH7110_VOUTRST_HDMI_TX_HDMI>;
> +				reset-names =3D "hdmi_tx";
> +
> +				phys =3D <&hdmi_phy>;
> +				phy-names =3D "hdmi-phy";
> +			};
> +		};
> +
> =C2=A0		voutcrg: clock-controller@295c0000 {
> =C2=A0			compatible =3D "starfive,jh7110-voutcrg";
> =C2=A0			reg =3D <0x0 0x295c0000 0x0 0x10000>;
> +
> +			power-domains =3D <&pwrc JH7110_PD_VOUT>;
> +
> =C2=A0			clocks =3D <&syscrg JH7110_SYSCLK_VOUT_SRC>,
> =C2=A0				 <&syscrg
> JH7110_SYSCLK_VOUT_TOP_AHB>,
> =C2=A0				 <&syscrg
> JH7110_SYSCLK_VOUT_TOP_AXI>,
> =C2=A0				 <&syscrg
> JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
> =C2=A0				 <&syscrg
> JH7110_SYSCLK_I2STX0_BCLK>,
> -				 <&hdmitx0_pixelclk>;
> +				 <&hdmi_phy>;
> =C2=A0			clock-names =3D "vout_src", "vout_top_ahb",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vout_top_axi",
> "vout_top_hdmitx0_mclk",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "i2stx0_bclk",
> "hdmitx0_pixelclk";
> +
> =C2=A0			resets =3D <&syscrg
> JH7110_SYSRST_VOUT_TOP_SRC>;
> =C2=A0			#clock-cells =3D <1>;
> =C2=A0			#reset-cells =3D <1>;
> -			power-domains =3D <&pwrc JH7110_PD_VOUT>;
> =C2=A0		};
> =C2=A0
> =C2=A0		pcie0: pcie@940000000 {
