Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CD1C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4903F10E586;
	Mon,  3 Aug 2026 09:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aPEJ8m3E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A33E10E586
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:56:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C771C43911;
 Mon,  3 Aug 2026 09:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBCD1F00A3A;
 Mon,  3 Aug 2026 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785750968;
 bh=1txSijz23MsSNY+eEq4S0NG9v46J20XQD8HMS0G8d4k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aPEJ8m3EztBRamt7MVHueU9tJtod3s7UjiF5GqCQZY0iQ/BCcG7qE4Gztjhi0XN9D
 uFbvHNeap+CTqyac2JXCdSwmZL6sojx8oqXNMIfHSXUG4NiQrwvXwqeBbDWhMtLERr
 rM1Y8c8wDKwugYCtxpK6TyJTQEW+76H3CmT7Nq76rUbQyKjEN/+W/1urXblW9oojtg
 mrd9cZ2LE9/ek1vzjGow125vgOxCJhdN5rvgHPustFSG2XeSyNck60xnb6mmK1ejMZ
 TrgH13cTIYXbYKzGXlkFsI4ZwyN4QqD/aDi1lJxM6vIrhnl/K2Rzj5DLl+xZJ6Cto4
 /oNuCWOmZ1p0A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 5/6] arm64: dts: rockchip: rk3576: add NPU (RKNN)
 nodes
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260803094125.3285895-6-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com>
 <20260803094125.3285895-6-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 09:56:07 +0000
Message-Id: <20260803095608.5CBCD1F00A3A@smtp.kernel.org>
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
- [Low] The newly added NPU core nodes violate the `rockchip,rk3588-rknn-co=
re` binding schema across multiple properties.
- [Low] The newly added IOMMU nodes violate the `rockchip,iommu` binding sc=
hema by declaring excessive clocks and missing required properties.
- [Low] Adding a `resets` property to the NPU power domains violates the ge=
neric Rockchip power controller schema.
--

--- Patch [5]: [RFC PATCH v4 5/6] arm64: dts: rockchip: rk3576: add NPU (RK=
NN) nodes ---
commit aae8c26737d67b11f41b924b5322997c922df364
Author: Jiaxing Hu <gahing@gahingwoo.com>

arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes

Add the two RKNN cores and their IOMMUs, plus the NPU power-domain
resets the pmdomain driver now cycles on power-on. Both cores are
disabled by default; boards enable what they wire up.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3576.dtsi
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1070,14 +1070,22 @@ power-domain@RK3576_PD_NPUTOP {
>  						power-domain@RK3576_PD_NPU0 {
>  							reg =3D <RK3576_PD_NPU0>;
>  							clocks =3D <&cru HCLK_RKNN_ROOT>,
> -								 <&cru ACLK_RKNN0>;
> +								 <&cru ACLK_RKNN0>,
> +								 <&cru CLK_RKNN_DSU0>,
> +								 <&cru ACLK_RKNN_CBUF>,
> +								 <&cru HCLK_RKNN_CBUF>;
> +							resets =3D <&cru SRST_A_RKNN0_BIU>;

[Severity: Low]
Does adding the resets property here violate the generic Rockchip power
controller schema?

The rockchip,power-controller.yaml binding restricts properties for pd-nodes
and it doesn't appear to list resets as an allowable property, which could
cause a dtbs_check failure.

>  							pm_qos =3D <&qos_npu_m0>;
>  							#power-domain-cells =3D <0>;
>  						};
>  						power-domain@RK3576_PD_NPU1 {
>  							reg =3D <RK3576_PD_NPU1>;
>  							clocks =3D <&cru HCLK_RKNN_ROOT>,
> -								 <&cru ACLK_RKNN1>;
> +								 <&cru ACLK_RKNN1>,
> +								 <&cru CLK_RKNN_DSU0>,
> +								 <&cru ACLK_RKNN_CBUF>,
> +								 <&cru HCLK_RKNN_CBUF>;
> +							resets =3D <&cru SRST_A_RKNN1_BIU>;

[Severity: Low]
This shares the same resets property schema issue mentioned for RK3576_PD_N=
PU0
above.

[ ... ]

> +		rknn_core_0: npu@27700000 {
> +			compatible =3D "rockchip,rk3576-rknn-core";
> +			reg =3D <0x0 0x27700000 0x0 0x1000>,
> +			      <0x0 0x27701000 0x0 0x1000>,
> +			      <0x0 0x27703000 0x0 0x1000>;
> +			reg-names =3D "pc", "cna", "core";
> +			interrupts =3D <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
> +				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
> +				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
> +			clock-names =3D "aclk", "hclk", "npu", "pclk",
> +				      "aclk_cbuf", "hclk_cbuf";
> +			resets =3D <&cru SRST_A_RKNN0>;
> +			reset-names =3D "srst_a";
> +			power-domains =3D <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;

[Severity: Low]
Do the power-domains, clocks, and missing npu-supply properties violate the
rockchip,rk3588-rknn-core binding schema?=20

The current schema seems to require exactly 1 power-domain, up to 4 clocks,
and explicitly requires an npu-supply.

> +			iommus =3D <&rknn_mmu_0>;
> +			status =3D "disabled";
> +		};
> +
> +		rknn_mmu_0: iommu@27702000 {
> +			compatible =3D "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
> +			reg =3D <0x0 0x27702000 0x0 0x100>,
> +			      <0x0 0x27702100 0x0 0x100>;
> +			interrupts =3D <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
> +				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
> +				 <&cru HCLK_RKNN_CBUF>;

[Severity: Low]
Does this node violate the rockchip,iommu binding schema by declaring 5 clo=
cks
without a clock-names mapping?=20

The rockchip,iommu.yaml schema restricts clocks to exactly 2 items and
requires the clock-names property to be defined.

[ ... ]

> +		rknn_core_1: npu@27708000 {
> +			compatible =3D "rockchip,rk3576-rknn-core";
[ ... ]
> +			power-domains =3D <&power RK3576_PD_NPU1>, <&power RK3576_PD_NPU0>;

[Severity: Low]
This shares the same rockchip,rk3588-rknn-core schema violation mentioned f=
or
rknn_core_0.

> +			iommus =3D <&rknn_mmu_1>;
> +			status =3D "disabled";
> +		};
> +
> +		rknn_mmu_1: iommu@2770a000 {
> +			compatible =3D "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
[ ... ]
> +			clocks =3D <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
> +				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
> +				 <&cru HCLK_RKNN_CBUF>;

[Severity: Low]
This shares the same rockchip,iommu schema violation mentioned for rknn_mmu=
_0
regarding extra clocks and missing clock-names.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803094125.3285=
895-1-gahing@gahingwoo.com?part=3D5
