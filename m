Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A93ACD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8001610ECC6;
	Sat, 13 Jun 2026 07:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RVWmZaIS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E4F10ECC6
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 07:11:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EBF3600AF;
 Sat, 13 Jun 2026 07:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0553B1F000E9;
 Sat, 13 Jun 2026 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781334711;
 bh=ODrHQX2Ep381eoCIb9oEeJ+a4T9W7kFsZW2BfgK55fg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RVWmZaIS5iETVkc671NV+lCLkMUOHyBLpwSshtHHs9PCWSkvVWlvke2/XA2gX8UD3
 M3vV5oHZRVny/7nRUV7cjZE6IUFsxefnXLhXv6KVqCdsarMQTnC6BbrTJyg8ZW3+Zr
 Fd+OEiF9MkvdRuTMmMEBoL4+kyM55EENugD8ujJIHyVURDfp5l99TYm42PSJi0CKl1
 MAMIs6KZW910h/WMS7FgBBhtOKzCpKvr9+07XtyT2WXa4WYbSGtTsJUw4euN5/sLmi
 2nXaFyVrr/5YEK5qQB11GLi/OPWTW01BwN8miWVMdb33QQg24yfpJD9IL21D7JPN9R
 C8ZuqI1C9kOsw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 3/9] accel: rocket: Add RK3568 SoC support
To: MidG971 <midgy971@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260613070116.438906-4-midgy971@gmail.com>
References: <20260613070116.438906-4-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:11:50 +0000
Message-Id: <20260613071151.0553B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] `pm_runtime_put_sync()` fails to suspend the device synchronously =
due to active autosuspend, leaking runtime PM state when `noc_init` fails.
- [High] `rk3568_noc_init()` ignores `clk_set_rate()` failures and incorrec=
tly uses short-circuiting logic, allowing initialization to proceed with an=
 inactive compute clock.
- [High] The RK3568 NPU compute clock (PVTPLL) is not restarted during runt=
ime resume, leading to a hardware hang.

Pre-existing issues:
- [High] Uninitialized bulk clock IDs cause the driver to silently fail at =
managing the NPU's actual clocks, fetching the identical default clock repe=
atedly.
- [High] `devm_drm_dev_alloc()` memory is leaked on probe deferral because =
it is allocated on a global facade device.
--

commit 18b5e0abd4d8cdab9122360b8a9bd630b4573645
Author: Midgy BALON <midgy971@gmail.com>

accel: rocket: Add RK3568 SoC support
   =20
The RK3568 has a single core of the same NVDLA-derived NPU IP as the
RK3588, with a 32-bit AXI master.  Add rk3568_soc_data and its
compatible.
   =20
Unlike the RK3588, the RK3568 NPU's compute clock is a PVTPLL managed by
TF-A via SCMI; start it from an noc_init callback with a real rate change
(an intermediate rate defeats the clock framework's unchanged-rate
shortcut).  Powering on and de-idling the NPU NoC are left to the power
domain (genpd), which performs them when the IOMMU supplier is resumed,
so the driver does not poke the PMU directly.
   =20
If noc_init fails, unwind through rocket_core_fini() so the core is torn
down completely rather than leaking the runtime-PM and IOMMU state.

> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index 09c445af7de73..779e951596a15 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -88,6 +88,15 @@ int rocket_core_init(struct rocket_core *core)
>  		return err;
>  	}
> =20
> +	if (core->soc_data->noc_init) {
> +		err =3D core->soc_data->noc_init(core);
> +		if (err) {
> +			pm_runtime_put_sync(dev);

[Severity: High]
Does this error path leak the runtime PM state?

Since rocket_core_init() enables autosuspend via pm_runtime_use_autosuspend=
(),
calling pm_runtime_put_sync() behaves asynchronously and schedules an
autosuspend timer instead of suspending immediately.

Then rocket_core_fini() calls pm_runtime_disable() which cancels pending
timers without suspending the device. Does this leave the device permanently
in the RPM_ACTIVE state and keep the power domain powered on?

> +			rocket_core_fini(core);
> +			return err;
> +		}
> +	}
> +
>  	version =3D rocket_pc_readl(core, VERSION);
>  	version +=3D rocket_pc_readl(core, VERSION_NUM) & 0xffff;

[ ... ]

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index f0beed2d522c7..86484110ad6f0 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c

[ ... ]

> @@ -223,12 +224,42 @@ static void rocket_remove(struct platform_device *p=
dev)
>  	}
>  }
> =20
> +/*
> + * The NPU compute clock is a PVTPLL managed by TF-A via SCMI; spin it up
> + * with a real rate change (an intermediate rate defeats the clock
> + * framework's unchanged-rate shortcut).  Powering on and de-idling the =
NPU
> + * NoC are handled by the power domain (genpd) before the NPU is accesse=
d.
> + */
> +static int rk3568_noc_init(struct rocket_core *core)
> +{
> +	struct clk *npu_clk;
> +
> +	npu_clk =3D of_clk_get_by_name(core->dev->of_node, "npu");
> +	if (IS_ERR(npu_clk))
> +		return dev_err_probe(core->dev, PTR_ERR(npu_clk),
> +				     "failed to get the NPU SCMI clock\n");
> +
> +	if (clk_set_rate(npu_clk, 600000000UL) ||
> +	    clk_set_rate(npu_clk, 1000000000UL))

[Severity: High]
Does this logical OR prevent the second rate change from executing if the
first one fails?

If clk_set_rate() fails for the first call, the short-circuiting logic will
prevent the second clk_set_rate() from running.

> +		dev_warn(core->dev, "failed to set the NPU compute clock rate\n");
> +	clk_put(npu_clk);
> +
> +	return 0;

[Severity: High]
Should this return an error code if the clock rate fails to set?

Returning 0 here allows initialization to proceed even if the compute clock
is inactive. When rocket_core_init() subsequently reads the NPU VERSION
register over the AXI bus, will this cause a system hang due to the
inactive clock?

> +}

[Severity: High]
This isn't a bug introduced by this patch, but does rocket_core_init() fail
to properly initialize the bulk clock IDs?

When rdev->cores is allocated with devm_kcalloc(), the core->clks array is
initialized with NULL pointers for the .id fields.=20

When rocket_core_init() later fetches the clocks:

	err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);

With NULL .id strings, clk_get() will repeatedly fetch the first clock list=
ed
in the device tree's clocks property for all elements. Does this leave the
other NPU clocks unmanaged and potentially disabled, leading to AXI bus
hangs?

[Severity: High]
This isn't a bug introduced by this patch, but is there a memory leak in the
probe deferral path for devm_drm_dev_alloc()?

In rocket_device_init(), rdev is allocated on the global drm_dev:

    rdev =3D devm_drm_dev_alloc(drm_dev->dev, ...);

If rocket_core_init() fails (e.g. returning -EPROBE_DEFER), rocket_probe()
clears the rdev pointer but the devm resources are tied to the static global
drm_dev which is never removed.=20

When probe is retried, does this result in allocating a new struct
rocket_device and leaking the previous allocation permanently?

[Severity: High]
Does the driver fail to restart the NPU compute clock during runtime resume?

During runtime suspend, the NPU power domain (DOMAIN_RK3568) is powered off
and the PVTPLL loses state.=20

On runtime resume, rocket_device_runtime_resume() enables the bulk clocks:

    err =3D clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks),
                                  rdev->cores[core].clks);

But it doesn't re-apply the rate-change sequence used in rk3568_noc_init() =
to
force TF-A to spin the clock up. Will this cause the hardware to hang on the
next NPU access because the compute clock remains off?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613070116.4389=
06-1-midgy971@gmail.com?part=3D3
