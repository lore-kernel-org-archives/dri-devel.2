Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B144DCD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 16:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F021128DC;
	Thu,  4 Jun 2026 16:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ESiBGNLI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBD91128DC
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 16:55:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 024074335B;
 Thu,  4 Jun 2026 16:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AF81F00893;
 Thu,  4 Jun 2026 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780592134;
 bh=KFK59Iuxfm39UpQWPx7lBY9nYyQCimcNM2GPkU1XEAQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ESiBGNLIYj8jlcCfFvrhqb4xi9eHgkZbuQb/QSrRALC8wxvdbu/wbxJheZqyNmU4d
 jJTUHwK7nB4fzeY7388X4eyypS81XlZsS4sAh4h2alwOiFkhOva0HpVqQsShvVW5MW
 LbN5HalVvZ/iZfNrvGpO0C3tVxem+nHaif/98S1IJcX4lUjn5d4KaUk+/sQ6ID0GYX
 hXTcQNY4XrlGZxtL0RxF1SBOIbuA18v1+H+Apa7/3OV65d4BbbZDqnpSRxqUW4Gx1T
 W3AzRFmHQ7vtPhO2E0RURQBBfSQruoBUBEu8GCfPEdfY8XPrSwmCKvwmFhAFh7FSw+
 4U61S2XK5UVKA==
Date: Thu, 4 Jun 2026 17:55:31 +0100
From: Conor Dooley <conor@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Midgy BALON <midgy971@gmail.com>, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 7/9] dt-bindings: npu: rockchip,rk3588-rknn-core:
 Add RK3568
Message-ID: <20260604-disparate-encircle-2de02c0885d0@spud>
References: <20260604135255.62682-8-midgy971@gmail.com>
 <20260604140850.C56C21F00899@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dh0UPhkfjL/WP3lO"
Content-Disposition: inline
In-Reply-To: <20260604140850.C56C21F00899@smtp.kernel.org>
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


--dh0UPhkfjL/WP3lO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 02:08:50PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issu=
e(s) to consider:
>=20
> New issues:
> - [High] The value written to `RK_MMU_AUTO_GATING` sets bit 1 instead of =
clearing it, contradicting the inline comment and hardware workaround logic.
> - [High] The error handling path for `noc_init()` failure leaks the IOMMU=
 group reference and leaves the device in an unbalanced PM runtime state.
> - [High] A malformed device tree with excessive NPU core nodes triggers a=
n out-of-bounds write in `rocket_probe()` array access.
> - [High] The NOC bus de-idle sequence via the PMU is missing from the run=
time PM resume path.
> - [Medium] The `rockchip,pmu` property is functionally mandatory for RK35=
68 but is not added to the schema's conditional `required` list.
>=20
> Pre-existing issues:
> - [High] The clock names in the `core->clks` array are uninitialized befo=
re being passed to `devm_clk_bulk_get()`, causing the framework to fetch th=
e wrong clocks.
> --
>=20
> commit 6c61da961bed3360a99f625d4a3b1599e7bfe685
> Author: Midgy BALON <midgy971@gmail.com>
>=20
>     dt-bindings: npu: rockchip, rk3588-rknn-core: Add RK3568
>    =20
>     The RK3568 carries a single core of the same NVDLA-derived NPU IP as =
the
>     RK3588. Add its compatible. On RK3568 the NPU NOC bus-idle and power
>     gating are controlled through the system PMU rather than a dedicated
>     register block.
>=20
> > diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn=
-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-cor=
e.yaml
> > index caca2a4903cd1..af9936b32e9fe 100644
> > --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.y=
aml
> > +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.y=
aml
> [ ... ]
> > @@ -75,7 +83,15 @@ required:
> >    - resets
> >    - reset-names
> >    - npu-supply
> > -  - sram-supply
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: rockchip,rk3588-rknn-core
> > +then:
> > +  required:
> > +    - sram-supply
>=20
> [Severity: Medium]
> Does the missing rockchip,pmu property from the conditional required block
> cause incomplete device trees to pass validation?
>=20
> The rockchip,pmu property is functionally mandatory for the
> rockchip,rk3568-rknn-core variant as the driver unconditionally fails to =
probe
> without it. Missing this mandatory property here could allow invalid devi=
ce
> trees to go undetected.

This looks valid. Additionally, the condition should forbid this
property on rk3588.
pw-bot: changes-requested
>=20
> >  additionalProperties: false
> > =20
> > diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/=
rocket_core.c

Why is the bot commenting on driver stuff here?

Cheers,
Conor.

> > index b3b2fa9ba645a..634f78dfe2887 100644
> > --- a/drivers/accel/rocket/rocket_core.c
> > +++ b/drivers/accel/rocket/rocket_core.c
> [ ... ]
> > @@ -83,6 +89,15 @@ int rocket_core_init(struct rocket_core *core)
> >  		return err;
> >  	}
> > =20
> > +	if (core->soc_data->noc_init) {
> > +		err =3D core->soc_data->noc_init(core);
> > +		if (err) {
> > +			pm_runtime_put_sync(dev);
> > +			rocket_job_fini(core);
> > +			return err;
> > +		}
> > +	}
>=20
> [Severity: High]
> Does this error path leak the IOMMU group reference and leave the device =
in an
> unbalanced PM runtime state?
>=20
> By returning directly after pm_runtime_put_sync() and rocket_job_fini(), =
the
> code misses calling rocket_core_fini() which handles iommu_group_put(),
> pm_runtime_disable(), and pm_runtime_dont_use_autosuspend().
>=20
> > +
> >  	version =3D rocket_pc_readl(core, VERSION);
> >  	version +=3D rocket_pc_readl(core, VERSION_NUM) & 0xffff;
> > =20
> > diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocke=
t/rocket_device.c
> > index 46e6ee1e72c5f..6186f4faa3a2a 100644
> > --- a/drivers/accel/rocket/rocket_device.c
> > +++ b/drivers/accel/rocket/rocket_device.c
> [ ... ]
> > @@ -27,17 +25,14 @@ struct rocket_device *rocket_device_init(struct pla=
tform_device *pdev,
> >  	ddev =3D &rdev->ddev;
> >  	dev_set_drvdata(dev, rdev);
> > =20
> > -	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
> > -		if (of_device_is_available(core_node))
> > -			num_cores++;
> > -
> > -	rdev->cores =3D devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GF=
P_KERNEL);
> > +	rdev->cores =3D devm_kcalloc(dev, soc_data->num_cores, sizeof(*rdev->=
cores),
> > +				   GFP_KERNEL);
>=20
> [Severity: High]
> Can this code overflow rdev->cores[] if the device tree contains more NPU
> nodes than soc_data->num_cores?
>=20
> With this change, the array size is fixed to soc_data->num_cores, but
> rocket_probe() in drivers/accel/rocket/rocket_drv.c is still called for e=
very
> matching node. If there are too many nodes in the device tree, it appears
> rocket_probe() will write out of bounds here:
>=20
> drivers/accel/rocket/rocket_drv.c:rocket_probe() {
>     ...
> 	unsigned int core =3D rdev->num_cores;
>     ...
> 	rdev->cores[core].rdev =3D rdev;
> 	rdev->cores[core].dev =3D &pdev->dev;
> 	rdev->cores[core].index =3D core;
>     ...
> }
>=20
> >  	if (!rdev->cores)
> >  		return ERR_PTR(-ENOMEM);
> > =20
> > diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/r=
ocket_drv.c
> > index 8bbbce594883e..5a72d0b5f4dff 100644
> > --- a/drivers/accel/rocket/rocket_drv.c
> > +++ b/drivers/accel/rocket/rocket_drv.c
> [ ... ]
> > @@ -213,8 +219,64 @@ static void rocket_remove(struct platform_device *=
pdev)
> >  	}
> >  }
> > =20
> > +/*
> > + * On RK3568 the NPU NOC bus is gated and idle out of reset and must be
> > + * powered on and de-idled through the PMU before the NPU is reachable=
=2E  PMU
> > + * registers use a write-mask protocol: the upper 16 bits enable write=
s to the
> > + * matching lower 16 bits.
> > + *
> > + * The NPU's high-speed clock is a PVTPLL managed by TF-A via SCMI and=
 must be
> > + * running before the NOC acknowledges the de-idle request.  Force a r=
eal SCMI
> > + * rate change (an intermediate rate defeats the clock framework's
> > + * unchanged-rate shortcut) now that the power domain is on and clocks=
 enabled.
> > + */
> > +#define ROCKET_RK3568_SCMI_CLK	2
> > +
> > +static int rk3568_noc_init(struct rocket_core *core)
> > +{
> > +	struct regmap *pmu;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	clk_set_rate(core->clks[ROCKET_RK3568_SCMI_CLK].clk, 600000000UL);
> > +	clk_set_rate(core->clks[ROCKET_RK3568_SCMI_CLK].clk, 1000000000UL);
>=20
> [Severity: High]
> This is a pre-existing issue, but does this unintentionally alter the sys=
tem
> aclk rate?
>=20
> Looking at rocket_core_init(), the core->clks array is passed to
> devm_clk_bulk_get() without initializing the id strings:
>=20
> drivers/accel/rocket/rocket_core.c:rocket_core_init() {
>     ...
> 	err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
>     ...
> }
>=20
> Because the id fields are NULL, the framework fetches the first DT clock
> (aclk) for all elements. Calling clk_set_rate() here seems to alter the
> system aclk frequency instead of the intended SCMI clock.
>=20
> > +
> > +	pmu =3D syscon_regmap_lookup_by_phandle(core->dev->of_node, "rockchip=
,pmu");
> > +	if (IS_ERR(pmu))
> > +		return dev_err_probe(core->dev, PTR_ERR(pmu),
> > +				     "failed to get PMU regmap\n");
> > +
> > +	/* Power on the NPU power domain (PWR_GATE_SFTCON bit 1 =3D 0). */
> > +	regmap_write(pmu, 0xa0, BIT(1 + 16));
> > +
> > +	/* Disable NPU NOC auto-idle (NOC_AUTO_CON0 bit 2). */
> > +	regmap_write(pmu, 0x70, BIT(2 + 16));
> > +
> > +	/* Request NPU bus de-idle (BUS_IDLE_SFTCON0 bit 2 =3D 0). */
> > +	regmap_write(pmu, 0x50, BIT(2 + 16));
> > +
> > +	/* Wait for the bus to report active (BUS_IDLE_ST bit 2 =3D 0). */
> > +	ret =3D regmap_read_poll_timeout(pmu, 0x68, val, !(val & BIT(2)), 10,=
 1000);
> > +	if (ret)
> > +		dev_err(core->dev, "timed out waiting for NPU bus de-idle\n");
> > +
> > +	return ret;
> > +}
>=20
> [Severity: High]
> Is a NOC bus de-idle sequence required in the runtime PM resume path as w=
ell?
>=20
> If the generic power domain (genpd) powers off the NPU during runtime sus=
pend,
> the NOC bus idle state would reset. Currently, rocket_device_runtime_resu=
me()
> enables clocks but doesn't repeat this PMU de-idle sequence, which could =
leave
> the AXI bus gated and cause subsequent hardware accesses to hang or crash.
>=20
> > +
> >  static const struct rocket_soc_data rk3568_soc_data =3D {
> >  	.num_cores =3D 1,
> >  	.dma_bits =3D 32,
> >  	.noc_init =3D rk3568_noc_init,
> >  };
> > =20
> > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-io=
mmu.c
> > index 0013cf196c573..7d40ecb26123f 100644
> > --- a/drivers/iommu/rockchip-iommu.c
> > +++ b/drivers/iommu/rockchip-iommu.c
> > @@ -952,6 +952,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
> > =20
> >  	ret =3D rk_iommu_enable_paging(iommu);
> > =20
> > +	if (!ret) {
> > +		/*
> > +		 * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page-walker
> > +		 * auto clock-gating; the walker's AXI master then loses its clock
> > +		 * between transactions and a TLB-miss page walk never completes,
> > +		 * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE).  Clear
> > +		 * bit 1 (keep bit 0, the slave-port gate) once paging is enabled.
> > +		 */
> > +		for (i =3D 0; i < iommu->num_mmu; i++)
> > +			rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, 0x2);
>=20
> [Severity: High]
> Will this write operation inadvertently set bit 1 instead of clearing it?
>=20
> Writing 0x2 (binary 10) sets bit 1 and clears bit 0, which contradicts the
> inline comment indicating that bit 1 should be cleared and bit 0 kept. Th=
is
> appears to enable the buggy page-walker auto clock-gating and disable the
> slave-port gate.
>=20
> > +	}
> > +
> >  out_disable_stall:
> >  	rk_iommu_disable_stall(iommu);
> >  out_disable_clocks:
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260604135255.62682=
-1-midgy971@gmail.com?part=3D7

--dh0UPhkfjL/WP3lO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiGuAwAKCRB4tDGHoIJi
0tP2APsE0I8hlUQjHx6Q+YvbRR/+e/YnDowmSE1/fsVgdf9L0QD8DVc8XQUWO/SB
GAZtg/sxgRg9xhV6De0JBbj2zYDMBww=
=lOwb
-----END PGP SIGNATURE-----

--dh0UPhkfjL/WP3lO--
