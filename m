Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2820CD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C86B88697;
	Tue, 16 Jun 2026 18:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EXhNfBSP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7CD88697
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 18:11:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 78C7C43444;
 Tue, 16 Jun 2026 18:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B461F00A3A;
 Tue, 16 Jun 2026 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781633493;
 bh=ONO+boQul0ynwIclZ0kLdB+897vInAujLlhGJN9Vwy8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EXhNfBSPhzOKed4PxSmIgWaldm2TMtpkG2jU3GmwjnTCntc8F4CoGhTjfUUE5d0V7
 b08dQGnLq1BAxCn5I0ZfcwGDOYzK7jUM7HAyfxFmC6QghUiP7bhDF+dWawMG02Zi4x
 JDEskU2QUkb3pVYZPxrBjXJXMzdbVd7GYegFc0QXc3WWN/ytj+xvmaur8SGi6h54Of
 Xnqx6nnHepR0LnEJA0+l29xe9a/px6psjevvmzIZ0gGstUlBm4Xvtl24e1dJL03xEF
 j1WxsZSdziwtkCxdB7YJr9vk6PzgHTk2ACGmN7Q5869cyVNVG3lBH4FXI9a27t6FcI
 FWxgTqPymD+dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: renesas: r8a77995: Add GE8300 GPU node
To: =?utf-8?b?TmlrbGFzIFPDtmRlcmx1bmQ=?=
 <niklas.soderlund+renesas@ragnatech.se>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260616175835.2109336-3-niklas.soderlund+renesas@ragnatech.se>
References: <20260616175835.2109336-3-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 18:11:32 +0000
Message-Id: <20260616181133.09B461F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added GPU node references core clock R8A77995_CLK_ZG a=
nd module clock 112, but neither is implemented in the R8A77995 CPG MSSR cl=
ock controller driver.
--

commit cb323f9d0762b84aa5d75f999bf135e4920caed4
Author: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>

arm64: dts: renesas: r8a77995: Add GE8300 GPU node

This commit describes the Imagination Technologies PowerVR Rogue GE8300 GPU
node for the Renesas R-Car R8A77995 D3 SoC.

> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/=
dts/renesas/r8a77995.dtsi
> index 5f3fcef7560cb..c42d96540ce73 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -1295,6 +1295,21 @@ gic: interrupt-controller@f1010000 {
>  			resets =3D <&cpg 408>;
>  		};
> =20
> +		gpu: gpu@fd000000 {
> +			compatible =3D "renesas,r8a77995-gpu",
> +				     "img,img-ge8300",
> +				     "img,img-rogue";
> +			reg =3D <0 0xfd000000 0 0x40000>;
> +			interrupts =3D <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cpg CPG_CORE R8A77995_CLK_ZG>,
> +				 <&cpg CPG_CORE R8A77995_CLK_S3D1>,
> +				 <&cpg CPG_MOD 112>;

[Severity: Medium]
Will this result in a probe failure when the node is enabled by a board?

The newly added GPU node requests the core clock R8A77995_CLK_ZG and module
clock 112, but neither appears to be defined in the R8A77995 CPG MSSR clock
controller driver (drivers/clk/renesas/r8a77995-cpg-mssr.c).

If R8A77995_CLK_ZG is missing from r8a77995_core_clks and index 112 is
missing from r8a77995_mod_clks, the clock requests will return -ENOENT and
prevent the GPU driver from probing successfully.

> +			clock-names =3D "core", "mem", "sys";
> +			power-domains =3D <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets =3D <&cpg 112>;
> +			status =3D "disabled";
> +		};
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616175835.2109=
336-1-niklas.soderlund+renesas@ragnatech.se?part=3D2
