Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099FAC5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 17:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F0610E1EF;
	Sat, 15 Aug 2026 17:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WIhprDT0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F99510E1EF
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 17:40:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0438341E5B;
 Sat, 15 Aug 2026 17:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ED91F000E9;
 Sat, 15 Aug 2026 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786815656;
 bh=xijNIYips6LjntRdo0u408llkVxWhN9bXKJPLtYCo7Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WIhprDT0IxL/Jvq+S4WOCuw5y4MnH1Ez4lS7rABLRmTZdMDez1AacuiFhSWWtMRHR
 d3vtO3qjXZhj5M3jCgjYI6QSEf4YRItQzUMZ1BNksznh2sDA7r37q4LVysjh0YBZ0m
 9ijKiGQp8j9N002Sz9QODeLuZgVog8JeSmA+j/AVU+o9kX1WbAjnPubhN9fyBP2bY/
 s8H794xCDZTpofNYfx87H8W/ufsMFgRK9QbaWYa6lyu+I/WXXOleNLW6KH8HkgHcol
 /q/T8BCKXgGlPtesL08m43VEzHIMLK8ZtWNPfGub1eqoLytZf6vPS9NA+azMUnb7KW
 KPfN95zbNtG7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/nouveau: Fix NULL pointer dereferences in
 GETPARAM ioctl
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260815-null-fixes-v1-1-0df9dda951fb@gmail.com>
References: <20260815-null-fixes-v1-0-0df9dda951fb@gmail.com>
 <20260815-null-fixes-v1-1-0df9dda951fb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 17:40:56 +0000
Message-Id: <20260815174056.B0ED91F000E9@smtp.kernel.org>
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
- [Critical] The patch fixes a NULL pointer dereference in the `GETPARAM` i=
octl when the graphics engine (`gr`) fails to initialize but misses an iden=
tical issue in `nouveau_abi16_ioctl_get_zcull_info`.
--

--- Patch [1]: [PATCH 1/2] drm/nouveau: Fix NULL pointer dereferences in GE=
TPARAM ioctl ---
commit 6569813c05cdc1cf39cfd469b6745e81e7cad86d
Author: Jim Cromie <jim.cromie@gmail.com>

drm/nouveau: Fix NULL pointer dereferences in GETPARAM ioctl

This patch adds safety checks for the graphics engine and device functions
in the GETPARAM ioctl handler. It returns -ENODEV to signal missing
hardware state to userspace, preventing a kernel NULL pointer dereference
when initialization fails.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/no=
uveau/nouveau_abi16.c
> index 291203121f0c2..c9270c5b0fac8 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -306,7 +306,12 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
>  		getparam->value =3D 1;
>  		break;
>  	case NOUVEAU_GETPARAM_GRAPH_UNITS:
> -		getparam->value =3D nvkm_gr_units(gr);
> +		if (gr && gr->func) {
> +			getparam->value =3D nvkm_gr_units(gr);
> +		} else {
> +			NV_ERROR_ONCE(drm, "GETPARAM_GRAPH_UNITS: no gr engine or func\n");
> +			return -ENODEV;
> +		}
>  		break;

[Severity: Critical]
This is a pre-existing issue, but while you are fixing the NULL pointer
dereference of the gr pointer here, is there a similar vulnerability
in the adjacent nouveau_abi16_ioctl_get_zcull_info() function?

If the graphics engine fails to initialize and gr is NULL, as addressed by
this patch, it looks like an unprivileged userspace process could still
trigger an Oops by calling the DRM_IOCTL_NOUVEAU_GET_ZCULL_INFO ioctl,
which only requires DRM_RENDER_ALLOW.

Looking at the nouveau_abi16_ioctl_get_zcull_info() function in
drivers/gpu/drm/nouveau/nouveau_abi16.c, the gr pointer is unconditionally
dereferenced:

int
nouveau_abi16_ioctl_get_zcull_info(ABI16_IOCTL_ARGS)
{
	struct nouveau_drm *drm =3D nouveau_drm(dev);
	struct nvkm_gr *gr =3D nvxx_gr(drm);
	struct drm_nouveau_get_zcull_info *out =3D data;

	if (gr->has_zcull_info) {
		const struct nvkm_gr_zcull_info *i =3D &gr->zcull_info;
		...

Would it make sense to add a similar check for gr being NULL before
dereferencing gr->has_zcull_info?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-null-fixes=
-v1-0-0df9dda951fb@gmail.com?part=3D1
