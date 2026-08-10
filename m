Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A73C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5053A10E84D;
	Mon, 10 Aug 2026 13:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fv2B1wsQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D0110E841
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:25:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D20A60052;
 Mon, 10 Aug 2026 13:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEBF1F000E9;
 Mon, 10 Aug 2026 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786368310;
 bh=DSIVuJOvkSdIJj8/7Ei9od/Yn2AH7odsK1UTwannEHg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fv2B1wsQnJXKVVegWtPFA458SMxahu8fXTpvB1VGvwTQWasfVykxEFvrJd1TIqBCy
 1VO4mitEfD7PHq3sxGShsH7z/I0gAfq8liGQhO4NWLskLz7n5Iqq7seBpNnF2gBCv3
 bGKs0h/tMZLuz4Uaj4uIoHKC8q7acoC4E+ePnaDHltWMuqB9o6xmbV73thTskJ0R7b
 wKYCCUgD2Lr6wwtkUhftA4CyKqCOheaodZmf2NjukH6KVgN3hQbA80NoAsBsrRHrNS
 gSe3szw/Hfi0ojgjKKNkQMvCBiVzX7PzDWZ+GPeS15+RLEx5erZyvlxOnjtsrHULvg
 XfcL/sr1blKgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/2] drm: add <linux/pm_runtime.h> where missing
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810131314.452865-2-vladimir.oltean@nxp.com>
References: <20260810131314.452865-1-vladimir.oltean@nxp.com>
 <20260810131314.452865-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 13:25:09 +0000
Message-Id: <20260810132510.4FEBF1F000E9@smtp.kernel.org>
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
- [High] The return value of pm_runtime_get_sync() is ignored in multiple D=
RM bridge functions, allowing hardware access to proceed even if the device=
 fails to power on.
- [High] Display bridge atomic_enable and atomic_pre_enable callbacks call =
sleeping functions (usleep_range, mutex_lock), violating atomic context inv=
ariants during non-blocking commits.
--

--- Patch [1]: [PATCH v9 1/2] drm: add <linux/pm_runtime.h> where missing -=
--
commit 480a50b0cdb420e6811072e4517e397225f3a7cf
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

drm: add <linux/pm_runtime.h> where missing
   =20
Multiple DRM bridge drivers use runtime PM operations without
including the proper header, instead relying on transitive inclusion
by <linux/phy/phy.h>.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 8d3d4a6e6ca25..a078bdb0b43c5 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>

[Severity: High]
This isn't a bug introduced by this patch, but while looking at runtime PM =
in
this file, I noticed that the return value of pm_runtime_get_sync() is igno=
red
in several places, allowing hardware access to proceed even if the device f=
ails
to power on.

For example, in analogix_dpaux_transfer():

	pm_runtime_get_sync(dp->dev);

	ret =3D analogix_dp_detect_hpd(dp);

And similarly in analogix_dpaux_wait_hpd_asserted() and
analogix_dp_set_bridge(). If pm_runtime_get_sync() returns a negative error
code, could proceeding to read or write hardware registers cause a synchron=
ous
external abort on ARM platforms?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential problem with
atomic contexts in this file.

In analogix_dp_bridge_atomic_enable(), there is a sleep loop:

	timeout_loop++;
	usleep_range(10, 11);

Since DRM atomic enable callbacks run in atomic context during non-blocking
commits, does calling usleep_range() here risk triggering
scheduling-while-atomic warnings or deadlocks?

> =20
>  #include <drm/bridge/analogix_dp.h>
>  #include <drm/display/drm_dp_aux_bus.h>

[ ... ]

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 504a3186ebb3a..c99151fdaf03d 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -32,6 +32,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/phy/phy-dp.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential problem
with atomic contexts in this driver.

In cdns_mhdp_atomic_enable(), the driver attempts to acquire a mutex:

	mutex_lock(&mhdp->link_mutex);

Since DRM atomic enable callbacks run in atomic context during non-blocking
commits, might this mutex_lock() call result in scheduling-while-atomic iss=
ues
when userspace triggers a non-blocking mode set?

>  #include <linux/slab.h>
>  #include <linux/wait.h>
> =20

[ ... ]

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index e2fc69fc51b60..59eef9697a5e5 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with atomic
contexts in this driver.

The samsung_dsim_init_link() function, which is called from
samsung_dsim_atomic_pre_enable(), uses usleep_range():

	samsung_dsim_write(dsi, DSIM_FIFOCTRL_REG, reg);

	usleep_range(9000, 11000);

Since DRM atomic pre-enable callbacks run in atomic context during non-bloc=
king
commits, could this sleep sequence cause system instability or deadlocks?

>  #include <linux/units.h>
> =20
>  #include <video/mipi_display.h>

[ ... ]

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index 68aa66915e8ac..a78de7eabd151 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -10,6 +10,7 @@
>  #include <linux/firmware.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pm_runtime.h>

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential problem
with atomic contexts in this driver.

In cdn_dp_bridge_atomic_enable(), the driver attempts to acquire a mutex:

	mutex_lock(&dp->lock);

Given that DRM atomic enable callbacks run in atomic context during non-blo=
cking
commits, is there a risk of scheduling-while-atomic bugs occurring from this
mutex_lock() call?

>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810131314.4528=
65-1-vladimir.oltean@nxp.com?part=3D1
