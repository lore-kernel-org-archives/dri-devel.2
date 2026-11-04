Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368B606D818
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jt6R8VVZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D5D10FD33;
	Wed,  4 Nov 2026 16:47:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B66110FD33
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:47:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F362160AA2;
 Wed,  4 Nov 2026 16:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817AA1F00A2C;
 Wed,  4 Nov 2026 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793810849;
 bh=6gRN1ayJaxuxTkU+k2N3ORrimon941PE9zfewTisDwg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jt6R8VVZr0FpZJW4ljt/KHrRh0cIGpMPRXv6BtHUE1/oRZHEiRjb+mwbzo6XBTRTr
 sX1xhD70Y7VfBtZx2KGsDpH9deheVeF1d75E01FGw101qz0ShqXHXYJkpwGXI6QuAp
 HslLA9ndp53xFk4CMXPsnouSs2aFu1T1NBtk3ARMCMtmw6+40oXWqBnTMQILm5ttJP
 nRDux+jOGgUSdfftYvyvVEk4V1Jmzcsl5HMtXfVqmLdTslTDblXO1EEnDDAGzd8OwB
 r75PMTldF/XNGpB3ZyKIRMzOmLRhuKB1BV+mhnSE0tTxy2AIz+YYs13JU03MIZVyrO
 tku9/r/PNAbyw==
Message-ID: <sashiko-outbox-197682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] drm/msm: check UBWC framebuffers against their layout
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261104-ubwc-format-docs-v1-3-389044012b4e@oss.qualcomm.com>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-3-389044012b4e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:47:29 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm: broken P010 UBWC pitch check in msm_framebuffer_init()
--

commit 692349e38091784388304159b902edd6edf3ad3a
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: check UBWC framebuffers against their layout

This commit updates msm_framebuffer_init() to validate UBWC framebuffers
against their computed UBWC plane pitches and sizes rather than checking
them as linear buffers.

> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> index 1e236416e15f0..dd24aa7a5ee80 100644
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c

[ ... ]

> @@ -177,14 +179,41 @@ msm_framebuffer_init(struct drm_device *dev, const =
struct drm_format_info *info,
>  		goto fail;
>  	}
> =20
> +	if (format->fetch_mode =3D=3D MDP_FETCH_UBWC)
> +		mdp_format_ubwc_plane_sizes(format, mode_cmd->width,
> +					    mode_cmd->height, ubwc_pitch,
> +					    ubwc_size);
> +
>  	for (i =3D 0; i < n; i++) {
>  		unsigned int width =3D mode_cmd->width / (i ? info->hsub : 1);
>  		unsigned int height =3D mode_cmd->height / (i ? info->vsub : 1);
> -		unsigned int min_size;
> -
> -		min_size =3D (height - 1) * mode_cmd->pitches[i]
> -			 + width * info->cpp[i]
> -			 + mode_cmd->offsets[i];
> +		u64 min_size;
> +
> +		if (format->fetch_mode =3D=3D MDP_FETCH_UBWC) {
> +			/*
> +			 * The CbCr planes follow the Y data in the first buffer,
> +			 * offsets[1] and pitches[1] are not used.
> +			 */
> +			if (i > 0) {
> +				if (bos[i] !=3D bos[0]) {
> +					ret =3D UERR(EINVAL, dev,
> +						   "plane %d not in the first buffer", i);
> +					goto fail;
> +				}
> +				min_size =3D 0;
> +			} else if (mode_cmd->pitches[0] !=3D ubwc_pitch[0]) {
> +				ret =3D UERR(EINVAL, dev, "pitch %u, expected %u",
> +					   mode_cmd->pitches[0], ubwc_pitch[0]);
> +				goto fail;

[Severity: High]
Does this break creating DRM_FORMAT_P010 framebuffers with
DRM_FORMAT_MOD_QCOM_COMPRESSED?

In drivers/gpu/drm/msm/disp/mdp_format.c, mdp_formats_ubwc[] defines the
P010 entry using PSEUDO_YUV_FMT_TILED, which sets
MSM_FORMAT_FLAG_UNPACK_TIGHT:

drivers/gpu/drm/msm/disp/mdp_format.c:
	PSEUDO_YUV_FMT_TILED(P010,
		BPC8, BPC8, BPC8,
		C1_B_Cb, C2_R_Cr,
		CHROMA_420, MSM_FORMAT_FLAG_DX,
		MDP_TILE_HEIGHT_UBWC),

When mdp_format_ubwc_plane_sizes() is called on a DX YUV format with
MSM_FORMAT_FLAG_UNPACK_TIGHT set, it computes the tightly-packed TP10
stride (4/3 bytes per pixel) rather than the 2 bytes-per-pixel P010 stride:

drivers/gpu/drm/msm/disp/mdp_format.c:mdp_format_ubwc_plane_sizes() {
	...
		if (MSM_FORMAT_IS_DX(fmt)) {
			if (fmt->flags & MSM_FORMAT_FLAG_UNPACK_TIGHT) {
				/* can't use round_up() here because 192 is NPoT */
				stride =3D roundup(width, 192);
				stride =3D round_up(stride * 4 / 3, 256);
				y_tile_width =3D 48;
			} else {
				stride =3D round_up(width * 2, 256);
				y_tile_width =3D 32;
			}
	...
}

However, before msm_framebuffer_init() is reached,
drm_internal_framebuffer_create() -> framebuffer_check() in
drivers/gpu/drm/drm_framebuffer.c checks r->pitches[0] against
drm_format_info_min_pitch() for DRM_FORMAT_P010 (which has
char_per_block[0] =3D 2 and block_w[0] =3D 1), rejecting any framebuffer wh=
ere
pitches[0] < width * 2:

drivers/gpu/drm/drm_framebuffer.c:framebuffer_check() {
	...
		if (block_size && r->pitches[i] < min_pitch) {
			drm_dbg_kms(dev, "bad pitch %u for plane %d\n", r->pitches[i], i);
			return -EINVAL;
		}
	...
}

Because roundup(width, 192) * 4 / 3 is strictly less than width * 2 for all
widths > 256 (as well as 129 <=3D width <=3D 192), no pitches[0] value can
satisfy both framebuffer_check() (pitches[0] >=3D width * 2) and
msm_framebuffer_init() (pitches[0] =3D=3D ubwc_pitch[0]). For example, at
width =3D 1920, framebuffer_check() requires pitches[0] >=3D 3840 while
ubwc_pitch[0] is 2560, causing ADDFB2 to fail unconditionally with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-ubwc-forma=
t-docs-v1-0-389044012b4e@oss.qualcomm.com?part=3D3
