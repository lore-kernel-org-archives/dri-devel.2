Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BAFC531FC
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4618C10E428;
	Mon, 27 Jul 2026 14:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kVheJb9L";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB56910E428
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 14:48:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ED040600AA;
 Mon, 27 Jul 2026 14:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED221F000E9;
 Mon, 27 Jul 2026 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785163686;
 bh=scnaVbUkAPuJU/AE0LjSDTX3CCN2iMGJrjFzW6gD9yE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kVheJb9LQTFCwENhhVF3VsoOuijWF/tYtlGuRtoWkpxrHT7nsv5IcBSjvcegNhTkt
 Oez+ePdvcPvF/6raUPwMHpQUYA0HvucwtUaKefs879b2FHdXQ7/m+FpROrg+3rUBcI
 j4VYJ9t3DwLdOcyyohEIHsfBWUXtKm3IyeGNt/k3wUNTQ4AdFGIqAWnOP52FxA1qHr
 SnRMe0ti52DjYTTWdN1WqnhBVDr7qG56EB1Y88YSEouNOhTRqG4AhvNpmheqZyDM1l
 7D8ayuuPQNZ7B9iGSeowvOmepCqr1WnZkJHkvAbsKkQatne2loo9jbM6Wi+lARXmfW
 GweWZRxP0aBZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 2/2] drm/vc4: Zero the tile state data array
 before each BIN job
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260727-vc4-bin-oom-fixes-v2-2-0d8a5eddc7c9@igalia.com>
References: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
 <20260727-vc4-bin-oom-fixes-v2-2-0d8a5eddc7c9@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:48:06 +0000
Message-Id: <20260727144806.8ED221F000E9@smtp.kernel.org>
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
- [Critical] Unprotected access to `vc4->bin_bo` during command list valida=
tion leads to NULL Pointer Dereference or Use-After-Free, which the patch e=
scalates to a severe memory write via `memset`.
--

--- Patch [2]: [PATCH RESEND v2 2/2] drm/vc4: Zero the tile state data arra=
y before each BIN job ---
commit e8713542a8743898c85cf163587b5ea2ab0ad42b
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Zero the tile state data array before each BIN job

The binner BO is a single 16MB buffer split into 512KB slots that are
handed out to jobs at submission time and recycled as jobs complete,
without ever being cleared. Each slot holds the job's Tile State Data
Array (TSDA) at its start, followed by the tile allocation pool.

Link: https://github.com/raspberrypi/linux/issues/3221 [1]
Link: https://github.com/raspberrypi/linux/issues/5780 [2]

> diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4=
_validate.c
> index 7f2fadfde7a8e..d2a65c968b1f9 100644
> --- a/drivers/gpu/drm/vc4/vc4_validate.c
> +++ b/drivers/gpu/drm/vc4/vc4_validate.c
> @@ -385,6 +385,23 @@ validate_tile_binning_config(VALIDATE_ARGS)
>  		return -EINVAL;
>  	}
> =20
> +	/* The tile state data array is 48 bytes per tile, and we put it at
> +	 * the start of a BO containing both it and the tile alloc.
> +	 */
> +	tile_state_size =3D 48 * tile_count;
> +
> +	/* Since the tile alloc array will follow us, align. */
> +	tile_state_size =3D roundup(tile_state_size, 4096);
> +
> +	/* Reject configurations whose tile state would leave no room for
> +	 * the tile alloc pool that follows it in the slot.
> +	 */
> +	if (tile_state_size >=3D vc4->bin_alloc_size) {
> +		DRM_DEBUG("Tile binning config of %dx%d too large\n",
> +			  exec->bin_tiles_x, exec->bin_tiles_y);
> +		return -EINVAL;
> +	}
> +
>  	bin_slot =3D vc4_v3d_get_bin_slot(vc4);

[ ... ]

> @@ -400,13 +417,13 @@ validate_tile_binning_config(VALIDATE_ARGS)
>  	exec->bin_slots |=3D BIT(bin_slot);
>  	bin_addr =3D vc4->bin_bo->base.dma_addr + bin_slot * vc4->bin_alloc_siz=
e;
> =20
> -	/* The tile state data array is 48 bytes per tile, and we put it at
> -	 * the start of a BO containing both it and the tile alloc.
> -	 */
> -	tile_state_size =3D 48 * tile_count;
> +	exec->tile_alloc_offset =3D bin_addr + tile_state_size;
> =20
> -	/* Since the tile alloc array will follow us, align. */
> -	exec->tile_alloc_offset =3D bin_addr + roundup(tile_state_size, 4096);
> +	/* The TSDA area must be zeroed out before use, otherwise the PTB might
> +	 * consume a stale tile state.
> +	 */
> +	memset(vc4->bin_bo->base.vaddr + bin_slot * vc4->bin_alloc_size, 0,
> +	       tile_state_size);

[Severity: Critical]
This is a pre-existing issue, but this patch escalates it to a potential ke=
rnel
memory corruption via a NULL pointer dereference or use-after-free write.

During command list validation, vc4->bin_bo is accessed here before it is
guaranteed to be allocated or referenced. The actual reference to the BO
is obtained later in vc4_get_bcl():

drivers/gpu/drm/vc4/vc4_gem.c:vc4_get_bcl() {
    ...
    ret =3D vc4_validate_bin_cl(dev, ...);
    ...
    if (exec->found_tile_binning_mode_config_packet) {
        ret =3D vc4_v3d_bin_bo_get(vc4, &exec->bin_bo_used);
    ...
}

If a user imports PRIME BOs without creating a local BO first, vc4->bin_bo
can be NULL.

Furthermore, if a previous BO was freed, bin_bo_release() sets vc4->bin_bo
to NULL but leaves vc4->bin_alloc_size as a stale non-zero value:

drivers/gpu/drm/vc4/vc4_v3d.c:bin_bo_release() {
    ...
    drm_gem_object_put(&vc4->bin_bo->base.base);
    vc4->bin_bo =3D NULL;
}

Because vc4->bin_alloc_size is not reset, the newly added size check
(tile_state_size >=3D vc4->bin_alloc_size) can pass, allowing the memset to
dereference a NULL or freed vc4->bin_bo and write up to ~512KB into
unallocated memory.

Could we ensure vc4->bin_bo is valid and properly referenced before
attempting to clear the memory here, or defer the initialization until
after vc4_v3d_bin_bo_get() has been called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-vc4-bin-oo=
m-fixes-v2-0-0d8a5eddc7c9@igalia.com?part=3D2
