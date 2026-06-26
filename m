Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83129C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A6010F00B;
	Fri, 26 Jun 2026 13:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PkkyVx9P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9E210ED89
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:25:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95E1C600D8;
 Fri, 26 Jun 2026 13:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1D61F000E9;
 Fri, 26 Jun 2026 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782480318;
 bh=7N03x+e/uAY722IFMuRCuPrCqHXJUgsyCd+hAHe9hnI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PkkyVx9P8/4mqEMi32o6hckQNLHrotVmCHfUbV0EIxR0AX0DB4RHT5grH6MOGKt9z
 alW/6e3xsmGU9xjf12u+msa4sY8gNinEPg9U5IWOCcNfZJ/01A0XJbWojXKoB52seI
 zUhsiNYGiGXJU7BVQJMV+JbQUQj0rRDTPcCZRtcEY6tphurtJ9ony5EvwqMudDnSv1
 Y9x5h08p8aCJtt+saUWHB5zwy4L/Hd1Ytzh0dg4spzBHRZ/YJ/+QQmzyPJot3n5GSo
 kQOrrMFJE6eNORUe6Yf83kVb75AMRUQNbxNwvwfPk45wFRvs34jQmKChrjSe6WPCcl
 0c4WBVcBWW8Pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm: drm_mode_obj_get_properties_ioctl:
 DRM_MODESET_LOCK_ALL_BEGIN   retry leaks drm_mode_object reference
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626131308.37604-1-vulab@iscas.ac.cn>
References: <20260626131308.37604-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 13:25:17 +0000
Message-Id: <20260626132518.2D1D61F000E9@smtp.kernel.org>
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
- [Medium] Double-free / Use-after-free on drm_mode_object pointer during m=
odeset lock retry
--

commit 09179daaa80ba21f29576fb6c0abc2ca7e1a0fbd
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm: drm_mode_obj_get_properties_ioctl: DRM_MODESET_LOCK_ALL_BEGIN ret=
ry leaks drm_mode_object reference

This commit attempts to fix a memory leak during deadlock retries by calling
drm_mode_object_put() at the start of the lock block. It modifies the code
following the DRM_MODESET_LOCK_ALL_BEGIN macro to release the object if a
retry occurs.

> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode=
_object.c
> index 21fc9deda4371..2360c61d1ae04 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
[ ... ]
> @@ -487,6 +487,8 @@ int drm_mode_obj_get_properties_ioctl(struct drm_devi=
ce *dev, void *data,
>  		return -EOPNOTSUPP;
> =20
>  	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> +	if (obj)
> +		drm_mode_object_put(obj);
> =20
>  	obj =3D drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type=
);
>  	if (!obj) {

[Severity: Medium]
Will this result in a double-free if the retry is triggered by code within =
the
block returning -EDEADLK?

If drm_mode_object_get_properties() returns -EDEADLK, the flow proceeds to =
the
error labels:

	ret =3D drm_mode_object_get_properties(...);

out_unref:
	drm_mode_object_put(obj);
out:
	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);

The DRM_MODESET_LOCK_ALL_END macro detects the -EDEADLK, performs backoff, =
and
jumps to the modeset_lock_retry label located inside DRM_MODESET_LOCK_ALL_B=
EGIN.

Since the object was already released in out_unref, and local variables ret=
ain
their values across goto, the obj pointer remains non-NULL. The newly added
check will then call drm_mode_object_put(obj) on the same pointer again bef=
ore
finding a new object, causing a double-free.

Additionally, if drm_modeset_lock_all_ctx() itself returns -EDEADLK during =
the
initial acquisition inside DRM_MODESET_LOCK_ALL_BEGIN, it jumps over the
entire block. In that scenario, drm_mode_object_find() has not executed yet,
so there is no object to leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626131308.3760=
4-1-vulab@iscas.ac.cn?part=3D1
