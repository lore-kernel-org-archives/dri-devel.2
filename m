Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E19C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F07310EC39;
	Wed, 29 Jul 2026 13:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q/OrKSDV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B58A10EC39
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:22:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF30A41990;
 Wed, 29 Jul 2026 13:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4731F000E9;
 Wed, 29 Jul 2026 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785331333;
 bh=AZ1yPPrl2P0u7w9cdReJbg5gscSANvY1BwyeTTrXNIY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q/OrKSDVS5W8aNJKpqPLoYnmOwXKU7B+/QWfyxZ6FqxiSFrkANpIBBtq7uA+Ghc4V
 wcFLI6uCrTYRua4xQFfCKrykDbu3EZcZ3ZGSiRDeYTcqhQZp3OohQxEF8EPN0rfEMs
 +vR58seSsbSnBzfqobIFF8rH6Myeiv/YuXJ3JmbRmoV2LBEVPfUaqTZFjzPL9Ukg9z
 RMa7XS3kxvUXU2SNXkMd5823DgmCtFfWoYcltTKyEhixLqNBfaKWetOq+90PlnGtT8
 iZy6h291+83BBHndo70kkHE2jz3MTRQQ5arX6iejZtHDI9AhAQ8Bi+UhJEHSwBV5Ll
 IC5rSsG+2uZxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/rocket: request the core clocks by name
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729130743.128876-1-royalnet026@gmail.com>
References: <20260729130743.128876-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 13:22:12 +0000
Message-Id: <20260729132213.4D4731F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] If `rocket_device_init` fails during the first core's probe, t=
he global `rdev` pointer is left as an `ERR_PTR` rather than being reset to=
 `NULL`, causing a kernel panic on subsequent probes.
- [High] The driver leaks the shared `rdev` and `rdev->cores` structures up=
on probe deferral or failure.
- [High] The driver incorrectly uses `rdev->num_cores` both as a count of a=
ctive cores and as the boundary index, causing state corruption and resourc=
e leaks upon out-of-order unbind.
--

--- Patch [1]: [PATCH v2] accel/rocket: request the core clocks by name ---
commit 4687ac2abf99b6ec4120f9d98c0f4148fc2a6b97
Author: Igor Paunovic <royalnet026@gmail.com>
accel/rocket: request the core clocks by name

This commit fixes clock initialization by setting the proper names for the
"aclk", "hclk", "npu", and "pclk" clocks before requesting them. Previously,
all four clocks defaulted to index 0, which meant only the AXI clock was
controlled by the driver.

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
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", c=
ore->index);

[Severity: High]
This isn't a bug introduced by this patch, but this devm_clk_bulk_get() call
can defer probe. If rocket_core_init() fails here, I noticed a potential=20
memory leak in the cleanup path.

In drivers/accel/rocket/rocket_device.c:rocket_device_init(), the rdev=20
structure is allocated via devres attached to the static drm_dev device:

drivers/accel/rocket/rocket_device.c:rocket_device_init() {
...
	rdev =3D devm_drm_dev_alloc(dev, rocket_drm_driver, struct rocket_device, =
ddev);
...
}

However, if probe fails, drivers/accel/rocket/rocket_drv.c:rocket_probe()=20
abandons it without freeing the devres:

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
...
		if (rdev->num_cores =3D=3D 0) {
			rocket_device_fini(rdev);
			rdev =3D NULL;
		}
...
}

Since drm_dev is never unbound while the module is loaded, does this leak=20
the rdev and rdev->cores structures on every probe deferral?

[Severity: Critical]
This is a pre-existing issue, but looking at the error handling in=20
drivers/accel/rocket/rocket_drv.c:rocket_probe():

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
...
	if (rdev =3D=3D NULL) {
		/* First core probing, initialize DRM device. */
		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver);
		if (IS_ERR(rdev)) {
			dev_err(&pdev->dev, "failed to initialize rocket device\n");
			return PTR_ERR(rdev);
		}
	}

	unsigned int core =3D rdev->num_cores;
...
}

If rocket_device_init() returns an error, rdev is left holding an ERR_PTR=20
instead of being reset to NULL. Will a subsequent probe attempt try to=20
dereference the poisoned rdev pointer when evaluating rdev->num_cores?

[Severity: High]
This is a pre-existing issue, but does the driver mishandle out-of-order=20
unbinds?=20

In drivers/accel/rocket/rocket_drv.c:find_core_for_dev(), num_cores is used
as a strict upper bound:

drivers/accel/rocket/rocket_drv.c:find_core_for_dev() {
...
	for (unsigned int core =3D 0; core < rdev->num_cores; core++) {
		if (dev =3D=3D rdev->cores[core].dev)
			return core;
	}
...
}

If an earlier core is unbound, num_cores is decremented. If a higher-indexe=
d=20
core is then unbound, find_core_for_dev() won't search far enough to find i=
t.=20

Furthermore, if another core is then bound, rocket_probe() inserts it using=
=20
num_cores as the index:

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
...
	rdev->cores[core].rdev =3D rdev;
	rdev->cores[core].dev =3D &pdev->dev;
...
}

Could this overwrite an active higher-indexed core that was never properly=
=20
cleaned up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729130743.1288=
76-1-royalnet026@gmail.com?part=3D1
