Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB4610AB82E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F8810EB78;
	Thu, 26 Mar 2026 23:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SExRwnYV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07D010EA33
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 23:18:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A9E5343B92;
 Thu, 26 Mar 2026 23:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A22C116C6;
 Thu, 26 Mar 2026 23:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774567091;
 bh=UmIsA1Hp8/Hqt5C7CdY95JzKtszZD0igX6Ar7eTPMHM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=SExRwnYVKoPF3hQ7zlSdsGgq6dYMvN+Wyoa3S1kU6uFxcF6Y8HwNQmjq7/0sT/2MY
 iT5BjKYa4zN9JrnuXx3N61lTWWNWfTY+xJDk490WS9XFpurxlLR+brm1bYA0Ej/GLO
 YWV3DjOvZFwFq0hz/B3hpUJIZfsSShvbBw22vy6170lyYmlZeh/FzG4C4+FItQcNdg
 fbi5LQzOMZ81dyheuXDr/vj+q4qydPc2ygObYac7LmsM6ITXRUNYyPd9i6Nag66hJH
 cGngck+wG74Fx2UW3AsARA+eRlJaPYcb9COcOT3VzCLizNMiOu5VdJyM0UvZY3qrek
 IvkbPo7tT3b9w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 00:18:06 +0100
Message-Id: <DHD3J5BKEG5P.U0R7DT73MJ0Q@kernel.org>
Subject: Re: [PATCH v5 06/11] drm/gpuvm: Add DRM_GPUVA_REPEAT flag and logic
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Steven Price" <steven.price@arm.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Janne Grunau" <j@jannau.net>,
 <kernel@collabora.com>, "Asahi Lina" <lina+kernel@asahilina.net>, "Caterina
 Shablia" <caterina.shablia@collabora.com>, "Matthew Brost"
 <matthew.brost@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
To: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
 <20260313150956.1618635-7-adrian.larumbe@collabora.com>
In-Reply-To: <20260313150956.1618635-7-adrian.larumbe@collabora.com>
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
> From: Asahi Lina <lina+kernel@asahilina.net>
>
> To be able to support "fake sparse" mappings without relying on GPU page
> fault handling, drivers may need to create large (e.g. 4GiB) mappings of
> the same page repeatedly (or same range of pages). Doing this through
> individual mappings would be very wasteful. This can be handled better
> by using a flag on map creation, but to do it safely, drm_gpuvm needs to
> be aware of this special case.
>
> Add a flag that signals that a given mapping is a page mapping, which is
> repeated all over the entire requested VA range. This tweaks the
> sm_map() logic to treat the GEM offsets differently when mappings are
> a repeated ones so they are not incremented as they would be with regular
> mappings.
>
> The size of the GEM portion to repeat is passed through
> drm_gpuva::gem::range. Most of the time it will be a page size, but
> it can be bigger as long as it's less than drm_gpuva::va::range, and
> drm_gpuva::va::range is a multiple of drm_gpuva::gem::range.
>
> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>

In v4 I also mentioned:

	I also think this feature deserves its own section in the global GPUVM
	documentation -- please add a corresponding paragraph.

	Also it seems that we need to update the documentation which shows all pot=
ential
	cases when calling __drm_gpuvm_sm_map() [1].

	[1] https://docs.kernel.org/gpu/drm-mm.html#split-and-merge

Why did this not happen?

> +static int validate_map_request(struct drm_gpuvm *gpuvm,
> +				const struct drm_gpuva_op_map *op)
> +{
> +	if (unlikely(!drm_gpuvm_range_valid(gpuvm, op->va.addr, op->va.range)))
> +		return -EINVAL;
> +
> +	if (op->flags & DRM_GPUVA_REPEAT) {
> +		u64 va_range =3D op->va.range;
> +
> +		/* For a repeated mapping, GEM range must be > 0
> +		 * and a multiple of the VA range.
> +		 */
> +		if (unlikely(!op->gem.repeat_range ||
> +			     va_range < op->gem.repeat_range ||
> +			     do_div(va_range, op->gem.repeat_range)))
> +			return -EINVAL;
> +	}
> +
> +	if (op->flags & DRM_GPUVA_INVALIDATED)
> +		return -EINVAL;

This seems unrelated to this patch.

> +
> +	return 0;
> +}
> +
>  static int
>  __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  		   const struct drm_gpuvm_ops *ops, void *priv,
> @@ -2429,7 +2475,8 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  	u64 req_end =3D req_addr + req_range;
>  	int ret;
> =20
> -	if (unlikely(!drm_gpuvm_range_valid(gpuvm, req_addr, req_range)))
> +	ret =3D validate_map_request(gpuvm, &req->map);
> +	if (unlikely(ret))
>  		return -EINVAL;
> =20
>  	drm_gpuvm_for_each_va_range_safe(va, next, gpuvm, req_addr, req_end) {
> @@ -2463,7 +2510,9 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  					.va.addr =3D req_end,
>  					.va.range =3D range - req_range,
>  					.gem.obj =3D obj,
> -					.gem.offset =3D offset + req_range,
> +					.gem.repeat_range =3D va->gem.repeat_range,
> +					.gem.offset =3D offset +
> +						(va->flags & DRM_GPUVA_REPEAT ? 0 : req_range),

This seems to be a repeating pattern, can we factor this into a helper?
