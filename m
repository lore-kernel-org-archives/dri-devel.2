Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30CBCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056AC10E109;
	Tue, 29 Sep 2026 03:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JQJYdaN3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8935310E109
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:56:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 462BD439F4;
 Tue, 29 Sep 2026 03:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF231F000FF;
 Tue, 29 Sep 2026 03:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790654195;
 bh=uooBTwwMlujkp7rQY/gVMQ9iWfA0Cbw/5bFZ4BtMb5A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JQJYdaN324/5Bcuzaaeuco4M4Prbv452LAjBs8vZH3otacZK0xXPMInZwET1o++Wy
 AVpONDKYsIBv1Uurj09xwNWM0EKQTL89enSAoRURVwOhIPoeuo8TDHB4dAifl/H3WH
 cVvE/HGiZ/FaFIwRTf7omk6JXQVJ3AapJofhuVRqzmWBDKpT/wcd0ygXFwmF2t5cqU
 +htEY2kD3JMBQ2albqGfakQhwyF7GbEMTQ5pp1Ey2N8ne+J43Iar1PH4o21LBbQUB8
 mW4SevFfHfUcgAzQq6MX3miUSckQ8Dl+p297cGwwTCjgVsyshavE5HVARfsj6YQJdf
 5Gm9DoFKy501Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/15] drm/panfrost: Consolidate device clock
 management and reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-claude-fixes-v12-5-62beb08de207@collabora.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-5-62beb08de207@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 03:56:34 +0000
Message-Id: <20260929035635.0BF231F000FF@smtp.kernel.org>
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
- [Medium] clk: slow clk_prepare on runtime resume due to unprepare in susp=
end
--

commit 9d5414aa4af3f7dd6f34ed2bea83b5c9b25db769
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Consolidate device clock management and reset

This commit gathers clock enables and disables into a single function to
avoid repetition between driver init/fini and device resume/suspend. It
also combines prepare/unprepare with enable/disable, under the assumption
that clock preparation can simply increase the reference count of an already
prepared clock.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index b3a53504bd016..9f2b1967a3984 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> @@ -436,34 +450,17 @@ static int panfrost_device_runtime_resume(struct de=
vice *dev)
>  		if (ret)
>  			return ret;
> =20
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
> +		if (ret) {
> +			reset_control_assert(pfdev->rstc);
> +			return ret;
> +		}
>  	}
> =20
>  	panfrost_device_reset(pfdev, true);
[ ... ]
> @@ -480,9 +477,7 @@ static int panfrost_device_runtime_suspend(struct dev=
ice *dev)
>  	panfrost_gpu_power_off(pfdev);
> =20
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> -		clk_disable(pfdev->bus_ace_clock);
> -		clk_disable(pfdev->bus_clock);
> -		clk_disable(pfdev->clock);
> +		panfrost_clks_disable(pfdev, true);
>  		reset_control_assert(pfdev->rstc);
>  	}

[Severity: Medium]
Does this introduce a performance regression by fully unpreparing the clocks
on every idle state?

Previously, this code only called clk_disable() during runtime suspend,
leaving the clock prepared. Now panfrost_clks_disable() uses
clk_disable_unprepare(), reducing the prepare refcount to 0.

When the device wakes up, panfrost_device_runtime_resume() calls
panfrost_clks_enable() which uses clk_prepare_enable(). Because the clock
was unprepared here in suspend, the resume path will pay the penalty of
executing the full sleep-capable prepare sequence from a cold state instead
of just a fast atomic-safe enable.

The commit message notes that "the clk_prepare_* family of functions can
simply increase the refcnt of an already prepared clock". However, since the
clocks are fully unprepared in this runtime suspend path, they won't be
already prepared on resume.

Was it intended to fully unprepare the clocks on every runtime suspend?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-claude-fix=
es-v12-0-62beb08de207@collabora.com?part=3D5
