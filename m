Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C601CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3D4112134;
	Fri,  9 Oct 2026 13:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I4Lc64F6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550D4112134
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:14:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD7B360098;
 Fri,  9 Oct 2026 13:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EFD1F000FF;
 Fri,  9 Oct 2026 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791551664;
 bh=vM0eTp7oj6CIav1VHdZhPAWhfrUD1iDGcoTzgio+ypk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I4Lc64F6926tWwkfE7SKb5X+CHKjb1+Mo7WKNtviW+z6cNQRa59rK+LwqUztiE5hj
 UtmovK81OpCG819rsQlx/3E+bLeitHwzm5RF1GZJMKWKKlgFbF9ldxKaPu3VqsGqpH
 1JGL4FXqj5SxD3zVRULeLrOIS1XlNLWo/W1//IJVpjPxZ3ICoGL2Q1NXpRsaMFcDns
 dkXphii+JavRMKVe9BPNUtCD5w5h5TMdnwwCmWocGhiw7+husnNEEFxvwoRy+LOcJL
 u/DW4A5BeCcITb5/qgfM+fHhxx50mihUkKNCLtKPm21jNwCt1hCMiNgpTX7uqn1ehB
 YGst6KanZL/kg==
Message-ID: <sashiko-outbox-165608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/15] drm/panfrost: Consolidate device clock
 management and reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-claude-fixes-v14-5-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
 <20261009-claude-fixes-v14-5-cb743b3b973b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:14:23 +0000
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
- [Medium] drm/panfrost: global prepare_lock mutex contention in runtime PM=
 hot path
--

commit 3af44bee15a2caec9722e2975dc04d5f8f206925
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Consolidate device clock management and reset

Gather all clock enables and disables into a single function to avoid
repetitions between driver init/fini and device resume/suspend, since
these clocks are always handled in bulk.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index b3a53504bd016..50f4713bfcfdd 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -34,10 +34,46 @@ static void panfrost_reset_fini(struct panfrost_devic=
e *pfdev)
>  	reset_control_assert(pfdev->rstc);
>  }
> =20
> -static int panfrost_clk_init(struct panfrost_device *pfdev)
> +static int panfrost_clks_enable(struct panfrost_device *pfdev, bool on_r=
esume)
>  {
>  	int err;
> +
> +	err =3D clk_prepare_enable(pfdev->clock);

[Severity: Medium]
Does this introduce global prepare_lock mutex contention into the runtime PM
hot path?

By replacing the atomic-safe clk_enable() and clk_disable() calls with
clk_prepare_enable() and clk_disable_unprepare() in the runtime PM suspend
and resume paths, this code will now unconditionally acquire the system-wide
prepare_lock mutex during high-frequency GPU idle transitions.

Even though panfrost_clk_init() appears to still prepare the clocks, the
Common Clock Framework's clk_prepare() unconditionally acquires the global
mutex to manage the software reference count. Acquiring this global mutex
during rapid runtime PM transitions defeats the separation of the slow prep=
are
phase from the fast enable phase, potentially causing unnecessary
serialization and latency spikes across the system.

[ ... ]

> @@ -436,34 +478,17 @@ static int panfrost_device_runtime_resume(struct de=
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

[ ... ]

> @@ -480,9 +505,7 @@ static int panfrost_device_runtime_suspend(struct dev=
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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-claude-fix=
es-v14-0-cb743b3b973b@collabora.com?part=3D5
