Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F8EC55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF26410F097;
	Thu, 30 Jul 2026 20:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K0jGAoKP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA87010F094
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:56:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 064DF6004E;
 Thu, 30 Jul 2026 20:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF051F000E9;
 Thu, 30 Jul 2026 20:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785444993;
 bh=I/V2GecalLETbHDEj3dhqL9+Ol1v29uWh1aTSvNLnp4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K0jGAoKPBSv6a2aY8hfKKB6/0F5o5g+Ev+NbzjQnt0xUM1idWCVc9k/HrOeM7fHLy
 aLU16jU5HHgq+K4p4mbUFUDhKObtLms0MW2eXaXew7P7cFzjzY61sT8Bd/zi8DT20L
 PpKlsn+8hflGhruHUNNDPHdb/iJSe8Dq8WlHMQd4LVzA5svUFuJ0pQvupwPICzNoC7
 qzMeTC8IuN7Gith4oW2fkGMvWpYr//dA14cWKC0d5bgj7jeBrfsiuunhFhqIL0u+KP
 k2uDDZKTfmYrKvqAMu1DRf5SENPXdc1xElX4AqqLdQmIDg928y+er7GyeDATM006XU
 xJbpWyYNWQ6Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] drm/nouveau: Fix drm_driver
 struct/nouveau.atomic parameter handling
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730204604.1729505-4-lyude@redhat.com>
References: <20260730204604.1729505-1-lyude@redhat.com>
 <20260730204604.1729505-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:56:33 +0000
Message-Id: <20260730205633.9AF051F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Embedding `drm_driver` inside `nouveau_drm` causes a Use-After=
-Free of `dev->driver` in the DRM core when the device is unbound or hot-un=
plugged while userspace holds an open file descriptor.

Pre-existing issues:
- [Critical] The `NOUVEAU_NVIF` ioctl bypasses DRM core unplug checks, lead=
ing to a Use-After-Free on `nouveau_cli` if executed after the device is re=
moved.
--

--- Patch [3]: [PATCH v5 3/5] drm/nouveau: Fix drm_driver struct/nouveau.at=
omic parameter handling ---
commit 04d65df2ae87442da9882dee1a1a2dd86491acc9
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau: Fix drm_driver struct/nouveau.atomic parameter handling

This commit moves the global drm_driver structures for PCI and platform
devices into the nouveau_drm struct. It initializes the embedded driver
struct by copying a const stub and dynamically adds the atomic modesetting
capability.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 451009adee0de..9cd12ebc7e449 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -744,9 +741,10 @@ nouveau_drm_device_new(const struct drm_driver *drm_=
driver, struct device *paren
>  	if (!drm)
>  		return ERR_PTR(-ENOMEM);
> =20
> +	drm->drm_driver =3D driver_stub;
>  	drm->nvkm =3D device;
> =20
> -	drm->dev =3D drm_dev_alloc(drm_driver, parent);
> +	drm->dev =3D drm_dev_alloc(&drm->drm_driver, parent);

[Severity: Critical]
Does embedding the drm_driver inside the nouveau_drm struct cause a
use-after-free of dev->driver during device unbind?

When the device is unbound via sysfs or hot-unplugged, the driver's remove
routine calls nouveau_drm_device_del(), which drops its reference to
drm_device (via drm_dev_put()) and unconditionally frees the nouveau_drm
structure, along with the embedded drm_driver.

However, userspace might still hold an open file descriptor, keeping the
drm_device alive. Later, when the file is closed, the DRM core's
drm_file_free() dereferences dev->driver->postclose:

drivers/gpu/drm/drm_file.c:drm_file_free() {
    ...
    if (dev->driver->postclose)
        dev->driver->postclose(dev, file);
    ...
}

Since dev->driver points to the freed embedded structure, does this result
in a use-after-free?


[Severity: Critical]
This is a pre-existing issue, but does the NOUVEAU_NVIF ioctl bypass DRM
core unplug checks and cause a use-after-free on nouveau_cli?

In nouveau_drm_ioctl(), this specific command routes directly to the ABI16
handler, bypassing drm_ioctl() and its drm_dev_is_unplugged() check:

drivers/gpu/drm/nouveau/nouveau_drm.c:nouveau_drm_ioctl() {
    ...
    case DRM_NOUVEAU_NVIF:
        ret =3D nouveau_abi16_ioctl(filp, (void __user *)arg, _IOC_SIZE(cmd=
));
        break;
    ...
}

If the device is unbound or unplugged, nouveau_drm_device_fini() iterates
over drm->clients and frees all cli structures:

drivers/gpu/drm/nouveau/nouveau_drm.c:nouveau_drm_device_fini() {
    ...
    list_for_each_entry_safe(cli, temp_cli, &drm->clients, head) {
        list_del(&cli->head);
        ...
        kfree(cli);
    }
    ...
}

If a userspace process then calls the DRM_NOUVEAU_NVIF ioctl,
nouveau_abi16_ioctl() calls nouveau_abi16_get(), which retrieves the freed
cli struct from file->driver_priv and attempts to lock its mutex:

drivers/gpu/drm/nouveau/nouveau_abi16.c:nouveau_abi16_get() {
    ...
    struct nouveau_cli *cli =3D nouveau_cli(file_priv);
    mutex_lock(&cli->mutex);
    ...
}

Can this lead to memory corruption if executed after the device is removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730204604.1729=
505-1-lyude@redhat.com?part=3D3
