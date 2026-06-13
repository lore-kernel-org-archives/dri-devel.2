Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD5ACD98D2
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1932510ECBE;
	Sat, 13 Jun 2026 07:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XhBP/2Nf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB26210ECBE
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 07:09:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 170D860018;
 Sat, 13 Jun 2026 07:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D1D1F000E9;
 Sat, 13 Jun 2026 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781334596;
 bh=LllGNlIctgRpFkMe6kZ0cZis/unjKDzySoabPYqAJQU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XhBP/2NfT7Oza1BkefenP5hDKBDPcAOPdZ9lw2RiNMSNJMwwoPEYU3dBqetVaUpbn
 7WRGl2o33MHxabhMRZOgJUY/b8qJXJsgxgS//2wm9IMXTWXKqFwBSoyKixpEtolPma
 qNno1ieIp5kVDUaq6ynrlCfNECu7faaTM/7DeKgtm6vdicyf7ZtKnaXmHxbkqA7IuI
 NO1wz+whpxnszVNMO8DgNO32MuxAQq8wnqXhdeBZCqrGqn1PUZtIn7wDiKptWpS32b
 TOY8EvH0Yz33X8A4EuHIcXBI93j6Ka/0mpJubpyTdatCUMQb6WBpLVzBEqf5gyrDFx
 9OmhY4lilhsxA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/9] accel: rocket: Derive DMA width and core
 count from match data
To: MidG971 <midgy971@gmail.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260613070116.438906-3-midgy971@gmail.com>
References: <20260613070116.438906-3-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:09:56 +0000
Message-Id: <20260613070956.90D1D1F000E9@smtp.kernel.org>
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
- [High] The bounds check for the 'cores' array uses the current node's mat=
ch data rather than the allocated capacity, allowing an out-of-bounds write=
 if the device tree has mixed compatible strings.

Pre-existing issues:
- [High] If `rocket_device_init()` fails, the global `rdev` pointer is left=
 containing an `ERR_PTR`, causing a kernel panic on subsequent core probes.
- [High] Global DRM device and core arrays are allocated using `devm_` help=
ers tied to the first probed core's lifecycle, causing a Use-After-Free whe=
n that core is unbound.
- [High] Removing and re-probing NPU cores out of order corrupts the 'cores=
' array because 'num_cores' is incorrectly used as both an active count and=
 the array index.
- [High] Missing locking around the global `rdev` initialization and `rdev-=
>num_cores` access allows concurrent probes to corrupt device tracking and =
leak allocations.
- [High] The DRM device is registered before its hardware cores are fully i=
nitialized, allowing userspace to trigger a NULL pointer dereference.
--

commit a4289515ae9af5aaa001a280a8b52c1288f26e24
Author: Midgy BALON <midgy971@gmail.com>
One line subject: accel: rocket: Derive DMA width and core count from match=
 data

The probe already has the per-SoC match data, which now records the core
count and DMA width. This patch uses it for the cores array allocation and
the device DMA mask instead of re-scanning the device tree for available
core nodes. It also rejects a device tree that declares more NPU core nodes
than the SoC has to prevent overrun.

> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/=
rocket_device.c
> index 46e6ee1e72c5f..6186f4faa3a2a 100644
> --- a/drivers/accel/rocket/rocket_device.c
> +++ b/drivers/accel/rocket/rocket_device.c
> @@ -6,18 +6,16 @@
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
> -#include <linux/of.h>
> =20
>  #include "rocket_device.h"
> =20
>  struct rocket_device *rocket_device_init(struct platform_device *pdev,
> -					 const struct drm_driver *rocket_drm_driver)
> +					 const struct drm_driver *rocket_drm_driver,
> +					 const struct rocket_soc_data *soc_data)
>  {
>  	struct device *dev =3D &pdev->dev;
> -	struct device_node *core_node;
>  	struct rocket_device *rdev;
>  	struct drm_device *ddev;
> -	unsigned int num_cores =3D 0;
>  	int err;
> =20
>  	rdev =3D devm_drm_dev_alloc(dev, rocket_drm_driver, struct rocket_devic=
e, ddev);
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
This is a pre-existing issue, but does using devres tied to the first
probed core's lifecycle cause a use-after-free when that core is unbound?

If userspace unbinds this first core via sysfs, rocket_remove() decrements
num_cores but does not explicitly clean up the DRM device because other
cores are still bound. Upon returning from remove, the driver core
automatically frees all devres tied to the first core's device. This
would destroy the global rdev memory, causing a use-after-free when any
remaining cores attempt to access it.

[Severity: High]
This is a pre-existing issue, but does registering the DRM device
before its hardware cores are fully initialized allow userspace to
trigger a NULL pointer dereference?

In rocket_device_init(), the driver calls drm_dev_register() to expose
the character device to userspace. This occurs before the caller,
rocket_probe(), populates rdev->cores[0].dev and initializes the hardware.

If userspace opens the device during this small timing window,
rocket_open() is called and invokes:

    rocket_iommu_domain_create(rdev->cores[0].dev);

Since the device pointer is still NULL, this would attempt to dereference
a NULL device pointer in the IOMMU subsystem, crashing the system.

[ ... ]

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 384c38e13acce..f0beed2d522c7 100644
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
This is a pre-existing issue, but does the lack of locking around the global
rdev initialization allow concurrent probes to corrupt device tracking
and leak memory?

If concurrent probes occur (for example, via asynchronous probing or
concurrent sysfs binds), multiple threads can pass this if check,
causing multiple DRM device allocations. They can also read the same
num_cores value, leading both threads to overwrite the same index in the
rdev->cores array.

>  		/* First core probing, initialize DRM device. */
> -		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver);
> +		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver, soc_data);
>  		if (IS_ERR(rdev)) {
>  			dev_err(&pdev->dev, "failed to initialize rocket device\n");
>  			return PTR_ERR(rdev);

[Severity: High]
This is a pre-existing issue, but does this error path leave the global
rdev pointer containing an ERR_PTR?

If rocket_device_init() fails, it returns an error pointer which is
assigned to the global rdev. The function then returns the error but fails
to reset rdev to NULL.

When the next core probes, the (rdev =3D=3D NULL) check is bypassed, and the
driver immediately dereferences the error pointer when reading
rdev->num_cores:

    unsigned int core =3D rdev->num_cores;

Could this lead to a reproducible kernel panic?

> @@ -172,6 +176,12 @@ static int rocket_probe(struct platform_device *pdev)
> =20
>  	unsigned int core =3D rdev->num_cores;
> =20
> +	if (core >=3D soc_data->num_cores) {

[Severity: High]
Does this bounds check use the current node's capacity rather than the
array's actual allocated size?

The array rdev->cores is permanently allocated using soc_data->num_cores
from the first probed device in rocket_device_init(). However, this bounds
check evaluates against the soc_data of the current probing device.

If a device tree or overlay declares a node with a smaller num_cores
followed by one with a larger num_cores, the check will pass for an index
that exceeds the initial allocation size. Will this cause a direct
out-of-bounds write into the rdev->cores array, corrupting kernel memory?

> +		dev_err(&pdev->dev, "too many NPU core nodes (max %u)\n",
> +			soc_data->num_cores);
> +		return -EINVAL;
> +	}
> +
>  	dev_set_drvdata(&pdev->dev, rdev);
> =20
>  	rdev->cores[core].rdev =3D rdev;

[Severity: High]
This is a pre-existing issue, but does removing and re-probing NPU cores
out of order corrupt the cores array?

When a core is removed, rocket_remove() decrements rdev->num_cores
without shifting the remaining cores in the array to close the gap:

    rdev->num_cores--;

If cores are removed out of order, active cores are left at indices equal
to or greater than the new num_cores. The driver later uses num_cores as its
search bound, making those trailing active cores unreachable.

Furthermore, if a new core is probed, it assigns itself to the index
rdev->num_cores, blindly overwriting a still-active core:

    rdev->cores[core].rdev =3D rdev;

Could this cause state corruption and resource leaks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613070116.4389=
06-1-midgy971@gmail.com?part=3D2
