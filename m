Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1ABCD98E2
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A2810E6FE;
	Mon, 15 Jun 2026 20:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G0A+eLnx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E50110E6FE
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:38:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8260C6008A;
 Mon, 15 Jun 2026 20:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A941F000E9;
 Mon, 15 Jun 2026 20:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555887;
 bh=PsE3Qj5DMk2w8uvREMXjcyEhl+Jf6Ja4aTATflW4eWI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G0A+eLnxO8hHxj/W4np4Sdszyi9jdn599mxhL4w9i2HGHapAnF0wdG1DgLRCJNGn/
 F2Z94JN6ftkXu2GyawR0bB9yTaLmgEmwX01lbCi34k1NFPfEUIPAmdQO8O7MWM8AnK
 BjzNHhJVaguTFM2FpsXoygaxigpe5UUmg7/Z6DdW/7kXCyB7jmWG0Us108eYmtqIGS
 OnFt9yoAQTARjrCAfRJwuUFKgDGlLIRBsTBF5/terHWRAfsstKKqrq2Lj+NIvAVPVm
 VLoQVEwLmPGWuChCe/uzOSVdcWPiVxbcgHC/gd/TmWRh+vk9+n3JQvLEd0HNI7Cb3T
 7mJP6cLP6dvCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: Use caller client for debug BO sync
To: "Shuvam Pandey" <shuvampandey1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178155468039.81818.12173237984867749651@gmail.com>
References: <178155468039.81818.12173237984867749651@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:38:06 +0000
Message-Id: <20260615203807.08A941F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a missi=
ng bounds check on user-supplied offset and size in `amdxdna_drm_sync_bo_io=
ctl`, allowing arbitrary kernel memory access via cache flushing.
- [High] This problem wasn't introduced by this patch, but there is a Use-A=
fter-Free vulnerability in `amdxdna_gem_del_bo_usage` when a shared BO outl=
ives its creator.
- [High] This problem wasn't introduced by this patch, but calling `amdxdna=
_hwctx_sync_debug_bo` or `amdxdna_drm_config_hwctx_ioctl` triggers an AA de=
adlock during runtime PM resume.
--

commit a01d4fd71144f0f677a3563f73b31b1641290aa0
Author: Shuvam Pandey <shuvampandey1@gmail.com>

accel/amdxdna: Use caller client for debug BO sync

The commit updates amdxdna_drm_sync_bo_ioctl() to use the caller's client
context rather than the BO's stored client when synchronizing the debug BO.
This ensures the client matching the provided handle is correctly used as t=
he
namespace owner.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 6e367ddb9e1be..6c16b21994abc 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1027,6 +1027,7 @@ int amdxdna_drm_get_bo_info_ioctl(struct drm_device=
 *dev, void *data, struct drm
>  int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>  			      void *data, struct drm_file *filp)
>  {
> +	struct amdxdna_client *client =3D filp->driver_priv;
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(dev);
>  	struct amdxdna_drm_sync_bo *args =3D data;
>  	struct amdxdna_gem_obj *abo;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for an
unprivileged user to trigger an out-of-bounds memory access here?

Looking at amdxdna_drm_sync_bo_ioctl(), the user-controlled args->offset and
args->size are used without validation against gobj->size:

    else if (amdxdna_gem_vmap(abo))
        drm_clflush_virt_range(amdxdna_gem_vmap(abo) + args->offset, args->=
size);

Could this allow arbitrary kernel memory access via cache flushing?

[ ... ]
> @@ -1061,7 +1062,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *de=
v,
>  		 args->handle, args->offset, args->size);
> =20
>  	if (args->direction =3D=3D SYNC_DIRECT_FROM_DEVICE)
> -		ret =3D amdxdna_hwctx_sync_debug_bo(abo->client, args->handle);

[Severity: High]
This is a pre-existing issue, but does relying on abo->client here and in
other parts of the driver risk a use-after-free if a shared BO outlives
its creator?

When a BO is exported and imported by another client, it can outlive the
original creator. If the creator closes its DRM file, abo->client is not
cleared because open_ref remains greater than 0.

When the importer finally closes the BO, amdxdna_gem_del_bo_usage() is
called and dereferences the now-freed client pointer:

amdxdna_gem_del_bo_usage()
    guard(mutex)(&client->mm_lock);

Could this cause memory corruption when the dangling client pointer is
dereferenced?

> +		ret =3D amdxdna_hwctx_sync_debug_bo(client, args->handle);

[Severity: High]
This isn't a bug introduced by this patch, but can calling
amdxdna_hwctx_sync_debug_bo() trigger an AA deadlock during runtime PM
resume?

In amdxdna_hwctx_sync_debug_bo(), the xdna->dev_lock is acquired:

    guard(mutex)(&xdna->dev_lock);
    hwctx =3D xa_load(&client->hwctx_xa, abo->assigned_hwctx);
    ...
    ret =3D xdna->dev_info->ops->hwctx_sync_debug_bo(hwctx, debug_bo_hdl);

If this hardware callback unconditionally calls amdxdna_cmd_submit(), which
then calls amdxdna_pm_resume_get(), the PM framework may synchronously
execute the resume callback amdxdna_pm_resume() if the device is suspended.

The resume callback then attempts to acquire the same lock:

amdxdna_pm_resume()
    guard(mutex)(&xdna->dev_lock);

Would this result in an AA deadlock?

> =20
>  put_obj:
>  	drm_gem_object_put(gobj);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178155468039.81818.=
12173237984867749651@gmail.com?part=3D1
