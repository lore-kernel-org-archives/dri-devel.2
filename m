Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4B9C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6280610F419;
	Fri, 28 Aug 2026 16:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kAWgKVFg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C37310F419
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 16:05:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B10460052;
 Fri, 28 Aug 2026 16:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAED1F000E9;
 Fri, 28 Aug 2026 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787933146;
 bh=y61BGA+fru/0r8mee7bnn96sFo0fTqS8LVjSA5cGIr0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kAWgKVFglzbjMGgup6NpL+HwGHG/LTsRXfktmJTjWLHfVvb8GtyXX3wrKJ2FXBLee
 sqHpYv7pZIIEWF36wvMoVZ1ZYkXA031t7rh2nqpuQAZynr74khqMTnuhLrNgmU6mgw
 Cb6zju+OQvBO69pT36EKnBrW6i73W52fn8mkViG6SuWSMQfxsgjiTeR2KBcYAYZhDm
 5yglNN/AlvKIew8eO4ehNT5UbcNKgQeAoZPEIInyJOKl4y4U7MghqA9x3enmRZFKl+
 XYHxr+QV79eZzfV0k0nw9Sjoc4GUtl/Lg9hs+09XaCCubcxj++ozcdye2kE/SyNmFO
 pt/vQPPbjIhJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] ARM: dts: microchip: sam9x7: Add GFX2D GPU
To: "Cyrille Pitchen" <cyrille.pitchen@microchip.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260828-cpitchen-mainline_gfx2d-v8-4-378374559738@microchip.com>
References: <20260828-cpitchen-mainline_gfx2d-v8-0-378374559738@microchip.com>
 <20260828-cpitchen-mainline_gfx2d-v8-4-378374559738@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 16:05:45 +0000
Message-Id: <20260828160546.0BAED1F000E9@smtp.kernel.org>
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
- [High] Storing `struct vm_area_struct` by value leads to a Use-After-Free=
 during cache flushing.
- [High] Shared `ctx->rectangles` buffer causes data corruption for concurr=
ent command submissions.
--

commit 78e2389302cd2c7d31509fbbf3d0fedaa8b301e2
Author: Cyrille Pitchen <cyrille.pitchen@microchip.com>

ARM: dts: microchip: sam9x7: Add GFX2D GPU

This patch enables the GFX2D GPU for the sam9x7 SoC by adding its device
tree node.

> diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/=
microchip/sam9x7.dtsi
> index c680a5033b6b4..5450fddf89dda 100644
> --- a/arch/arm/boot/dts/microchip/sam9x7.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
> @@ -292,6 +292,14 @@ AT91_XDMAC_DT_PERID(26))>,
>  			status =3D "disabled";
>  		};
> =20
> +		gpu: gpu@f0018000 {
> +			compatible =3D "microchip,sam9x7-gfx2d";
> +			reg =3D <0xf0018000 0x100>;
> +			interrupts =3D <36 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks =3D <&pmc PMC_TYPE_PERIPHERAL 36>;
> +			status =3D "disabled";
> +		};
> +

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free when
this device is used.

When a GEM buffer is mapped, mchp_gfx2d_gem_object_mmap() makes a shallow
copy of the kernel-managed vm_area_struct:

drivers/gpu/drm/microchip/mchp_gfx2d_gem.c:mchp_gfx2d_gem_object_mmap() {
    ...
	if (ret)
		drm_gem_vm_close(vma);
	else
		memcpy(&gfx2d_obj->vma, vma, sizeof(gfx2d_obj->vma));

	return ret;
}

If the mapping is torn down, the original VMA is destroyed. A subsequent
call to mchp_gfx2d_ioctl_sync_for_gpu() passes this stale VMA copy to
flush_cache_range():

drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c:mchp_gfx2d_ioctl_sync_for_gpu(=
) {
    ...
	dir =3D gfx2d_obj->direction;
	if (valid_dma_direction(dir)) {
		struct vm_area_struct *vma =3D &gfx2d_obj->vma;

		flush_cache_range(vma, vma->vm_start, vma->vm_end);
	}
    ...
}

Additionally, since the stored vm_start/vm_end are userspace virtual
addresses from the original process, calling this ioctl from another
process sharing the GEM object will attempt to flush memory in the
wrong address space.

Does this sequence cause a use-after-free or cross-process memory corruption
when an unprivileged user calls the DRM sync ioctl?

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a data
corruption issue with concurrent command submissions.

In mchp_gfx2d_alloc_rectangles(), if the requested number of rectangles is
small enough, the driver assigns the asynchronous command state to use a
single shared context buffer:

drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c:mchp_gfx2d_alloc_rectangles() {
    ...
	cmd->num_rects =3D num_rectangles;

	if (num_rectangles <=3D ARRAY_SIZE(cmd->ctx->rectangles)) {
		cmd->can_free_rects =3D false;
		cmd->rects =3D cmd->ctx->rectangles;
		return 0;
	}
    ...
}

This ctx array is stored in the file_priv->driver_priv context, which is
shared among all threads using the same DRM file descriptor. Later in
mchp_gfx2d_submit(), copy_from_user() writes directly into this shared
array without holding any locks:

drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c:mchp_gfx2d_submit() {
    ...
	ret =3D mchp_gfx2d_alloc_rectangles(cmd, args->num_rectangles);
	if (ret)
		goto err_release_command;

	ret =3D copy_from_user(cmd->rects, u64_to_user_ptr(args->rectangles),
			     args->num_rectangles * sizeof(*cmd->rects));
    ...
}

If multiple threads concurrently submit commands on the same file descripto=
r,
will they race and overwrite each other's rectangles, leading to corrupted
instructions being sent to the GPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-cpitchen-m=
ainline_gfx2d-v8-0-378374559738@microchip.com?part=3D4
