Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCC4CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E786410E462;
	Fri,  9 Oct 2026 13:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y78Gscd3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C8010E462
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:47:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BF6C60098;
 Fri,  9 Oct 2026 13:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75DF1F000FF;
 Fri,  9 Oct 2026 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791553636;
 bh=B2Jk0CSSC/uLhIZ+0qizqCvS+I9KN25YIIy013TweWg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y78Gscd3UMNb+qbnkuE6wUUrhbA9qGIglrKsFKonsBxQbbkTTEpbjmWI7LA06p2Nd
 xQmb5tlI+3jvaN4Nc7MmV4Uzp+yLFgzHhRVuVmtgqdTNeVV3Hq4gYx0aJEyRfDuy2+
 irSH+hKBpwjHVHOCeOXpl2oKCBOOAEmKStEgbl6MeYvWRFLBh2y3WKC1vA3zDYbcC8
 fuZ0sH+xsfYwqzw1xPMRpjDhYlGaKh0r/mb9oiTymyHmWRIv9Y+sxuBVYJOX7reDlP
 LhRm/XgMPUfC611sWqookS7R/U7xQzKg62N50MNz+ETcjA/1c/PuhqzfXHC9fQqknA
 srOLEaBZHOWPQ==
Message-ID: <sashiko-outbox-165669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 09/15] drm/panfrost: Warn of RPM get failure at
 device remove time
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-claude-fixes-v14-9-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
 <20261009-claude-fixes-v14-9-cb743b3b973b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:47:15 +0000
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
- [High] drm/panfrost: bus fault due to unpowered MMIO access in fini
--

commit 1d33acca0e677034f1a99e084840bcc7a625c2cf
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Warn of RPM get failure at device remove time

This commit adds a warning during device removal if taking a PM reference=20
fails. The goal is to avoid silent failures and notify the user when the=20
PM resume operation is unsuccessful.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index a6deabb39fd2c..6872302257431 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> @@ -385,7 +386,7 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
> =20
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> -	pm_runtime_get_sync(pfdev->base.dev);
> +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);

[Severity: High]
If pm_runtime_get_sync() fails, it indicates the device is still in a
powered-off or clock-gated state. While this adds a warning, execution
continues unconditionally to the hardware teardown.

The teardown process then performs MMIO writes to an unpowered device. For
example, later in panfrost_device_fini(), these writes are executed:

panfrost_mmu_fini()
  mmu_write(pfdev, MMU_INT_MASK, 0);

panfrost_gpu_fini()
  panfrost_gpu_power_off()
    gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);

On ARM platforms, accessing MMIO of a powered-off device triggers a
synchronous external abort (bus fault), leading to a kernel panic. Should
this function return early or otherwise skip the hardware teardown steps if
the PM reference cannot be acquired?

> =20
>  	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-claude-fix=
es-v14-0-cb743b3b973b@collabora.com?part=3D9
