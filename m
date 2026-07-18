Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B84C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 03:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A3D10E516;
	Sat, 18 Jul 2026 03:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J4E/ce3B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6221D10E516
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 03:26:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AD5441FE2;
 Sat, 18 Jul 2026 03:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA651F000E9;
 Sat, 18 Jul 2026 03:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784345218;
 bh=zmq7e+3HvSLP3DTktMV/ZRVZx9CCfR8zg72mswHdqQY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J4E/ce3BDap9JphflxFFLRSSPrbHxpmvN4nwjTQKQhFxUMpjA7nXbZaPwEyBBDike
 iV5IQufBGa4GU27YViv+mxPAKvXJs6eARq7r9Irzlx/TFuvhAxvt07HnrmUikz9D9S
 /zh/uwKAMfsAEUs4lqh+o2JroAuIkdHYwOoswVCFQz2TzJkJzii9MUVQ4S0bcA9OLV
 ebOf7GAPqnPS64rYOpry2MvF2Y9uIta9diJZ5+Z+mWO6mg6mvIaK2YPG3JF9nOf72B
 eSsto+LC7ppPaLL4idypCgC6sSYyOobO19FTOHEFq6WJu2pPuaGMcOczzen1dlCzIn
 /D1YyTrUkov0A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 7/8] arm64: dts: rockchip: rk3576: add NPU (RKNN)
 nodes
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260718031146.3368811-8-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
 <20260718031146.3368811-8-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 03:26:57 +0000
Message-Id: <20260718032657.DDA651F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] `rknn_core_1` is missing the `aclk_cbuf` and `hclk_cbuf` clocks an=
d their corresponding `clock-names`, which will cause the driver probe to f=
ail unconditionally.
- [High] The NPU core nodes specify only a single power domain each, which =
causes the driver's explicit power domain attachment to fail with `-EEXIST`.
- [High] The register address for `rknn_mmu_1` (`0x2770a000`) is highly lik=
ely a typo for `0x27712000`.
- [Medium] The new RK3576 NPU, IOMMU, and power domain nodes violate multip=
le device tree binding schemas because the schemas were not properly update=
d for the RK3576 variant properties.
--

--- Patch [7]: [RFC PATCH v2 7/8] arm64: dts: rockchip: rk3576: add NPU (RK=
NN) nodes ---
commit fcbf6a103f04119fa8ae492b4bcf746be4890ddf
Author: Jiaxing Hu <gahing@gahingwoo.com>

arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes

This commit adds the RK3576 NPU core and MMU nodes, configuring their
register addresses, interrupts, clocks, resets, and power domains.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3576.dtsi
> index e12a2a0cfb891..5033f762840ae 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi

[ ... ]

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

[Severity: Medium]
Will this fail device tree schema validation?

The resets property appears to be completely undocumented in
rockchip,power-controller.yaml's pd-node.

>  							pm_qos =3D <&qos_npu_m0>;
>  							#power-domain-cells =3D <0>;
>  						};

[ ... ]

> @@ -1804,6 +1812,72 @@ qos_npu_m1ro: qos@27f22100 {
>  			reg =3D <0x0 0x27f22100 0x0 0x20>;
>  		};
> =20
> +		rknn_core_0: npu@27700000 {
> +			compatible =3D "rockchip,rk3576-rknn-core";
> +			reg =3D <0x0 0x27700000 0x0 0x1000>,
> +			      <0x0 0x27701000 0x0 0x1000>,
> +			      <0x0 0x27703000 0x0 0x1000>,
> +			      <0x0 0x27704000 0x0 0x1000>,
> +			      <0x0 0x27705000 0x0 0x1000>;
> +			reg-names =3D "pc", "cna", "core", "dpu", "dpu_rdma";
> +			interrupts =3D <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
> +				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
> +				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;

[Severity: Medium]
Does this node violate the rockchip,rk3588-rknn-core.yaml schema?

The schema strictly limits reg to a maximum of 3 entries and clocks to a
maximum of 4, but there are 5 and 6 here respectively.

> +			clock-names =3D "aclk", "hclk", "npu", "pclk",
> +				      "aclk_cbuf", "hclk_cbuf";
> +			resets =3D <&cru SRST_A_RKNN0>;
> +			reset-names =3D "srst_a";
> +			power-domains =3D <&power RK3576_PD_NPU0>;

[Severity: High]
Does specifying a single power domain here cause the driver probe to fail?

Because rk3576.dtsi lists only a single power domain for the core node, the
Linux driver core (via genpd_dev_pm_attach) automatically attaches it during
early probe and sets dev->pm_domain.

When the driver's probe runs and calls devm_pm_domain_attach_list(), won't
it see that dev->pm_domain is already set and abort with -EEXIST, rendering
both NPU cores unusable?

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

[Severity: Medium]
Will this fail device tree schema validation for rockchip,iommu.yaml?

The schema limits clocks to 2 and requires clock-names, while 5 clocks are
specified here without clock-names.

> +			#iommu-cells =3D <0>;
> +			power-domains =3D <&power RK3576_PD_NPU0>;
> +			status =3D "disabled";
> +		};
> +
> +		rknn_core_1: npu@27710000 {
> +			compatible =3D "rockchip,rk3576-rknn-core";
> +			reg =3D <0x0 0x27710000 0x0 0x1000>,
> +			      <0x0 0x27711000 0x0 0x1000>,
> +			      <0x0 0x27713000 0x0 0x1000>,
> +			      <0x0 0x27714000 0x0 0x1000>,
> +			      <0x0 0x27715000 0x0 0x1000>;
> +			reg-names =3D "pc", "cna", "core", "dpu", "dpu_rdma";
> +			interrupts =3D <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
> +				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>;
> +			clock-names =3D "aclk", "hclk", "npu", "pclk";

[Severity: High]
Are the aclk_cbuf and hclk_cbuf clocks missing from this list?

The rocket driver initializes with .num_clks =3D 6 for the RK3576 variant a=
nd
requests all 6 clocks by name using devm_clk_bulk_get().

Since rknn_core_1 only specifies 4 clocks, won't the bulk clock acquisition
fail with -ENOENT during device probe, rendering the second NPU core unusab=
le?

> +			resets =3D <&cru SRST_A_RKNN1>;
> +			reset-names =3D "srst_a";
> +			power-domains =3D <&power RK3576_PD_NPU1>;
> +			iommus =3D <&rknn_mmu_1>;
> +			status =3D "disabled";
> +		};
> +
> +		rknn_mmu_1: iommu@2770a000 {
> +			compatible =3D "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
> +			reg =3D <0x0 0x2770a000 0x0 0x100>,
> +			      <0x0 0x2770a100 0x0 0x100>;

[Severity: High]
Is the register address 0x2770a000 a typo for 0x27712000?

Looking at rknn_core_0, it spans 0x27700000 with a gap at 0x27702000 for
its MMU. rknn_core_1 spans 0x27710000 and has an identical gap at
0x27712000.

Placing the MMU at 0x2770a000 could lead to mapping unassigned I/O space
instead of the target IOMMU control registers, causing a synchronous extern=
al
abort when accessed.

> +			interrupts =3D <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718031146.3368=
811-1-gahing@gahingwoo.com?part=3D7
