Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D32C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A973210F4C5;
	Tue, 15 Sep 2026 15:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LSJyUtuH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7143B10F4C5
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:49:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DAE5B600C8;
 Tue, 15 Sep 2026 15:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31541F0089A;
 Tue, 15 Sep 2026 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789487364;
 bh=SA+7bRI595a3ViWr6Td9MxNP+tY0TlfoBqentn1PFLo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LSJyUtuHSoxWojvjuDPhhAOVBumL63hzKaIuYHDqHQu9ARLjMg8LgCCoWc9C9f3ly
 /YsbAhlNJBUYr8grHPsChDWn6cEnnkqNhcqGvRfTfD1+/q6yPTCVbaqp2YWJVbhMC8
 U/qKZEUvswRkSFRH913oNg3IdX3DnMW2pfFSBYgzQ9clIk7R5jvtyXmXJqZ0wjVMbT
 iY7eM11eYv61YltZA1R+gg5NPhwr3KWqhOtGu1gdjSpYLnuKTHcajgJEgLEVr3AyQU
 QKhzd/tspADGk9b4dhX2onVzC4+/SMN92bZ7DSOSzWOCpUChEdet+T2ti1sfTCEQI8
 oYsazSlCi4MRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/20] riscv: dts: starfive: jh7110: Update DT for
 display subsystem
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-clk@vger.kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 mfd@lists.linux.dev, vkoul@kernel.org, lee@kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-19-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153248eucas1p27d8d2c9fa536bbd951e0102b04416dad@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-19-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:49:23 +0000
Message-Id: <20260915154923.E31541F0089A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] dts: CMA allocation failure on 1GB boards
- [Medium] dts: missing 'status =3D "disabled"' in SoC DTSI for display IPs
- [Low] dts: redundant reg property on display-subsystem bus node
--

commit d9fbb93d7964da0ec9e48356030bc459050f3218
Author: Michal Wilczynski <m.wilczynski@samsung.com>

riscv: dts: starfive: jh7110: Update DT for display subsystem

This commit activates the display subsystem on the JH7110 SoC by describing
the video output subsystem, HDMI block, and voutcrg in the device tree. It
restructures the HDMI node into a container with phy and controller children
to break a circular clock dependency. Additionally, the CMA pool is expanded
and constrained to memory addressable by the display controller.

> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index a7a1c09a2c907..a4c3daf712a63 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -33,6 +33,27 @@ memory@40000000 {
>  		bootph-pre-ram;
>  	};
> =20
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		/*
> +		 * The display controller allocates its framebuffers from CMA,
> +		 * and the default pool is too small for them. Keep the pool
> +		 * inside the range the controller can address; it fits in the
> +		 * memory every VisionFive 2 variant has.
> +		 */
> +		linux,cma {
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +			size =3D <0x0 0x20000000>;
> +			alignment =3D <0x0 0x1000>;
> +			alloc-ranges =3D <0x0 0x70000000 0x0 0x20000000>;

[Severity: High]
Will this unconditionally fail to allocate the CMA pool on 1GB boards?

On boards like the 1GB Milk-V Mars, physical RAM starts at 0x40000000 and=20
ends at 0x80000000. With alloc-ranges starting at 0x70000000, there is only
256MB of physical memory available within the requested bounds, making a
512MB allocation mathematically impossible.

> +			linux,cma-default;
> +		};
> +	};
> +

[ ... ]

> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 9c3e4598747eb..bc2470963520e 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi

[ ... ]

> @@ -1199,22 +1200,84 @@ csi_phy: phy@19820000 {
>  			#phy-cells =3D <0>;
>  		};
> =20
> -		voutcrg: clock-controller@295c0000 {
> -			compatible =3D "starfive,jh7110-voutcrg";
> -			reg =3D <0x0 0x295c0000 0x0 0x10000>;
> -			clocks =3D <&syscrg JH7110_SYSCLK_VOUT_SRC>,
> -				 <&syscrg JH7110_SYSCLK_VOUT_TOP_AHB>,
> -				 <&syscrg JH7110_SYSCLK_VOUT_TOP_AXI>,
> -				 <&syscrg JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
> -				 <&syscrg JH7110_SYSCLK_I2STX0_BCLK>,
> -				 <&hdmitx0_pixelclk>;
> -			clock-names =3D "vout_src", "vout_top_ahb",
> -				      "vout_top_axi", "vout_top_hdmitx0_mclk",
> -				      "i2stx0_bclk", "hdmitx0_pixelclk";
> -			resets =3D <&syscrg JH7110_SYSRST_VOUT_TOP_SRC>;
> -			#clock-cells =3D <1>;
> -			#reset-cells =3D <1>;
> +		vout_subsystem: display-subsystem@29400000 {
> +			compatible =3D "starfive,jh7110-vout-subsystem";
> +			reg =3D <0x0 0x29400000 0x0 0x200000>;
> +			ranges;

[Severity: Low]
Is this reg property redundant on the bus node?

It assigns a memory region to a bus node that does not own configuration
registers, simply to represent the aggregated bounds of its children. The
dc8200 child claims the exact same starting physical registers.

> +			#address-cells =3D <2>;
> +			#size-cells =3D <2>;
> +			clocks =3D <&syscrg JH7110_SYSCLK_NOC_BUS_DISP_AXI>;
> +			dma-noncoherent;
>  			power-domains =3D <&pwrc JH7110_PD_VOUT>;
> +			resets =3D <&syscrg JH7110_SYSRST_NOC_BUS_DISP_AXI>;
> +
> +			dc8200: display@29400000 {
> +				compatible =3D "starfive,jh7110-dc8200", "verisilicon,dc";

[Severity: Medium]
Should this SoC-level IP definition include status =3D "disabled"?

Custom boards that include jh7110.dtsi but do not include jh7110-common.dtsi
will attempt to probe this IP by default. Headless boards lacking physical
HDMI connectors and necessary board-level pinmuxing may experience probe
errors or unwanted resource consumption.

> +				reg =3D <0x0 0x29400000 0x0 0x2800>;
> +				clocks =3D <&voutcrg JH7110_VOUTCLK_DC8200_CORE>,
> +					 <&voutcrg JH7110_VOUTCLK_DC8200_AXI>,

[ ... ]

> +				resets =3D <&voutcrg JH7110_VOUTRST_DC8200_CORE>,
> +					 <&voutcrg JH7110_VOUTRST_DC8200_AXI>,
> +					 <&voutcrg JH7110_VOUTRST_DC8200_AHB>;
> +				reset-names =3D "core", "axi", "ahb";
> +			};
> +
> +			hdmi_subsystem: hdmi@29590000 {
> +				compatible =3D "starfive,jh7110-hdmi-subsystem";

[Severity: Medium]
Should the hdmi_subsystem IP definition also be disabled by default at the
SoC level?

Like the dc8200 node above, enabling this by default in the SoC devicetree
may cause unintended probe attempts on boards that do not utilize the displ=
ay
subsystem.

> +				reg =3D <0x0 0x29590000 0x0 0x4000>;
> +
> +				hdmi_controller: controller {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D19
