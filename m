Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6D606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNaw/3tS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B2410EA95;
	Fri,  6 Nov 2026 16:12:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1351C10EA9D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 16:12:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 976C16062A;
 Fri,  6 Nov 2026 16:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F8E1F0089F;
 Fri,  6 Nov 2026 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793981536;
 bh=QtyI2+GW86z5aHl6ZfHYzAXAzVDLDy/TcEMNr+ncFIw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gNaw/3tSv8m4eZq5Rbm+KVy98y6k76OWln2MWVLAlfgfnlXZKHh3eNBfCo6Iebxmr
 jii8IAmpCtjqPzc8+Vv5dg2LH32pH6ncuOHZEpBed4Za/lkY7rMcrGerYxRZO29HgI
 LHFrPqFzaVhshSthR5g0+1LkkzOSuU3RygUbfZGY7B3LXkGrCB1+hJQ3SUOZQlDXre
 F0catWc6po8NKu5o8+L4mAda71pML/YrAxg16d6lHq4tra91mCP4Zvyyx4wrkVj7pc
 AhIldq5AiMuvlNRCbsx0WAlmpu7ZSmmtL1vpyBx69VeMI/oz8Ick51xWgzyiKVCQY9
 SmO+w75/qlDJA==
Message-ID: <sashiko-outbox-201775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/19] riscv: dts: starfive: jh7110: Update DT for
 display subsystem
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106-jh7110-clean-send-v7-18-68f7ea9913db@samsung.com>
References: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
 <CGME20261106135924eucas1p17cd8d0880486f9e932fe1b81ba3eeaf6@eucas1p1.samsung.com>
 <20261106-jh7110-clean-send-v7-18-68f7ea9913db@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:12:15 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] riscv: dts: starfive: CMA alloc-ranges in jh7110-common.dtsi
  breaks 1 GiB RAM
- [Low] riscv: dts: starfive: missing status disabled on jh7110.dtsi
  display nodes
- [Low] riscv: dts: starfive: duplicate 24 MHz xin24m clock node in
  jh7110.dtsi
--

commit e4e97f0b932284258aa4795e30b6380ab560afa7
Author: Michal Wilczynski <m.wilczynski@samsung.com>

riscv: dts: starfive: jh7110: Update DT for display subsystem

This commit describes the JH7110 video output subsystem, DC8200 display
controller, HDMI controller and PHY in the SoC device tree, and enables
the display pipeline with a 512 MiB default CMA pool in the common board
device tree.

> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 64de468f2c317..bfc7ae1282234 100644
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
> +			linux,cma-default;
> +		};
> +	};

[Severity: High]
Does this alloc-ranges setting cause linux,cma reservation to fail on 1 GiB
JH7110 boards, or whenever an earlier reservation overlaps 0x70000000..
0x90000000?

jh7110-common.dtsi is also included by 1 GiB boards such as Milk-V Mars and
Mars CM, where physical RAM at 0x40000000..0x80000000 only covers 256 MiB of
the 0x70000000..0x90000000 window, so __reserved_mem_alloc_size() fails with
-ENOMEM and leaves the system without a default CMA pool. Because the window
size equals the 512 MiB allocation size with no slack, any bootloader or
initrd reservation in 0x70000000..0x90000000 also causes CMA allocation to
fail on larger boards even though DC8200 uses a 32-bit DMA mask and can
address any RAM below 0x100000000.

[ ... ]

> @@ -644,3 +757,7 @@ &U74_3 {
>  &U74_4 {
>  	cpu-supply =3D <&vdd_cpu>;
>  };
> +
> +&voutcrg {
> +	status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 82ea63f715b0e..ac10d79770f24 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi

[ ... ]

> @@ -352,6 +346,13 @@ tdm_ext: tdm-ext-clock {
>  		#clock-cells =3D <0>;
>  	};
> =20
> +	xin24m: xin24m-clock {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "xin24m";
> +	};

[Severity: Low]
Can hdmi_phy use the existing <&osc> node in jh7110.dtsi instead of adding a
duplicate 24 MHz xin24m fixed-clock node?

jh7110.dtsi already defines the 24 MHz reference crystal as osc: oscillator
(with its frequency set in jh7110-common.dtsi), and neither the
starfive,jh7110-inno-hdmi-phy binding nor starfive_hdmi_phy_probe() requires
the clock to be named xin24m.

> @@ -1262,22 +1263,84 @@ csi_phy: phy@19820000 {
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
> +			#address-cells =3D <2>;
> +			#size-cells =3D <2>;
> +			clocks =3D <&syscrg JH7110_SYSCLK_NOC_BUS_DISP_AXI>;
> +			dma-noncoherent;
>  			power-domains =3D <&pwrc JH7110_PD_VOUT>;
> +			resets =3D <&syscrg JH7110_SYSRST_NOC_BUS_DISP_AXI>;
> +
> +			dc8200: display@29400000 {
> +				compatible =3D "starfive,jh7110-dc8200", "verisilicon,dc";
> +				reg =3D <0x0 0x29400000 0x0 0x2800>;
> +				clocks =3D <&voutcrg JH7110_VOUTCLK_DC8200_CORE>,
> +					 <&voutcrg JH7110_VOUTCLK_DC8200_AXI>,
> +					 <&voutcrg JH7110_VOUTCLK_DC8200_AHB>,
> +					 <&voutcrg JH7110_VOUTCLK_DC8200_PIX0>,
> +					 <&voutcrg JH7110_VOUTCLK_DC8200_PIX1>;
> +				clock-names =3D "core", "axi", "ahb", "pix0", "pix1";
> +				assigned-clocks =3D <&voutcrg JH7110_VOUTCLK_DC8200_PIX0>,
> +						  <&voutcrg JH7110_VOUTCLK_DC8200_PIX1>;
> +				assigned-clock-parents =3D <&hdmi_phy>, <&hdmi_phy>;
> +				interrupts =3D <95>;
> +				resets =3D <&voutcrg JH7110_VOUTRST_DC8200_CORE>,
> +					 <&voutcrg JH7110_VOUTRST_DC8200_AXI>,
> +					 <&voutcrg JH7110_VOUTRST_DC8200_AHB>;
> +				reset-names =3D "core", "axi", "ahb";
> +			};
> +
> +			hdmi_subsystem: hdmi@29590000 {
> +				compatible =3D "starfive,jh7110-hdmi-subsystem";
> +				reg =3D <0x0 0x29590000 0x0 0x4000>;
> +
> +				hdmi_controller: controller {
> +					compatible =3D
> +						"starfive,jh7110-inno-hdmi-controller";
> +					clocks =3D <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
> +						 <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
> +						 <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
> +						 <&hdmi_phy>;
> +					clock-names =3D "pclk", "mclk", "bclk", "pixel";
> +					interrupts =3D <99>;
> +					phys =3D <&hdmi_phy>;
> +					resets =3D <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
> +					starfive,vout-syscon =3D <&vout_syscon>;
> +				};

[Severity: Low]
Should dc8200 and hdmi_controller have status =3D "disabled" in jh7110.dtsi,
and should the &voutcrg override in jh7110-common.dtsi be dropped?

Both dc8200 and hdmi_controller require board-specific port graphs and
pinctrl properties that are only populated in jh7110-common.dtsi (which
explicitly sets status =3D "okay" on both nodes), so leaving them enabled by
default in jh7110.dtsi leaves them incomplete for any board not using
jh7110-common.dtsi. Conversely, voutcrg is never disabled in jh7110.dtsi, so
the &voutcrg block setting status =3D "okay" in jh7110-common.dtsi has no
effect.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-jh7110-cle=
an-send-v7-0-68f7ea9913db@samsung.com?part=3D18
