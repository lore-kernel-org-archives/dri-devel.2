Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77344C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03B010E904;
	Mon, 29 Jun 2026 14:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aunLW5Ci";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5394310E904
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:13:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B778E60008;
 Mon, 29 Jun 2026 14:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF4D1F000E9;
 Mon, 29 Jun 2026 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782742428;
 bh=gH0O1WW7LZcg7V6s2WbI6A0Rk9jvgxjWd8ehGAhYDYk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aunLW5Cik8KdzJaCfURIQiddimEP4oWQQEO1RGINEn2XxYqKlbW9I1ED0hJlPXfxh
 B+3kdnJEo8lPO4eDpfc+BeZTWGjyGluoAfl7DFjCAQEU+OnlmnPcBo/8k+N0yxnQNH
 GHGBbzpNrVuj6G9CyAInLU5vNaRF5ook57T8n+blu0G1LUxvEx4wg37c4Guzi3icNF
 Ide+2ZTYAXjScFoa+WkBAz+altIwwL60kFaBpgzzSniB01BFLRhUTUb0D8tkiXOYit
 qgLpnrpq8dCDReBMYARyWe9gSMiN8cDQqolufEI0XxDTjKnUme1gSRuReqBuOc8fqG
 CYhAXPMnKLuHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Fix returned size for
 DRM_IOCTL_PVR_DEV_QUERY
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629-b4-b4-query-v1-1-d17fe10b32c4@imgtec.com>
References: <20260629-b4-b4-query-v1-1-d17fe10b32c4@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:13:47 +0000
Message-Id: <20260629141348.1EF4D1F000E9@smtp.kernel.org>
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
- [Critical] Arbitrary kernel memory leak and local denial of service via s=
wapped pointer increments in `pvr_set_uobj_array`.
--

commit 6b5a278856eb4ef8ab480c543efc90923416bfbf
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Fix returned size for DRM_IOCTL_PVR_DEV_QUERY

This commit updates DRM_IOCTL_PVR_DEV_QUERY to ensure the returned size
does not exceed the size of the query structure. It prevents the driver
from unconditionally overriding the size reported to userspace.

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index ca3042d14253b..ee86c74df0d7a 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
[ ... ]
> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index e1ec60f34b6e6..396d349fb6ce4 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> @@ -1019,7 +1019,8 @@ pvr_static_data_areas_get(const struct pvr_device *=
pvr_dev,
>  	if (err < 0)
>  		return err;
> =20
> -	args->size =3D sizeof(query);
> +	if (args->size > sizeof(query))
> +		args->size =3D sizeof(query);

[Severity: Critical]
This is a pre-existing issue, but since this function uses=20
PVR_UOBJ_SET_ARRAY() to copy static_data_areas to userspace, could this lead
to an out-of-bounds kernel memory leak?

Looking at the underlying pvr_set_uobj_array() function in=20
drivers/gpu/drm/imagination/pvr_drv.c, the pointer increments in the copy l=
oop
appear to be swapped:

drivers/gpu/drm/imagination/pvr_drv.c:pvr_set_uobj_array() {
    ...
    for (u32 i =3D 0; i < out->count; i++) {
        if (copy_to_user(out_ptr, in_ptr, cpy_elem_size))
            return -EFAULT;

        out_ptr +=3D obj_size;
        in_ptr +=3D out->stride;
    }
    ...
}

Here in_ptr (the kernel source) is incremented by out->stride (which is
controlled by userspace), while out_ptr (the userspace destination) is
incremented by obj_size (the kernel's structure size).

If userspace provides an arbitrarily large stride via DRM_IOCTL_PVR_DEV_QUE=
RY,
would this cause in_ptr to read unmapped kernel memory or leak arbitrary
kernel memory to userspace?

Additionally, the padding clearance in that same function seems to be
misplaced outside the loop:

drivers/gpu/drm/imagination/pvr_drv.c:pvr_set_uobj_array() {
    ...
    if (out->stride > obj_size &&
        clear_user(u64_to_user_ptr(out->array + obj_size),
               out->stride - obj_size)) {
        return -EFAULT;
    }
    ...
}

Does this leave the padding for subsequent array elements uncleared since it
only runs once at the end?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-b4-b4-quer=
y-v1-1-d17fe10b32c4@imgtec.com?part=3D1
