Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A17CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915B511A109;
	Thu,  4 Jun 2026 14:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QfINY7Rx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5458111A108
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:08:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DCBD4198E;
 Thu,  4 Jun 2026 14:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56C21F00899;
 Thu,  4 Jun 2026 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780582131;
 bh=LSMTqyeIz6gzNQSzJ/4NFZxbHUY5X8rvlB7JVS4YLkM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QfINY7RxP4SoRE53ZD78jWh8B+C+KAgXTzDZ0ieRySyrnhS54HrsQ+GLle7mDeLiL
 6K17EoRvL3bP6e2nCh0DwnxuiPH3U5ya8D+BSDJxoAu1jrn7CyeDdFL7Cqxe8GLFgj
 hCctTQOBWutJQqZIn8O7/IY8bTZ88QNnXZmK8I765s8IanTUSJPorIen0wTbBLPoBr
 +7kGpaWR+M7zsGL5wqCEIbkAzFlv7mQsQ0nZvJsKByrfopp8p6UJnhGqA54gxmGKbJ
 VWmIa2JpEGvxwThErQ+IyP6g8QX+u0zXRS5cfxF6EtvUmankFDmyNbSAOcVfmdUyyh
 GYLClESi6eROw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 7/9] dt-bindings: npu: rockchip,rk3588-rknn-core:
 Add RK3568
To: "Midgy BALON" <midgy971@gmail.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260604135255.62682-8-midgy971@gmail.com>
References: <20260604135255.62682-8-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 14:08:50 +0000
Message-Id: <20260604140850.C56C21F00899@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The value written to `RK_MMU_AUTO_GATING` sets bit 1 instead of cl=
earing it, contradicting the inline comment and hardware workaround logic.
- [High] The error handling path for `noc_init()` failure leaks the IOMMU g=
roup reference and leaves the device in an unbalanced PM runtime state.
- [High] A malformed device tree with excessive NPU core nodes triggers an =
out-of-bounds write in `rocket_probe()` array access.
- [High] The NOC bus de-idle sequence via the PMU is missing from the runti=
me PM resume path.
- [Medium] The `rockchip,pmu` property is functionally mandatory for RK3568=
 but is not added to the schema's conditional `required` list.

Pre-existing issues:
- [High] The clock names in the `core->clks` array are uninitialized before=
 being passed to `devm_clk_bulk_get()`, causing the framework to fetch the =
wrong clocks.
--

commit 6c61da961bed3360a99f625d4a3b1599e7bfe685
Author: Midgy BALON <midgy971@gmail.com>

    dt-bindings: npu: rockchip, rk3588-rknn-core: Add RK3568
   =20
    The RK3568 carries a single core of the same NVDLA-derived NPU IP as the
    RK3588. Add its compatible. On RK3568 the NPU NOC bus-idle and power
    gating are controlled through the system PMU rather than a dedicated
    register block.

> diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-c=
ore.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.=
yaml
> index caca2a4903cd1..af9936b32e9fe 100644
> --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
> +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
[ ... ]
> @@ -75,7 +83,15 @@ required:
>    - resets
>    - reset-names
>    - npu-supply
> -  - sram-supply
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: rockchip,rk3588-rknn-core
> +then:
> +  required:
> +    - sram-supply

[Severity: Medium]
Does the missing rockchip,pmu property from the conditional required block
cause incomplete device trees to pass validation?

The rockchip,pmu property is functionally mandatory for the
rockchip,rk3568-rknn-core variant as the driver unconditionally fails to pr=
obe
without it. Missing this mandatory property here could allow invalid device
trees to go undetected.

>  additionalProperties: false
> =20
> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index b3b2fa9ba645a..634f78dfe2887 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
[ ... ]
> @@ -83,6 +89,15 @@ int rocket_core_init(struct rocket_core *core)
>  		return err;
>  	}
> =20
> +	if (core->soc_data->noc_init) {
> +		err =3D core->soc_data->noc_init(core);
> +		if (err) {
> +			pm_runtime_put_sync(dev);
> +			rocket_job_fini(core);
> +			return err;
> +		}
> +	}

[Severity: High]
Does this error path leak the IOMMU group reference and leave the device in=
 an
unbalanced PM runtime state?

By returning directly after pm_runtime_put_sync() and rocket_job_fini(), the
code misses calling rocket_core_fini() which handles iommu_group_put(),
pm_runtime_disable(), and pm_runtime_dont_use_autosuspend().

> +
>  	version =3D rocket_pc_readl(core, VERSION);
>  	version +=3D rocket_pc_readl(core, VERSION_NUM) & 0xffff;
> =20
> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/=
rocket_device.c
> index 46e6ee1e72c5f..6186f4faa3a2a 100644
> --- a/drivers/accel/rocket/rocket_device.c
> +++ b/drivers/accel/rocket/rocket_device.c
[ ... ]
> @@ -27,17 +25,14 @@ struct rocket_device *rocket_device_init(struct platf=
orm_device *pdev,
>  	ddev =3D &rdev->ddev;
>  	dev_set_drvdata(dev, rdev);
> =20
> -	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
> -		if (of_device_is_available(core_node))
> -			num_cores++;
> -
> -	rdev->cores =3D devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_=
KERNEL);
> +	rdev->cores =3D devm_kcalloc(dev, soc_data->num_cores, sizeof(*rdev->co=
res),
> +				   GFP_KERNEL);

[Severity: High]
Can this code overflow rdev->cores[] if the device tree contains more NPU
nodes than soc_data->num_cores?

With this change, the array size is fixed to soc_data->num_cores, but
rocket_probe() in drivers/accel/rocket/rocket_drv.c is still called for eve=
ry
matching node. If there are too many nodes in the device tree, it appears
rocket_probe() will write out of bounds here:

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
    ...
	unsigned int core =3D rdev->num_cores;
    ...
	rdev->cores[core].rdev =3D rdev;
	rdev->cores[core].dev =3D &pdev->dev;
	rdev->cores[core].index =3D core;
    ...
}

>  	if (!rdev->cores)
>  		return ERR_PTR(-ENOMEM);
> =20
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..5a72d0b5f4dff 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
[ ... ]
> @@ -213,8 +219,64 @@ static void rocket_remove(struct platform_device *pd=
ev)
>  	}
>  }
> =20
> +/*
> + * On RK3568 the NPU NOC bus is gated and idle out of reset and must be
> + * powered on and de-idled through the PMU before the NPU is reachable. =
 PMU
> + * registers use a write-mask protocol: the upper 16 bits enable writes =
to the
> + * matching lower 16 bits.
> + *
> + * The NPU's high-speed clock is a PVTPLL managed by TF-A via SCMI and m=
ust be
> + * running before the NOC acknowledges the de-idle request.  Force a rea=
l SCMI
> + * rate change (an intermediate rate defeats the clock framework's
> + * unchanged-rate shortcut) now that the power domain is on and clocks e=
nabled.
> + */
> +#define ROCKET_RK3568_SCMI_CLK	2
> +
> +static int rk3568_noc_init(struct rocket_core *core)
> +{
> +	struct regmap *pmu;
> +	unsigned int val;
> +	int ret;
> +
> +	clk_set_rate(core->clks[ROCKET_RK3568_SCMI_CLK].clk, 600000000UL);
> +	clk_set_rate(core->clks[ROCKET_RK3568_SCMI_CLK].clk, 1000000000UL);

[Severity: High]
This is a pre-existing issue, but does this unintentionally alter the system
aclk rate?

Looking at rocket_core_init(), the core->clks array is passed to
devm_clk_bulk_get() without initializing the id strings:

drivers/accel/rocket/rocket_core.c:rocket_core_init() {
    ...
	err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
    ...
}

Because the id fields are NULL, the framework fetches the first DT clock
(aclk) for all elements. Calling clk_set_rate() here seems to alter the
system aclk frequency instead of the intended SCMI clock.

> +
> +	pmu =3D syscon_regmap_lookup_by_phandle(core->dev->of_node, "rockchip,p=
mu");
> +	if (IS_ERR(pmu))
> +		return dev_err_probe(core->dev, PTR_ERR(pmu),
> +				     "failed to get PMU regmap\n");
> +
> +	/* Power on the NPU power domain (PWR_GATE_SFTCON bit 1 =3D 0). */
> +	regmap_write(pmu, 0xa0, BIT(1 + 16));
> +
> +	/* Disable NPU NOC auto-idle (NOC_AUTO_CON0 bit 2). */
> +	regmap_write(pmu, 0x70, BIT(2 + 16));
> +
> +	/* Request NPU bus de-idle (BUS_IDLE_SFTCON0 bit 2 =3D 0). */
> +	regmap_write(pmu, 0x50, BIT(2 + 16));
> +
> +	/* Wait for the bus to report active (BUS_IDLE_ST bit 2 =3D 0). */
> +	ret =3D regmap_read_poll_timeout(pmu, 0x68, val, !(val & BIT(2)), 10, 1=
000);
> +	if (ret)
> +		dev_err(core->dev, "timed out waiting for NPU bus de-idle\n");
> +
> +	return ret;
> +}

[Severity: High]
Is a NOC bus de-idle sequence required in the runtime PM resume path as wel=
l?

If the generic power domain (genpd) powers off the NPU during runtime suspe=
nd,
the NOC bus idle state would reset. Currently, rocket_device_runtime_resume=
()
enables clocks but doesn't repeat this PMU de-idle sequence, which could le=
ave
the AXI bus gated and cause subsequent hardware accesses to hang or crash.

> +
>  static const struct rocket_soc_data rk3568_soc_data =3D {
>  	.num_cores =3D 1,
>  	.dma_bits =3D 32,
>  	.noc_init =3D rk3568_noc_init,
>  };
> =20
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 0013cf196c573..7d40ecb26123f 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -952,6 +952,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
> =20
>  	ret =3D rk_iommu_enable_paging(iommu);
> =20
> +	if (!ret) {
> +		/*
> +		 * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page-walker
> +		 * auto clock-gating; the walker's AXI master then loses its clock
> +		 * between transactions and a TLB-miss page walk never completes,
> +		 * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE).  Clear
> +		 * bit 1 (keep bit 0, the slave-port gate) once paging is enabled.
> +		 */
> +		for (i =3D 0; i < iommu->num_mmu; i++)
> +			rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, 0x2);

[Severity: High]
Will this write operation inadvertently set bit 1 instead of clearing it?

Writing 0x2 (binary 10) sets bit 1 and clears bit 0, which contradicts the
inline comment indicating that bit 1 should be cleared and bit 0 kept. This
appears to enable the buggy page-walker auto clock-gating and disable the
slave-port gate.

> +	}
> +
>  out_disable_stall:
>  	rk_iommu_disable_stall(iommu);
>  out_disable_clocks:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604135255.6268=
2-1-midgy971@gmail.com?part=3D7
