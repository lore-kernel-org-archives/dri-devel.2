Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206ACCD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8511811A0FA;
	Thu,  4 Jun 2026 14:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ccOdxQhX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F2811A0FD
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:05:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13FBB4322F;
 Thu,  4 Jun 2026 14:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42DB1F00893;
 Thu,  4 Jun 2026 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780581954;
 bh=48DX+aMBE741hgDWAbkQnn56pJcNUQbIcpFxw4bqeEA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ccOdxQhXgPpCOi6jiMcYV6dsLMnXvjEA2wAhEIahAJKBY6lqzX/fy26W2y/LHQvov
 Yr5loTLru7TXlRuXYT3IJq7cb3W7rD0apBBvC6nu3O2egbNLajMldcseZnupbPLms5
 gnl5ax82bovjsRBIshilCqPbIpnWeM/cb3RXLqkt3QjMdXpYBJQPkbkxnRytLkpbbk
 Yaop1m1GLk0iRfjenrTngfK7tMCTiVui+z45UNX/ftMZUY/DeFHHJmyvQwh9N3jnhe
 kSBIyYyILBS25J8uM2bxxYyM2TZ2bzeFIXaQtFQdTzV9nwcEmc4DR6wua5draxkcI9
 nvCNquHTLRA0A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/9] accel: rocket: Derive DMA width and core
 count from match data
To: "Midgy BALON" <midgy971@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260604135255.62682-3-midgy971@gmail.com>
References: <20260604135255.62682-3-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 14:05:53 +0000
Message-Id: <20260604140553.A42DB1F00893@smtp.kernel.org>
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
- [High] Missing bounds check on `rdev->num_cores` against `soc_data->num_c=
ores` causes an out-of-bounds array write.

Pre-existing issues:
- [Critical] Early registration of the DRM device creates a race window lea=
ding to a NULL pointer dereference in `rocket_open`.
- [High] Array indexing mismatch on unbind/rebind causes state corruption a=
nd failed lookups.
- [High] Race condition during global device initialization and array modif=
ication due to lack of locking.
- [High] Failure in `rocket_device_init()` leaves an `ERR_PTR` in the globa=
l `rdev` variable, causing a panic on the next probe.
--

commit d76917aa771a1a958c02a6121211647bc25a0160
Author: Midgy BALON <midgy971@gmail.com>

accel: rocket: Derive DMA width and core count from match data

The probe already has the per-SoC match data, which now records the core
count and DMA width.  Use it for the cores array allocation and the
device DMA mask instead of re-scanning the device tree for available core
nodes.

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

[Severity: Critical]
This is a pre-existing issue, but does rocket_device_init() register the
DRM device prematurely?

The first core to probe invokes rocket_device_init(), which immediately cal=
ls
drm_dev_register() at the end of the function. This exposes the DRM device =
to
userspace before the caller can initialize the core array elements.

If userspace quickly opens the DRM device node:

rocket_open()
  rocket_iommu_domain_create(rdev->cores[0].dev)

Since the device pointer in the array has not yet been assigned in
rocket_probe() and is still NULL, this results in a NULL pointer dereferenc=
e.

>  	if (!rdev->cores)
>  		return ERR_PTR(-ENOMEM);
> =20
>  	dma_set_max_seg_size(dev, UINT_MAX);
> =20
> -	err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> +	err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(soc_data->dma_bits)=
);
>  	if (err)
>  		return ERR_PTR(err);
> =20
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 384c38e13acce..c18840e5aff76 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -159,11 +159,15 @@ static const struct drm_driver rocket_drm_driver =
=3D {
> =20
>  static int rocket_probe(struct platform_device *pdev)
>  {
> +	const struct rocket_soc_data *soc_data =3D of_device_get_match_data(&pd=
ev->dev);
>  	int ret;
> =20
> +	if (!soc_data)
> +		return -EINVAL;
> +
>  	if (rdev =3D=3D NULL) {

[Severity: High]
This isn't a bug introduced by this patch, but does this lack locking?

The kernel driver core can probe multiple matching rockchip,rk3588-rknn-core
devices in parallel. Concurrent probes could observe rdev =3D=3D NULL
simultaneously, instantiating the DRM device multiple times and leaking
memory. Additionally, concurrent reads and increments of rdev->num_cores can
cause multiple threads to overwrite the same array slot in rdev->cores[]
while leaving others uninitialized.

>  		/* First core probing, initialize DRM device. */
> -		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver);
> +		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver, soc_data);

[Severity: High]
This is a pre-existing issue, but what happens if rocket_device_init() fail=
s?

If rocket_device_init() returns an error pointer, it is directly assigned to
the global rdev variable. The error path correctly returns the error but
fails to reset the static global rdev back to NULL. When the driver core
invokes rocket_probe() for the next matching device tree node, the
rdev =3D=3D NULL check evaluates to false because rdev contains an error po=
inter.
The probe will then attempt to access rdev->num_cores, causing an invalid
pointer dereference.

>  		if (IS_ERR(rdev)) {
>  			dev_err(&pdev->dev, "failed to initialize rocket device\n");
>  			return PTR_ERR(rdev);
>  		}
>  	}

[Severity: High]
Can this cause an out-of-bounds array write?

The allocation of the rdev->cores array now uses a fixed size defined by
soc_data->num_cores instead of dynamically counting the device tree nodes.
However, rocket_probe() is called by the driver core for every matching DT
node, and it unconditionally uses the auto-incrementing rdev->num_cores as
the array index later in the function.

If a malformed or custom device tree contains more core nodes than
soc_data->num_cores, rocket_probe() will be invoked more times than the arr=
ay
can hold, writing past the end of the rdev->cores buffer.

[ ... ]
> @@ -214,6 +218,7 @@ static void rocket_remove(struct platform_device *pde=
v)
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the array indexing hand=
le
unbind and rebind correctly?

When a core is unbound, rocket_remove() decrements rdev->num_cores without
compacting the remaining active cores in the rdev->cores array to fill the
empty slot. Consequently, find_core_for_dev() (which relies on
rdev->num_cores for its loop bound) fails to find any remaining cores
located at indices >=3D the new rdev->num_cores, preventing their cleanup.

Furthermore, if a core is re-bound, rocket_probe() will use the decremented
rdev->num_cores as the index and overwrite an existing active core, causing
resource leaks and state corruption.

> =20
>  static const struct rocket_soc_data rk3588_soc_data =3D {
> +	.num_cores =3D 3,
>  	.dma_bits =3D 40,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604135255.6268=
2-1-midgy971@gmail.com?part=3D2
