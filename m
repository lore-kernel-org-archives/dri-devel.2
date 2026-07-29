Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E44C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD97410EB41;
	Wed, 29 Jul 2026 09:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sltf1plp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6707810EB41
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 09:40:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA14D600B1;
 Wed, 29 Jul 2026 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA631F00A3A;
 Wed, 29 Jul 2026 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785318021;
 bh=YafjRvKWI0IWpJsZk4570M/5u4BOm9bbbYmMUDZLDAI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Sltf1plpAbLCPf6kKxZGavnI5ltNRvfOTtZYupMxQHbm/Sxeot7vOqhyOg42RbJnS
 +SJEpfLuOqhe25ZOPNYe7nvXsQnGsMukMOvYa5vvyK9QExK86SWGJLVA98DndIrSjl
 dXj9UPU9YKeOuiPVkUj20H5WE+Kv1zk5ZzFdVpFy6xrzxjzp1F9azPYhWsawValWNw
 +uxbi9IVediXJ8VnfGQnJ0iWflRBSey9F+xN5VyP/aN0nTt35HdZXEQe+fXo5mX5hV
 JcCHt8pKMO/xUOJSK/PsKKaLEbX6yPe2n5NrDAIEBZ8txLn8qQRMIpkA6yD2cF1Lx1
 nnPVvs6s7t99A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: request the core clocks by name
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729092939.118779-1-royalnet026@gmail.com>
References: <20260729092939.118779-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 09:40:20 +0000
Message-Id: <20260729094021.3DA631F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but probe failure or=
 probe deferral causes a devres memory leak on the global facade device (dr=
m_dev).
- [High] This problem wasn't introduced by this patch, but the interrupt ha=
ndler leaks an IOMMU group reference on every job completion.
--

--- Patch [1]: [PATCH] accel/rocket: request the core clocks by name ---
commit e7950f0bb8935713c990dc5f57ac6b5f0568e5dc
Author: Igor Paunovic <royalnet026@gmail.com>
accel/rocket: request the core clocks by name

This commit updates the rocket driver to explicitly request the core
clocks by name (aclk, hclk, npu, pclk). This ensures the correct clocks
are prepared and enabled during runtime power management, preventing a
latent issue where the driver held no reference to the actual NPU clock.

> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index b3b2fa9ba645a..5dd260bacbff6 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -28,6 +28,10 @@ int rocket_core_init(struct rocket_core *core)
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get resets for core %d\n", c=
ore->index);
> =20
> +	core->clks[0].id =3D "aclk";
> +	core->clks[1].id =3D "hclk";
> +	core->clks[2].id =3D "npu";
> +	core->clks[3].id =3D "pclk";
>  	err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);

[Severity: High]
This isn't a bug introduced by this patch, but does the increased likelihood
of probe deferral here expose a devres memory leak?

In rocket_device_init(), rdev and rdev->cores are allocated via devm_ on the
global drm_dev:

drivers/accel/rocket/rocket_device.c:rocket_device_init() {
    ...
    rdev =3D devm_drm_dev_alloc(dev, rocket_drm_driver, struct rocket_devic=
e, ddev);
    ...
    rdev->cores =3D devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_=
KERNEL);
    ...
}

If devm_clk_bulk_get() returns -EPROBE_DEFER, rocket_probe() cleans up by
calling rocket_device_fini() and nullifies rdev:

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
    ...
    err =3D rocket_core_init(core);
    if (err) {
        rocket_device_fini(rdev);
        rdev =3D NULL;
        ...
    }
    ...
}

Because drm_dev is a global platform device that is never unbound, the devr=
es
allocations remain attached to it. On the next probe retry, new allocations
are made, leaking the previous ones.

[Severity: High]
This problem wasn't introduced by this patch, but does the interrupt handler
leak an IOMMU group reference on every job completion?

Looking at rocket_job_handle_irq(), when a job finishes, it detaches the
IOMMU group:

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
    ...
    iommu_detach_group(NULL, iommu_group_get(core->dev));
    ...
}

The iommu_group_get() function increments the IOMMU group's reference count,
but a matching iommu_group_put() is never called. Because this is a hot path
triggered by hardware interrupts, the reference count will quickly overflow,
permanently leaking the structure.=20

Could the driver use its cached core->iommu_group pointer here instead,=20
similar to how it is handled in rocket_reset()?

>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", c=
ore->index);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729092939.1187=
79-1-royalnet026@gmail.com?part=3D1
