Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF47CC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9F210E457;
	Mon, 17 Aug 2026 20:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F0t0SRBa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCF510E457
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:18:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0235D40628;
 Mon, 17 Aug 2026 20:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFA51F000E9;
 Mon, 17 Aug 2026 20:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786997921;
 bh=fer7itHLWFo3y73Etd/h/e+rcM/YaRVEn5jG4HmTdH4=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=F0t0SRBaDrgn3MeTVBS8+8rrEaszww1HtnTbMx/KNEzJcuHEJ3Cess3H178pHKnG+
 2+4yGpNi79hfFri21cLMHR3EQYQN2viaazV0jMc2/zBfYGEYNYrPxRtz96/KRtyma9
 KqoDY2AeYDdQGdQTxlWHBzhDdj7+OldEnd+p6tIZQQug7ZIwpKR6r0YIvhqVy/8e7j
 80Ap14mGJ/2AxHvLUEw2SGSl+hLnA811Pg2bEpshWRmdw0N3SAiceorX8ed+ex9fOL
 CQTP6jFQMjdSiXgsUEhWMC6oLRYVo8Lnup9MbG3qkWrrymKzgp4hiWeliXP8cPzZ63
 Sq29F8tZAr5Nw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 22:18:38 +0200
Message-Id: <DKRHW6G6P4K5.15H1A4DGR6672@kernel.org>
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 4/7] drm: nova: Add a GPU info ioctl
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-5-apopple@nvidia.com>
In-Reply-To: <20260811050657.646799-5-apopple@nvidia.com>
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

On Tue Aug 11, 2026 at 7:06 AM CEST, Alistair Popple wrote:
> diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
> index ea7665383644..2604e4d2698b 100644
> --- a/include/uapi/drm/nova_drm.h
> +++ b/include/uapi/drm/nova_drm.h
> @@ -118,9 +118,34 @@ struct drm_nova_gem_info {
>  	__u64 size;
>  };
> =20
> +/**
> + * struct drm_nova_gpu_info - query DRM GPU info.
> + */
> +struct drm_nova_gpu_info {
> +	/**
> +	 * @size: The amount of space allocated by userspace for this structure=
.
> +	 * The kernel will return the amount of data it did/could actually writ=
e.
> +	 * User space can use this to determine how much of the struct is valid
> +	 * when running against an older kernel.
> +	 */
> +	__u64 size;
> +
> +	/**
> +	 * @chipid: GPU chip identifier. See &enum drm_nova_chipid for currentl=
y
> +	 * known chip identifiers.
> +	 */
> +	__u32 chipid;
> +
> +	/**
> +	 * @pad: 32 bit padding, must be 0.
> +	 */
> +	__u32 pad;
> +};

I think we should add the indirection we discussed in [1], i.e. have an
indirection via

	struct drm_nova_info {
		__u32 id;
		__u32 size;
		__u64 info;
		/* Revserved fields, just in case? */
	};

so we can easily add new info structures, or extend an existing one with a =
v2
without having to create new ioctls for this purpose.

[1] https://lore.kernel.org/nova-gpu/DKC6T1DQX2L3.HTHPB2L167TC@kernel.org/

>  #define DRM_NOVA_GETPARAM		0x00
>  #define DRM_NOVA_GEM_CREATE		0x01
>  #define DRM_NOVA_GEM_INFO		0x02
> +#define DRM_NOVA_GPU_INFO		0x03
> =20
>  /* Note: this is an enum so that it can be resolved by Rust bindgen. */
>  enum {
> @@ -130,6 +155,8 @@ enum {
>  						   struct drm_nova_gem_create),
>  	DRM_IOCTL_NOVA_GEM_INFO		=3D DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_I=
NFO,
>  						   struct drm_nova_gem_info),
> +	DRM_IOCTL_NOVA_GPU_INFO		=3D DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GPU_I=
NFO,
> +						   struct drm_nova_gpu_info),
>  };
> =20
>  #if defined(__cplusplus)
> --=20
> 2.54.0

