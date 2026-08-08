Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386DCC5AD48
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 23:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66BC710E092;
	Sat,  8 Aug 2026 23:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J2kIPwQJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C14110E092
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 23:26:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66F8241372;
 Sat,  8 Aug 2026 23:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C977C1F000E9;
 Sat,  8 Aug 2026 23:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786231606;
 bh=5r/7HEfK+cX34PmBGc8Vwb2p4lrukmMzFygQoaKetec=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J2kIPwQJ0DPNwut9gxQWNUJsri4amD31JaMrNtSg+8M7YPeFVxA+gUcgsOiguu9Yj
 Z3OQ1t1MCbmNrwWEf9sHPfBS92/Hg0E9KmvCP2XkTzgr8qtS9WAp7lS3GWF4XiR/Jj
 U0icrQE/r6UWrKpuKlmpA6+Ok3nEaEgIacmMdF9nZnpnlWN7shrhFCQifXbN4zwfew
 VZm+88pT7WBdR9qXthnB66EMrat/rcy3JQIuI2guBFrC2VbYlu3HniyJYypdDtiokW
 /SSOKoDlwMTmKo7KGAeZCUWEQTnZE4EPfuO7fZtLpXFyOZ1qN34AgWZ8OpP+WVJUU6
 5w3BaqryRHxbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size
 computation
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808230945.67525-1-qwe.aldo@gmail.com>
References: <20260808230945.67525-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 23:26:45 +0000
Message-Id: <20260808232645.C977C1F000E9@smtp.kernel.org>
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
- [High] The integer overflow fix for surface size computation remains vuln=
erable on 32-bit architectures due to wrap-around in the addition operation=
 before the overflow check.

Pre-existing issues:
- [High] A memory leak of a GEM object occurs if handle creation fails in `=
qxl_gem_object_create_with_handle()`.
--

--- Patch [1]: [PATCH] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size =
computation ---
commit 49a28e971687973dbde5077170aba70504fc31af
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/qxl: fix 32-bit overflow in the ALLOC_SURF size computation
   =20
The patch attempts to fix an integer overflow in the QXL_ALLOC_SURF ioctl
by checking for multiplication overflow and bounding the result, but some
edge cases remain.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index 591b026ceff9c..f245ead003802 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c

[ ... ]

> @@ -386,12 +387,26 @@ int qxl_alloc_surf_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *fi
>  	struct drm_qxl_alloc_surf *param =3D data;
>  	int handle;
>  	int ret;
> -	int size, actual_stride;
> +	int actual_stride;
> +	size_t size;
>  	struct qxl_surface surf;
> =20
>  	/* work out size allocate bo with handle */
> +	if (param->stride =3D=3D INT_MIN)
> +		return -EINVAL;
>  	actual_stride =3D param->stride < 0 ? -param->stride : param->stride;
> -	size =3D actual_stride * param->height + actual_stride;
> +	if (!actual_stride || !param->width || !param->height)
> +		return -EINVAL;
> +	/*
> +	 * size =3D actual_stride * (height + 1), evaluated in a type that cann=
ot
> +	 * wrap, then bounded so it survives the int parameter of
> +	 * qxl_gem_object_create().
> +	 */
> +	if (check_mul_overflow((size_t)actual_stride,
> +			       (size_t)param->height + 1, &size))
> +		return -EINVAL;

[Severity: High]
On 32-bit platforms where size_t is 32 bits, can the addition
(size_t)param->height + 1 wrap around before the overflow check occurs?

For example, if userspace passes 0xFFFFFFFF for height, does this evaluate
to 0, resulting in size =3D 0 and bypassing the overflow protection entirel=
y?

> +	if (size > INT_MAX)
> +		return -EINVAL;
> =20
>  	surf.format =3D param->format;
>  	surf.width =3D param->width;

[Severity: High]
This is a pre-existing issue, but does qxl_gem_object_create_with_handle()
leak the GEM object if handle creation fails?

Further down in qxl_alloc_surf_ioctl(), we call=20
qxl_gem_object_create_with_handle(). Looking at that function in=20
drivers/gpu/drm/qxl/qxl_gem.c:

int qxl_gem_object_create_with_handle(...)
{
        ...
        r =3D drm_gem_handle_create(file_priv, local_gobj, handle);
        if (r)
                return r;
        ...
}

If drm_gem_handle_create() fails, it returns without calling
drm_gem_object_put() to drop the initial reference on local_gobj. Could
a malicious userspace program repeatedly allocate surfaces until handle
creation fails to exhaust memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808230945.6752=
5-1-qwe.aldo@gmail.com?part=3D1
