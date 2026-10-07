Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133A1CA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E32B10E00C;
	Wed,  7 Oct 2026 23:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZP4AhxYW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634F110E00C
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 23:54:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 096E7600D1;
 Wed,  7 Oct 2026 23:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B4A1F000FF;
 Wed,  7 Oct 2026 23:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791417280;
 bh=rHcvvizEbhBQ7teuXqLhFxkWz+7qFPQ983dY5/WZyyg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZP4AhxYWpltJiHKgs7S1iCZWqlJi5jfR6B7lqjf8aS0GorSL9dTxUIVuaUqHy3cXp
 8/f+7qoJ2WegDncWJBQucLU4cNM2dIcfdDQ3sZZFDkGYgefqACpLHlAjXlEzUdEEf3
 qu0qo7eExDIK8tmb8Mdzkpsh6Jbmaqn42737qRKgyc8krPYUfV4Qc51omv65qK2vLx
 mlXc9pxacsVZqOAytdZEcg3bsuAnS83lvOAoOjeznQ+9qYXBmqQ87O8SZS5ZzjUuZF
 TBngCHxNmFDIPQqC/dmjVP+GS3Czpf0RUmHbdLBggct3l1SApp7oSfwiz2b7P8w7Jy
 EJarCHOJbpL0Q==
Message-ID: <sashiko-outbox-163440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 08/15] drm/panfrost: Move all DRM device
 initialisation into device_init()
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-claude-fixes-v13-8-d6a493185860@collabora.com>
References: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
 <20261008-claude-fixes-v13-8-d6a493185860@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 23:54:40 +0000
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
- [High] drm/panfrost: UAF and MMIO faults on device unbind due to missing =
drm_dev_unplug
--

commit 6682d5cdca6ad86a6d0e64fd3ea14cdc2a997862
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move all DRM device initialisation into device_init()

Ideally the probe() function will do as little as possible, and all device
initialisation and registration should happen inside the panfrost device
subsystem, just like it's done in Panthor. This also simplifies resource
unwinding in the error path. Do the same thing for DRM driver remove.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 907d4a14a0b55..f77780c72a1ae 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c

[ ... ]

> @@ -891,13 +847,7 @@ static void panfrost_remove(struct platform_device *=
pdev)
> =20
>  	drm_dev_unregister(&pfdev->base);
> =20
> -	pm_runtime_get_sync(pfdev->base.dev);
> -	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> -	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);

[Severity: High]
Does this sequence cause a regression that leaves the driver vulnerable to
use-after-free and MMIO faults on device unbind?

When panfrost_remove() calls drm_dev_unregister(), it removes the device
node but does not revoke existing open file descriptors. The subsequent
call to panfrost_device_fini() shuts down the hardware, and after this
function returns, the driver core will free all devm allocations.

For example, panfrost_jm_init() allocates pfdev->js using devm_kzalloc:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_jm_init() {
	...
	js =3D devm_kzalloc(pfdev->base.dev, sizeof(*js), GFP_KERNEL);
	if (!js)
		return -ENOMEM;
	pfdev->js =3D js;
	...
}

If a user unbinds the driver (e.g., via sysfs) while holding an open DRM
file descriptor, subsequent ioctls (like PANFROST_IOCTL_SUBMIT) could
access the freed pfdev->js pointer and unmapped or powered-off hardware
registers.

Should this teardown path use drm_dev_unplug() instead, and should the
driver add drm_dev_enter() and drm_dev_exit() guards to safely manage
concurrent ioctls during device removal?

> -	pm_runtime_set_suspended(pfdev->base.dev);
> -	pm_runtime_put_noidle(pfdev->base.dev);
> -
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-claude-fix=
es-v13-0-d6a493185860@collabora.com?part=3D8
