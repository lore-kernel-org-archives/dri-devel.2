Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE3110AB832
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE6910EAB0;
	Thu, 26 Mar 2026 23:39:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R0SZu8VZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B8F10EAB0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 23:39:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A09EA40AC1;
 Thu, 26 Mar 2026 23:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC028C116C6;
 Thu, 26 Mar 2026 23:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774568377;
 bh=MiT8ZV+7RfdHE/6jDwL7NJzlSNwavzfqYu9JOAIr5nQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=R0SZu8VZt0BbFTv9GlGLwRtUOFEF/OOxc0PEOxt+bwlNjSo8w79wAhRuBGctk47dw
 QvbGuDkgedI49upIaOP9fm70ZbnjaJMoBvsPWPcmKDgCjgBMC9bxCNQ/Ws4++kmqf9
 zpLHbpTY+uuFRnFiL6Eu4KPXPnfl3Zv+6dTsqRVw5/rUZrU9My3xSMzG+cSx1Li9Ie
 i3/lfF95955hmXmlQY9Osiv9eSl5wNsedMN4QtaD31TZXQuoJx/IlgLp9+ClLZmQpA
 4bUQ1EDpFdlHEc164TuYfAyuyBOKJ2yGJGIFzFCL5q8pu63ldkVkKU7Yvcjw/xNh1Z
 E8G5VaRzRRrsA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 00:39:33 +0100
Message-Id: <DHD3ZK92KSI6.1CHSK2HLBSQI0@kernel.org>
Subject: Re: [PATCH v5 07/11] drm/gpuvm: Ensure correctness of unmap/remaps
 of repeated regions
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Steven Price" <steven.price@arm.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Janne Grunau" <j@jannau.net>,
 <kernel@collabora.com>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
To: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
 <20260313150956.1618635-8-adrian.larumbe@collabora.com>
In-Reply-To: <20260313150956.1618635-8-adrian.larumbe@collabora.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri Mar 13, 2026 at 4:09 PM CET, Adri=C3=A1n Larumbe wrote:
> When an unmap or map operation that leads to a remap intersects with a
> GPU VA that spans over a repeated range, the newly spawned VAs must
> preserve the repeated property, ie, VA's range must be a multiple of
> gem.range, and also the VA's start address must be on a gem.range
> boundary. When this doesn't hold, disallow such operations and notify
> UM with an invalid argument error.
>
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/drm_gpuvm.c | 67 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_gpuvm.h     |  7 +++-
>  2 files changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index ca7445f767fc..80750119221d 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -2462,6 +2462,65 @@ static int validate_map_request(struct drm_gpuvm *=
gpuvm,
>  	return 0;
>  }
> =20
> +static int
> +validate_repeated_unmap_request(struct drm_gpuvm *gpuvm,
> +				u64 req_addr, u64 req_end)

I think the name is misleading, this is called from both __drm_gpuvm_sm_map=
()
and __drm_gpuvm_sm_unmap().

> +{
> +	struct drm_gpuva *first, *last, *va;
> +	u64 multiple;
> +
> +	if (!(gpuvm->flags & DRM_GPUVM_HAS_REPEAT_MAPS))
> +		return 0;
> +
> +	/* Find the first and last VAs the map request intersects with */
> +	first =3D last =3D NULL;
> +	drm_gpuvm_for_each_va_range(va, gpuvm, req_addr, req_end) {
> +		if (!first)
> +			first =3D va;
> +		last =3D va;
> +	}

Can't this be covered with two calls to drm_gpuva_find_first()? I.e. for th=
e
last you can call drm_gpuva_find_first(gpuvm, req_end - 1, 1), as you are o=
nly
interested if it spans across the req_end boundary.

This way this becomes O(log N) rather than O(N), where N can actually be ve=
ry
large.

> +
> +	if (!first)
> +		return 0;
> +
> +	if (first->flags & DRM_GPUVA_REPEAT) {
> +		u64 addr =3D first->va.addr;
> +		u64 range =3D first->va.range;
> +		u64 end =3D addr + range;
> +
> +		drm_WARN_ON(gpuvm->drm, first->gem.repeat_range =3D=3D 0);

How can this ever happen? Why do we need to check it here? If that's invali=
d
reject it when creating the VA instead.

> +
> +		if (addr < req_addr) {
> +			multiple =3D req_addr;
> +			if (do_div(multiple, first->gem.repeat_range))
> +				return -EINVAL;
> +		}
> +
> +		if (end > req_end) {
> +			multiple =3D req_end;
> +			if (do_div(multiple, first->gem.repeat_range))
> +				return -EINVAL;
> +			return 0;
> +		}
> +	}
> +
> +	if ((first !=3D last) && (last->flags & DRM_GPUVA_REPEAT)) {
> +		u64 addr =3D last->va.addr;
> +		u64 range =3D last->va.range;
> +		u64 end =3D addr + range;
> +
> +		drm_WARN_ON(last->vm->drm, last->gem.repeat_range =3D=3D 0);
> +
> +		if (end > req_end) {
> +			multiple =3D req_end;
> +			if (do_div(multiple, last->gem.repeat_range))
> +				return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
