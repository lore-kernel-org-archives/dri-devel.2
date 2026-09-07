Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8425AC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA26710E5FA;
	Mon,  7 Sep 2026 20:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W1WcWdX5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E0110E5FA
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:31:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27696601FB;
 Mon,  7 Sep 2026 20:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C751F00A3A;
 Mon,  7 Sep 2026 20:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788813065;
 bh=YhNgif/BKfNwQ4xq1EMYs6DBLjKUpUnIVPyiVX19CVc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W1WcWdX5FLfNJqKS8rCn9G2Gdz+y8ATPL7veINamggzWRu56Vc3Ppcz7cVZDA+zsH
 cd3YKgT4IbVZjHoHMkaGSOaE6p44ox+jSKLGZm+j0NMwk1ssMrumBHt25L7KU9ccN3
 1oUbgfNYnfmJik/G5Z0ldkrYPJAfruKiZ8wcPCAILn1rUoeiz9zVh0OGbDGhvb7mun
 wjCWaqcZ217YbrMi9W54dpQIvMKn7atYVx3wd4NAE4Apqv3oXS/9Gh+dJxlek1AI68
 bI7Rg68UiaxXrFxaKvKuY4ZI1eCuBbKiENmsg6xfAD10DY26rk1sm77b1GI6kyd4w2
 ZVb60c4s91wpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/16] drm/panfrost: Consolidate device clock
 management and reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-claude-fixes-v8-5-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
 <20260907-claude-fixes-v8-5-c2bcb5e82184@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:31:05 +0000
Message-Id: <20260907203105.A5C751F00A3A@smtp.kernel.org>
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
- [Medium] Incomplete refactoring of clock management in system PM callback=
s, contradicting the commit message
--

commit ade848b25069fa976d1163310dd16ab781b653aa
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Consolidate device clock management and reset

This commit introduces helpers to consolidate clock management and avoid
repetition across different power states. It updates the driver init, fini,
and runtime PM paths to prepare/enable and disable/unprepare clocks togethe=
r.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index b3a53504bd016..48135e412b6c9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c

[ ... ]

> @@ -506,11 +498,11 @@ static int panfrost_device_resume(struct device *de=
v)
>  	}
> =20
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> -		ret =3D clk_enable(pfdev->clock);
> +		ret =3D clk_prepare_enable(pfdev->clock);
>  		if (ret)
>  			goto err_clk;
> =20
> -		ret =3D clk_enable(pfdev->bus_clock);
> +		ret =3D clk_prepare_enable(pfdev->bus_clock);
>  		if (ret)
>  			goto err_bus_clk;
>  	}

[Severity: Medium]
The commit message mentions gathering all clock enables and disables into a
single function to avoid repetitions between driver init/fini and device
resume/suspend. Does this system resume path intentionally bypass the newly
added panfrost_clk_enable() function?

By calling clk_prepare_enable() directly, it appears to miss the refactoring
goal and omits bus_ace_clock for platforms using GPU_PM_CLK_DIS.

[ ... ]

> @@ -543,8 +535,8 @@ static int panfrost_device_suspend(struct device *dev)
>  		return ret;
> =20
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> -		clk_disable(pfdev->bus_clock);
> -		clk_disable(pfdev->clock);
> +		clk_disable_unprepare(pfdev->bus_clock);
> +		clk_disable_unprepare(pfdev->clock);
>  	}
> =20
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))

[Severity: Medium]
Similarly, should this section use the new panfrost_clk_disable() helper
instead of open-coding the clk_disable_unprepare() calls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-claude-fix=
es-v8-0-c2bcb5e82184@collabora.com?part=3D5
