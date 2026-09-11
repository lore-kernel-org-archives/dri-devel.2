Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC8AC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7229D10E5BC;
	Fri, 11 Sep 2026 23:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nmmyy/RV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A9C10E5BC
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:36:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C19E0601EF;
 Fri, 11 Sep 2026 23:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6611F0089B;
 Fri, 11 Sep 2026 23:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789169795;
 bh=+j0evFSeLOFc8yFSCKSz+3z2DVKe6qrDDzyHUeuHXRA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nmmyy/RVrbWSZB6cMC8E6LkIJlLSODClsCZ3PmXNEhGSpLB3Kau+WqUbbm1h5uUE0
 zEcYn8sFYzDev+gH3xlwlkO6KHipISZIi80RU4o+uDdS04wF9waEtX3VXdPbQEvYgK
 72evjzoquUcac5wa/DKqA8m+mCO172wdP4RcR8V2iYB1CXJ9K/PlpCJZ71hTbayT12
 7+pBIFapz5S4+1C/pPYP4D8vbmZ2yH5bRiQv/VBF/27TyRJIVg3bDGuvq64n/6PFRK
 9Iouswkdf2gTu5hL9PxVi3QPFDzp2wtcVWDXS6ZmBwKRa8v2kpG36VdaPLDaC0UQbO
 F2fxc2EQNMJTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/16] drm/panfrost: Consolidate device clock
 management and reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-claude-fixes-v9-5-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-5-e588feaa61ef@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:36:34 +0000
Message-Id: <20260911233635.4A6611F0089B@smtp.kernel.org>
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
- [Medium] Missing clock disable/unprepare for `pfdev->clock` in the error =
path of `panfrost_device_resume()`.
--

commit 57e1cc8c0bd76260d5e27d81a245c42e7661aa0a
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Consolidate device clock management and reset

This commit gathers clock enables and disables into a single function to
avoid repetitions between driver init/fini and device resume/suspend. It
also groups clk prepares and enables into the same function calls.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index b3a53504bd016..2fcbd223204c4 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> @@ -506,13 +501,9 @@ static int panfrost_device_resume(struct device *dev)
>  	}
> =20
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> -		ret =3D clk_enable(pfdev->clock);
> +		ret =3D panfrost_clk_enable(pfdev, false);
>  		if (ret)
>  			goto err_clk;
> -
> -		ret =3D clk_enable(pfdev->bus_clock);
> -		if (ret)
> -			goto err_bus_clk;
>  	}
> =20
>  	ret =3D pm_runtime_force_resume(dev);
> @@ -523,10 +514,7 @@ static int panfrost_device_resume(struct device *dev)
> =20
>  err_resume:
>  	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> -		clk_disable(pfdev->bus_clock);
> -err_bus_clk:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> -		clk_disable(pfdev->clock);
> +		clk_disable_unprepare(pfdev->bus_clock);
>  err_clk:

[Severity: Medium]
When pm_runtime_force_resume() fails and jumps to err_resume, does this code
leak the clock preparation and enable reference counts for pfdev->clock?

Because panfrost_clk_enable(pfdev, false) prepares and enables both
pfdev->clock and pfdev->bus_clock, disabling only pfdev->bus_clock here
seems to leave pfdev->clock enabled. Should panfrost_clk_disable(pfdev,
false) be used on this path instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-claude-fix=
es-v9-0-e588feaa61ef@collabora.com?part=3D5
