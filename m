Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B78CA9EC5
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C96A10E6C4;
	Tue, 13 Oct 2026 00:36:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7294910E6C4
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 00:36:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AD34435EB;
 Tue, 13 Oct 2026 00:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78FA1F0089B;
 Tue, 13 Oct 2026 00:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791851764;
 bh=txpfRMN9wo1w84piYsKN53q4T1Yis6uujWmG9SBlBf0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DCdLuinlsFbJ1np/krY52GGHKStokU/k0LJvfCq7s/JbnA4jsuXMghDHOiUVbyhL7
 jaheEPxo8wOVVQwh4eXCr6m1u2SKlQ63qPP5yniQ0y+i59nTXR9l+Sprl9hr7ugYME
 SyXpMDECE/Ee70u9tggvJ6zOFLGJ1b+SUyUXv9RVqZ6eksOqGogM2jKhNNWy6QUyZi
 wtPXIazFNYS9cXq5xqATsCML2jkR2s9TnFeg2gSlB/aLUWElSq+KmMivfDikQb37St
 WnKffOBbv38CnvFUrDyV6rK+4XuiBlJrd4Z2p3pzzVfFOrkoa5sjZxtb0qHDO+AVSn
 E+kwkZVt7Yzvw==
Message-ID: <sashiko-outbox-168803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dpu: add the missing GC block to the SM8750
 DSPP catalog
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013002124.332074-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261013002124.332074-1-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:36:03 +0000
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
- [High] drm/msm/dpu: out-of-bounds read due to missing gamma_lut size check
- [High] drm/msm: GFP_KERNEL allocation in atomic_begin callback causes sle=
ep in atomic context
--

commit 3f1bdbf4572ec65ee6d3f256b00cb20d05a40d96
Author: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

drm/msm/dpu: add the missing GC block to the SM8750 DSPP catalog

This commit adds the missing GC (gamma correction) sub-block to the SM8750=
=20
DSPP catalog. This change enables the GAMMA_LUT property for CRTCs on SM875=
0=20
boards, allowing userspace to perform night light and color temperature=20
adjustments.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu=
/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 9a993cdfab856..11dc08e4a4846 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -428,6 +428,13 @@ static const struct dpu_dspp_sub_blks sdm845_dspp_sb=
lk =3D {
>  static const struct dpu_dspp_sub_blks sm8750_dspp_sblk =3D {
>  	.pcc =3D {.name =3D "pcc", .base =3D 0x1700,
>  		.len =3D 0x90, .version =3D 0x60000},
> +	/*
> +	 * SM8750 has the same GC block as SM8650/SDM845.  Without it
> +	 * dpu_crtc.c does not call drm_crtc_enable_color_mgmt(), so no
> +	 * CRTC exposes GAMMA_LUT (night light/color temperature).
> +	 */
> +	.gc =3D {.name =3D "gc", .base =3D 0x17c0,
> +		.len =3D 0x40, .version =3D 0x10008},

[Severity: High]
By exposing the GAMMA_LUT property to userspace here, does this code
overflow the lut array?

Looking at _dpu_crtc_get_gc_lut():

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:_dpu_crtc_get_gc_lut():
	/* Pack 1024 10-bit entries in 512 32-bit registers */
	for (i =3D 0; i < PGC_TBL_LEN; i++) {
		val_even =3D drm_color_lut_extract(lut[i * 2].green, 10);
		val_odd =3D drm_color_lut_extract(lut[i * 2 + 1].green, 10);

This loop unconditionally accesses up to 1024 elements of the user-provided
lut array. Because the DRM core allows blobs smaller than the property's
maximum size, and the driver's dpu_crtc_atomic_check() lacks a validation
check on the blob size, providing an undersized blob will cause an
out-of-bounds read here.

The read memory is then written to hardware registers (gc_lut->c0/c1/c2),
allowing a local attacker to leak adjacent kernel heap memory.

[Severity: High]
Can exposing the GC block trigger a sleep in an atomic context?

The DRM subsystem requires CRTC atomic callbacks to be non-sleeping, but
dpu_crtc_atomic_begin() calls into _dpu_crtc_setup_cp_blocks():

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:dpu_crtc_atomic_begin():
	_dpu_crtc_blend_setup(crtc);

	_dpu_crtc_setup_cp_blocks(crtc);

which performs a GFP_KERNEL allocation when state->gamma_lut is present:

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:_dpu_crtc_setup_cp_blocks():
			} else {
				gc_lut =3D kzalloc_obj(*gc_lut);
				if (!gc_lut)
					continue;
				_dpu_crtc_get_gc_lut(state, gc_lut);
				dspp->ops.setup_gc(dspp, gc_lut);
				kfree(gc_lut);
			}

The kzalloc_obj() macro implicitly uses GFP_KERNEL as its allocation flag.
GFP_KERNEL allocations can sleep (e.g., while waiting for memory reclaim or
I/O), which violates the atomic context constraints and will trigger
scheduling while atomic kernel warnings, system instability, or deadlocks.

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013002124.3320=
74-1-xiaqinghuan@mail.ustc.edu.cn?part=3D1
