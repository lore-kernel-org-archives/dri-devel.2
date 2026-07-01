Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A64C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC22F10E2ED;
	Wed,  1 Jul 2026 05:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i258u28O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996FF10E2ED
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 05:30:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54F49402FD;
 Wed,  1 Jul 2026 05:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22EA1F000E9;
 Wed,  1 Jul 2026 05:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782883835;
 bh=GPCiC7zASmQyo24QDWC3RSQpVhT9qcPbd2ezVyUxaVU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i258u28O1ZysaHOvPGSfVM1IORmoIqhqAsyCaSBGZSxROD6A36UIgJaAmYLtY1xEw
 ZCae7L94Ge1xcQSVXIIxhlbG1BtcSIQfM3NiUylPQTKUD/q1tPoJVpLRKSGdO6qOgg
 mSqyX+VqVTQ7x2tL2cRifYMZ3In0viYfGaOXxUHw1sAshSiOAVP0diHNNyCEv4Xs5f
 RQdbi/UPmb0voviJhedsOArrE/UTZsiR2YmQ9iIgOmj/O9e15t2NMBUkTFrhRZX43m
 NoRHbcr4SWuMsG7LUgaDS/L865ufCvw11nRzG4omE/B8AEtvakzyyugXTsshyOKc5I
 v5Qf3L15qpIOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/imagination: Fix returned size for
 DRM_IOCTL_PVR_DEV_QUERY
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-b4-b4-query-v2-1-a1b491387875@imgtec.com>
References: <20260701-b4-b4-query-v2-1-a1b491387875@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 05:30:34 +0000
Message-Id: <20260701053034.F22EA1F000E9@smtp.kernel.org>
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
- [Critical] In `pvr_set_uobj_array`, the pointer increments for the source=
 (kernel) and destination (userspace) are swapped when `obj_size !=3D out->=
stride`. This allows an out-of-bounds kernel memory read and memory corrupt=
ion in userspace.
--

commit da1445e748ce26b12e26b7056dc2b26080c7fd58
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Fix returned size for DRM_IOCTL_PVR_DEV_QUERY

This patch modifies how the driver overrides the returned size for subtypes
of DRM_IOCTL_PVR_DEV_QUERY. It caps the reported size so it doesn't exceed
the query structure size when the arguments specify a smaller size.

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
This is a pre-existing issue, but I noticed a potential out-of-bounds kernel
memory read when this function calls PVR_UOBJ_SET_ARRAY() earlier.

In drivers/gpu/drm/imagination/pvr_drv.c:pvr_set_uobj_array(), the pointer
increments for the source and destination appear to be swapped when
obj_size !=3D out->stride:

	void __user *out_ptr =3D u64_to_user_ptr(out->array);
	const void *in_ptr =3D in;

	for (u32 i =3D 0; i < out->count; i++) {
		if (copy_to_user(out_ptr, in_ptr, cpy_elem_size))
			return -EFAULT;

		out_ptr +=3D obj_size;
		in_ptr +=3D out->stride;
	}

Does this incorrectly advance the kernel-space source pointer (in_ptr) by t=
he
userspace-controlled out->stride?

This could allow an unprivileged user to read past the bounds of kernel
arrays by providing a large stride in the ioctl.

Should out_ptr increment by out->stride and in_ptr increment by obj_size?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-b4-b4-quer=
y-v2-1-a1b491387875@imgtec.com?part=3D1
