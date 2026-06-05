Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8495ACD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68D111A90D;
	Fri,  5 Jun 2026 14:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C8MUMCu6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D30C11A90D
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:39:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6418600AF;
 Fri,  5 Jun 2026 14:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CE51F00893;
 Fri,  5 Jun 2026 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780670340;
 bh=LNrCtLxbrsYYm8L4TG6n+3MmQ/E3miCy79zQk1trAj4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C8MUMCu6G01bf8qB/QMEbV+R7PMDdpS7o9OPmf2RoXO9xvcRYXE6cCe/aFNv+r1wg
 eAp4QamR1g+c+BSYrxjA5yd9A4PSjkE05aZdxNjmNzHP8cNSTCTIIu0T+JQeprAieE
 AvrczfDCf9DXph8AUD6KIws1qlV3crnp9F/peDaHNFWAXp5lPjKsKXSnQjv3Xx07cR
 i3j/Rw2FWago18q2wO6+daHtnXiyC1t5uDOL+fVM7M6SzhRE0bJ7hNsL0hVov/7DmS
 3pJdSCg9z7mY8Jwy9ewW2KSwLKl4gDnI2+nO9DjWL4WpVhcarvRC2TU0+PWVBxyQXD
 bIUgfy7CO1hHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/gem: fix signed integer overflow in idr_alloc
 end parameter
To: w15303746062@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605142644.1205922-1-w15303746062@163.com>
References: <20260605142644.1205922-1-w15303746062@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 14:38:59 +0000
Message-Id: <20260605143900.57CE51F00893@smtp.kernel.org>
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
- [Critical] A race condition exists between `drm_gem_change_handle_ioctl` =
and `DRM_IOCTL_GEM_CLOSE` due to a lockless window, allowing a Use-After-Fr=
ee, unbalanced handle counts, and IDR corruption.
- [Medium] Calling `idr_alloc` with `GFP_NOWAIT` inside a spinlock without =
a preceding `idr_preload` can cause spurious memory allocation failures.
--

commit b765b42ca862b5e1577465e07a11a3f29e24c848
Author: Mingyu Wang <25181214217@stu.xidian.edu.cn>

drm/gem: fix signed integer overflow in idr_alloc end parameter

This commit fixes a signed integer overflow vulnerability in
drm_gem_change_handle_ioctl(). It tightens the limit check to >=3D INT_MAX =
to
prevent overflow and explicitly rejects 0 as a handle, as 0 is universally
treated as an invalid handle in the DRM subsystem.

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index ac751a42db281..b42241d6802f9 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1025,8 +1025,12 @@ int drm_gem_change_handle_ioctl(struct drm_device =
*dev, void *data,
>  	if (!drm_core_check_feature(dev, DRIVER_GEM))
>  		return -EOPNOTSUPP;
> =20
> -	/* idr_alloc() limitation. */
> -	if (args->new_handle > INT_MAX)
> +	/*
> +	 * idr_alloc() limitation.
> +	 * Reject handle 0 (invalid in DRM) and strictly bound
> +	 * to < INT_MAX to avoid signed integer overflow in handle + 1.
> +	 */
> +	if (args->new_handle =3D=3D 0 || args->new_handle >=3D INT_MAX)
>  		return -EINVAL;
>  	handle =3D args->new_handle;
> =20

[Severity: Medium]
This is a pre-existing issue, but can calling idr_alloc() with GFP_NOWAIT
inside a spinlock without a preceding idr_preload() cause spurious memory
allocation failures?

drivers/gpu/drm/drm_gem.c:drm_gem_change_handle_ioctl() {
	...
	spin_lock(&file_priv->table_lock);
	...
	ret =3D idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
			GFP_NOWAIT);
	...
}

Because handle is user-controlled and can be up to INT_MAX - 1, the IDR rad=
ix
tree may need to allocate multiple deep tree nodes. Without preloading, is =
it
possible for this GFP_NOWAIT allocation to fail under memory pressure, caus=
ing
the ioctl to spuriously return -ENOMEM?

[Severity: Critical]
This is a pre-existing issue, but does a race condition exist between
drm_gem_change_handle_ioctl() and DRM_IOCTL_GEM_CLOSE due to a lockless
window?

drivers/gpu/drm/drm_gem.c:drm_gem_change_handle_ioctl() {
	...
	idr_replace(&file_priv->object_idr, NULL, args->handle);
	spin_unlock(&file_priv->table_lock);
	...
}

drm_gem_change_handle_ioctl() looks up args->handle locklessly, gaining a
temporary kref. Between this lookup and acquiring table_lock, could another
thread call DRM_IOCTL_GEM_CLOSE on args->handle, removing it from the IDR a=
nd
releasing its handle reference?

When drm_gem_change_handle_ioctl() resumes, it ignores the return value of
idr_replace(..., NULL, args->handle) and unconditionally associates
args->new_handle with obj.

Since the handle reference was dropped by the concurrent close, and this
function doesn't acquire a new one for the new handle, could obj be left in
the IDR without a corresponding handle reference?

When the temporary lookup kref is dropped via drm_gem_object_put(obj) at the
end of the function, the object is freed, but args->new_handle still points=
 to
it in the IDR. Could subsequent access to this handle trigger an exploitable
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605142644.1205=
922-1-w15303746062@163.com?part=3D1
