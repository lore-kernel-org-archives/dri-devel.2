Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB90C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADFCF10E45C;
	Sat, 12 Sep 2026 07:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iFIoIjmA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614FC10E45C
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:06:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3241641A80;
 Sat, 12 Sep 2026 07:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58491F000FF;
 Sat, 12 Sep 2026 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789196801;
 bh=vDB8t+SSzlD/WKelBuoHf+xaLYhj1gpYQMTiRUasn2U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iFIoIjmA3DpKVkHfPr2ZNXOM4efltgfANpHehGeBL6SnGpdxv028+Dsc5Ix7jvo/Q
 C9ERGDlAfu8rWTT+t1gzHSuTyuEhVhLoM81j14O6fOHQObIF+wgchMV0gjJLIf1aVm
 xuM0ac3OIH32bDNT93cUfjBYjZSdB80/vYe7dMAr82Er4jZSQIDbPeZAynVFJkxYOi
 A2xqkK0sVZ13xHD9znWmWoo3ldJpzIIfBPMwgg1ORbwgBBXug8LvTEJHNCnl8inY26
 c9m5hK/TSSFn6gR+l2CXIPpa3WjdyshNaOlWg737ldFuxykObE60e4rRI6OsX0rl2L
 JGpt4U3Uek+bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/14] accel/rocket: select the per-core clock and
 reset counts from match data
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260912065053.1519165-12-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
 <20260912065053.1519165-12-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 07:06:40 +0000
Message-Id: <20260912070640.C58491F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [High] Failure to clear the global `rdev` pointer on an error path leads =
to an error pointer dereference on subsequent probe attempts.
- [High] Removing and re-probing cores out of order will corrupt the state =
of active cores and leak resources due to flawed `rdev->num_cores` indexing.
- [High] Resources allocated using `devm_*` APIs on the global dummy `drm_d=
ev` are permanently leaked when cores are unbound or when initialization fa=
ils.
- [High] The global `rdev` pointer and `rdev->num_cores` state are accessed=
 and modified without synchronization during concurrent probes.
- [High] The DRM device is exposed to userspace before core initialization =
completes, leading to a NULL pointer dereference on early open().
- [High] Asynchronous tasks and IRQs are not canceled/disabled before destr=
oying the DRM scheduler.
--

commit 699632a47b8954e3644c77059cfdba18cb1c898b
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: select the per-core clock and reset counts from match data

This patch updates the RKNN block driver to read clock and reset counts from
per-SoC match data instead of using compile-time constants. This accommodat=
es
SoCs like the RK3576 which have different hardware requirements than the RK=
3588.
The arrays sizing logic is also updated to use the dynamically provided cou=
nts.

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..7ed64c131e9cb 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -159,8 +159,22 @@ static const struct drm_driver rocket_drm_driver =3D=
 {
> =20
>  static int rocket_probe(struct platform_device *pdev)
>  {
> +	const struct rocket_soc_data *soc =3D of_device_get_match_data(&pdev->d=
ev);
>  	int ret;
> =20
> +	/*
> +	 * soc is dereferenced without a check by every one of its users, and
> +	 * rocket_core_init() below is the first of them. A device that bound
> +	 * by name rather than by compatible has no match data, so fail before
> +	 * anything is allocated rather than at the first dereference: the
> +	 * number of cores comes from a walk of matching DT nodes, and a device
> +	 * with no of_node was never counted by it.
> +	 */
> +	if (!soc) {
> +		dev_err(&pdev->dev, "no match data for this device\n");
> +		return -ENODEV;
> +	}
> +
>  	if (rdev =3D=3D NULL) {
>  		/* First core probing, initialize DRM device. */
>  		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver);

[Severity: High]
This isn't a bug introduced by this patch, but if rocket_device_init() fails
during the first core's probe, it returns an error pointer which is assigned
to the global rdev pointer:

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
  ...
  if (IS_ERR(rdev)) {
    dev_err(&pdev->dev, "failed to initialize rocket device\n");
    return PTR_ERR(rdev);
  }
  ...
}

Could a subsequent probe attempt bypass the rdev =3D=3D NULL check and dere=
ference
the error pointer when accessing rdev->num_cores?

[Severity: High]
This is a pre-existing issue, but do devm_* resources allocated on the glob=
al
dummy drm_dev leak when cores are unbound?

drivers/accel/rocket/rocket_device.c:rocket_device_init() {
  ...
  rdev =3D devm_drm_dev_alloc(dev, rocket_drm_driver, struct rocket_device,
                            ddev);
  ...
}

When all cores are unbound, rocket_device_fini() unregisters the DRM device
and sets the global rdev to NULL. Since the global drm_dev is never destroy=
ed,
does this permanently leak the struct rocket_device, core arrays, and mutex=
es?

[Severity: High]
This is a pre-existing issue, but are the global rdev pointer and
rdev->num_cores state protected against concurrent probes?

If multiple RKNN cores are probed concurrently via sysfs bind, could multip=
le
threads observe rdev =3D=3D NULL simultaneously, leading to multiple
initializations of the DRM device and races when modifying the cores array?

[Severity: High]
This isn't a bug introduced by this patch, but is the DRM device exposed to
userspace before core initialization completes?

rocket_device_init() registers the DRM device via drm_dev_register(), making
it visible to userspace. If userspace opens the device immediately:

drivers/accel/rocket/rocket_drv.c:rocket_open() {
  ...
  rocket_priv->domain =3D rocket_iommu_domain_create(rdev->cores[0].dev);
  ...
}

Could this lead to a NULL pointer dereference in iommu_paging_domain_alloc()
since rocket_probe() hasn't populated rdev->cores[0].dev yet?

[ ... ]

> @@ -176,6 +190,7 @@ static int rocket_probe(struct platform_device *pdev)
> =20
>  	rdev->cores[core].rdev =3D rdev;
>  	rdev->cores[core].dev =3D &pdev->dev;
> +	rdev->cores[core].soc =3D soc;
>  	rdev->cores[core].index =3D core;
> =20
>  	rdev->num_cores++;

[Severity: High]
This is a pre-existing issue, but does using rdev->num_cores as an array
index corrupt the state of active cores when devices are removed and
re-probed out of order?

If core 0 is unbound via sysfs, rocket_remove() decrements rdev->num_cores
without shifting the rdev->cores[] array:

drivers/accel/rocket/rocket_drv.c:rocket_remove() {
  ...
  rdev->num_cores--;
  ...
}

A subsequent unbind of core 1 would fail because find_core_for_dev() shrinks
its search bounds to the new num_cores. If a new core is then probed, it us=
es
the decremented num_cores as the index:

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
  ...
  unsigned int core =3D rdev->num_cores;
  ...
  rdev->cores[core].rdev =3D rdev;
  ...
}

Would this overwrite the active state of core 1?

[Severity: High]
This is a pre-existing issue, but are asynchronous tasks and IRQs canceled
before destroying the DRM scheduler?

In rocket_job_fini(), drm_sched_fini() is called to tear down the DRM
scheduler before canceling the background work:

drivers/accel/rocket/rocket_job.c:rocket_job_fini() {
  ...
  drm_sched_fini(&core->sched);
   =20
  cancel_work_sync(&core->reset.work);
  destroy_workqueue(core->reset.wq);
  ...
}

If the background reset.work executes concurrently, it calls
rocket_reset_work() which issues drm_sched_start() on a scheduler that is
already destroyed. Could this lead to a use-after-free or list corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912065053.1519=
165-1-gahing@gahingwoo.com?part=3D11
