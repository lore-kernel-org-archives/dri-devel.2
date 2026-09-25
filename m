Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F41C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E91310E136;
	Fri, 25 Sep 2026 18:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i2ivh1RE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5BA710E136
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:57:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D12D41FD4;
 Fri, 25 Sep 2026 18:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ABA1F000FF;
 Fri, 25 Sep 2026 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790362630;
 bh=9urLjBbQJqV31l/GSLtRwGuRLaQxggmfvjvuH0G7Maw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i2ivh1REKx85SsuATt/+OceiC76n4xZlUc0xTp86oc9etEn8po6V57dX2bnEjDPn0
 o3sbqxRiKGrQh9Lcm80qrCWfaExABcSQn/a/h6knd/x+HhtxmKTvwuBae5kAhucgf1
 tX0XWPUenMR96CwIvzslr163yfV5j9QSM6wSjOH9J3I+OLxjfzcxy+ysC67Wru97ox
 2NA4mpLTSJhrtArfVJhevIZohxWg75alOva7zi6X7j1iVhQJawUdzhUj23vm4ww6SK
 pRyLltQxc/vOcHGLHP+XvaNa+9/MYUfxY5nuuclI09AWrenF6pRTuIVOqIKuCd9nGT
 5XDQFT1Oqoo3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/15] drm/panfrost: Consolidate device clock
 management and reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260925-claude-fixes-v11-5-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
 <20260925-claude-fixes-v11-5-0dbf5a58e7ce@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 18:57:09 +0000
Message-Id: <20260925185710.40ABA1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/panfrost: Unintended global prepare_lock contention in runti=
me PM
--

commit b64fb23518fa629aff18538498a7ba6190344212
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Consolidate device clock management and reset

This commit gathers clock enables and disables into a single function to av=
oid
repetitions between driver init/fini and device resume/suspend. It also
combines clock prepares and enables together, simplifying the management AP=
I.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index b3a53504bd016..9f2b1967a3984 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> +static int panfrost_clks_enable(struct panfrost_device *pfdev, bool on_r=
esume)
>  {
>  	int err;
> +
> +	err =3D clk_prepare_enable(pfdev->clock);

[Severity: Medium]
Will this introduce global lock contention during runtime PM wake-ups?

The commit message notes that clk_prepare can simply increase the refcnt
of an already prepared clock. However, clk_prepare() and clk_unprepare()
always acquire the global prepare_lock mutex to do so.

Furthermore, since the GPU driver is the sole consumer of its specific leaf
clocks, the refcount might drop to 0, forcing a full hardware
unprepare/prepare cycle which can be quite slow.

Because panfrost_clks_enable() is called from
panfrost_device_runtime_resume(), this replaces the previous clk_enable()
calls (which only take a fast spinlock) with clk_prepare_enable(), causing
the driver to contend for the global prepare_lock mutex every time the GPU
wakes up from runtime suspend.

> +	if (err)
> +		return err;
> +
> +	err =3D clk_prepare_enable(pfdev->bus_clock);
> +	if (err)
> +		goto disable_clock;
> +
> +	if (on_resume) {
> +		err =3D clk_prepare_enable(pfdev->bus_ace_clock);
> +		if (err)
> +			goto disable_bus_clock;
> +	}
> +
> +	return 0;
> +
> +disable_bus_clock:
> +	clk_disable_unprepare(pfdev->bus_clock);
> +disable_clock:
> +	clk_disable_unprepare(pfdev->clock);
> +
> +	return err;
> +}
> +
> +static void panfrost_clks_disable(struct panfrost_device *pfdev, bool on=
_suspend)
> +{
> +	if (on_suspend)
> +		clk_disable_unprepare(pfdev->bus_ace_clock);
> +	clk_disable_unprepare(pfdev->bus_clock);
> +	clk_disable_unprepare(pfdev->clock);

[Severity: Medium]
Similar to the resume path, since this is called from
panfrost_device_runtime_suspend(), will replacing clk_disable() with
clk_disable_unprepare() cause unintended global prepare_lock contention
every time the GPU idles?

[ ... ]
> @@ -436,34 +450,17 @@ static int panfrost_device_runtime_resume(struct de=
vice *dev)
[ ... ]
> -		ret =3D clk_enable(pfdev->clock);
> -		if (ret)
> -			goto err_clk;
> -
> -		ret =3D clk_enable(pfdev->bus_clock);
> -		if (ret)
> -			goto err_bus_clk;
> -
> -		ret =3D clk_enable(pfdev->bus_ace_clock);
> -		if (ret)
> -			goto err_bus_ace_clk;
> +		ret =3D panfrost_clks_enable(pfdev, true);
[ ... ]
> @@ -480,9 +477,7 @@ static int panfrost_device_runtime_suspend(struct dev=
ice *dev)
[ ... ]
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> -		clk_disable(pfdev->bus_ace_clock);
> -		clk_disable(pfdev->bus_clock);
> -		clk_disable(pfdev->clock);
> +		panfrost_clks_disable(pfdev, true);
>  		reset_control_assert(pfdev->rstc);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-claude-fix=
es-v11-0-0dbf5a58e7ce@collabora.com?part=3D5
