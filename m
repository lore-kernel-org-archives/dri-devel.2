Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34819CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB8810ECDB;
	Tue, 23 Jun 2026 21:22:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K/Ko4zjn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4080E10ECD9
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:22:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7349E60018;
 Tue, 23 Jun 2026 21:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5D11F000E9;
 Tue, 23 Jun 2026 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782249751;
 bh=WKugvH1aCySLIDS9YDuVpMFksr6jBqpxUBUp59bPR2A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K/Ko4zjnCJcRYtp8aicU4+SIeDbO+oieqEITIAxuujwbVQbnsXFQVgVU+wiYRx0Ry
 LSzsdPKW9fddDtCFcICsg9SMzhanbLYcJ7WNCRCcnIvM6vlBsCmLLW6uVKOgCrnw7y
 i3GUIKKezByge1gifOxeGoTIuuFH6wejuBdFKluyY8YQUaeWMcemTXe5xChXYElpM6
 FtrqvPFfA20rutp/PPgOlaYPlHboqKLChzRrdRju3TNkWaBWXHREBYnKEWNPyrEKpo
 03n+mNlsygiyt2tNiJM3XgjWQMMCzk3KQEpykdlduRv03nVjn1f8YnHkCujx/7m9Qd
 T1k76sjthZwRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Validate vmw_surface_metadata::array_size
To: "Ian Forbes" <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623193314.506257-1-ian.forbes@broadcom.com>
References: <20260623193314.506257-1-ian.forbes@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:22:30 +0000
Message-Id: <20260623212231.0B5D11F000E9@smtp.kernel.org>
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
- [Critical] Integer overflows and missing bounds checks in surface size co=
mputations lead to severe buffer undersizing and out-of-bounds memory acces=
s.
- [Critical] Integer truncation from `unsigned long` to `uint32_t` causes c=
ritical buffer undersize when allocating GEM objects for large surfaces.
--

commit 50825a4076b6af2aa84715573bcdaf84763db731
Author: Ian Forbes <ian.forbes@broadcom.com>

drm/vmwgfx: Validate vmw_surface_metadata::array_size

This field comes from userspace and should be validated against specific
limits depending on which Shader Model (SM) is available.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index b2d3927b55673..bd0563741e89d 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -1521,9 +1521,21 @@ vmw_gb_surface_define_internal(struct drm_device *=
dev,
>  				req->base.svga3d_flags);
> =20
>  	/* array_size must be null for non-GL3 host. */
> -	if (req->base.array_size > 0 && !has_sm4_context(dev_priv)) {
> -		VMW_DEBUG_USER("SM4 surface not supported.\n");
> -		return -EINVAL;
> +	if (req->base.array_size > 0) {
> +		if (has_sm5_context(dev_priv)) {
> +			if (req->base.array_size > SVGA3D_SM5_MAX_SURFACE_ARRAYSIZE) {
> +				VMW_DEBUG_USER("Invalid Surface Array Size.\n");
> +				return -EINVAL;
> +			}
> +		} else if (has_sm4_context(dev_priv)) {
> +			if (req->base.array_size > SVGA3D_SM4_MAX_SURFACE_ARRAYSIZE) {
> +				VMW_DEBUG_USER("Invalid Surface Array Size.\n");
> +				return -EINVAL;
> +			}
> +		} else {
> +			VMW_DEBUG_USER("SM4+ surface not supported.\n");
> +			return -EINVAL;
> +		}
>  	}

[Severity: Critical]
This is a pre-existing issue, but does the surface size computation lack
sufficient bounds checking for non-scanout formats?

If a user-space process issues a surface define ioctl for a non-scanout
format with extremely large base_size dimensions, vmw_gb_surface_define()
skips checking the maximum boundaries:

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_gb_surface_define() {
    ...
    } else {
        const SVGA3dSurfaceDesc *desc =3D
            vmw_surface_get_desc(req->format);

        if (desc->blockDesc =3D=3D SVGA3DBLOCKDESC_NONE) {
            VMW_DEBUG_USER("Invalid surface format.\n");
            return -EINVAL;
        }
    }
    ...
}

This allows massive dimensions to be processed without validation by
vmw_surface_calculate_pitch() and vmw_surface_get_serialized_size(), where
the 32-bit multiplications can wrap around:

drivers/gpu/drm/vmwgfx/vmw_surface_cache.h:vmw_surface_calculate_pitch() {
    ...
    pitch =3D blocks.width * desc->pitchBytesPerBlock;
    ...
}

Because this wraps around to a small u32 value, it can evade the U32_MAX
clamp in vmw_surface_get_serialized_size_extended(), resulting in a
tiny guest_memory_size allocation while the original massive dimensions
remain in the surface metadata. Can this lead to severe guest physical
memory corruption from out-of-bounds access?

[ ... ]

>  	} else if (req->base.drm_surface_flags &
>  		   (drm_vmw_surface_flag_create_buffer |
>  		    drm_vmw_surface_flag_coherent)) {
>  		ret =3D vmw_gem_object_create_with_handle(dev_priv, file_priv,
>  							res->guest_memory_size,
>  							&backup_handle,
>  							&res->guest_memory_bo);
>  	}

[Severity: Critical]
This isn't a bug introduced by this patch, but does the guest memory size
get silently truncated when creating the GEM object for large surfaces?

If a user-space process requests a large surface that causes
vmw_surface_get_serialized_size_extended() to return exactly U32_MAX
(the clamped maximum), and sets the SVGA3D_SURFACE_BIND_STREAM_OUTPUT flag,
vmw_gb_surface_define() unconditionally adds 16 bytes to the size:

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_gb_surface_define() {
    ...
    if (metadata->flags & SVGA3D_SURFACE_BIND_STREAM_OUTPUT)
        srf->res.guest_memory_size +=3D sizeof(SVGA3dDXSOState);
    ...
}

This pushes the 64-bit value to 0x10000000F (U32_MAX + 16). When this is
passed to vmw_gem_object_create_with_handle(), the size appears to be
truncated because the function signature takes a 32-bit size:

drivers/gpu/drm/vmwgfx/vmwgfx_gem.c:vmw_gem_object_create_with_handle() {
    int vmw_gem_object_create_with_handle(struct vmw_private *dev_priv,
                                          struct drm_file *filp,
                                          uint32_t size,
                                          uint32_t *handle,
                                          struct vmw_bo **p_vbo)
    ...
}

This truncation wraps the 0x10000000F size down to just 15 bytes. Is it
possible for this to allocate a tiny 15-byte GEM object for a surface
that the metadata considers to be 4GB, leading to massive out-of-bounds
memory overrides during surface operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623193314.5062=
57-1-ian.forbes@broadcom.com?part=3D1
