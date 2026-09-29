Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31008CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE5B10E037;
	Tue, 29 Sep 2026 15:06:51 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0990110E037
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 15:06:49 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-05 (Coremail) with SMTP id zQCowACHt0Hz07tqfp+vCQ--.6830S2;
 Tue, 29 Sep 2026 23:06:28 +0800 (CST)
Message-ID: <b5eb69f3f41a98b5a98694435df25a632babf05a.camel@iscas.ac.cn>
Subject: Re: [PATCH v4 19/20] riscv: dts: starfive: jh7110: Update DT for
 display subsystem
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Vinod Koul
 <vkoul@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Andrzej Hajda	 <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart	
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>, Philipp Zabel	 <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng	
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi	 <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet	 <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Marek Szyprowski
 <m.szyprowski@samsung.com>,  Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>, Chaoyi Chen	
 <chaoyi.chen@rock-chips.com>, Joshua Peisach <jpeisach@ubuntu.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>
Date: Tue, 29 Sep 2026 23:06:26 +0800
In-Reply-To: <20260915-jh7110-clean-send-v4-19-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153248eucas1p27d8d2c9fa536bbd951e0102b04416dad@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-19-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowACHt0Hz07tqfp+vCQ--.6830S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Zw43AFyDKFy5Aw1xWr4kZwb_yoWDCr45pF
 n2y34fGrZayrn7Aa1aqayUKFykKa4kC3Z09wnxWF1Fyr13XFyxtr4jywsxWa4UJrs7Jw12
 qF1kZrWa9FnrKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
 cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
 VjvjDU0xZFpf9x07b-eOXUUUUU=
X-Originating-IP: [112.94.101.54]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

=E5=9C=A8 2026-09-15=E4=BA=8C=E7=9A=84 17:32 +0200=EF=BC=8CMichal Wilczynsk=
i=E5=86=99=E9=81=93=EF=BC=9A
> Activate the display subsystem by describing the video output
> subsystem,
> which the documentation calls dom_vout_top, as a bus node covering
> the
> whole 0x29400000 region, with dc8200, the HDMI block, the video
> output
> system controller and voutcrg as its children.
>=20
> The subsystem node owns the resources its children share: the NoC
> display
> bus clock and reset that gate access to every register in the region,
> and
> the PD_VOUT power domain. Modelling it this way keeps a shared gate
> owned
> by the block that shares it rather than by whichever consumer happens
> to
> probe first, and lets dc8200 inherit dma-noncoherent for framebuffer
> DMA
> from the bus it sits on.
>=20
> The monolithic hdmi node is in turn modelled as a container with
> hdmi_phy
> and hdmi_controller children. This lets the PHY (clock provider,
> depending only on xin24m) and the controller (clock consumer) probe
> independently, breaking the circular clock dependency with voutcrg.
>=20
> voutcrg consumes the pixel clock from the &hdmi_phy node instead of
> the
> old fixed-clock, and dc8200 gets its pixel clocks from voutcrg's
> MUXes.
> The old, incorrect hdmitx0-pixel-clock fixed-clock node is removed.
>=20
> The HDMI controller gets a phandle to the video output system
> controller,
> which holds the mux selecting the DC8200 output that drives the HDMI
> transmitter.
>=20
> CMA is enlarged and constrained to memory the display controller can
> address, because the default pool is too small for its framebuffers.
>=20
> Co-developed-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

```
Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

But,

> ---
> =C2=A0arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 121
> +++++++++++++++++++++++-
> =C2=A0arch/riscv/boot/dts/starfive/jh7110.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 105
> ++++++++++++++++----
> =C2=A02 files changed, 203 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index
> a7a1c09a2c9075711f3a214a49618911fdc7b421..a4c3daf712a63b177f744e8c613
> 416d22e0c9dbd 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -33,6 +33,27 @@ memory@40000000 {
> =C2=A0		bootph-pre-ram;
> =C2=A0	};
> =C2=A0
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		/*
> +		 * The display controller allocates its framebuffers
> from CMA,
> +		 * and the default pool is too small for them. Keep
> the pool
> +		 * inside the range the controller can address; it
> fits in the
> +		 * memory every VisionFive 2 variant has.
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

I don't know whether constraining the CMA pool in the DT is a good
idea.

Thanks,
Icenowy

> =C2=A0	gpio-restart {
> =C2=A0		compatible =3D "gpio-restart";
> =C2=A0		gpios =3D <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> @@ -73,12 +94,47 @@ codec {
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
> @@ -99,8 +155,31 @@ &gmac1_rmii_refin {
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
> +
> +			hdmi_out_con: endpoint {
> +				remote-endpoint =3D <&hdmi_con_in>;
> +			};
> +		};
> +	};
> =C2=A0};
> =C2=A0
> =C2=A0&i2srx_bclk_ext {
> @@ -351,6 +430,40 @@ &syscrg {
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
> +			pinmux =3D <GPIOMUX(15, GPOUT_LOW,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPOEN_DISABLE,
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
> @@ -629,3 +742,7 @@ &U74_3 {
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
> 9c3e4598747eb5541effe697044484715569a285..bc2470963520eef30d7524370fc
> b013f0631f509 100644
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
> +	xin24m: xin24m-clock {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "xin24m";
> +	};
> +
> =C2=A0	soc {
> =C2=A0		compatible =3D "simple-bus";
> =C2=A0		interrupt-parent =3D <&plic>;
> @@ -1199,22 +1200,84 @@ csi_phy: phy@19820000 {
> =C2=A0			#phy-cells =3D <0>;
> =C2=A0		};
> =C2=A0
> -		voutcrg: clock-controller@295c0000 {
> -			compatible =3D "starfive,jh7110-voutcrg";
> -			reg =3D <0x0 0x295c0000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_VOUT_SRC>,
> -				 <&syscrg
> JH7110_SYSCLK_VOUT_TOP_AHB>,
> -				 <&syscrg
> JH7110_SYSCLK_VOUT_TOP_AXI>,
> -				 <&syscrg
> JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
> -				 <&syscrg
> JH7110_SYSCLK_I2STX0_BCLK>,
> -				 <&hdmitx0_pixelclk>;
> -			clock-names =3D "vout_src", "vout_top_ahb",
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vout_top_axi",
> "vout_top_hdmitx0_mclk",
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "i2stx0_bclk",
> "hdmitx0_pixelclk";
> -			resets =3D <&syscrg
> JH7110_SYSRST_VOUT_TOP_SRC>;
> -			#clock-cells =3D <1>;
> -			#reset-cells =3D <1>;
> +		vout_subsystem: display-subsystem@29400000 {
> +			compatible =3D "starfive,jh7110-vout-
> subsystem";
> +			reg =3D <0x0 0x29400000 0x0 0x200000>;
> +			ranges;
> +			#address-cells =3D <2>;
> +			#size-cells =3D <2>;
> +			clocks =3D <&syscrg
> JH7110_SYSCLK_NOC_BUS_DISP_AXI>;
> +			dma-noncoherent;
> =C2=A0			power-domains =3D <&pwrc JH7110_PD_VOUT>;
> +			resets =3D <&syscrg
> JH7110_SYSRST_NOC_BUS_DISP_AXI>;
> +
> +			dc8200: display@29400000 {
> +				compatible =3D "starfive,jh7110-
> dc8200", "verisilicon,dc";
> +				reg =3D <0x0 0x29400000 0x0 0x2800>;
> +				clocks =3D <&voutcrg
> JH7110_VOUTCLK_DC8200_CORE>,
> +					 <&voutcrg
> JH7110_VOUTCLK_DC8200_AXI>,
> +					 <&voutcrg
> JH7110_VOUTCLK_DC8200_AHB>,
> +					 <&voutcrg
> JH7110_VOUTCLK_DC8200_PIX0>,
> +					 <&voutcrg
> JH7110_VOUTCLK_DC8200_PIX1>;
> +				clock-names =3D "core", "axi", "ahb",
> "pix0", "pix1";
> +				assigned-clocks =3D <&voutcrg
> JH7110_VOUTCLK_DC8200_PIX0>,
> +						=C2=A0 <&voutcrg
> JH7110_VOUTCLK_DC8200_PIX1>;
> +				assigned-clock-parents =3D
> <&hdmi_phy>, <&hdmi_phy>;
> +				interrupts =3D <95>;
> +				resets =3D <&voutcrg
> JH7110_VOUTRST_DC8200_CORE>,
> +					 <&voutcrg
> JH7110_VOUTRST_DC8200_AXI>,
> +					 <&voutcrg
> JH7110_VOUTRST_DC8200_AHB>;
> +				reset-names =3D "core", "axi", "ahb";
> +			};
> +
> +			hdmi_subsystem: hdmi@29590000 {
> +				compatible =3D "starfive,jh7110-hdmi-
> subsystem";
> +				reg =3D <0x0 0x29590000 0x0 0x4000>;
> +
> +				hdmi_controller: controller {
> +					compatible =3D
> +						"starfive,jh7110-
> inno-hdmi-controller";
> +					clocks =3D <&voutcrg
> JH7110_VOUTCLK_HDMI_TX_SYS>,
> +						 <&voutcrg
> JH7110_VOUTCLK_HDMI_TX_MCLK>,
> +						 <&voutcrg
> JH7110_VOUTCLK_HDMI_TX_BCLK>,
> +						 <&hdmi_phy>;
> +					clock-names =3D "pclk",
> "mclk", "bclk", "pixel";
> +					interrupts =3D <99>;
> +					phys =3D <&hdmi_phy>;
> +					resets =3D <&voutcrg
> JH7110_VOUTRST_HDMI_TX_HDMI>;
> +					starfive,vout-syscon =3D
> <&vout_syscon>;
> +				};
> +
> +				hdmi_phy: phy {
> +					compatible =3D
> "starfive,jh7110-inno-hdmi-phy";
> +					clocks =3D <&xin24m>;
> +					#clock-cells =3D <0>;
> +					#phy-cells =3D <0>;
> +				};
> +			};
> +
> +			vout_syscon: syscon@295b0000 {
> +				compatible =3D "starfive,jh7110-vout-
> syscon", "syscon";
> +				reg =3D <0x0 0x295b0000 0x0 0x10000>;
> +			};
> +
> +			voutcrg: clock-controller@295c0000 {
> +				compatible =3D "starfive,jh7110-
> voutcrg";
> +				reg =3D <0x0 0x295c0000 0x0 0x10000>;
> +				clocks =3D <&syscrg
> JH7110_SYSCLK_VOUT_SRC>,
> +					 <&syscrg
> JH7110_SYSCLK_VOUT_TOP_AHB>,
> +					 <&syscrg
> JH7110_SYSCLK_VOUT_TOP_AXI>,
> +					 <&syscrg
> JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
> +					 <&syscrg
> JH7110_SYSCLK_I2STX0_BCLK>,
> +					 <&hdmi_phy>;
> +				clock-names =3D "vout_src",
> "vout_top_ahb",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vout_top_axi",
> "vout_top_hdmitx0_mclk",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "i2stx0_bclk",
> "hdmitx0_pixelclk";
> +				power-domains =3D <&pwrc
> JH7110_PD_VOUT>;
> +				resets =3D <&syscrg
> JH7110_SYSRST_VOUT_TOP_SRC>;
> +				#clock-cells =3D <1>;
> +				#reset-cells =3D <1>;
> +			};
> =C2=A0		};
> =C2=A0
> =C2=A0		pcie0: pcie@940000000 {

