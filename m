Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310D8C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 737BC10E5D6;
	Sat, 18 Jul 2026 17:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F29356U3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03F210E5D6
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:44:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C470E60018;
 Sat, 18 Jul 2026 17:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFFE1F000E9;
 Sat, 18 Jul 2026 17:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784396665;
 bh=qr1lZ8YmLgvNQPGRsJqpiQo1HXfaAsfxEZjlcOjA9Hs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F29356U3LckGJiiAKwNrntQfRnxhiQmUVgQ/1YZCiH7CJf4rEzAsJrfQ8MshT+bkJ
 RvGUFiHIr0vvpbLDasyhrrItpYVudyEyJCNvXdoZ2rcDooQF437Wr1bh780HpXe+0O
 fjo8gTas6+2XnYqO0LpNUF0SulmLWb23v5Sc9l3j/hGDt8nWBSRC81V+pQ0PQJESoV
 JgFqQvwoP7XKWeGpJ3nKDneSbObnTSVm6hEH7HmOYpHE7uWlOALCBscatZkzwbVmsG
 AGvIEq5vNms6fGDwgWcj2/WMngqqTW6+A8xdLzBU7OpNZdqCSdcUtIERFBTUfzMWto
 M1HZ/HhO7yuQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/vc4: Dynamically size the initial tile-alloc block
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260718-vc4-bin-oom-fixes-v1-3-8cba09558c33@igalia.com>
References: <20260718-vc4-bin-oom-fixes-v1-0-8cba09558c33@igalia.com>
 <20260718-vc4-bin-oom-fixes-v1-3-8cba09558c33@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 17:44:24 +0000
Message-Id: <20260718174425.4EFFE1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Missing bounds check on user-controlled `bin_tiles_x` and `bin=
_tiles_y` causes an integer underflow when calculating the `tile alloc size=
`, leading to massive out-of-bounds writes in GPU memory.
- [Critical] Off-by-one validation check on `max_x_tile` allows out-of-boun=
ds tile rendering, leading to an out-of-bounds physical offset computation.
- [High] Unconditional dereference of `vc4->bin_bo` allows local attackers =
to trigger a NULL pointer dereference by bypassing the BO allocation.
--

--- Patch [3]: [PATCH 3/3] drm/vc4: Dynamically size the initial tile-alloc=
 block ---
commit 70ba8b264b3becc24aff870ad390492995036867
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Dynamically size the initial tile-alloc block

This patch dynamically adjusts the initial tile-allocation block size to fix
hardware hangs caused by unreliable continuation-block chain linking. It
calculates the largest block size that fits within the binner slot for the
job's tile count, and programs the RCL branch stride to match.

Link: https://github.com/raspberrypi/linux/issues/3221
Link: https://github.com/raspberrypi/linux/issues/5780

> diff --git a/drivers/gpu/drm/vc4/vc4_render_cl.c b/drivers/gpu/drm/vc4/vc=
4_render_cl.c
> index c264d21bc3fe3..be150bad676f6 100644
> --- a/drivers/gpu/drm/vc4/vc4_render_cl.c
> +++ b/drivers/gpu/drm/vc4/vc4_render_cl.c
> @@ -184,7 +184,8 @@ static void emit_tile(struct vc4_exec_info *exec,
>  	if (has_bin) {
>  		rcl_u8(setup, VC4_PACKET_BRANCH_TO_SUB_LIST);
>  		rcl_u32(setup, (exec->tile_alloc_offset +
> -				(y * exec->bin_tiles_x + x) * 32));
> +				(y * exec->bin_tiles_x + x) *
> +				exec->tile_alloc_stride));

[Severity: Critical]
This is a pre-existing issue, but can this out-of-bounds computation occur
here?

If a user specifies args->max_x_tile equal to exec->bin_tiles_x in the rend=
er
job ioctl, the check (args->max_x_tile > exec->bin_tiles_x) in vc4_get_rcl()
will pass since it uses > instead of >=3D for bounds checking.

Would this cause the driver to iterate an extra tile and emit a branch
instruction pointing to an out-of-bounds tile index in the initial tile-all=
oc
block array, bypassing the command stream validation sandbox?

> diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4=
_validate.c
> index 7f2fadfde7a8e..3961cf38fc2a5 100644
> --- a/drivers/gpu/drm/vc4/vc4_validate.c
> +++ b/drivers/gpu/drm/vc4/vc4_validate.c
[ ... ]
> @@ -406,13 +407,35 @@ validate_tile_binning_config(VALIDATE_ARGS)
>  	tile_state_size =3D 48 * tile_count;
> =20
>  	/* Since the tile alloc array will follow us, align. */
> -	exec->tile_alloc_offset =3D bin_addr + roundup(tile_state_size, 4096);
> +	tile_state_aligned =3D roundup(tile_state_size, 4096);
> +	exec->tile_alloc_offset =3D bin_addr + tile_state_aligned;

[Severity: Critical]
This isn't a bug introduced by this patch, but does the lack of bounds
validation on user-controlled bin_tiles_x and bin_tiles_y cause an integer
underflow later when calculating the tile alloc size?

If bin_tiles_x and bin_tiles_y are set to 255, tile_state_aligned evaluates
to ~3.1MB, which is greater than vc4->bin_alloc_size (512KB). The computati=
on
of (vc4->bin_alloc_size - exec->tile_alloc_offset) would then underflow,
writing a massive positive size to the validated command packet. This could
allow the GPU's binner to overwrite arbitrary physical memory out of bounds.

[Severity: High]
This isn't a bug introduced by this patch, but could the unconditional
dereference of vc4->bin_bo in validate_tile_binning_config() trigger a NULL
pointer dereference?

If an attacker allocates a dumb buffer and submits a command list containing
VC4_PACKET_TILE_BINNING_MODE_CONFIG, vc4_v3d_bin_bo_get() isn't called yet,
and the validator might blindly access vc4->bin_bo->base.dma_addr before
it is guaranteed to be allocated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718-vc4-bin-oo=
m-fixes-v1-0-8cba09558c33@igalia.com?part=3D3
