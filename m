Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7596C54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C08D10E078;
	Thu, 30 Jul 2026 01:18:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UcbyIIT4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BC910E078
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:18:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71C1A4022A;
 Thu, 30 Jul 2026 01:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD971F000E9;
 Thu, 30 Jul 2026 01:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785374333;
 bh=GOErYHMJ/tW8Iw4/HmlyXfc/7pPoaxiz1AOHqqhp3M8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UcbyIIT4kPG3BkXZBgy4m0ar2esUluQR6/ANGALCywcKXkyy8xQdWJ9UdIo+lsD5W
 wzt2PjpVSatD3T29P8zCPgT91aXsi+WtTGq3CwAAtKfn7r7nfYqVYK23hDBwt4DRnz
 aJGNQEjgZyUN0tJVZSo2zLL4FfMtJG5qr/YIaU1sHtQEa1jSYtZWegpUesrc83BOZb
 WKD/fVTvPkKlwVt8NMVMiTsnLo7DsClNiSkomB0AkvTiXHzcWIi8IeKniQ8gplqMcf
 eF1cXiuwg91kJbIXK9qT7wrsAV2R4X8wycCffekahYuWtju/KUTNyPgmQNSUO2Z0Sa
 aNXmCpN9/z4MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/nouveau/kms: Check nouveau.atomic parameter
 after nvif_device_ctor()
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730010828.1056397-3-lyude@redhat.com>
References: <20260730010828.1056397-1-lyude@redhat.com>
 <20260730010828.1056397-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:18:52 +0000
Message-Id: <20260730011853.2AD971F000E9@smtp.kernel.org>
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
- [Medium] The shared initialization function nouveau_drm_device_new() inco=
rrectly hardcodes modifications to the global driver_pci struct instead of =
the provided drm_driver parameter.

Pre-existing issues:
- [High] nouveau_drm_device_del() attempts to release an error pointer if d=
rm_dev_alloc() fails, causing a kernel panic.
--

--- Patch [2]: [PATCH 2/4] drm/nouveau/kms: Check nouveau.atomic parameter =
after nvif_device_ctor() ---
commit c020f75bf537ed725d051dbe5e66bd9bd3dfb6b7
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms: Check nouveau.atomic parameter after nvif_device_ctor()

This commit moves the check for the nouveau.atomic parameter into
nouveau_drm_device_new() so it occurs after the NVIF device is ready.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index ad693d2849bec..8899f009f825e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -727,7 +727,7 @@ nouveau_drm_device_del(struct nouveau_drm *drm)
>  }
> =20
>  static struct nouveau_drm *
> -nouveau_drm_device_new(const struct drm_driver *drm_driver, struct devic=
e *parent,
> +nouveau_drm_device_new(struct drm_driver *drm_driver, struct device *par=
ent,
>  		       struct nvkm_device *device)
>  {

[Severity: High]
This is a pre-existing issue, but does the error path in
nouveau_drm_device_new() cause a crash if drm_dev_alloc() fails?

If drm_dev_alloc() fails, it returns an error pointer which is stored
directly in drm->dev:

drivers/gpu/drm/nouveau/nouveau_drm.c:nouveau_drm_device_new() {
    ...
    drm->dev =3D drm_dev_alloc(drm_driver, parent);
    if (IS_ERR(drm->dev)) {
        ret =3D PTR_ERR(drm->dev);
        goto done;
    }
    ...
done:
    if (ret) {
        nouveau_drm_device_del(drm);
...
}

Then in nouveau_drm_device_del(), the truthiness check will succeed for
the error pointer, leading to a panic when it is passed to drm_dev_put():

drivers/gpu/drm/nouveau/nouveau_drm.c:nouveau_drm_device_del() {
    if (drm->dev)
        drm_dev_put(drm->dev);
    ...
}

Could we clear drm->dev on allocation failure, or check for IS_ERR()
in the cleanup function?

[ ... ]

> @@ -770,6 +770,9 @@ nouveau_drm_device_new(const struct drm_driver *drm_d=
river, struct device *paren
>  		goto done;
>  	}
> =20
> +	if (nouveau_atomic)
> +		driver_pci.driver_features |=3D DRIVER_ATOMIC;

[Severity: Medium]
Does this unintentionally modify the global driver_pci struct instead of the
drm_driver parameter passed to nouveau_drm_device_new()?

If nouveau_drm_device_new() is called for a platform device (such as Tegra),
the platform driver template would miss the DRIVER_ATOMIC flag, and the
PCI driver template would be unexpectedly mutated instead.

Should this update drm_driver->driver_features rather than driver_pci?

> +
>  	ret =3D nvif_device_map(&drm->device);
>  	if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730010828.1056=
397-1-lyude@redhat.com?part=3D2
