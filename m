Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FA5CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0555F11A111;
	Thu,  4 Jun 2026 14:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QOV+uKdU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8432311A111
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:11:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 092006024D;
 Thu,  4 Jun 2026 14:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1E81F00893;
 Thu,  4 Jun 2026 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780582302;
 bh=MH5p5UiRGIxma5jv4p3iiLlreHzJsU1eQo5K+b7v1QA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QOV+uKdUZO2+uB77cd6Dbj+5LJDwYmxGF1aOY8WnsOxw3NqBEMS11ys0lUTDsEaaF
 amwB82L94bLw6d3hlx+7hnDEwv5sebJGTJJBpS8SUSP2xQv3Dzw0Z3Fm6MW44AVOoS
 AxKR32yQe9WGh6SGb0Z4Mb2Vg0TrVV/JE7fLXse+ypnD0NuTwxFbNCbaZRCLQOEGRO
 R1u9Nrd4BUTZIlnbUvpfIo99RCOW5Ei9QWUIAe9Z0V/qKbumeaDCU6Jow9oFP9BlqO
 9HQpXzcXryHJFt+WV8XPrG+SJVkiWxNv+3Pfs6QKWjMObQQ0PMZtDWN8OMTD04v/Mu
 qbAOX/879e1sg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 8/9] arm64: dts: rockchip: rk356x: Add the NPU
 and its IOMMU
To: "Midgy BALON" <midgy971@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260604135255.62682-9-midgy971@gmail.com>
References: <20260604135255.62682-9-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 14:11:42 +0000
Message-Id: <20260604141142.7B1E81F00893@smtp.kernel.org>
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

New issues:
- [High] The NPU node simultaneously defines `power-domains` and `rockchip,=
pmu`, causing the generic power domain framework and the NPU driver to conc=
urrently manipulate the same PMU power and idle registers.
- [Low] Device tree nodes `npu@fde40000` and `iommu@fde4b000` are not sorte=
d by unit address.

Pre-existing issues:
- [Critical] The driver calls `devm_clk_bulk_get` without initializing the =
`.id` fields of the clock bulk data array, causing all clock requests to in=
correctly default to the first clock in the device tree node.
--

commit dff3ba648a490ef1a1c6644d672ca0b9e1d68360
Author: Midgy BALON <midgy971@gmail.com>

arm64: dts: rockchip: rk356x: Add the NPU and its IOMMU

This commit adds the NPU and its associated IOMMU device tree nodes to the=
=20
RK3568 base devicetree. It also configures the necessary clocks, resets, and
power domain for the NPU.

> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk356x-base.dtsi
> index 64bdd8b7754b5..50ce5a5e4fc24 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi

[ ... ]

> @@ -948,6 +955,37 @@ qos_rga_wr: qos@fe158300 {
>  		reg =3D <0x0 0xfe158300 0x0 0x20>;
>  	};
> =20
> +	rknn_core_0: npu@fde40000 {
[Severity: Low]
This isn't a bug, but should the npu@fde40000 and iommu@fde4b000 nodes be
ordered alphanumerically by unit address? They appear to be inserted after
qos@fe158300 rather than being placed right before gpu@fde60000.

> +		compatible =3D "rockchip,rk3568-rknn-core";
> +		reg =3D <0x0 0xfde40000 0x0 0x1000>,
> +		      <0x0 0xfde41000 0x0 0x1000>,
> +		      <0x0 0xfde43000 0x0 0x1000>;
> +		reg-names =3D "pc", "cna", "core";
> +		interrupts =3D <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&cru ACLK_NPU>, <&cru HCLK_NPU>,
> +			 <&scmi_clk SCMI_CLK_NPU>, <&cru PCLK_NPU_PRE>;
[Severity: Critical]
This is a pre-existing issue, but enabling this node exposes a bug where
devm_clk_bulk_get() is called without initializing the .id fields in
rocket_core_init().

Since the connection ID is NULL, does clk_get() implicitly fall back to
of_clk_get(np, 0) for each loop iteration, mapping all four clock array
entries to ACLK_NPU?

Later, when rk3568_noc_init() dynamically scales the SCMI clock rate to
1 GHz:

    clk_set_rate(core->clks[ROCKET_RK3568_SCMI_CLK].clk, 1000000000UL);

Does this mistakenly configure the rate of ACLK_NPU instead, which could
overclock the AXI bus and lead to immediate hardware instability?

> +		clock-names =3D "aclk", "hclk", "npu", "pclk";
> +		assigned-clocks =3D <&scmi_clk SCMI_CLK_NPU>;
> +		assigned-clock-rates =3D <200000000>;
> +		resets =3D <&cru SRST_A_NPU>, <&cru SRST_H_NPU>;
> +		reset-names =3D "srst_a", "srst_h";
> +		power-domains =3D <&power RK3568_PD_NPU>;
> +		rockchip,pmu =3D <&pmu>;
[Severity: High]
Could setting both power-domains and rockchip,pmu cause a race condition
with TF-A and corrupt hardware state?

The generic power domain framework inherently manages power gating and NoC
bus idle requests for this domain, and explicitly protects these PMU
transitions with pmu->mutex.

Concurrently, the rocket driver's rk3568_noc_init() issues direct, un-polled
regmap_write() operations to the exact same PMU offsets:

    regmap_write(pmu, 0xa0, BIT(1 + 16));
    ...
    regmap_write(pmu, 0x50, BIT(2 + 16));

Does bypassing GenPD's tracked state machine and the pmu->mutex lock create
a layering violation here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604135255.6268=
2-1-midgy971@gmail.com?part=3D8
