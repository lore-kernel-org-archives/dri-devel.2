Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BE3C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B749E10F924;
	Fri,  4 Sep 2026 13:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zh0z4Zhm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3EC10E1F1
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:15:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 711C2600CB;
 Fri,  4 Sep 2026 13:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1260A1F00A3F;
 Fri,  4 Sep 2026 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788527749;
 bh=ZKwYupZ1kzBHj34OTSCEmJrCYYFzf4rrBUQgf4nj6x0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zh0z4ZhmGYBYywNAct6LUy/JFuFu5RyrACIMLEV9wIgtP6HhmpInod/H8yDUMKW6P
 +70/6V6fHKnai+jJAT7SxR8XcqtWSURTVcPv95B79DgDbUMrYultLThU5YLfVtKXhw
 Xb16KYw3R1ZwWwFlKBfERlC8K5MI1nncuzFdHIfMtT4aTyc4FDTDSaUjsIT/Z9acoM
 dGTHcY09UppIT8WLSL5shmsvyID25fZMJ+xa8RGX4YibXCKS7QYw9Z6nTnlDsw7Z36
 kPFJwhRPXvjrG57aKUWQBT40kxZ2fiILImpX8M3/Bf7JAbFt1bESlZ+BOR5nY/huoq
 FZB1rqdX5SezA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: search every core slot when a core is
 removed
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904125936.26234-1-royalnet026@gmail.com>
References: <20260904125936.26234-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:15:48 +0000
Message-Id: <20260904131549.1260A1F00A3F@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-order core unbinding and subsequent rebinding corrupts the =
`rdev->cores` array, leading to heap out-of-bounds writes, memory corruptio=
n, and active cores being overwritten or ignored.
- [High] Repeated unbinding and rebinding of all cores permanently leaks th=
e global `struct rocket_device` and its associated devm-managed resources.
- [High] Concurrent probe and remove operations cause data races on the unp=
rotected global `rdev` pointer and `num_cores` counter.
- [High] Core unbinding destroys the DRM scheduler while existing open file=
 descriptors still hold references, leading to a Use-After-Free upon job su=
bmission.
- [High] `rocket_open` unconditionally accesses `cores[0]` for IOMMU domain=
 creation, leading to a crash if core 0 is unbound.
- [High] Global static `rdev` retains an `ERR_PTR` if `rocket_device_init` =
fails, causing a crash on subsequent probes.
- [High] Missing NULL check for `kmalloc_objs` in `rocket_job_open` causes =
a NULL pointer dereference on allocation failure.
- [High] The DRM device is prematurely exposed to userspace before its back=
ing cores are initialized, leading to a NULL pointer dereference on open.
--

commit d884827ebadaac3af5198fed539a2afc027a3c79
Author: Igor Paunovic <royalnet026@gmail.com>

accel/rocket: search every core slot when a core is removed

rocket_remove() decrements rdev->num_cores for each core it removes,
while find_core_for_dev() searches slots 0 to num_cores - 1. Record how
many slots were allocated and search all of them so every core is found on
removal.

>     num_cores never reaches zero, rocket_device_fini() never runs, and the
>     file-scoped rdev keeps pointing at a device that is going away. Bindi=
ng
>     the cores again starts from that stale count, because rocket_probe()
>     takes rdev->num_cores as the slot to fill.

[Severity: High]
This is a pre-existing issue, but is the file-scoped rdev pointer and its
num_cores counter protected against concurrent access?

If multiple core devices are probed or unbound concurrently via sysfs, could
threads race on if (rdev =3D=3D NULL) in rocket_probe(), potentially double-
initializing the device? Could they also race on rdev->num_cores++ or
rdev->num_cores--, corrupting the core array indexing?

>     Record how many slots were allocated and search all of them. Every co=
re
>     is then found on removal, num_cores reaches zero, the device is torn =
down
>     and a later bind starts from a clean rdev.

[Severity: High]
This is a pre-existing issue, but does unbinding all cores permanently leak
the global struct rocket_device and its associated devm-managed resources?

When all cores are removed, rocket_device_fini() is called, but it only
unregisters the DRM device. The allocations made with devm_drm_dev_alloc()
and devm_kcalloc() are tied to the global drm_dev platform device, which
is never destroyed during unbind. Since rdev is set to NULL, would a later
bind allocate a completely new device and permanently leak the previous
allocations?

[Severity: High]
This is also a pre-existing issue, but does tearing down the device and its
cores destroy the DRM scheduler while existing open file descriptors still
hold references to it?

When a core is removed, rocket_core_fini() calls rocket_job_fini(), which
executes drm_sched_fini(). If a user still holds an open DRM file descriptor
and submits a job via ioctl, would drm_sched_entity_push_job() operate on
the already destroyed scheduler and trigger a Use-After-Free?

>     This does not make unbinding a single core out of several work. probe
>     still takes num_cores as the slot to fill, so rebinding one core while
>     its siblings stay bound would write over a slot that is already in us=
e,
>     and rocket_open() still reaches for cores[0] whether or not anything =
is
>     there. Both of those want more thought than a fix should carry.

[Severity: High]
This is a pre-existing issue, but does leaving this unfixed allow memory
corruption? Because rocket_remove() doesn't clear the dev pointer or
compact the array, wouldn't subsequent out-of-order unbinds match stale
pointers since find_core_for_dev() now searches up to max_cores?

Also, because rocket_job_open() and sched_to_core() iterate strictly up to
num_cores, would they miss active cores that have been shifted past
num_cores - 1 and incorrectly read finalized schedulers from the torn down
slots?

[Severity: High]
Regarding rocket_open(), this is a pre-existing issue, but does leaving it
reaching for cores[0] allow an unprivileged user to trigger a kernel panic?

If a root user unbinds core 0, would a subsequent open of the DRM device no=
de
by any user crash when it unconditionally calls
rocket_iommu_domain_create(rdev->cores[0].dev)?

> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/=
rocket_device.c
> index 46e6ee1e72c5f..efd004194c1af 100644
> --- a/drivers/accel/rocket/rocket_device.c
> +++ b/drivers/accel/rocket/rocket_device.c
> @@ -31,6 +31,8 @@ struct rocket_device *rocket_device_init(struct platfor=
m_device *pdev,
>  		if (of_device_is_available(core_node))
>  			num_cores++;
> =20
> +	rdev->max_cores =3D num_cores;
> +
>  	rdev->cores =3D devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_=
KERNEL);
>  	if (!rdev->cores)
>  		return ERR_PTR(-ENOMEM);

[Severity: High]
This is a pre-existing issue, but if rocket_device_init() fails here (or
elsewhere) and returns an ERR_PTR, doesn't the global rdev pointer in
rocket_probe() retain that ERR_PTR?

Since rocket_probe() only checks if (rdev =3D=3D NULL) and does not reset it
on failure, would a subsequent bind attempt blindly dereference the ERR_PTR
when it accesses rdev->num_cores?

[Severity: High]
This is another pre-existing issue, but is the DRM device prematurely expos=
ed
to userspace during this initialization?

rocket_device_init() registers the DRM device via drm_dev_register(),
making it immediately visible to userspace. However, the first core's device
pointer (rdev->cores[core].dev) is only assigned in rocket_probe() after
rocket_device_init() returns. If an unprivileged user opens the device
during this window, would rocket_open() encounter a NULL pointer
dereference when it accesses cores[0].dev?

[Severity: High]
Finally, this is a pre-existing issue, but does rocket_job_open() correctly
handle memory allocation failures when creating the scheds array for these
cores?

It allocates the array using kmalloc_objs(*scheds, rdev->num_cores) but
fails to check if the returned pointer is NULL before executing
scheds[core] =3D &rdev->cores[core].sched;. Would this lead to a NULL point=
er
dereference on allocation failure?

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..2bcfe4ab3c68f 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -223,7 +223,7 @@ static int find_core_for_dev(struct device *dev)
>  {
>  	struct rocket_device *rdev =3D dev_get_drvdata(dev);
> =20
> -	for (unsigned int core =3D 0; core < rdev->num_cores; core++) {
> +	for (unsigned int core =3D 0; core < rdev->max_cores; core++) {
>  		if (dev =3D=3D rdev->cores[core].dev)
>  			return core;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904125936.2623=
4-1-royalnet026@gmail.com?part=3D1
