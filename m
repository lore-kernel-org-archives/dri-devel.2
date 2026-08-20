Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C5FC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C52910E205;
	Thu, 20 Aug 2026 17:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F9DK0Pv6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6857310E205
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:01:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 148124143D;
 Thu, 20 Aug 2026 17:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EFD1F000E9;
 Thu, 20 Aug 2026 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787245308;
 bh=GuE3U2xRbBuChW//HOVsJ8ZJ4XXTTJed6ret8aeM5mY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F9DK0Pv6Z0HeriJCzSw3cYN+tKxw0SHL7OXNz1jYUP5kwIpdfoUPLD4bzbwqmTb1f
 tk0zqoa8b7Z8a6k8Ebl0tgiUdjVk4AWcjUASfpB6DDoTncUGs46l337/wUeJLiB7yB
 6eFRqZO6rfd1FBS/hlv7qgmwWVppJCKiKHz+sN9IvAaiiYuAgnzFeA7+qZyqJ58p8F
 v6l0lUj7s5lWNLcK+iwYz0n5o2n4YDY01DxUdNh4hMv2CP4Igk3Wc2etDZ6cathz3G
 bEC0c7StIen7+02R6d+jc0j1jQMizOMOSmpOD5HUKr8D4s+FVC++e01R6JNS3Zvwou
 MsdBTbDjokh7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] drm/nouveau/disp: route GSP-RM display MMIO
 through nvkm_disp_func hooks
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820164929.17117-4-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-4-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 17:01:47 +0000
Message-Id: <20260820170147.C0EFD1F000E9@smtp.kernel.org>
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
- [Critical] Pre-existing Use-After-Free and Double Free in `r535_disp_new`=
 error path when `nvkm_disp_new_` fails after subdev registration.
- [High] Pre-existing NULL pointer dereference in the error path of `r535_d=
isp_new` due to unconditional lock initialization on a potentially NULL poi=
nter.
--

--- Patch [3]: [PATCH v2 03/10] drm/nouveau/disp: route GSP-RM display MMIO=
 through nvkm_disp_func hooks ---
commit eaafa1eb740ad36427480951cde140701ddc6d3a
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

drm/nouveau/disp: route GSP-RM display MMIO through nvkm_disp_func hooks

The GSP-RM display code in rm/r535/disp.c borrows a few
register-programming routines from engine/disp (the head-timing
interrupt handler, vblank enables, armed head state and scanout position
readback, the AVI/VSI infoframe writers and the GCP AVMute write) and so
far picked them by name, which means it has to know which chip it runs
on the moment a generation changes any of them.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index cd4451e625122..f3e55253bcbca 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
[ ... ]
> @@ -1688,6 +1729,7 @@ r535_disp_new(const struct nvkm_disp_func *hw, stru=
ct nvkm_device *device,
>  	rm->uevent =3D hw->uevent;
>  	rm->sor.cnt =3D r535_sor_cnt;
>  	rm->sor.new =3D r535_sor_new;
> +	rm->gsp =3D hw->gsp;
>  	rm->ramht_size =3D hw->ramht_size;
> =20
>  	rm->root.oclass =3D gpu->disp.class.root;

[Severity: Critical]
This is a pre-existing issue, but can the error path in r535_disp_new() lead
to a use-after-free and double-free?

If nvkm_disp_new_() fails after subdev registration, the subdevice is alrea=
dy
attached to the device's subdev list. r535_disp_new() handles the error by
freeing the dynamically allocated rm struct:

	ret =3D nvkm_disp_new_(rm, device, type, inst, pdisp);
	if (ret)
		kfree(rm);

However, disp->func still points to this freed memory. Later, during device
teardown on the error path, nvkm_subdev_del() invokes nvkm_disp_dtor() which
evaluates the pointer:

	if (disp->func && disp->func->dtor)
		disp->func->dtor(disp);

This dereferences the freed rm struct and calls r535_disp_dtor(), which
subsequently executes kfree(disp->func), causing a double-free.

[Severity: High]
This is another pre-existing issue, but can the same error path cause a NULL
pointer dereference?

If nvkm_disp_new_() fails early before allocating the struct, *pdisp is set
to NULL. r535_disp_new() then unconditionally attempts to initialize a mutex
on it:

	ret =3D nvkm_disp_new_(rm, device, type, inst, pdisp);
	if (ret)
		kfree(rm);

	mutex_init(&(*pdisp)->super.mutex);
	return ret;

Passing an offset from NULL to mutex_init() will cause a panic when it tries
to write to the mutex fields.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820164929.1711=
7-1-mohamedahmedegypt2001@gmail.com?part=3D3
