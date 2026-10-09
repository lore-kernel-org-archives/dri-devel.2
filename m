Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E621CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6607211215D;
	Fri,  9 Oct 2026 13:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FXMzkrIN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4768511215D
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:39:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAA1640639;
 Fri,  9 Oct 2026 13:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B661F000FF;
 Fri,  9 Oct 2026 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791553166;
 bh=pPAhLNyuDOTYSe17nIy9otyWSF4neLAAeHEXvUDPiOE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FXMzkrINuDIiFrR7tN+2gluglEdmo04bhbKxqwQBzkgwy2Lj+WTu1+Qf7PUJIpfvu
 RQWh0MOZgkeyTy6Z9nq5m1yAmcIJm8MaTfWyN8PLyBFv8TVRn4djJ8HAQQCIMiSFT6
 9ZYTL3rjwOcux2vIb9j4ip0K8X5+Z55suITouhDqrJJEzlNPfVmj/A9EKZlsABVIpR
 7hSpHcBRcXSTqTOyynu/JI0T0r3QiACf/bYHD57XvUqq72PPWCrsafFPY1nCil8Uqh
 1SsSdjt4tdZaZAznQkx1AbtV+ubpShHxiXMmvdr68w3xHW1R0bPb2odTAM2DB6pAx/
 xnSvFFEhMmIhA==
Message-ID: <sashiko-outbox-165653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 08/15] drm/panfrost: Move all DRM device
 initialisation into device_init()
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-claude-fixes-v14-8-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
 <20261009-claude-fixes-v14-8-cb743b3b973b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:39:24 +0000
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
- [Medium] Resource teardown order mismatch between init error path and fin=
i()
--

commit cc1a89616a9fe7ee1baf348443aab4d77f011c53
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
drm/panfrost: Move all DRM device initialisation into device_init()

This commit moves all DRM device initialization and registration into
panfrost_device_init() so the probe function can be minimal. It also
adjusts panfrost_remove() to rely on panfrost_device_fini() for resource
cleanup.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 50f4713bfcfdd..a6deabb39fd2c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> +	pm_runtime_get_sync(pfdev->base.dev);
> +
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> +	pm_runtime_disable(pfdev->base.dev);
> +
>  	panfrost_gem_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
>  	panfrost_jm_fini(pfdev);
> @@ -354,6 +400,9 @@ void panfrost_device_fini(struct panfrost_device *pfd=
ev)
>  	panfrost_clk_fini(pfdev);
>  	panfrost_reset_fini(pfdev);
>  	panfrost_pm_domain_fini(pfdev);

[Severity: Medium]
Is there a resource teardown order mismatch here?

In panfrost_device_init(), devfreq is initialized before regulators, and its
error path correctly tears down regulators before devfreq:

panfrost_device_init() {
    ...
out_regulator:
    panfrost_regulator_fini(pfdev);
out_devfreq:
    panfrost_devfreq_fini(pfdev);
    ...
}

However, in panfrost_device_fini(), panfrost_devfreq_fini() is called before
panfrost_regulator_fini() (just above panfrost_clk_fini()).

Could this create an issue during device removal by not following the strict
reverse-initialization order used in the init error path?

> +
> +	pm_runtime_set_suspended(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-claude-fix=
es-v14-0-cb743b3b973b@collabora.com?part=3D8
