Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FE4C88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF8F10E333;
	Tue, 15 Sep 2026 21:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kyTn/ecl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B804E10E333
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:04:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A138C43C65;
 Tue, 15 Sep 2026 21:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B2C1F000FF;
 Tue, 15 Sep 2026 21:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789506285;
 bh=yOArcJ6FJStKqf4vOcIAf8R0Cidqirwn7AJemKfu75k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kyTn/ecluGKS04vLMueqQ2/x7gw06/rjxhAGxfZUhoUpM0QztQBr1GqLGg0Kw+/pF
 FKgK4lS90C8sCZV2k8IE8y7Orclw9/H4zhrAou/VXa7O5VZjmJTZZcm4K2u3KOTp1u
 QQ4a2qwy7FVP1jpasQCIzqv36oLap2t0cNNL+ZehSdVftGf3hGjxlDmZAiD0ae1Tuu
 gqm1ysg1YUWCe75oOWROfVrvKQEEf4Ook4W6/PF94lTk2BIj3oBm3I3e2R9cJuhalQ
 sn3H9rIPj0uZ1FN4ZVyOLohboGdv9yt8XOUlVL9nCpw8dc6bT87j99RDWZZ2ByWUol
 Ri/Pew4RIzpug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/vc4: Use the reset controller to recover
 from a GPU hang
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260915-vc4-reset-control-v2-3-cb3a25b07822@igalia.com>
References: <20260915-vc4-reset-control-v2-0-cb3a25b07822@igalia.com>
 <20260915-vc4-reset-control-v2-3-cb3a25b07822@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 21:04:44 +0000
Message-Id: <20260915210445.42B2C1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/vc4: UAF in vc4_job_done_work() due to missing hardware reset
- [Medium] drm/vc4: component re-bind fails due to devm_reset_control in bi=
nd
--

commit 8ebe4ef2282246bb3aa856ccf103a302ccfae13f
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Use the reset controller to recover from a GPU hang

This patch switches the GPU recovery mechanism from a runtime PM power cycle
to using a dedicated V3D reset line. It also leaves the runtime PM wrapper
functions as simple passthroughs and makes the reset line optional for older
device trees.

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

[Severity: High]
Does this create a use-after-free on older device trees where v3d->reset is
NULL?=20

By removing the runtime PM suspend/resume cycle, the hardware is no longer
reset on older platforms. However, the driver continues to unconditionally
call vc4_irq_reset() which cancels jobs and finishes render jobs:

vc4_irq_reset()
  vc4_cancel_bin_job(dev)
  vc4_irq_finish_render_job(dev)

These routines signal the job fences and schedule vc4_job_done_work, which
frees the GEM memory. If the GPU hardware is still executing because the
reset was skipped, won't it asynchronously access this freed memory when it
eventually makes progress?

[ ... ]
> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> index a86739873e05b..b40d98c9d1d28 100644
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

[Severity: Medium]
Will this cause component re-bind operations to fail?

Since devm allocations are tied to the device's initial probe lifecycle rat=
her
than the component bind/unbind lifecycle, the exclusive reset control is not
released when the component is unbound.=20

If the DRM master device is unbound and then rebound, wouldn't a subsequent
bind attempt fail with -EBUSY because the leaked initial allocation still
holds the exclusive lock on the reset line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-vc4-reset-=
control-v2-0-cb3a25b07822@igalia.com?part=3D3
