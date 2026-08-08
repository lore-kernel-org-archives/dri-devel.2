Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C1BC5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AAD010E390;
	Sat,  8 Aug 2026 13:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WpBW6Sof";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 679CC10E390
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:54:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8769760054;
 Sat,  8 Aug 2026 13:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C501F000E9;
 Sat,  8 Aug 2026 13:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786197278;
 bh=QSStXOGgtWFNR/xnFbOv9TdSP09/LIt0QySfVy3r2q8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WpBW6SofeEPR9Z1VC3SJ6D+cbzH/7CCHWR43laG1nrTAPTT4bOoX53c930NbeOPh7
 SRg/Xkj+XS6PZ121atDWv+AAhEL/QdxPPT3DZo9a/7uyyukeFGyxA4Gwy8Eksc4hVh
 JycZDBwXpPxgektHBVBP7R52C7hxqO3eJTbNtaj2dHNzyoB3OXy944NI4Rj3nePzd4
 mtJI8mRgPsi7h02/HPvcATjvhgoQeJ7OjY2CY7zhUuqhbro9rmuC9RPCgurkGqnbS7
 OVQpfDS9yqq/A1Y/1gIORy4kY09CEe+9WcfKIYaYZDeqk+J2pLWRYKFzhYpsRqysjB
 bMeuxkdEdOsuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau: fix autosuspend cleanup during teardown
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808134137.2864847-1-lgs201920130244@gmail.com>
References: <20260808134137.2864847-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:54:37 +0000
Message-Id: <20260808135438.13C501F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Hot-unplug during an open file descriptor leads to a use-after-fre=
e of nouveau_cli via the DRM_NOUVEAU_NVIF ioctl.
--

--- Patch [1]: [PATCH] drm/nouveau: fix autosuspend cleanup during teardown=
 ---
commit ae87ae00f3257ee8e11b10260263c7423ec1666c
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/nouveau: fix autosuspend cleanup during teardown

nouveau_drm_device_init() calls pm_runtime_use_autosuspend(), but
nouveau_drm_device_fini() does not call the matching
pm_runtime_dont_use_autosuspend().

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 4d1ad718e09b7..42daad06fdbe3 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -585,6 +585,7 @@ nouveau_drm_device_fini(struct nouveau_drm *drm)
>  	if (nouveau_pmops_runtime()) {
>  		pm_runtime_get_sync(dev->dev);
>  		pm_runtime_forbid(dev->dev);
> +		pm_runtime_dont_use_autosuspend(dev->dev);
>  	}
> =20
>  	nouveau_led_fini(dev);

[Severity: High]
This is a pre-existing issue, but could the subsequent client cleanup in
nouveau_drm_device_fini() lead to a use-after-free if the device is
hot-unplugged while userspace still has an open file descriptor?

If a hot-unplug occurs, nouveau_drm_device_fini() unconditionally frees the
client structures a bit further down in the function:

	list_for_each_entry_safe(cli, temp_cli, &drm->clients, head) {
		...
		nouveau_cli_fini(cli);
		kfree(cli);
	}

If userspace then issues a DRM_NOUVEAU_NVIF ioctl on the still-open file
descriptor, nouveau_drm_ioctl() handles it:

	ret =3D pm_runtime_get_sync(dev->dev);
	if (ret < 0 && ret !=3D -EACCES)
		return ret;
	...
	switch (cmd) {
	case DRM_NOUVEAU_NVIF:
		ret =3D nouveau_abi16_ioctl(filp, (void __user *)arg, _IOC_SIZE(cmd));
		break;

Because runtime PM is disabled upon device removal, pm_runtime_get_sync()
returns -EACCES, which the ioctl handler ignores. The ioctl proceeds direct=
ly
to nouveau_abi16_ioctl(), bypassing the standard drm_dev_is_unplugged() che=
ck.

This eventually calls nouveau_abi16_get(), which accesses the freed memory:

	struct nouveau_cli *cli =3D nouveau_cli(file_priv);
	mutex_lock(&cli->mutex);

Can this sequence lead to memory corruption or panics during teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808134137.2864=
847-1-lgs201920130244@gmail.com?part=3D1
