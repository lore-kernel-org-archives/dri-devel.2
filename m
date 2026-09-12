Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F86C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE6F10E42D;
	Sat, 12 Sep 2026 07:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jd6FQmy3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2192910E42D
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:03:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C948C415B6;
 Sat, 12 Sep 2026 07:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696351F000FF;
 Sat, 12 Sep 2026 07:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789196601;
 bh=j9qx35s3quuS2FKYSk+NhNhqnpAllV5c/aAT/YY8D4o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jd6FQmy3121CB5OaF+Tsu6raPfsgYCdnQpdCF0R8S4vfJbEJERP39zsSYabymrN79
 TMnvoWSOc5aqhNA08nbFB6PQbRnSXXutEHqXATI/Tv0FWTAYVtltTbps+GjpvlzhJl
 v+G6cRLadMLkaFVMzxnJO+BdH0+9RNC6LgkoMDFtE1AwC8J5Hl1yI5xMgrGKXthy+r
 974zRuPMe1n/oUz/kSpK1Kye6sG2A8XjekPfEQrmhZmqPKx3XGT/W1VgHcCnt9ouJB
 RVtYO4yYMjKATG00wiF7lhJR59CSSMUTK7YbVlogw1eV+F7meaq+zv16Ma3GBdGscI
 9e6z+a7UCqWMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/14] accel/rocket: request the core clocks by name
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260912065053.1519165-2-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
 <20260912065053.1519165-2-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 07:03:21 +0000
Message-Id: <20260912070321.696351F000FF@smtp.kernel.org>
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
- [High] Probe deferral, missing clocks, or device unbind leaks devres allo=
cations attached to the global `drm_dev`.
- [High] Incorrect core tracking logic in `rocket_remove` and `rocket_probe=
` causes active cores to be orphaned, unreachable, or silently overwritten =
upon partial unbind.
--

commit 4baecbc1d36cdb2c0321f080e879383800570708
Author: Igor Paunovic <royalnet026@gmail.com>

accel/rocket: request the core clocks by name

This patch fixes an issue where the NPU driver failed to set the .id members
of its clk_bulk_data struct before requesting them. Without IDs, clk_bulk_g=
et
defaulted to returning the first clock in the device tree for all entries. =
The
clocks are now properly requested by name as required by the DT binding.

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
This is a pre-existing issue, but does this failure path cause an unbounded
resource leak if devm_clk_bulk_get() defers probe or fails?

If rocket_core_init() fails here, rocket_probe() cleans up by calling
rocket_device_fini() and setting the global rdev pointer to NULL:

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
    ...
	ret =3D rocket_core_init(&rdev->cores[core]);
	if (ret) {
		rdev->num_cores--;

		if (rdev->num_cores =3D=3D 0) {
			rocket_device_fini(rdev);
			rdev =3D NULL;
		}
	}
    ...
}

However, rdev and its cores array are allocated in rocket_device_init() usi=
ng
devm_* functions attached to drm_dev, which is a static global device:

drivers/accel/rocket/rocket_device.c:rocket_device_init() {
    ...
	rdev =3D devm_drm_dev_alloc(dev, rocket_drm_driver, struct rocket_device, =
ddev);
    ...
	rdev->cores =3D devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_KER=
NEL);
    ...
}

Because drm_dev is global and persists across probe deferrals, its devres
list is never cleared. When rocket_probe() executes again, a new rdev is
allocated on the same global device, permanently leaking the previous one.

[Severity: High]
This is also a pre-existing issue, but if this failure path is hit (or if a
core is unbound via sysfs), does the core tracking logic in rocket_remove()
and rocket_probe() orphan the remaining active cores?

If a core other than the most-recently-probed one fails or unbinds,
rocket_remove() blindly decrements rdev->num_cores:

drivers/accel/rocket/rocket_drv.c:rocket_remove() {
    ...
	rocket_core_fini(&rdev->cores[core]);
	rdev->num_cores--;
    ...
}

Without shifting array elements to compact the list, active cores located
past the shrunken num_cores boundary can no longer be found for teardown or
power management:

drivers/accel/rocket/rocket_drv.c:find_core_for_dev() {
    ...
	for (unsigned int core =3D 0; core < rdev->num_cores; core++) {
		if (dev =3D=3D rdev->cores[core].dev)
			return core;
	}
    ...
}

This could cause power management callbacks to fail with -ENODEV while the
hardware is still running. Furthermore, if a new core binds later,
rocket_probe() will insert it at rdev->num_cores, which could silently
overwrite the live context of the stranded core.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912065053.1519=
165-1-gahing@gahingwoo.com?part=3D1
