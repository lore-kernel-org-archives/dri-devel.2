Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302CEC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 669F610E20A;
	Fri, 25 Sep 2026 18:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OoHwadfy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E34510E20A
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:57:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CDEF60136;
 Fri, 25 Sep 2026 18:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC56A1F000FF;
 Fri, 25 Sep 2026 18:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790362676;
 bh=rFmnwtwUj0if7+mwxOcaDtUdyrVYdF+P+3Crq7bvUzw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OoHwadfyokg0MquWNpHBQoaAi9/3q0SBV+LgA6wdi7w6sT8J2frBrL2/RDSe4ZhWW
 rVk4zd34QrrWiZ5o2vf3q7bbJyAhZDp6jtQ+tH6brSpAywOR4uCiuew/hM88mnbmwz
 xc2Iw68fzXjQoGHJPGXxcPG5KSW9aqEIb53ANmfgIBvM4d3o0exMuKdhQokGioMW72
 yR9/MgyPKn+FRE+HibioJp4vLeXJ4M7sPrtbXGmmdI3lHUTVzLU6PXdewsqxOhVs/d
 a//aIxPaIYF74iBBBKHWbk+DJhGhXgmrZJrSsNlWL17ssqKs2t/WDy9rDEZDp+RP+A
 h7XhEFiq65rVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/15] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260925-claude-fixes-v11-6-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
 <20260925-claude-fixes-v11-6-0dbf5a58e7ce@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 18:57:55 +0000
Message-Id: <20260925185755.EC56A1F000FF@smtp.kernel.org>
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
- [Medium] pm: omitted reordering of pm_runtime_set_suspended() contrary to=
 commit message
--

commit e5b622a5bf50c2417ee98e980c4b45ec511cb4e7
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove

This commit attempts to fix PM reference count and autosuspend issues
during device probe and removal. It manually adjusts the PM reference
count, disables autosuspend in wind-down paths, and aims to reorder
PM teardown steps to mirror initialization.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 55fc22e8d4d4e..907d4a14a0b55 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
[ ... ]
> @@ -866,13 +871,16 @@ static int panfrost_probe(struct platform_device *p=
dev)
[ ... ]
>  err_out1:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);

[Severity: Medium]
The commit message states "Move pm_runtime_set_suspended() before
panfrost_device_fini() so that resource unwinding happens in the opposite
order as initialisation." However, this structural reordering appears to be
missing from the code.

Should pm_runtime_set_suspended() be moved above panfrost_device_fini() in
the panfrost_probe() error path to match the intent described in the commit
message?

> +	pm_runtime_put_noidle(pfdev->base.dev);
>  err_out0:
>  	return err;
>  }
> @@ -884,9 +892,12 @@ static void panfrost_remove(struct platform_device *=
pdev)
[ ... ]
>  	pm_runtime_get_sync(pfdev->base.dev);
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);

[Severity: Medium]
Similarly, in the panfrost_remove() path, the reordering mentioned in the
commit message is omitted.

Should pm_runtime_set_suspended() be moved above panfrost_device_fini()
here as well?

> +	pm_runtime_put_noidle(pfdev->base.dev);
> +
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-claude-fix=
es-v11-0-0dbf5a58e7ce@collabora.com?part=3D6
