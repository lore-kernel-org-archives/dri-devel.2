Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5275C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E0810E30D;
	Sun, 16 Aug 2026 14:22:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IkxOimCg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D4810E30D
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 14:22:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE1D740503;
 Sun, 16 Aug 2026 14:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BF31F000E9;
 Sun, 16 Aug 2026 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786890125;
 bh=DBQvGg8JH2zzX4H370i8mdL8y1P8q3oyIm63hRx5I8c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IkxOimCgsTac4X4NrpC76H1dSiq9abI/h1dWDIW4PnZJieXi4UCI0OSXWLpqFGWbP
 AtL/LJfOMlr/EkCSCrn2HYyUWRtdoL8HhLkd0nuQ8xxllDFmKf+7IN1S7xcwJZmDgY
 nfHYsQopUEipzvXbXjzgi7fWPlFwIIFUQkI8UbH9xfv9DYGUaJu7oCl0Wk+ogn4c3T
 Hw2WxCDMyZsFSm6ADsNXw60qgUyT7773Om2KUVN4IsEvz7/JOCWvoH4uzVPDJ0rjzx
 6IzNJyUaXH45EWSryuK0gITjFAwIaJTANe4AZa6NmHDo1KGv/lJbKJi+FXdSdmFrGd
 o6PP9ref4lYtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/vc4: Use the reset controller to recover from a
 GPU hang
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260816-vc4-reset-control-v1-3-896444373716@igalia.com>
References: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
 <20260816-vc4-reset-control-v1-3-896444373716@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 14:22:05 +0000
Message-Id: <20260816142205.72BF31F000E9@smtp.kernel.org>
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
- [Critical] Removing the fallback GPU power-cycle reset mechanism breaks G=
PU hang recovery and introduces a critical DMA Use-After-Free vulnerability=
 on older device trees lacking a reset line.

Pre-existing issues:
- [High] The hangcheck timer and associated work items are never canceled d=
uring device teardown, leading to a Use-After-Free if they execute after th=
e DRM device is freed.
- [High] Requesting exclusive resources using `devm_` APIs inside a compone=
nt `bind` callback causes re-bind operations to fail with -EBUSY.
--

--- Patch [3]: [PATCH 3/4] drm/vc4: Use the reset controller to recover fro=
m a GPU hang ---
commit 1ede01913981622e3c76606cafec272dc32b7700
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Use the reset controller to recover from a GPU hang

vc4_reset() recovers a hung GPU by dropping the runtime PM usage count to
zero so that the power domain goes down, and then taking it again. Such an
unconventional approach only works if the driver knows exactly how many
references it holds, which is why vc4 wrapped every pm_runtime_get_sync()
call in a private refcount and mutex.

Commit 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains
under a new binding.") exposed a V3D reset line for exactly this reason,
so that the block can be reset without power-cycling its domain, but the
vc4 driver never picked it up. Use it now, which removes the need for the
private refcount and leaves vc4_v3d_pm_get/put() as plain runtime PM
wrappers.

The reset line is optional, to accommodate older device trees. Device
trees that do not describe one still get the driver-side recovery in
vc4_irq_reset(), but the hardware is left untouched. Two in-tree platforms
use the VC4 V3D block: BCM2835 gains the resets property in the next
commit, and Cygnus is no worse off than it was, as its V3D node has no
power domain and the power-cycle only ever gated its clock.

Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index e231c906709c1..3212b91676201 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c

[ ... ]

> @@ -292,19 +292,22 @@ vc4_save_hang_state(struct drm_device *dev)
>  static void
>  vc4_reset(struct drm_device *dev)
>  {
> -	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +	struct vc4_v3d *v3d =3D to_vc4_dev(dev)->v3d;
> +	int ret;
> =20
> -	DRM_INFO("Resetting GPU.\n");
> +	vc4_irq_disable(dev);
> =20
> -	mutex_lock(&vc4->power_lock);
> -	if (vc4->power_refcount) {
> -		/* Power the device off and back on the by dropping the
> -		 * reference on runtime PM.
> -		 */
> -		pm_runtime_put_sync_suspend(&vc4->v3d->pdev->dev);
> -		pm_runtime_get_sync(&vc4->v3d->pdev->dev);
> +	if (v3d->reset) {
> +		drm_info(dev, "Resetting GPU.\n");
> +
> +		ret =3D reset_control_reset(v3d->reset);
> +		if (ret)
> +			drm_err(dev, "Failed to reset the GPU: %d\n", ret);
> +
> +		vc4_v3d_init_hw(dev);
> +	} else {
> +		drm_info_once(dev, "No reset line; GPU state is not reset.\n");
>  	}
> -	mutex_unlock(&vc4->power_lock);
> =20
>  	vc4_irq_reset(dev);

[Severity: Critical]
Does removing the fallback GPU power-cycle reset mechanism break GPU hang
recovery and introduce a DMA use-after-free regression on older device
trees lacking a reset line?

If the device tree lacks a reset line, vc4_reset() skips resetting the
hardware since v3d->reset is NULL, but still proceeds to call
vc4_irq_reset().

This cancels the active software jobs, unreferences their buffer objects,
and frees the backing memory in vc4_irq_reset() and vc4_cancel_bin_job().
Because the GPU hardware was not actually stopped or reset, it
asynchronously continues executing the hanging command stream and performs
DMA reads/writes into the newly freed memory pages.

Could this memory corruption be triggered by any unprivileged user that
submits a hanging shader?

[ ... ]

> @@ -1177,10 +1189,6 @@ int vc4_gem_init(struct drm_device *dev)
> =20
>  	INIT_WORK(&vc4->job_done_work, vc4_job_done_work);
> =20
> -	ret =3D drmm_mutex_init(dev, &vc4->power_lock);
> -	if (ret)
> -		return ret;
> -
>  	INIT_LIST_HEAD(&vc4->purgeable.list);

[Severity: High]
This is a pre-existing issue, but is there a use-after-free regression
because the hangcheck timer and associated work items are never canceled
during device teardown?

In vc4_gem_init(), the driver initializes the hangcheck.timer,
hangcheck.reset_work, and job_done_work.

However, neither vc4_gem_destroy() nor vc4_irq_disable() appears to
cancel these asynchronous workers using del_timer_sync() or
cancel_work_sync().

If the driver is unloaded or unbound while a hangcheck timer is pending
or work is scheduled, will the callbacks fire after the vc4_dev memory
has been freed, leading to a kernel panic?

> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> index 379ab77243ad3..d2da8d2f8eebb 100644
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c

[ ... ]

> @@ -447,6 +427,14 @@ static int vc4_v3d_bind(struct device *dev, struct d=
evice *master, void *data)
>  	if (IS_ERR(v3d->clk))
>  		return dev_err_probe(dev, PTR_ERR(v3d->clk), "Failed to get V3D clock\=
n");
> =20
> +	v3d->reset =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(v3d->reset))
> +		return dev_err_probe(dev, PTR_ERR(v3d->reset),
> +				     "Failed to get reset control\n");
> +
> +	if (!v3d->reset)
> +		drm_warn(drm, "No V3D reset line in the device tree");
> +
>  	ret =3D platform_get_irq(pdev, 0);
>  	if (ret < 0)
>  		return ret;

[Severity: High]
This is a pre-existing issue, but does requesting exclusive resources using
devm_ APIs inside a component bind callback cause re-bind operations to
fail with -EBUSY?

The vc4_v3d_bind() function uses devm_ APIs attached to the component's
device (pdev->dev). When the component unbinds, these resources are not
freed because the platform device itself is not removed.

If the DRM master defers probing and retries, or is unbound and rebound,
vc4_v3d_bind() is called again. Does the second attempt to acquire
exclusive resources like the reset control fail with -EBUSY, permanently
breaking V3D initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816-vc4-reset-=
control-v1-0-896444373716@igalia.com?part=3D3
