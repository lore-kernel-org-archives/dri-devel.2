Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1559FC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D17310E2B7;
	Mon, 31 Aug 2026 14:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NrjyBR6B";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF81F10E2B7
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:44:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C387860204
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B571F000E9;
 Mon, 31 Aug 2026 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788187495;
 bh=b2imqHIaSGsyFT8jD6/C0ecg4yzhzYMVqJdCsQDqE7Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NrjyBR6BpaHqAh00+fww+vasvWMnhQRDMnSOBu/SOzn8L9NPLDZdr9dNpgyya+mce
 ASkZt8kKx/m+9AHFEZUIVSJtbSmePTfitSY0k293iJx5CNWuZ+9Ai0NLvueYcHoYGW
 XKmXenChfZNyjTDrirTW3pPdhYzGk1TDnR2QgU/YyjI4Dr/EiZMI6u7m6CXLTO8Qva
 fY/34AzRGupxwqxrc9td9zie6HhTfJkkkvS2XW4RTzn2fc5LrBVpKBoDodu8Zh53Gf
 vDxH6R2RnIMfwk6tarEF+sFW6MP9G9KLzZ3gvb3vHqGHnD2hfucETD6+9xc6q3hvXh
 ldxFkO0mll5kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] drm/amdkfd: Let driver decide buffer
 size at AMDKFD_IOC_GET_DMABUF_INFO ioctl
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-158-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-158-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:44:54 +0000
Message-Id: <20260831144455.58B571F000E9@smtp.kernel.org>
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

New issues:
- [Critical] The ioctl now fails with -EINVAL for callers requesting BO inf=
o without a metadata buffer, breaking backward compatibility.
- [High] Missing dma_buf reference cleanup on the kzalloc failure path lead=
s to a reference leak.

Pre-existing issues:
- [High] Lockless access to BO metadata may race with concurrent metadata u=
pdates, leading to a UAF and info leak.
--

commit 98042267674366568e68066442c1f4f8b9968f33
Author: Xiaogang Chen <xiaogang.chen@amd.com>

drm/amdkfd: Let driver decide buffer size at AMDKFD_IOC_GET_DMABUF_INFO ioc=
tl

This commit hardens the AMDKFD_IOC_GET_DMABUF_INFO ioctl by allocating the
metadata buffer based on the driver-queried BO metadata size rather than a
user-provided size. This prevents an issue where a malicious render-group
user could provide an extremely large size to trigger a kernel OOM.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c

[ ... ]

> @@ -563,9 +563,24 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_devi=
ce *adev, int dma_buf_fd,
>  		*dmabuf_adev =3D adev;
>  	if (bo_size)
>  		*bo_size =3D amdgpu_bo_size(bo);
> -	if (metadata_buffer)
> -		r =3D amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
> -					   metadata_size, &metadata_flags);
> +	if (metadata_buffer) {
> +		/* first get metadata_size by buffer =3D NULL */
> +		r =3D amdgpu_bo_get_metadata(bo, NULL, 0,
> +					   metadata_size, NULL);

[Severity: High]
This is a pre-existing issue, but does lockless access to the BO metadata
here race with concurrent metadata updates?

Another thread could call amdgpu_gem_metadata_ioctl() which frees and
reallocates ubo->metadata. If the free occurs while the inner memcpy()
inside amdgpu_bo_get_metadata() is executing, it might read freed memory
and copy it to userspace. Should the reservation lock (amdgpu_bo_reserve)
be held before reading metadata here?

> +
> +		/* user buf_size is bigger than bo metadata_size
> +		 * allocate a buf at kernel space and copy */
> +		if (*metadata_size <=3D buffer_size) {
> +			*metadata_buffer =3D kzalloc(*metadata_size, GFP_KERNEL);
> +
> +			if (!*metadata_buffer)
> +				return -ENOMEM;

[Severity: High]
Does this direct return skip the out_put label and leak the dma_buf
reference?=20

If kzalloc() fails, returning -ENOMEM directly bypasses the
dma_buf_put(dma_buf) call at the end of the function.

> +
> +			r =3D amdgpu_bo_get_metadata(bo, *metadata_buffer, *metadata_size,
> +						   NULL, &metadata_flags);
> +		} else
> +			r =3D -EINVAL;
> +	}
>  	if (flags) {
>  		*flags =3D (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>  				KFD_IOC_ALLOC_MEM_FLAGS_VRAM

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c

[ ... ]

> @@ -1520,16 +1520,10 @@ static int kfd_ioctl_get_dmabuf_info(struct file =
*filep,
>  	if (!dev)
>  		return -EINVAL;
> =20
> -	if (args->metadata_ptr) {
> -		metadata_buffer =3D kzalloc(args->metadata_size, GFP_KERNEL);
> -		if (!metadata_buffer)
> -			return -ENOMEM;
> -	}
> -
>  	/* Get dmabuf info from KGD */
>  	r =3D amdgpu_amdkfd_get_dmabuf_info(dev->adev, args->dmabuf_fd,
>  					  &dmabuf_adev, &args->size,
> -					  metadata_buffer, args->metadata_size,
> +					  &metadata_buffer, args->metadata_size,

[Severity: Critical]
Will unconditionally passing this pointer break backwards compatibility for
callers who explicitly opt out of fetching metadata?

Previously, if args->metadata_ptr was 0, metadata_buffer was NULL, and
amdgpu_amdkfd_get_dmabuf_info() would skip the metadata fetch entirely.
Now, because &metadata_buffer is unconditionally passed, the pointer is
never NULL inside amdgpu_amdkfd_get_dmabuf_info().

If userspace requests basic BO info without metadata by providing
args->metadata_ptr =3D 0 and args->metadata_size =3D 0, but the BO actually
contains metadata, the *metadata_size <=3D buffer_size condition in
amdgpu_amdkfd_get_dmabuf_info() will fail. This causes the ioctl to
unexpectedly return -EINVAL, even though the caller did not want the
metadata in the first place.

>  					  &args->metadata_size, &flags, &xcp_id);
>  	if (r)
>  		goto exit;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-158-sashal@kernel.org?part=3D1
