Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CFCC61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FCC10F302;
	Fri, 28 Aug 2026 09:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HlKT/fqN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4DD10F304
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:05:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C790601FD
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8861F000E9;
 Fri, 28 Aug 2026 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787907912;
 bh=+Fxogp5/4UbgJNbzriuczM68hflHOmSHOPcb3KIH3O4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HlKT/fqNVXFHzT5EMY4addvQ5jg+yUQCwy0aKMF4g1ydfgfwd0K7FRRqtdr1gGOwD
 PKugnHP3jZUXKsPI1f1Bik5sCJBvtemOWTt5N1TllESNaohHVswq1bAKlZIJeyp7m/
 6Bc6EuwYGeoqhZJDuCoHckw0iXBkTr/OniSdVfSgvtNa5xTnlbGaNrd+AGVHKL678u
 QAxpJpsSXIxoRTF6WWOBCig8ArXznb3q9yJk5xWkNa6+qpHlXlLzB68AXE64RNJknW
 wCbd85h0ezt7BP5beUl7c+LAXr5gA5wMqaW3qiblYfw/cTb0c3jAY06T1g6hWMGUkT
 V/7UBfK3syBbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/qxl: fix use-after-free and NULL pointer deref
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828085136.128561-1-jirislaby@kernel.org>
References: <20260828085136.128561-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:05:11 +0000
Message-Id: <20260828090511.DB8861F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Ignoring the return value of `qxl_release_list_add()` can lead to =
a use-after-free of a buffer object by the hardware.
- [High] Sleeping in atomic context during plane updates.
--

commit f18d8a877369f4db994d43ef4a35d9b13d174685
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>

drm/qxl: fix use-after-free and NULL pointer deref

When allocating a qxl_release structure with kmalloc(), the underlying
memory contained uninitialized garbage. Specifically, release->base.flags
(part of the embedded dma_fence) was not cleared.

Closes: https://bugzilla.suse.com/show_bug.cgi?id=3D1271081

> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_=
release.c
> index 06979d0e8a9f0..07dc6eafe6f7f 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -89,17 +89,13 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
>  {
>  	struct qxl_release *release;
>  	int handle;
> =20
> -	release =3D kmalloc(size, GFP_KERNEL);
> +	release =3D kzalloc_obj(*release);
>  	if (!release) {
>  		DRM_ERROR("Out of memory\n");
>  		return -ENOMEM;
>  	}
> -	release->base.ops =3D NULL;
>  	release->type =3D type;
> -	release->release_offset =3D 0;
> -	release->surface_release_id =3D 0;
>  	INIT_LIST_HEAD(&release->bos);
> =20
>  	idr_preload(GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but does this code sleep in an
atomic context?

Looking at the plane update paths, qxl_primary_atomic_update() is an atomic
commit callback where sleeping is forbidden. It appears to call
qxl_release_alloc() through this chain:

qxl_primary_atomic_update()
  qxl_draw_dirty_fb()
    alloc_drawable()
      qxl_alloc_release_reserved()
        qxl_release_alloc()

Can kzalloc_obj() and idr_preload(GFP_KERNEL) sleep here? Additionally,
qxl_alloc_release_reserved() acquires a mutex before calling this function,
which could also cause deadlocks in an atomic context.


[Severity: High]
This is also a pre-existing issue, but can ignoring the return value of
qxl_release_list_add() lead to a hardware use-after-free?

In drivers/gpu/drm/qxl/qxl_release.c:qxl_alloc_surface_release_reserved():

    qxl_release_list_add(*release, bo);

If qxl_release_list_add() fails (e.g. returning -ENOMEM), the BO is not
added to the list and its reference count is not incremented. However, the
function ignores this failure and continues, returning success. When the
hardware ring processes the command referencing this BO, could the BO memory
be freed prematurely if the original reference is dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828085136.1285=
61-1-jirislaby@kernel.org?part=3D1
